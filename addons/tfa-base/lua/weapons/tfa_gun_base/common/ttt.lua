--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

SWEP.HeadshotMultiplier = 2.7
SWEP.StoredAmmo = 0
SWEP.IsDropped = false
SWEP.DeploySpeed = 1.4
SWEP.fingerprints = {}

-- crosshair
if CLIENT then
	-- luacheck: globals LANG Key
	local SafeTranslation = function(x) return x end
	local GetPTranslation = LANG and LANG.GetParamTranslation or SafeTranslation

	-- Many non-gun weapons benefit from some help
	local help_spec = {
		text = "",
		font = "TabLarge",
		xalign = TEXT_ALIGN_CENTER
	}

	function SWEP:DrawHelp()
		local data = self.HUDHelp
		local translate = data.translatable
		local primary = data.primary
		local secondary = data.secondary

		if translate then
			primary = primary and GetPTranslation(primary, data.translate_params)
			secondary = secondary and GetPTranslation(secondary, data.translate_params)
		end

		help_spec.pos = {ScrW() / 2.0, ScrH() - 40}
		help_spec.text = secondary or primary
		draw.TextShadow(help_spec, 2)

		-- if no secondary exists, primary is drawn at the bottom and no top line
		-- is drawn
		if secondary then
			help_spec.pos[2] = ScrH() - 60
			help_spec.text = primary
			draw.TextShadow(help_spec, 2)
		end
	end

	local function SafeKey(binding, default)
		local b = input.LookupBinding(binding)
		if not b then return default end

		return string.upper(b)
	end

	local Key = Key or SafeKey

	-- mousebuttons are enough for most weapons
	local default_key_params = {
		primaryfire = Key("+attack", "LEFT MOUSE"),
		secondaryfire = Key("+attack2", "RIGHT MOUSE"),
		usekey = Key("+use", "USE")
	}

	function SWEP:AddHUDHelp(primary_text, secondary_text, translate, extra_params)
		extra_params = extra_params or {}

		self.HUDHelp = {
			primary = primary_text,
			secondary = secondary_text,
			translatable = translate,
			translate_params = table.Merge(extra_params, default_key_params)
		}
	end
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
	return self.HeadshotMultiplier or 2
end

function SWEP:IsEquipment()
	-- luacheck: globals WEPS
	if WEPS and WEPS.IsEquipment then
		local val = WEPS.IsEquipment(self)

		if val ~= nil then
			return val
		else
			return false
		end
	else
		return false
	end
end

-- The OnDrop() hook is useless for this as it happens AFTER the drop. OwnerChange
-- does not occur when a drop happens for some reason. Hence this thing.
function SWEP:PreDrop()
	if not IsValid(self) then return end
	if not self.Ammo1 then return end

	if SERVER and IsValid(self:GetOwner()) and self.Primary_TFA.Ammo ~= "none" then
		local ammo = self:Ammo1()

		-- Do not drop ammo if we have another gun that uses this type
		for _, w in pairs(self:GetOwner():GetWeapons()) do
			if IsValid(w) and w ~= self and w:GetPrimaryAmmoType() == self:GetPrimaryAmmoType() then
				ammo = 0
			end
		end

		self.StoredAmmo = ammo

		if ammo > 0 then
			self:GetOwner():RemoveAmmo(ammo, self.Primary_TFA.Ammo)
		end
	end
end

function SWEP:DampenDrop()
	if not IsValid(self) then return end
	-- For some reason gmod drops guns on death at a speed of 400 units, which
	-- catapults them away from the body. Here we want people to actually be able
	-- to find a given corpse's weapon, so we override the velocity here and call
	-- this when dropping guns on death.
	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:SetVelocityInstantaneous(Vector(0, 0, -75) + phys:GetVelocity() * 0.001)
		phys:AddAngleVelocity(phys:GetAngleVelocity() * -0.99)
	end
end

local SF_WEAPON_START_CONSTRAINED = 1

-- Picked up by player. Transfer of stored ammo and such.
function SWEP:EquipTTT(newowner)
	if engine.ActiveGamemode() ~= "terrortown" then return end

	if SERVER then
		if self:IsOnFire() then
			self:Extinguish()
		end

		self.fingerprints = self.fingerprints or {}

		if not table.HasValue(self.fingerprints, newowner) then
			table.insert(self.fingerprints, newowner)
		end

		if self:HasSpawnFlags(SF_WEAPON_START_CONSTRAINED) then
			-- If this weapon started constrained, unset that spawnflag, or the
			-- weapon will be re-constrained and float
			local flags = self:GetSpawnFlags()
			local newflags = bit.band(flags, bit.bnot(SF_WEAPON_START_CONSTRAINED))
			self:SetKeyValue("spawnflags", newflags)
		end
	end

	if not self.Ammo1 then return end

	if SERVER and IsValid(newowner) and self.StoredAmmo > 0 and self.Primary_TFA.Ammo ~= "none" then
		local ammo = newowner:GetAmmoCount(self.Primary_TFA.Ammo)
		self.Primary_TFA.ClipMax = self.Primary_TFA.ClipMax or (math.abs(self.Primary_TFA.ClipSize) * 4)
		local given = math.min(self.StoredAmmo, self.Primary_TFA.ClipMax - ammo)
		newowner:GiveAmmo(given, self.Primary_TFA.Ammo)
		self.StoredAmmo = 0
	end
end

-- We were bought as special equipment, some weapons will want to do something
-- extra for their buyer
function SWEP:WasBought(buyer)
end

function SWEP:DyingShot()
	local fired = false
	-- if self:GetIronSightsProgress() and self:GetIronSightsProgress() > 0.01  then
	self:SetIronSightsRaw(false)
	if self:GetNextPrimaryFire() > CurTime() then return fired end

	-- Owner should still be alive here
	if IsValid(self:GetOwner()) then
		local punch = self.Primary_TFA.Recoil or 5
		-- Punch view to disorient aim before firing dying shot
		local eyeang = self:GetOwner():EyeAngles()
		eyeang.pitch = eyeang.pitch - math.Rand(-punch, punch)
		eyeang.yaw = eyeang.yaw - math.Rand(-punch, punch)
		self:GetOwner():SetEyeAngles(eyeang)
		MsgN(self:GetOwner():Nick() .. " fired his DYING SHOT")
		self:GetOwner().dying_wep = self
		self:PrimaryAttack()
		fired = true
	end
	-- end

	return fired
end