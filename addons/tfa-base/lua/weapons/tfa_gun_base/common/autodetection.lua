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

function SWEP:FixSprintAnimBob()
	local self2 = self:GetTable()

	if self:GetStatRawL("Sprint_Mode") == TFA.Enum.LOCOMOTION_ANI then
		self:SetStatRawL("SprintBobMult", 0)
	end
end

function SWEP:FixWalkAnimBob()
	local self2 = self:GetTable()
	if self:GetStatRawL("Walk_Mode") == TFA.Enum.LOCOMOTION_ANI then
		self:SetStatRawL("WalkBobMult_Iron", self:GetStatRawL("WalkBobMult"))
		self:SetStatRawL("WalkBobMult", 0)
	end
end

function SWEP:PatchAmmoTypeAccessors()
	local self2 = self:GetTable()
	self:SetStatRawL("GetPrimaryAmmoTypeOld", self:GetStatRawL("GetPrimaryAmmoTypeOld") or self:GetStatRawL("GetPrimaryAmmoType"))
	self:SetStatRawL("GetPrimaryAmmoType", function(myself, ...) return myself.GetPrimaryAmmoTypeC(myself, ...) end)
	self:SetStatRawL("GetSecondaryAmmoTypeOld", self:GetStatRawL("GetSecondaryAmmoTypeOld") or self:GetStatRawL("GetSecondaryAmmoType"))
	self:SetStatRawL("GetSecondaryAmmoType", function(myself, ...) return myself.GetSecondaryAmmoTypeC(myself, ...) end)
end

function SWEP:FixProjectile()
	local self2 = self:GetTable()
	if self:GetStatRawL("ProjectileEntity") and self:GetStatRawL("ProjectileEntity") ~= "" then
		self:SetStatRawL("Primary.Projectile", self:GetStatRawL("ProjectileEntity"))
		self:SetStatRawL("ProjectileEntity", nil)
	end

	if self:GetStatRawL("ProjectileModel") and self:GetStatRawL("ProjectileModel") ~= "" then
		self:SetStatRawL("Primary.ProjectileModel", self:GetStatRawL("ProjectileModel"))
		self:SetStatRawL("ProjectileModel", nil)
	end

	if self:GetStatRawL("ProjectileVelocity") and self:GetStatRawL("ProjectileVelocity") ~= "" then
		self:SetStatRawL("Primary.ProjectileVelocity", self:GetStatRawL("ProjectileVelocity"))
		self:SetStatRawL("ProjectileVelocity", nil)
	end
end

local sv_tfa_range_modifier = GetConVar("sv_tfa_range_modifier")

function SWEP:AutoDetectRange()
	local self2 = self:GetTable()

	if self:GetStatL("Primary.FalloffMetricBased") and not self:GetStatRawL("Primary.RangeFalloffLUT") then
		self:SetStatRawL("Primary.RangeFalloffLUT_IsConverted", true)

		self:SetStatRawL("Primary.RangeFalloffLUT", {
			bezier = false,
			range_func = "linear", -- function to spline range
			units = "meters",
			lut = {
				{range = self:GetStatL("Primary.MinRangeStartFalloff"), damage = 1},
				{range = self:GetStatL("Primary.MinRangeStartFalloff") + self:GetStatL("Primary.MaxFalloff") / self:GetStatL("Primary.FalloffByMeter"),
					damage = (self:GetStatL("Primary.Damage") - self:GetStatL("Primary.MaxFalloff")) / self:GetStatL("Primary.Damage")},
			}
		})

		return
	end

	if self:GetStatL("Primary.FalloffMetricBased") or self:GetStatL("Primary.RangeFalloffLUT") then return end

	if self:GetStatL("Primary.Range") <= 0 then
		self:SetStatRawL("Primary.Range", math.sqrt(self:GetStatL("Primary.Damage") / 32) * self:MetersToUnits(350) * self:AmmoRangeMultiplier())
	end

	if self:GetStatL("Primary.RangeFalloff") <= 0 then
		self:SetStatRawL("Primary.RangeFalloff", 0.5)
	end

	self:SetStatRawL("Primary.RangeFalloffLUT_IsConverted", true)

	self:SetStatRawL("Primary.RangeFalloffLUT", {
		bezier = false,
		range_func = "linear", -- function to spline range
		units = "hammer",
		lut = {
			{range = self:GetStatL("Primary.Range") * self:GetStatL("Primary.RangeFalloff"), damage = 1},
			{range = self:GetStatL("Primary.Range"), damage = 1 - sv_tfa_range_modifier:GetFloat()},
		}
	})
