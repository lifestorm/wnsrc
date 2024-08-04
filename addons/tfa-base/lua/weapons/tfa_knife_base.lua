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

DEFINE_BASECLASS("tfa_gun_base")
SWEP.DrawCrosshair = true
SWEP.Primary.Automatic = true
SWEP.Secondary.Automatic = true
SWEP.Primary.RPM = 120 --Primary Slashs per minute
SWEP.Secondary.RPM = 60 --Secondary stabs per minute
SWEP.Primary.Delay = 0.15 --Delay for hull (primary)
SWEP.Secondary.Delay = 0.33 --Delay for hull (secondary)
SWEP.Primary.Length = 32
SWEP.Secondary.Length = 48
SWEP.Primary.Sound = Sound("Weapon_Knife.Slash") --Sounds
SWEP.KnifeShink = "Weapon_Knife.HitWall" --Sounds
SWEP.KnifeSlash = "Weapon_Knife.Hit" --Sounds
SWEP.KnifeStab = "Weapon_Knife.Slash" --Sounds
SWEP.SlashTable = {"midslash1", "midslash2"} --Table of possible hull sequences
SWEP.StabTable = {"stab"} --Table of possible hull sequences
SWEP.StabMissTable = {"stab_miss"} --Table of possible hull sequences
SWEP.DisableIdleAnimations = false --Enable idles
--[[ Don't Edit Below ]]
--
SWEP.DamageType = DMG_SLASH
SWEP.MuzzleFlashEffect = "" --No muzzle
SWEP.DoMuzzleFlash = false --No muzzle
SWEP.WeaponLength = 1 --No nearwall
SWEP.Primary.Ammo = "" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.Primary.ClipSize = 1 -- Size of a clip
SWEP.Primary.DefaultClip = 1 -- Bullets you start with
SWEP.data = {} --No ironsights
SWEP.Secondary.IronSightsEnabled = false --No ironsights
SWEP.Secondary.DisplaySpread = false
SWEP.IsMelee = true

SWEP.CrosshairConeRecoilOverride = .05

SWEP.HullData = {
	hullMin = Vector(-16, -16, -16),
	hullMax = Vector(16, 16, 16)
}

SWEP.Primary.DisplayFalloff = false

SWEP.SlashCounter = 1
SWEP.StabCounter = 1

function SWEP:Deploy()
	return BaseClass.Deploy(self)
end

local lim_up_vec = Vector(1,1,0.1)

function SWEP:ApplyForce(ent, force, posv, now)
	if not IsValid(ent) or not ent.GetPhysicsObjectNum then return end

	if now then
		if ent.GetRagdollEntity then
			ent = ent:GetRagdollEntity() or ent
		end

		if not IsValid(ent) then return end
		local phys = ent:GetPhysicsObjectNum(0)

		if IsValid(phys) then
			if ent:IsPlayer() or ent:IsNPC() then
				ent:SetVelocity( force * 0.1 * lim_up_vec )
				phys:SetVelocity(phys:GetVelocity() + force * 0.1 * lim_up_vec )
			else
				phys:ApplyForceOffset(force, posv)
			end
		end
	else
		timer.Simple(0, function()
			if IsValid(self) and self:OwnerIsValid() and IsValid(ent) then
				self:ApplyForce(ent, force, posv, true)
			end
		end)
	end
end

function SWEP:SlashSound(tr)
	if IsFirstTimePredicted() then
		if tr.Hit then
			if tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH then
				self:EmitSound(self.KnifeSlash)
			else
				self:EmitSound(self.KnifeShink)
			end
		else
			self:EmitSound(self.Primary_TFA.Sound)
		end
	end
end

function SWEP:GetSlashTrace(tbl, fwd)
	local ow = self:GetOwner()
	ow:LagCompensation(true)

	local traceRes = util.TraceLine(tbl)

	if (not traceRes.Hit) then
		if not self.HullData.Radius then
			self.HullData.Radius = self.HullData.hullMin:Distance(self.HullData.hullMax) / 2
		end

		local hd = self.HullData
		tbl.mins = -hd.hullMin
		tbl.maxs = hd.hullMax
		tbl.endpos = tbl.endpos - fwd * hd.Radius
		traceRes = util.TraceHull(tbl)
	end
	ow:LagCompensation(false)

	return traceRes
end

function SWEP:SmackDamage(tr, fwd, primary)
	if not tr.Entity:IsValid() then return end
	local dmg, force

	if primary then
		dmg = self:GetStatL("Primary.Damage")
	else
		dmg = self:GetStatL("Secondary.Damage")
	end

	force = dmg * 25
	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(self:GetOwner())
	dmginfo:SetInflictor(self)
	dmginfo:SetDamage(dmg)
	dmginfo:SetDamageType(self.DamageType)
	dmginfo:SetDamagePosition(tr.HitPos)
	dmginfo:SetReportedPosition(tr.StartPos)
	dmginfo:SetDamageForce(fwd * force)
	tr.Entity:DispatchTraceAttack(dmginfo, tr, fwd)
	self:ApplyForce( tr.Entity, dmginfo:GetDamageForce(), tr.HitPos )
end

function SWEP:SmackEffect(tr)
	local vSrc = tr.StartPos
	local bFirstTimePredicted = IsFirstTimePredicted()
	local bHitWater = bit.band(util.PointContents(vSrc), MASK_WATER) ~= 0
	local bEndNotWater = bit.band(util.PointContents(tr.HitPos), MASK_WATER) == 0

	local trSplash = bHitWater and bEndNotWater and util.TraceLine({
		start = tr.HitPos,
		endpos = vSrc,
		mask = MASK_WATER
	}) or not (bHitWater or bEndNotWater) and util.TraceLine({
		start = vSrc,
		endpos = tr.HitPos,
		mask = MASK_WATER
	})

	if (trSplash and bFirstTimePredicted) then
		local data = EffectData()
		data:SetOrigin(trSplash.HitPos)
		data:SetScale(1)

		if (bit.band(util.PointContents(trSplash.HitPos), CONTENTS_SLIME) ~= 0) then
			data:SetFlags(1) --FX_WATER_IN_SLIME
		end

		util.Effect("watersplash", data)
	end

	self:DoImpactEffect(tr, self.DamageType)

	if (tr.Hit and bFirstTimePredicted and not trSplash) then
		local data = EffectData()
		data:SetOrigin(tr.HitPos)
		data:SetStart(vSrc)
		data:SetSurfaceProp(tr.SurfaceProps)
		data:SetDamageType(self.DamageType)
		data:SetHitBox(tr.HitBox)
		data:SetEntity(tr.Entity)
		util.Effect("Impact", data)
	end
end

local tracedata = {}

function SWEP:Slash(bPrimary)
	local ow, gsp, ea, fw, tr, rpm, delay

	if bPrimary == nil then
		bPrimary = true
	end

	ow = self:GetOwner()
	gsp = ow:GetShootPos()
	ea = ow:EyeAngles()
	fw = ea:Forward()
	tracedata.start = gsp
	tracedata.endpos = gsp + fw * (bPrimary and self.Primary_TFA.Length or self.Secondary_TFA.Length)
	tracedata.filter = ow

	tr = self:GetSlashTrace(tracedata, fw)
	rpm = self:GetStatL("Primary.RPM")
	delay = self:GetStatL("Primary.Delay")
	self:SlashSound(tr)
	self:SmackDamage(tr, fw, bPrimary)
	self:SmackEffect(tr, fw, bPrimary)
	self:ScheduleStatus(TFA.Enum.STATUS_SHOOTING, 60 / rpm - delay)
end

function SWEP:CanAttack()
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return false end
	if CurTime() < self:GetNextPrimaryFire() then return false end
	return true
end

function SWEP:PrimaryAttack()
	if not self:CanAttack() then return end

	if self:GetNextPrimaryFire() < CurTime() and self:GetOwner():IsPlayer() and not self:GetOwner():KeyDown(IN_RELOAD) then
		self.SlashCounter = self.SlashCounter + 1

		if self.SlashCounter > #self.SlashTable then
			self.SlashCounter = 1
		end

		self:SendViewModelSeq(self.SlashTable[self.SlashCounter])

		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self:SetNextPrimaryFire(CurTime() + 1 / (self.Primary_TFA.RPM / 60))
		self:SetNextSecondaryFire(CurTime() + 1 / (self.Primary_TFA.RPM / 60))
		self:ScheduleStatus(TFA.Enum.STATUS_RELOADING, self.Primary_TFA.Delay)
	end
end

function SWEP:SecondaryAttack()

	if not self:CanAttack() then return end

	local ow, gsp, ea, fw, tr

	ow = self:GetOwner()
	gsp = ow:GetShootPos()
	ea = ow:EyeAngles()
	fw = ea:Forward()
	tracedata.start = gsp
	tracedata.endpos = gsp + fw * self.Secondary_TFA.Length
	tracedata.filter = ow

	tr = self:GetSlashTrace(tracedata, fw)

	if tr.Hit then
		self.StabIndex = self.StabIndex or 0
		self.StabIndex = self.StabIndex + 1

		if self.StabIndex > #self.StabTable then
			self.StabIndex = 1
		end

		self:SendViewModelSeq(self.StabTable[self.StabIndex])
	else
		self.StabMiss = self.StabMiss or 0
		self.StabMiss = self.StabMiss + 1

		if self.StabMiss > #self.StabMissTable then
			self.StabMiss = 1
		end

		self:SendViewModelSeq(self.StabMissTable[self.StabMiss])
	end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SetNextPrimaryFire(CurTime() + 60 / self.Secondary_TFA.RPM)
	self:SetNextSecondaryFire(CurTime() + 60 / self.Secondary_TFA.RPM )
	self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, self.Secondary_TFA.Delay)
end

function SWEP:ThrowKnife()
	if not IsFirstTimePredicted() then return end
	self:EmitSound(self.Primary_TFA.Sound)

	if SERVER then
		local ent = ents.Create("tfa_thrown_blade")

		if ent:IsValid() then
			ent:SetPos(self:GetOwner():GetShootPos())
			ent:SetAngles(self:GetOwner():EyeAngles())
			ent:SetModel(self.Primary_TFA.ProjectileModel or self.WorldModel)
			ent:SetOwner(self:GetOwner())
			ent:SetPhysicsAttacker(self:GetOwner())
			ent:Spawn()
			ent:Activate()
			ent:SetNW2String("ClassName", self:GetClass())
			local phys = ent:GetPhysicsObject()

			if IsValid(phys) then
				phys:SetVelocity(self:GetOwner():GetAimVector() * 1250)
				phys:AddAngleVelocity(Vector(0, 480, 0))
			end

			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			self:GetOwner():StripWeapon(self:GetClass())
		end
	end
end

function SWEP:Reload()
	if not self:OwnerIsValid() and self:GetOwner():KeyDown(IN_RELOAD) then return end
	self:ThrowKnife()
end

function SWEP:Think2(...)
	if self:GetStatus() == TFA.Enum.STATUS_SILENCER_TOGGLE and CurTime() > self:GetStatusEnd() then
		self:Slash(false)
	elseif self:GetStatus() == TFA.Enum.STATUS_RELOADING and CurTime() > self:GetStatusEnd() then
		self:Slash(true)
	end

	BaseClass.Think2(self, ...)
end

SWEP.IsKnife = true
SWEP.WeaponLength = 8

TFA.FillMissingMetaValues(SWEP)
