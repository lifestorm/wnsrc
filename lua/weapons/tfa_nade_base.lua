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

if SERVER then
	AddCSLuaFile()
end

local CurTime = CurTime
local sp = game.SinglePlayer()

DEFINE_BASECLASS("tfa_gun_base")
SWEP.DrawCrosshair = true
SWEP.Type = "Grenade"
SWEP.MuzzleFlashEffect = ""
SWEP.Secondary.IronSightsEnabled = false
SWEP.Delay = 0.3 -- Delay to fire entity
SWEP.Delay_Underhand = 0.3 -- Delay to fire entity when underhand
SWEP.Primary.Round = "" -- Nade Entity
SWEP.Velocity = 550 -- Entity Velocity
SWEP.Underhanded = false
SWEP.DisableIdleAnimations = true
SWEP.IronSightsPosition = Vector(5,0,0)
SWEP.IronSightsAngle = Vector(0,0,0)
SWEP.Callback = {}

SWEP.AllowUnderhanded = true

SWEP.AllowSprintAttack = true

local nzombies = nil

function SWEP:Initialize()
	if nzombies == nil then
		nzombies = engine.ActiveGamemode() == "nzombies"
	end

	self.ProjectileEntity = self.ProjectileEntity or self.Primary.Round -- Entity to shoot
	self.ProjectileVelocity = self.Velocity or 550  -- Entity to shoot's velocity
	self.ProjectileModel = nil                                          -- Entity to shoot's model

	self:SetNW2Bool("Underhanded", false)

	BaseClass.Initialize(self)
end

local cl_defaultweapon = GetConVar("cl_defaultweapon")

function SWEP:SwitchToPreviousWeapon()
	local wep = LocalPlayer():GetPreviousWeapon()

	if IsValid(wep) and wep:IsWeapon() and wep:GetOwner() == LocalPlayer() then
		input.SelectWeapon(wep)
	else
		wep = LocalPlayer():GetWeapon(cl_defaultweapon:GetString())

		if IsValid(wep) then
			input.SelectWeapon(wep)
		else
			local _
			_, wep = next(LocalPlayer():GetWeapons())

			if IsValid(wep) then
				input.SelectWeapon(wep)
			end
		end
	end
end

function SWEP:Deploy()
	if self:Clip1() <= 0 then
		if self:Ammo1() <= 0 then
			if self:GetOwner():IsPlayer() then
				if CLIENT and not sp then
					self:SwitchToPreviousWeapon()
				elseif SERVER and not nzombies then
					if sp then
						self:CallOnClient("SwitchToPreviousWeapon", "")
						local ply = self:GetOwner()
						local classname = self:GetClass()
						timer.Simple(0, function() ply:StripWeapon(classname) end)
					else
						self:GetOwner():StripWeapon(self:GetClass())
						return
					end
				end
			end
		else
			self:TakePrimaryAmmo(1, true)
			self:SetClip1(1)
		end
	end

	self:SetNW2Bool("Underhanded", false)

	self.oldang = self:GetOwner():EyeAngles()
	self.anga = Angle()
	self.angb = Angle()
	self.angc = Angle()

	self:CleanParticles()

	return BaseClass.Deploy(self)
end

function SWEP:ChoosePullAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChoosePullAnim then
		self.Callback.ChoosePullAnim(self)
	end

	if self:GetOwner():IsPlayer() then
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
	end

	self:SendViewModelAnim(ACT_VM_PULLPIN)

	if sp then
		self:CallOnClient("AnimForce", ACT_VM_PULLPIN)
	end

	return true, ACT_VM_PULLPIN
end

function SWEP:ChooseShootAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChooseShootAnim then
		self.Callback.ChooseShootAnim(self)
	end

	if self:GetOwner():IsPlayer() then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end

	local tanim = self:GetNW2Bool("Underhanded", false) and self.SequenceEnabled[ACT_VM_RELEASE] and ACT_VM_RELEASE or ACT_VM_THROW
	self:SendViewModelAnim(tanim)

	if sp then
		self:CallOnClient("AnimForce", tanim)
	end

	return true, tanim
end

function SWEP:ThrowStart()
	if self:Clip1() <= 0 then return end

	local success, tanim, animType = self:ChooseShootAnim()

	local delay = self:GetNW2Bool("Underhanded", false) and self.Delay_Underhand or self.Delay
	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW, delay)

	if success then
		self.LastNadeAnim = tanim
		self.LastNadeAnimType = animType
		self.LastNadeDelay = delay
	end
end

function SWEP:Throw()
	if self:Clip1() <= 0 then return end
	self.ProjectileVelocity = (self:GetNW2Bool("Underhanded", false) and self.Velocity_Underhand) or ((self.Velocity or 550) / 1.5)

	self:TakePrimaryAmmo(1)
	self:ShootBulletInformation()

	if self.LastNadeAnim then
		local len = self:GetActivityLength(self.LastNadeAnim, true, self.LastNadeAnimType)
		self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW_WAIT, len - (self.LastNadeDelay or len))
	end
end

function SWEP:Think2(...)
	if not self:OwnerIsValid() then return end

	local stat = self:GetStatus()

	-- This is the best place to do this since Think2 is called inside FinishMove
	self:SetNW2Bool("Underhanded", self.AllowUnderhanded and self:KeyDown(IN_ATTACK2))

	local statusend = CurTime() >= self:GetStatusEnd()

	if stat == TFA.Enum.STATUS_GRENADE_PULL and statusend then
		stat = TFA.Enum.STATUS_GRENADE_READY
		self:SetStatus(stat, math.huge)
	end

	if stat == TFA.Enum.STATUS_GRENADE_READY and (self:GetOwner():IsNPC() or not self:KeyDown(IN_ATTACK2) and not self:KeyDown(IN_ATTACK)) then
		self:ThrowStart()
	end

	if stat == TFA.Enum.STATUS_GRENADE_THROW and statusend then
		self:Throw()
	end

	if stat == TFA.Enum.STATUS_GRENADE_THROW_WAIT and statusend then
		self:Deploy()
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:PrimaryAttack()
	if self:Clip1() <= 0 or not self:OwnerIsValid() or not self:CanFire() then return end

	local _, tanim = self:ChoosePullAnim()

	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_PULL, self:GetActivityLength(tanim))
	self:SetNW2Bool("Underhanded", false)
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
	self:SetNW2Bool("Underhanded", self.AllowUnderhanded)
end

function SWEP:Reload()
	if self:Clip1() <= 0 and self:OwnerIsValid() and self:CanFire() then
		self:Deploy()
	end
end

function SWEP:CanFire() -- what
	if not self:CanPrimaryAttack() then return false end
	return true
end

function SWEP:ChooseIdleAnim(...)
	if self:GetStatus() == TFA.Enum.STATUS_GRENADE_READY then return end
	return BaseClass.ChooseIdleAnim(self, ...)
end

SWEP.CrosshairConeRecoilOverride = .05

TFA.FillMissingMetaValues(SWEP)