end

function SWEP:FixProceduralReload()
	-- do nothing
end

function SWEP:FixRPM()
	local self2 = self:GetTable()
	if not self:GetStatRawL("Primary.RPM") then
		if self:GetStatRawL("Primary.Delay") then
			self:SetStatRawL("Primary.RPM", 60 / self:GetStatRawL("Primary.Delay"))
		else
			self:SetStatRawL("Primary.RPM", 120)
		end
	end
end

function SWEP:FixCone()
	local self2 = self:GetTable()
	if self:GetStatRawL("Primary.Cone") then
		if (not self:GetStatRawL("Primary.Spread")) or self:GetStatRawL("Primary.Spread") < 0 then
			self:SetStatRawL("Primary.Spread", self:GetStatRawL("Primary.Cone"))
		end

		self:SetStatRawL("Primary.Cone", nil)
	end
end

--legacy compatibility
function SWEP:FixIdles()
	local self2 = self:GetTable()
	if self:GetStatRawL("DisableIdleAnimations") ~= nil and self:GetStatRawL("DisableIdleAnimations") == true then
		self:SetStatRawL("Idle_Mode", TFA.Enum.IDLE_LUA)
	end
end

function SWEP:FixIS()
	local self2 = self:GetTable()
	if self:GetStatRawL("SightsPos") and (not self:GetStatRawL("IronSightsPosition") or (self:GetStatRawL("IronSightsPosition").x ~= self:GetStatRawL("SightsPos").x and self:GetStatRawL("SightsPos").x ~= 0)) then
		self:SetStatRawL("IronSightsPosition", self:GetStatRawL("SightsPos") or Vector())
		self:SetStatRawL("IronSightsAngle", self:GetStatRawL("SightsAng") or Vector())
	end
end

local legacy_spread_cv = GetConVar("sv_tfa_spread_legacy")

function SWEP:AutoDetectSpread()
	local self2 = self:GetTable()
	if legacy_spread_cv and legacy_spread_cv:GetBool() then
		self:SetUpSpreadLegacy()

		return
	end

	if self:GetStatRawL("Primary.SpreadMultiplierMax") == -1 or not self:GetStatRawL("Primary.SpreadMultiplierMax") then
		self:SetStatRawL("Primary.SpreadMultiplierMax", math.Clamp(math.sqrt(math.sqrt(self:GetStatRawL("Primary.Damage") / 35) * 10 / 5) * 5, 0.01 / self:GetStatRawL("Primary.Spread"), 0.1 / self:GetStatRawL("Primary.Spread")))
	end

	if self:GetStatRawL("Primary.SpreadIncrement") == -1 or not self:GetStatRawL("Primary.SpreadIncrement") then
		self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadMultiplierMax") * 60 / self:GetStatRawL("Primary.RPM") * 0.85 * 1.5)
	end

	if self:GetStatRawL("Primary.SpreadRecovery") == -1 or not self:GetStatRawL("Primary.SpreadRecovery") then
		self:SetStatRawL("Primary.SpreadRecovery", math.max(self:GetStatRawL("Primary.SpreadMultiplierMax") * math.pow(self:GetStatRawL("Primary.RPM") / 600, 1 / 3) * 0.75, self:GetStatRawL("Primary.SpreadMultiplierMax") / 1.5))
	end
end

--[[
Function Name:  AutoDetectMuzzle
Syntax: self:AutoDetectMuzzle().  Call only once, or it's redundant.
Returns:  Nothing.
Notes:  Detects the proper muzzle flash effect if you haven't specified one.
Purpose:  Autodetection
]]
--
function SWEP:AutoDetectMuzzle()
	local self2 = self:GetTable()
	if not self:GetStatRawL("MuzzleFlashEffect") then
		local a = string.lower(self:GetStatRawL("Primary.Ammo"))
		local cat = string.lower(self:GetStatRawL("Category") and self:GetStatRawL("Category") or "")

		if self:GetStatRawL("Silenced") or self:GetSilenced() then
			self:SetStatRawL("MuzzleFlashEffect", "tfa_muzzleflash_silenced")
		elseif string.find(a, "357") or self:GetStatRawL("Revolver") or string.find(cat, "revolver") then
			self:SetStatRawL("MuzzleFlashEffect", "tfa_muzzleflash_revolver")
		elseif self:GetStatL("LoopedReload") or a == "buckshot" or a == "slam" or a == "airboatgun" or string.find(cat, "shotgun") then
			self:SetStatRawL("MuzzleFlashEffect", "tfa_muzzleflash_shotgun")
		elseif string.find(a, "smg") or string.find(cat, "smg") or string.find(cat, "submachine") or string.find(cat, "sub-machine") then
			self:SetStatRawL("MuzzleFlashEffect", "tfa_muzzleflash_smg")
		elseif string.find(a, "sniper") or string.find(cat, "sniper") then
			self:SetStatRawL("MuzzleFlashEffect", "tfa_muzzleflash_sniper")
		elseif string.find(a, "pistol") or string.find(cat, "pistol") then
			self:SetStatRawL("MuzzleFlashEffect", "tfa_muzzleflash_pistol")
		elseif string.find(a, "ar2") or string.find(a, "rifle") or (string.find(cat, "revolver") and not string.find(cat, "rifle")) then
			self:SetStatRawL("MuzzleFlashEffect", "tfa_muzzleflash_rifle")
		else
			self:SetStatRawL("MuzzleFlashEffect", "tfa_muzzleflash_generic")
		end
	end
end

--[[
Function Name:  AutoDetectDamage
Syntax: self:AutoDetectDamage().  Call only once.  Hopefully you call this only once on like SWEP:Initialize() or something.
Returns:  Nothing.
Notes:  Fixes the damage for GDCW.
Purpose:  Autodetection
]]
--
function SWEP:AutoDetectDamage()
	local self2 = self:GetTable()
	if self:GetStatRawL("Primary.Damage") and self:GetStatRawL("Primary.Damage") ~= -1 then return end

	if self:GetStatRawL("Primary.Round") then
		local rnd = string.lower(self:GetStatRawL("Primary.Round"))

		if string.find(rnd, ".50bmg") then
			self:SetStatRawL("Primary.Damage", 185)
		elseif string.find(rnd, "5.45x39") then
			self:SetStatRawL("Primary.Damage", 22)
		elseif string.find(rnd, "5.56x45") then
			self:SetStatRawL("Primary.Damage", 30)
		elseif string.find(rnd, "338_lapua") then
			self:SetStatRawL("Primary.Damage", 120)
		elseif string.find(rnd, "338") then
			self:SetStatRawL("Primary.Damage", 100)
		elseif string.find(rnd, "7.62x51") then
			self:SetStatRawL("Primary.Damage", 100)
		elseif string.find(rnd, "9x39") then
			self:SetStatRawL("Primary.Damage", 32)
		elseif string.find(rnd, "9mm") then
			self:SetStatRawL("Primary.Damage", 22)
		elseif string.find(rnd, "9x19") then
			self:SetStatRawL("Primary.Damage", 22)
		elseif string.find(rnd, "9x18") then
			self:SetStatRawL("Primary.Damage", 20)
		end

		if string.find(rnd, "ap") then
			self:SetStatRawL("Primary.Damage", self:GetStatRawL("Primary.Damage") * 1.2)
		end
	end

	if (not self:GetStatRawL("Primary.Damage")) or (self:GetStatRawL("Primary.Damage") <= 0.01) and self:GetStatRawL("Velocity") then
		self:SetStatRawL("Primary.Damage", self:GetStatRawL("Velocity") / 5)
	end

	if (not self:GetStatRawL("Primary.Damage")) or (self:GetStatRawL("Primary.Damage") <= 0.01) then
		self:SetStatRawL("Primary.Damage", (self:GetStatRawL("Primary.KickUp") + self:GetStatRawL("Primary.KickUp") + self:GetStatRawL("Primary.KickUp")) * 10)
	end
end

--[[
Function Name:  AutoDetectDamageType
Syntax: self:AutoDetectDamageType().  Call only once.  Hopefully you call this only once on like SWEP:Initialize() or something.
Returns:  Nothing.
Notes:  Sets a damagetype
Purpose:  Autodetection
]]
--
function SWEP:AutoDetectDamageType()
	local self2 = self:GetTable()
	if self:GetStatRawL("Primary.DamageType") == -1 or not self:GetStatRawL("Primary.DamageType") then
		if self:GetStatRawL("DamageType") and not self:GetStatRawL("Primary.DamageType") then
			self:SetStatRawL("Primary.DamageType", self:GetStatRawL("DamageType"))
		else
			self:SetStatRawL("Primary.DamageType", DMG_BULLET)
		end
	end
end

--[[
Function Name:  AutoDetectForce
Syntax: self:AutoDetectForce().  Call only once.  Hopefully you call this only once on like SWEP:Initialize() or something.
Returns:  Nothing.
Notes:  Detects force from damage
Purpose:  Autodetection
]]
--
function SWEP:AutoDetectForce()
	local self2 = self:GetTable()
	if self:GetStatRawL("Primary.Force") == -1 or not self:GetStatRawL("Primary.Force") then
		self:SetStatRawL("Primary.Force", self:GetStatRawL("Force") or (math.sqrt(self:GetStatRawL("Primary.Damage") / 16) * 3 / math.sqrt(self:GetStatRawL("Primary.NumShots"))))
	end
end

function SWEP:AutoDetectPenetrationPower()
	local self2 = self:GetTable()

	if self:GetStatRawL("Primary.PenetrationPower") == -1 or not self:GetStatRawL("Primary.PenetrationPower") then
		local am = string.lower(self:GetStatL("Primary.Ammo"))
		local m = 1

		if (am == "pistol") then
			m = 0.4
		elseif (am == "357") then
			m = 1.75
		elseif (am == "smg1") then
			m = 0.34
		elseif (am == "ar2") then
			m = 1.1
		elseif (am == "buckshot") then
			m = 0.3
		elseif (am == "airboatgun") then
			m = 2.25
		elseif (am == "sniperpenetratedround") then
			m = 3
		end

		self:SetStatRawL("Primary.PenetrationPower", self:GetStatRawL("PenetrationPower") or math.sqrt(self:GetStatRawL("Primary.Force") * 200 * m))
	end
end

--[[
Function Name:  AutoDetectKnockback
Syntax: self:AutoDetectKnockback().  Call only once.  Hopefully you call this only once on like SWEP:Initialize() or something.
Returns:  Nothing.
Notes:  Detects knockback from force
Purpose:  Autodetection
]]
--
function SWEP:AutoDetectKnockback()
	local self2 = self:GetTable()
	if self:GetStatRawL("Primary.Knockback") == -1 or not self:GetStatRawL("Primary.Knockback") then
		self:SetStatRawL("Primary.Knockback", self:GetStatRawL("Knockback") or math.max(math.pow(self:GetStatRawL("Primary.Force") - 3.25, 2), 0) * math.pow(self:GetStatRawL("Primary.NumShots"), 1 / 3))
	end
end

--[[
Function Name:  IconFix
Syntax: self:IconFix().  Call only once.  Hopefully you call this only once on like SWEP:Initialize() or something.
Returns:  Nothing.
Notes:  Fixes the icon.  Call this if you give it a texture path, or just nothing.
Purpose:  Autodetection
]]
--
local selicon_final = {}

function SWEP:IconFix()
	local self2 = self:GetTable()

	if not surface then return end

	local class = self2.ClassName

	if selicon_final[class] then
		self:SetStatRawL("WepSelectIcon", selicon_final[class])

		return
	end

	if self2.WepSelectIcon and type(self2.WepSelectIcon) == "string" then
		self:SetStatRawL("WepSelectIcon", surface.GetTextureID(self2.WepSelectIcon))
	else
		if file.Exists("materials/vgui/hud/" .. class .. ".png", "GAME") then
			self:SetStatRawL("WepSelectIcon", Material("vgui/hud/" .. class .. ".png", "smooth noclamp")) -- NOTHING should access this variable directly and our DrawWeaponSelection override supports IMaterial.
		elseif file.Exists("materials/vgui/hud/" .. class .. ".vmt", "GAME") then
			self:SetStatRawL("WepSelectIcon", surface.GetTextureID("vgui/hud/" .. class))
		end
	end

	selicon_final[class] = self2.WepSelectIcon
end

--[[
Function Name:  CorrectScopeFOV
Syntax: self:CorrectScopeFOV( fov ).  Call only once.  Hopefully you call this only once on like SWEP:Initialize() or something.
Returns:  Nothing.
Notes:  If you're using scopezoom instead of FOV, this translates it.
Purpose:  Autodetection
]]
--
function SWEP:CorrectScopeFOV(fov)
	local self2 = self:GetTable()
	fov = fov or self:GetStatRawL("DefaultFOV")

	if not self:GetStatRawL("Secondary.OwnerFOV") or self:GetStatRawL("Secondary.OwnerFOV") <= 0 then
		if self:GetStatRawL("Scoped") then
			self:SetStatRawL("Secondary.OwnerFOV", fov / (self:GetStatRawL("Secondary.ScopeZoom") and self:GetStatRawL("Secondary.ScopeZoom") or 2))
		else
			self:SetStatRawL("Secondary.OwnerFOV", 32)
		end
	end
end

--[[
Function Name:  CreateFireModes
Syntax: self:CreateFireModes( is first draw).  Call as much as you like.  isfirstdraw controls whether the default fire mode is set.
Returns:  Nothing.
Notes:  Autodetects fire modes depending on what params you set up.
Purpose:  Autodetection
]]
--
SWEP.FireModeCache = {}

function SWEP:CreateFireModes(isfirstdraw)
	local self2 = self:GetTable()
	if not self2.FireModes then
		self:SetStatRawL("FireModes", {})
		local burstcnt = self:FindEvenBurstNumber()

		if self2.SelectiveFire then
			if self2.OnlyBurstFire then
				if burstcnt then
					self2.FireModes[1] = burstcnt .. "Burst"
					self2.FireModes[2] = "Single"
				else
					self2.FireModes[1] = "Single"
				end
			else
				self2.FireModes[1] = "Automatic"

				if self2.DisableBurstFire then
					self2.FireModes[2] = "Single"
				else
					if burstcnt then
						self2.FireModes[2] = burstcnt .. "Burst"
						self2.FireModes[3] = "Single"
					else
						self2.FireModes[2] = "Single"
					end
				end
			end
		else
			if self2.Primary_TFA.Automatic then
				self2.FireModes[1] = "Automatic"

				if self2.OnlyBurstFire and burstcnt then
					self2.FireModes[1] = burstcnt .. "Burst"
				end
			else
				self2.FireModes[1] = "Single"
			end
		end
	end

	if self2.FireModes[#self2.FireModes] ~= "Safe" then
		self2.FireModes[#self2.FireModes + 1] = "Safe"
	end

	if not self2.FireModeCache or #self2.FireModeCache <= 0 then
		for k, v in ipairs(self2.FireModes) do
			self2.FireModeCache[v] = k
		end

		if type(self2.DefaultFireMode) == "number" then
			self:SetFireMode(self2.DefaultFireMode or (self2.Primary_TFA.Automatic and 1 or #self2.FireModes - 1))
		else
			self:SetFireMode(self2.FireModeCache[self2.DefaultFireMode] or (self2.Primary_TFA.Automatic and 1 or #self2.FireModes - 1))
		end
	end
end

--[[
Function Name:  CacheAnimations
Syntax: self:CacheAnimations().  Call as much as you like.
Returns:  Nothing.
Notes:  This is what autodetects animations for the SWEP.SequenceEnabled and SWEP.SequenceLength tables.
Purpose:  Autodetection
]]
--
--SWEP.actlist = {ACT_VM_DRAW, ACT_VM_DRAW_EMPTY, ACT_VM_DRAW_SILENCED, ACT_VM_DRAW_DEPLOYED, ACT_VM_HOLSTER, ACT_VM_HOLSTER_EMPTY, ACT_VM_IDLE, ACT_VM_IDLE_EMPTY, ACT_VM_IDLE_SILENCED, ACT_VM_PRIMARYATTACK, ACT_VM_PRIMARYATTACK_1, ACT_VM_PRIMARYATTACK_EMPTY, ACT_VM_PRIMARYATTACK_SILENCED, ACT_VM_SECONDARYATTACK, ACT_VM_RELOAD, ACT_VM_RELOAD_EMPTY, ACT_VM_RELOAD_SILENCED, ACT_VM_ATTACH_SILENCER, ACT_VM_RELEASE, ACT_VM_DETACH_SILENCER, ACT_VM_FIDGET, ACT_VM_FIDGET_EMPTY, ACT_VM_FIDGET_SILENCED, ACT_SHOTGUN_RELOAD_START, ACT_VM_DRYFIRE, ACT_VM_DRYFIRE_SILENCED }
--If you really want, you can remove things from SWEP.actlist and manually enable animations and set their lengths.
SWEP.SequenceEnabled = {}
SWEP.SequenceLength = {}
SWEP.SequenceLengthOverride = {} --Override this if you want to change the length of a sequence but not the next idle
SWEP.ActCache = {}
local vm, seq

function SWEP:CacheAnimations()
	local self2 = self:GetTable()
	table.Empty(self2.ActCache)

	if self:GetStatRawL("CanBeSilenced") and self2.SequenceEnabled[ACT_VM_IDLE_SILENCED] == nil then
		self2.SequenceEnabled[ACT_VM_IDLE_SILENCED] = true
	end

	if not self:VMIV() then return end
	vm = self2.OwnerViewModel

	if IsValid(vm) then
		self:BuildAnimActivities()

		for _, v in ipairs(table.GetKeys(self2.AnimationActivities)) do
			if isnumber(v) then
				seq = vm:SelectWeightedSequence(v)

				if seq ~= -1 and vm:GetSequenceActivity(seq) == v and not self2.ActCache[seq] then
					self2.SequenceEnabled[v] = true
					self2.SequenceLength[v] = vm:SequenceDuration(seq)
					self2.ActCache[seq] = v
				else
					self2.SequenceEnabled[v] = false
					self2.SequenceLength[v] = 0.0
				end
			else
				local s = vm:LookupSequence(v)

				if s and s > 0 then
					self2.SequenceEnabled[v] = true
					self2.SequenceLength[v] = vm:SequenceDuration(s)
					self2.ActCache[s] = v
				else
					self2.SequenceEnabled[v] = false
					self2.SequenceLength[v] = 0.0
				end
			end
		end
	else
		return false
	end

	if self:GetStatRawL("ProceduralHolsterEnabled") == nil then
		if self2.SequenceEnabled[ACT_VM_HOLSTER] then
			self:SetStatRawL("ProceduralHolsterEnabled", false)
		else
			self:SetStatRawL("ProceduralHolsterEnabled", true)
		end
	end

	self:SetStatRawL("HasDetectedValidAnimations", true)

	return true
end

function SWEP:GetType()
	local self2 = self:GetTable()
	if self:GetStatRawL("Type") then return self:GetStatRawL("Type") end
	local at = string.lower(self:GetStatRawL("Primary.Ammo") or "")
	local ht = string.lower((self:GetStatRawL("DefaultHoldType") or self:GetStatRawL("HoldType")) or "")
	local rpm = self:GetStatRawL("Primary.RPM_Displayed") or self:GetStatRawL("Primary.RPM") or 600

	if self:GetStatRawL("Primary.ProjectileEntity") or self:GetStatRawL("ProjectileEntity") then
		if (self:GetStatRawL("ProjectileVelocity") or self:GetStatRawL("Primary.ProjectileVelocity")) > 400 then
			self:SetStatRawL("Type", "Launcher")
		else
			self:SetStatRawL("Type", "Grenade")
		end
		return
	end

	if at == "buckshot" then
		self:SetStatRawL("Type", "Shotgun")

		return self:GetType()
	end

	if self:GetStatRawL("Pistol") or (at == "pistol" and ht == "pistol") then
		self:SetStatRawL("Type", "Pistol")

		return self:GetType()
	end

	if self:GetStatRawL("SMG") or (at == "smg1" and (ht == "smg" or ht == "pistol" or ht == "357")) then
		self:SetStatRawL("Type", "Sub-Machine Gun")

		return self:GetType()
	end

	if self:GetStatRawL("Revolver") or (at == "357" and ht == "revolver") then
		self:SetStatRawL("Type", "Revolver")

		return self:GetType()
	end

	--Detect Sniper Type
	if ( (self:GetStatRawL("Scoped") or self:GetStatRawL("Scoped_3D")) and rpm < 600 ) or at == "sniperpenetratedround" then
		if rpm > 180 and (self:GetStatRawL("Primary.Automatic") or self:GetStatRawL("Primary.SelectiveFire")) then
			self:SetStatRawL("Type", "Designated Marksman Rifle")

			return self:GetType()
		else
			self:SetStatRawL("Type", "Sniper Rifle")

			return self:GetType()
		end
	end

	--Detect based on holdtype
	if ht == "pistol" then
		if self:GetStatRawL("Primary.Automatic") then
			self:SetStatRawL("Type", "Machine Pistol")
		else
			self:SetStatRawL("Type", "Pistol")
		end

		return self:GetType()
	end

	if ht == "duel" then
		if at == "pistol" then
			self:SetStatRawL("Type", "Dual Pistols")

			return self:GetType()
		elseif at == "357" then
			self:SetStatRawL("Type", "Dual Revolvers")

			return self:GetType()
		elseif at == "smg1" then
			self:SetStatRawL("Type", "Dual Sub-Machine Guns")

			return self:GetType()
		else
			self:SetStatRawL("Type", "Dual Guns")

			return self:GetType()
		end
	end

	--If it's using rifle ammo, it's a rifle or a carbine
	if at == "ar2" then
		if self:GetStatRawL("Primary.ClipSize") >= 60 then
			self:SetStatRawL("Type", "Light Machine Gun")

			return self:GetType()
		elseif ht == "rpg" or ht == "revolver" then
			self:SetStatRawL("Type", "Carbine")

			return self:GetType()
		else
			self:SetStatRawL("Type", "Rifle")

			return self:GetType()
		end
	end

	--Check SMG one last time
	if ht == "smg" or at == "smg1" then
		self:SetStatRawL("Type", "Sub-Machine Gun")

		return self:GetType()
	end

	--Fallback to generic
	self:SetStatRawL("Type", "Weapon")

	return self:GetType()
end

function SWEP:SetUpSpreadLegacy()
	local self2 = self:GetTable()
	local ht = self:GetStatRawL("DefaultHoldType") and self:GetStatRawL("DefaultHoldType") or self:GetStatRawL("HoldType")

	if not self:GetStatRawL("Primary.SpreadMultiplierMax") or self:GetStatRawL("Primary.SpreadMultiplierMax") <= 0 or self:GetStatRawL("AutoDetectSpreadMultiplierMax") then
		self:SetStatRawL("Primary.SpreadMultiplierMax", 2.5 * math.max(self:GetStatRawL("Primary.RPM"), 400) / 600 * math.sqrt(self:GetStatRawL("Primary.Damage") / 30 * self:GetStatRawL("Primary.NumShots"))) --How far the spread can expand when you shoot.

		if ht == "smg" then
			self:SetStatRawL("Primary.SpreadMultiplierMax", self:GetStatRawL("Primary.SpreadMultiplierMax") * 0.8)
		end

		if ht == "revolver" then
			self:SetStatRawL("Primary.SpreadMultiplierMax", self:GetStatRawL("Primary.SpreadMultiplierMax") * 2)
		end

		if self:GetStatRawL("Scoped") then
			self:SetStatRawL("Primary.SpreadMultiplierMax", self:GetStatRawL("Primary.SpreadMultiplierMax") * 1.5)
		end

		self:SetStatRawL("AutoDetectSpreadMultiplierMax", true)
	end

	if not self:GetStatRawL("Primary.SpreadIncrement") or self:GetStatRawL("Primary.SpreadIncrement") <= 0 or self:GetStatRawL("AutoDetectSpreadIncrement") then
		self:SetStatRawL("AutoDetectSpreadIncrement", true)
		self:SetStatRawL("Primary.SpreadIncrement", 1 * math.Clamp(math.sqrt(self:GetStatRawL("Primary.RPM")) / 24.5, 0.7, 3) * math.sqrt(self:GetStatRawL("Primary.Damage") / 30 * self:GetStatRawL("Primary.NumShots"))) --What percentage of the modifier is added on, per shot.

		if ht == "revolver" then
			self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadIncrement") * 2)
		end

		if ht == "pistol" then
			self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadIncrement") * 1.35)
		end

		if ht == "ar2" or ht == "rpg" then
			self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadIncrement") * 0.65)
		end

		if ht == "smg" then
			self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadIncrement") * 1.75)
			self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadIncrement") * (math.Clamp((self:GetStatRawL("Primary.RPM") - 650) / 150, 0, 1) + 1))
		end

		if ht == "pistol" and self:GetStatRawL("Primary.Automatic") == true then
			self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadIncrement") * 1.5)
		end

		if self:GetStatRawL("Scoped") then
			self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadIncrement") * 1.25)
		end

		self:SetStatRawL("Primary.SpreadIncrement", self:GetStatRawL("Primary.SpreadIncrement") * math.sqrt(self:GetStatRawL("Primary.Recoil") * (self:GetStatRawL("Primary.KickUp") + self:GetStatRawL("Primary.KickDown") + self:GetStatRawL("Primary.KickHorizontal"))) * 0.8)
	end

	if not self:GetStatRawL("Primary.SpreadRecovery") or self:GetStatRawL("Primary.SpreadRecovery") <= 0 or self:GetStatRawL("AutoDetectSpreadRecovery") then
		self:SetStatRawL("AutoDetectSpreadRecovery", true)
		self:SetStatRawL("Primary.SpreadRecovery", math.sqrt(math.max(self:GetStatRawL("Primary.RPM"), 300)) / 29 * 4) --How much the spread recovers, per second.

		if ht == "smg" then
			self:SetStatRawL("Primary.SpreadRecovery", self:GetStatRawL("Primary.SpreadRecovery") * (1 - math.Clamp((self:GetStatRawL("Primary.RPM") - 600) / 200, 0, 1) * 0.33))
		end
	end
end

SWEP.LowAmmoSoundTypeBlacklist = {
	["launcher"] = true,
	["grenade"] = true,
}

SWEP.LowAmmoSoundByType = {
	["handgun"] = "TFA.LowAmmo.Handgun",
	["pistol"] = "TFA.LowAmmo.Handgun",
	["dualpistols"] = "TFA.LowAmmo.Handgun",
	["machinepistol"] = "TFA.LowAmmo.Handgun",
	["handcannon"] = "TFA.LowAmmo.Revolver",
	["revolver"] = "TFA.LowAmmo.Revolver",
	["dualrevolvers"] = "TFA.LowAmmo.Revolver",
	["shotgun"] = "TFA.LowAmmo.Shotgun",
	["machinegun"] = "TFA.LowAmmo.MachineGun",
	["lightmachinegun"] = "TFA.LowAmmo.MachineGun",
	["heavymachinegun"] = "TFA.LowAmmo.MachineGun",
	["carbine"] = "TFA.LowAmmo.AssaultRifle",
	["rifle"] = "TFA.LowAmmo.AssaultRifle",
	["assaultrifle"] = "TFA.LowAmmo.AssaultRifle",
	["dmr"] = "TFA.LowAmmo.DMR",
	["designatedmarksmanrifle"] = "TFA.LowAmmo.DMR",
	["sniperrifle"] = "TFA.LowAmmo.Sniper",
	["smg"] = "TFA.LowAmmo.SMG",
	["submachinegun"] = "TFA.LowAmmo.SMG",
}
SWEP.LastAmmoSoundByType = {
	["handgun"] = "TFA.LowAmmo.Handgun_Dry",
	["pistol"] = "TFA.LowAmmo.Handgun_Dry",
	["dualpistols"] = "TFA.LowAmmo.Handgun_Dry",
	["machinepistol"] = "TFA.LowAmmo.Handgun_Dry",
	["handcannon"] = "TFA.LowAmmo.Revolver_Dry",
	["revolver"] = "TFA.LowAmmo.Revolver_Dry",
	["dualrevolvers"] = "TFA.LowAmmo.Revolver_Dry",
	["shotgun"] = "TFA.LowAmmo.Shotgun_Dry",
	["machinegun"] = "TFA.LowAmmo.MachineGun_Dry",
	["lightmachinegun"] = "TFA.LowAmmo.MachineGun_Dry",
	["heavymachinegun"] = "TFA.LowAmmo.MachineGun_Dry",
	["carbine"] = "TFA.LowAmmo.AssaultRifle_Dry",
	["rifle"] = "TFA.LowAmmo.AssaultRifle_Dry",
	["assaultrifle"] = "TFA.LowAmmo.AssaultRifle_Dry",
	["dmr"] = "TFA.LowAmmo.DMR_Dry",
	["designatedmarksmanrifle"] = "TFA.LowAmmo.DMR_Dry",
	["sniperrifle"] = "TFA.LowAmmo.Sniper_Dry",
	["smg"] = "TFA.LowAmmo.SMG_Dry",
	["submachinegun"] = "TFA.LowAmmo.SMG_Dry",
}

function SWEP:AutoDetectLowAmmoSound()
	if not self.FireSoundAffectedByClipSize then return end

	local t1, t2 = self:GetType():lower():gsub("[^%w]+", ""), (self:GetStatRawL("Type_Displayed") or ""):lower():gsub("[^%w]+", "")

	if self.LowAmmoSoundTypeBlacklist[t2] or self.LowAmmoSoundTypeBlacklist[t1] then return end

	local clip1 = self:GetStatRawL("Primary.ClipSize")
	if (not clip1 or clip1 <= 4) then return end

	if not self.LowAmmoSound then
		local snd = self.LowAmmoSoundByType[t2] or self.LowAmmoSoundByType[t1] or "TFA.LowAmmo"

		if (t2 == "shotgun" or t1 == "shotgun") and not self:GetStatL("LoopedReload") then
			snd = "TFA.LowAmmo.AutoShotgun"
		end

		self:SetStatRawL("LowAmmoSound", snd)
	end

	if not self.LastAmmoSound then
		local snd = self.LastAmmoSoundByType[t2] or self.LastAmmoSoundByType[t1] or "TFA.LowAmmo_Dry"

		if (t2 == "shotgun" or t1 == "shotgun") and not self:GetStatL("LoopedReload") then
			snd = "TFA.LowAmmo.AutoShotgun_Dry"
		end

		self:SetStatRawL("LastAmmoSound", snd)
	end
end
