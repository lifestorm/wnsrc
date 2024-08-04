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

local vector_origin = Vector()
local angle_zero = Angle()

local l_mathClamp = math.Clamp
local Lerp = Lerp
SWEP.MainBullet = {}
SWEP.MainBullet.Spread = Vector()

local function DisableOwnerDamage(a, b, c)
	if b.Entity == a and c then
		c:ScaleDamage(0)
	end
end

local ballistics_distcv = GetConVar("sv_tfa_ballistics_mindist")

local function BallisticFirebullet(ply, bul, ovr, angPreserve)
	local wep = ply:GetActiveWeapon()

	if TFA.Ballistics and TFA.Ballistics:ShouldUse(wep) then
		if ballistics_distcv:GetInt() == -1 or util.QuickTrace(ply:GetShootPos(), ply:GetAimVector() * 0x7fff, ply).HitPos:Distance(ply:GetShootPos()) > (ballistics_distcv:GetFloat() * TFA.Ballistics.UnitScale) then
			bul.SmokeParticle = bul.SmokeParticle or wep.BulletTracer or wep.TracerBallistic or wep.BallisticTracer or wep.BallisticsTracer

			if ovr then
				TFA.Ballistics:FireBullets(wep, bul, angPreserve or angle_zero, true)
			else
				TFA.Ballistics:FireBullets(wep, bul, angPreserve)
			end
		else
			ply:FireBullets(bul)
		end
	else
		ply:FireBullets(bul)
	end
end

--[[
Function Name:  ShootBulletInformation
Syntax: self:ShootBulletInformation().
Returns:   Nothing.
Notes:  Used to generate a self.MainBullet table which is then sent to self:ShootBullet, and also to call shooteffects.
Purpose:  Bullet
]]
--
local sv_tfa_damage_multiplier = GetConVar("sv_tfa_damage_multiplier")
local sv_tfa_damage_multiplier_npc = GetConVar("sv_tfa_damage_multiplier_npc")
local cv_dmg_mult_min = GetConVar("sv_tfa_damage_mult_min")
local cv_dmg_mult_max = GetConVar("sv_tfa_damage_mult_max")
local sv_tfa_recoil_legacy = GetConVar("sv_tfa_recoil_legacy")
local dmg, con, rec

function SWEP:ShootBulletInformation()
	--self:CalculateRatios()
	self:UpdateConDamage()

	self.lastbul = nil
	self.lastbulnoric = false
	self.ConDamageMultiplier = self:GetOwner():IsNPC() and sv_tfa_damage_multiplier_npc:GetFloat() or sv_tfa_damage_multiplier:GetFloat()

	if not IsFirstTimePredicted() then return end

	con, rec = self:CalculateConeRecoil()

	local tmpranddamage = math.Rand(cv_dmg_mult_min:GetFloat(), cv_dmg_mult_max:GetFloat())
	local basedamage = self.ConDamageMultiplier * self:GetStatL("Primary.Damage")
	dmg = basedamage * tmpranddamage

	local ns = self:GetStatL("Primary.NumShots")
	local clip = (self:GetStatL("Primary.ClipSize") == -1) and self:Ammo1() or self:Clip1()

	ns = math.Round(ns, math.min(clip / self:GetStatL("Primary.NumShots"), 1))

	self:ShootBullet(dmg, rec, ns, con)
end

function SWEP:PreSpawnProjectile(ent)
	-- override
end

function SWEP:PostSpawnProjectile(ent)
	-- override
end

--[[
Function Name:  ShootBullet
Syntax: self:ShootBullet(damage, recoil, number of bullets, spray cone, disable ricochet, override the generated self.MainBullet table with this value if you send it).
Returns:   Nothing.
Notes:  Used to shoot a self.MainBullet.
Purpose:  Bullet
]]
--
local TracerName
local cv_forcemult = GetConVar("sv_tfa_force_multiplier")
local sv_tfa_bullet_penetration_power_mul = GetConVar("sv_tfa_bullet_penetration_power_mul")
local sv_tfa_bullet_randomseed = GetConVar("sv_tfa_bullet_randomseed")

local randomseed = "tfa_" .. tostring({})

SWEP.Primary.SpreadPattern = ""
SWEP.Primary.SpreadBiasYaw = 1
SWEP.Primary.SpreadBiasPitch = 1

-- Default ComputeBulletDeviation implementation
-- Custom implementations should return two numbers
-- Yaw (X) and Pitch (Y) deviation
function SWEP:ComputeBulletDeviation(bulletNum, totalBullets, aimcone)
	local sharedRandomSeed

	if sv_tfa_bullet_randomseed:GetBool() then
		sharedRandomSeed = randomseed .. CurTime()
	else
		sharedRandomSeed = "TFA_ShootBullet" .. CurTime()
	end

	return
		-- Yaw
		util.SharedRandom(sharedRandomSeed, -aimcone * 45 * self:GetStatL("Primary.SpreadBiasYaw"), aimcone * 45 * self:GetStatL("Primary.SpreadBiasYaw"), totalBullets + 1 + bulletNum),
		-- Pitch
		util.SharedRandom(sharedRandomSeed, -aimcone * 45 * self:GetStatL("Primary.SpreadBiasPitch"), aimcone * 45 * self:GetStatL("Primary.SpreadBiasPitch"), bulletNum)
end

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
	if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
	num_bullets = num_bullets or 1
	aimcone = aimcone or 0

	self:SetLastGunFire(CurTime())

	if self:GetStatL("Primary.Projectile") then
		if CLIENT then return end

		for _ = 1, num_bullets do
			local ent = ents.Create(self:GetStatL("Primary.Projectile"))

			local ang = self:GetOwner():GetAimVector():Angle()

			if not sv_tfa_recoil_legacy:GetBool() then
				ang.p = ang.p + self:GetViewPunchP()
				ang.y = ang.y + self:GetViewPunchY()
			end

			ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
			ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))

			ent:SetPos(self:GetOwner():GetShootPos())
			ent:SetOwner(self:GetOwner())
			ent:SetAngles(ang)
			ent.damage = self:GetStatL("Primary.Damage")
			ent.mydamage = self:GetStatL("Primary.Damage")

			if self:GetStatL("Primary.ProjectileModel") then
				ent:SetModel(self:GetStatL("Primary.ProjectileModel"))
			end

			self:PreSpawnProjectile(ent)

			ent:Spawn()

			local dir = ang:Forward()
			dir:Mul(self:GetStatL("Primary.ProjectileVelocity"))

			ent:SetVelocity(dir)
			local phys = ent:GetPhysicsObject()

			if IsValid(phys) then
				phys:SetVelocity(dir)
			end

			if self.ProjectileModel then
				ent:SetModel(self:GetStatL("Primary.ProjectileModel"))
			end

			ent:SetOwner(self:GetOwner())

			self:PostSpawnProjectile(ent)
		end
		-- Source
		-- Dir of self.MainBullet
		-- Aim Cone X
		-- Aim Cone Y
		-- Show a tracer on every x bullets
		-- Amount of force to give to phys objects

		return
	end

	if self.Tracer == 1 then
		TracerName = "Ar2Tracer"
	elseif self.Tracer == 2 then
		TracerName = "AirboatGunHeavyTracer"
	else
		TracerName = "Tracer"
	end

	self.MainBullet.PCFTracer = nil

	if self:GetStatL("TracerName") and self:GetStatL("TracerName") ~= "" then
		if self:GetStatL("TracerPCF") then
			TracerName = nil
			self.MainBullet.PCFTracer = self:GetStatL("TracerName")
			self.MainBullet.Tracer = 0
		else
			TracerName = self:GetStatL("TracerName")
		end
	end

	local owner = self:GetOwner()

	self.MainBullet.Attacker = owner
	self.MainBullet.Inflictor = self
	self.MainBullet.Src = owner:GetShootPos()

	self.MainBullet.Dir = self:GetAimVector()
	self.MainBullet.HullSize = self:GetStatL("Primary.HullSize") or 0
	self.MainBullet.Spread.x = 0
	self.MainBullet.Spread.y = 0

	self.MainBullet.Num = 1

	if num_bullets == 1 then
		local dYaw, dPitch = self:ComputeBulletDeviation(1, 1, aimcone)

		local ang = self.MainBullet.Dir:Angle()
		local up, right = ang:Up(), ang:Right()

		ang:RotateAroundAxis(up, dYaw)
		ang:RotateAroundAxis(right, dPitch)

		self.MainBullet.Dir = ang:Forward()
	end

	self.MainBullet.Wep = self

	if self.TracerPCF then
		self.MainBullet.Tracer = 0
	else
		self.MainBullet.Tracer = self:GetStatL("TracerCount") or 3
	end

	self.MainBullet.TracerName = TracerName
	self.MainBullet.PenetrationCount = 0
	self.MainBullet.PenetrationPower = self:GetStatL("Primary.PenetrationPower") * sv_tfa_bullet_penetration_power_mul:GetFloat(1)
	self.MainBullet.InitialPenetrationPower = self.MainBullet.PenetrationPower
	self.MainBullet.AmmoType = self:GetPrimaryAmmoType()
	self.MainBullet.Force = self:GetStatL("Primary.Force") * cv_forcemult:GetFloat() * self:GetAmmoForceMultiplier()
	self.MainBullet.Damage = damage
	self.MainBullet.InitialDamage = damage
	self.MainBullet.InitialForce = self.MainBullet.Force
	self.MainBullet.InitialPosition = Vector(self.MainBullet.Src)
	self.MainBullet.HasAppliedRange = false

	if self.CustomBulletCallback then
		self.MainBullet.Callback2 = self.CustomBulletCallback
	else
		self.MainBullet.Callback2 = nil
	end

	if num_bullets > 1 then
		local ang_ = self.MainBullet.Dir:Angle()
		local up, right = ang_:Up(), ang_:Right()

		-- single callback per multiple bullets fix
		for i = 1, num_bullets do
			local bullet = table.Copy(self.MainBullet)

			local ang = Angle(ang_)

			local dYaw, dPitch = self:ComputeBulletDeviation(i, num_bullets, aimcone)
			ang:RotateAroundAxis(up, dYaw)
			ang:RotateAroundAxis(right, dPitch)

			bullet.Dir = ang:Forward()

			function bullet.Callback(attacker, trace, dmginfo)
				if not IsValid(self) then return end

				dmginfo:SetInflictor(self)
				dmginfo:SetDamage(dmginfo:GetDamage() * bullet:CalculateFalloff(trace.HitPos))

				if bullet.Callback2 then
					bullet.Callback2(attacker, trace, dmginfo)
				end

				self:CallAttFunc("CustomBulletCallback", attacker, trace, dmginfo)

				bullet:Penetrate(attacker, trace, dmginfo, self, {})
				self:PCFTracer(bullet, trace.HitPos or vector_origin)
			end

			BallisticFirebullet(owner, bullet, nil, ang)
		end

		return
	end

	function self.MainBullet.Callback(attacker, trace, dmginfo)
		if not IsValid(self) then return end

		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(dmginfo:GetDamage() * self.MainBullet:CalculateFalloff(trace.HitPos))

		if self.MainBullet.Callback2 then
			self.MainBullet.Callback2(attacker, trace, dmginfo)
		end

		self:CallAttFunc("CustomBulletCallback", attacker, trace, dmginfo)

		self.MainBullet:Penetrate(attacker, trace, dmginfo, self, {})
		self:PCFTracer(self.MainBullet, trace.HitPos or vector_origin)
	end

	BallisticFirebullet(owner, self.MainBullet)
end

local sp = game.SinglePlayer()

function SWEP:TFAMove(ply, movedata)
	local velocity = self:GetQueuedRecoil()

	if velocity:Length() ~= 0 then
		movedata:SetVelocity(movedata:GetVelocity() + velocity)
		self:SetQueuedRecoil(vector_origin)
	end
end

hook.Add("Move", "TFAMove", function(self, movedata)
	local weapon = self:GetActiveWeapon()

	if IsValid(weapon) and weapon.IsTFAWeapon then
		weapon:TFAMove(self, movedata)
	end
end)

local sv_tfa_recoil_mul_p = GetConVar("sv_tfa_recoil_mul_p")
local sv_tfa_recoil_mul_p_npc = GetConVar("sv_tfa_recoil_mul_p_npc")
local sv_tfa_recoil_mul_y = GetConVar("sv_tfa_recoil_mul_y")
local sv_tfa_recoil_mul_y_npc = GetConVar("sv_tfa_recoil_mul_y_npc")

local sv_tfa_recoil_viewpunch_mul = GetConVar("sv_tfa_recoil_viewpunch_mul")
local sv_tfa_recoil_eyeangles_mul = GetConVar("sv_tfa_recoil_eyeangles_mul")

function SWEP:SetRecoilVector(vector)
	if self:GetOwner():IsPlayer() then
		self:SetQueuedRecoil(vector)
	else
		self:GetOwner():SetVelocity(vector)
	end
end

function SWEP:QueueRecoil(vector)
	if self:GetOwner():IsPlayer() then
		self:SetQueuedRecoil(vector + self:GetQueuedRecoil())
	else
		self:GetOwner():SetVelocity(vector)
	end
end

function SWEP:Recoil(recoil, ifp)
	if sp and type(recoil) == "string" then
		local _, CurrentRecoil = self:CalculateConeRecoil()
		self:Recoil(CurrentRecoil, true)

		return
	end

	local owner = self:GetOwner()
	local isplayer = owner:IsPlayer()

	self:SetLastRecoil(CurTime())
	self:SetSpreadRatio(l_mathClamp(self:GetSpreadRatio() + self:GetStatL("Primary.SpreadIncrement"), 1, self:GetStatL("Primary.SpreadMultiplierMax")))
	self:QueueRecoil(-owner:GetAimVector() * self:GetStatL("Primary.Knockback") * cv_forcemult:GetFloat() * recoil / 5)

	local seed = self:GetSeed() + 1

	local kickP = util.SharedRandom("TFA_KickDown", self:GetStatL("Primary.KickDown"), self:GetStatL("Primary.KickUp"), seed) * recoil * -1
	local kickY = util.SharedRandom("TFA_KickHorizontal", -self:GetStatL("Primary.KickHorizontal"), self:GetStatL("Primary.KickHorizontal"), seed) * recoil

	if isplayer then
		kickP, kickY = kickP * sv_tfa_recoil_mul_p:GetFloat(), kickY * sv_tfa_recoil_mul_y:GetFloat()
	else
		kickP, kickY = kickP * sv_tfa_recoil_mul_p_npc:GetFloat(), kickY * sv_tfa_recoil_mul_y_npc:GetFloat()
	end

	local factor = 1 - self:GetStatL("Primary.StaticRecoilFactor")

	if self:GetIronSights() then
		factor = factor * Lerp(self:GetIronSightsProgress(), 1, self:GetStatL("Primary.IronRecoilMultiplier", 0.5))
	end

	factor = factor * Lerp(self:GetCrouchingRatio(), 1, self:GetStatL("CrouchAccuracyMultiplier", 0.5))

	local punchY = kickY * factor
	local deltaP = 0
	local deltaY = 0

	if self:HasRecoilLUT() then
		local ang = self:GetRecoilLUTAngle()

		if self:GetPrevRecoilAngleTime() < CurTime() then
			self:SetPrevRecoilAngleTime(CurTime() + 0.1)
			self:SetPrevRecoilAngle(ang)
		end

		local prev_recoil_angle = self:GetPrevRecoilAngle()
		deltaP = ang.p - prev_recoil_angle.p
		deltaY = ang.y - prev_recoil_angle.y
		self:SetPrevRecoilAngle(ang)
	end

	if isplayer then
		local maxdist = math.min(math.max(0, 89 + owner:EyeAngles().p - math.abs(owner:GetViewPunchAngles().p * 2)), 88.5)
		local punchP = l_mathClamp((kickP + deltaP * self:GetStatL("Primary.RecoilLUT_ViewPunchMult")) * factor, -maxdist, maxdist)

		owner:ViewPunch(Angle(punchP * sv_tfa_recoil_viewpunch_mul:GetFloat(), (punchY + deltaY * self:GetStatL("Primary.RecoilLUT_ViewPunchMult")) * sv_tfa_recoil_viewpunch_mul:GetFloat()))
	end

	if (not isplayer or not sv_tfa_recoil_legacy:GetBool()) and not self:HasRecoilLUT() then
		local maxdist2 = l_mathClamp(30 - math.abs(self:GetViewPunchP()), 0, 30)
		local punchP2 = l_mathClamp(kickP, -maxdist2, maxdist2) * factor

		self:SetViewPunchP(self:GetViewPunchP() + punchP2 * 1.5)
		self:SetViewPunchY(self:GetViewPunchY() + punchY * 1.5)
		self:SetViewPunchBuild(math.min(3, self:GetViewPunchBuild() + math.sqrt(math.pow(punchP2, 2) + math.pow(punchY, 2)) / 3) + 0.2)
	end

	if isplayer and ((game.SinglePlayer() and SERVER) or (CLIENT and ifp)) then
		local neweyeang = owner:EyeAngles()

		local ap, ay = (kickP + deltaP * self:GetStatL("Primary.RecoilLUT_AnglePunchMult")) * self:GetStatL("Primary.StaticRecoilFactor") * sv_tfa_recoil_eyeangles_mul:GetFloat(),
						(kickY + deltaY * self:GetStatL("Primary.RecoilLUT_AnglePunchMult")) * self:GetStatL("Primary.StaticRecoilFactor") * sv_tfa_recoil_eyeangles_mul:GetFloat()

		neweyeang.p = neweyeang.p + ap
		neweyeang.y = neweyeang.y + ay
		--neweyeang.p = l_mathClamp(neweyeang.p, -90 + math.abs(owner:GetViewPunchAngles().p), 90 - math.abs(owner:GetViewPunchAngles().p))
		owner:SetEyeAngles(neweyeang)
	end
end

--[[
Function Name:  GetAmmoRicochetMultiplier
Syntax: self:GetAmmoRicochetMultiplier().
Returns:  The ricochet multiplier for our ammotype.  More is more chance to ricochet.
Notes:  Only compatible with default ammo types, unless you/I mod that.  BMG ammotype is detected based on name and category.
Purpose:  Utility
]]
--
function SWEP:GetAmmoRicochetMultiplier()
	local am = string.lower(self:GetStatL("Primary.Ammo"))

	if (am == "pistol") then
		return 1.25
	elseif (am == "357") then
		return 0.75
	elseif (am == "smg1") then
		return 1.1
	elseif (am == "ar2") then
		return 0.9
	elseif (am == "buckshot") then
		return 2
	elseif (am == "slam") then
		return 1.5
	elseif (am == "airboatgun") then
		return 0.8
	elseif (am == "sniperpenetratedround") then
		return 0.5
	else
		return 1
	end
end

--[[
Function Name:  GetMaterialConcise
Syntax: self:GetMaterialConcise().
Returns:  The string material name.
Notes:  Always lowercase.
Purpose:  Utility
]]
--
function SWEP:GetAmmoForceMultiplier()
	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
	--AR2=Rifle ~= Caliber>.308
	--SMG1=SMG ~= Small/Medium Calber ~= 5.56 or 9mm
	--357=Revolver ~= .357 through .50 magnum
	--Pistol = Small or Pistol Bullets ~= 9mm, sometimes .45ACP but rarely.  Generally light.
	--Buckshot = Buckshot = Light, barely-penetrating sniper bullets.
	--Slam = Medium Shotgun Round
	--AirboatGun = Heavy, Penetrating Shotgun Round
	--SniperPenetratedRound = Heavy Large Rifle Caliber ~= .50 Cal blow-yer-head-off
	local am = string.lower(self:GetStatL("Primary.Ammo"))

	if (am == "pistol") then
		return 0.4
	elseif (am == "357") then
		return 0.6
	elseif (am == "smg1") then
		return 0.475
	elseif (am == "ar2") then
		return 0.6
	elseif (am == "buckshot") then
		return 0.5
	elseif (am == "slam") then
		return 0.5
	elseif (am == "airboatgun") then
		return 0.7
	elseif (am == "sniperpenetratedround") then
		return 1
	else
		return 1
	end
end

--[[
Function Name:  GetPenetrationMultiplier
Syntax: self:GetPenetrationMultiplier( concise material name).
Returns:  The multilier for how much you can penetrate through a material.
Notes:  Should be used with GetMaterialConcise.
Purpose:  Utility
]]
--
SWEP.Primary.PenetrationMaterials = {
	[MAT_DEFAULT] = 1,
	[MAT_VENT] = 0.4, --Since most is aluminum and stuff
	[MAT_METAL] = 0.6, --Since most is aluminum and stuff
	[MAT_WOOD] = 0.2,
	[MAT_PLASTIC] = 0.23,
	[MAT_FLESH] = 0.48,
	[MAT_CONCRETE] = 0.87,
	[MAT_GLASS] = 0.16,
	[MAT_SAND] = 1,
	[MAT_SLOSH] = 1,
	[MAT_DIRT] = 0.95, --This is plaster, not dirt, in most cases.
	[MAT_FOLIAGE] = 0.9
}

local fac

function SWEP:GetPenetrationMultiplier(mat)
	fac = self.Primary.PenetrationMaterials[mat or MAT_DEFAULT] or self.Primary.PenetrationMaterials[MAT_DEFAULT]

	return fac * (self:GetStatL("Primary.PenetrationMultiplier") and self:GetStatL("Primary.PenetrationMultiplier") or 1)
end

local decalbul = {
	Num = 1,
	Spread = vector_origin,
	Tracer = 0,
	TracerName = "",
	Force = 0,
	Damage = 0,
	Distance = 40
}

local maxpen
local penetration_max_cvar = GetConVar("sv_tfa_penetration_hardlimit")
local penetration_cvar = GetConVar("sv_tfa_bullet_penetration")
local ricochet_cvar = GetConVar("sv_tfa_bullet_ricochet")
local cv_rangemod = GetConVar("sv_tfa_range_modifier")
local cv_decalbul = GetConVar("sv_tfa_fx_penetration_decal")
local atype
local develop = GetConVar("developer")
local sv_tfa_debug = GetConVar("sv_tfa_debug")

function SWEP:SetBulletTracerName(nm)
	self.BulletTracerName = nm or self.BulletTracerName or ""
end

local debugcolors = {
	Color(166, 91, 236),
	Color(91, 142, 236),
	Color(29, 197, 208),
	Color(61, 232, 109),
	Color(194, 232, 61),
	Color(232, 178, 61),
	Color(232, 61, 129),
	Color(128, 31, 109),
}

local nextdebugcol = -1
local debugsphere1 = Color(149, 189, 230)
local debugsphere2 = Color(34, 43, 53)
local debugsphere3 = Color(255, 255, 255)
local debugsphere4 = Color(0, 0, 255)
local debugsphere5 = Color(12, 255, 0)

local IsInWorld, IsInWorld2

do
	local tr = {collisiongroup = COLLISION_GROUP_WORLD}

	function IsInWorld2(pos)
		tr.start = pos
		tr.endpos = pos
		return not util.TraceLine(tr).AllSolid
	end
end

if CLIENT then
	IsInWorld = IsInWorld2
else
	IsInWorld = util.IsInWorld
end

local MAX_CORRECTION_ITERATIONS = 20

-- bullettable can be nil
function SWEP:CalculateFalloff(InitialPosition, HitPos, bullettable)
	local dist = InitialPosition:Distance(HitPos)

	if not self.Primary.RangeFalloffLUTBuilt then return 1 end

	local target = self.Primary.RangeFalloffLUTBuilt

	if dist <= target[1][1] then
		return target[1][2]
	end

	if dist >= target[#target][1] then
		return target[#target][2]
	end

	for i = 1, #target - 1 do
		local a, b = target[i], target[i + 1]

		if a[1] <= dist and b[1] >= dist then
			return Lerp((dist - a[1]) / (b[1] - a[1]), a[2], b[2])
		end
	end

	return target[#target][2] -- wtf?
end

function SWEP.MainBullet:CalculateFalloff(HitPos)
	return self.Wep:CalculateFalloff(self.InitialPosition, HitPos, self)
end

local function shouldDisplayDebug()
	return SERVER and sv_tfa_debug:GetBool() and develop:GetBool() and DLib
end

function SWEP.MainBullet:Penetrate(ply, traceres, dmginfo, weapon, penetrated, previousStartPos)
	if hook.Run("TFA_Bullet_Penetrate", weapon, ply, traceres, dmginfo, penetrated, previousStartPos) == false then return end

	--debugoverlay.Sphere( self.Src, 5, 5, color_white, true)

	DisableOwnerDamage(ply, traceres, dmginfo)

	if self.TracerName and self.TracerName ~= "" then
		weapon.BulletTracerName = self.TracerName

		if game.SinglePlayer() then
			weapon:CallOnClient("SetBulletTracerName", weapon.BulletTracerName)
		end
	end

	if not IsValid(weapon) then return end

	local hitent = traceres.Entity

	self:HandleDoor(ply, traceres, dmginfo, weapon)

	atype = weapon:GetStatL("Primary.DamageType")
	dmginfo:SetDamageType(atype)

	if SERVER and IsValid(ply) and ply:IsPlayer() and IsValid(hitent) and (hitent:IsPlayer() or hitent:IsNPC() or type(hitent) == "NextBot") then
		weapon:SendHitMarker(ply, traceres, dmginfo)
	end

	if IsValid(traceres.Entity) and traceres.Entity:GetClass() == "npc_sniper" then
		traceres.Entity.TFAHP = (traceres.Entity.TFAHP or 100) - dmginfo:GetDamage()

		if traceres.Entity.TFAHP <= 0 then
			traceres.Entity:Fire("SetHealth", "", -1)
		end
	end

	local cl = hitent:GetClass()

	if cl == "npc_helicopter" then
		dmginfo:SetDamageType(bit.bor(dmginfo:GetDamageType(), DMG_AIRBOAT))
	end

	-- custom damage checks
	if atype ~= DMG_BULLET then
		--[[if cl == "npc_strider" and (dmginfo:IsDamageType(DMG_SHOCK) or dmginfo:IsDamageType(DMG_BLAST)) and traceres.Hit and IsValid(hitent) and hitent.Fire then
			hitent:SetHealth(math.max(hitent:Health() - dmginfo:GetDamage(), 2))

			if hitent:Health() <= 3 then
				hitent:Extinguish()
				hitent:Fire("sethealth", "-1", 0.01)
				dmginfo:ScaleDamage(0)
			end
		end]]

		if dmginfo:IsDamageType(DMG_BURN) and weapon.Primary.DamageTypeHandled and traceres.Hit and IsValid(hitent) and not traceres.HitWorld and not traceres.HitSky and dmginfo:GetDamage() > 1 and hitent.Ignite then
			hitent:Ignite(dmginfo:GetDamage() / 2, 1)
		end

		if dmginfo:IsDamageType(DMG_BLAST) and weapon.Primary.DamageTypeHandled and traceres.Hit and not traceres.HitSky then
			local tmpdmg = dmginfo:GetDamage()
			dmginfo:SetDamageForce(dmginfo:GetDamageForce() / 2)
			util.BlastDamageInfo(dmginfo, traceres.HitPos, weapon:GetStatL("Primary.BlastRadius") or (tmpdmg / 2)  )
			--util.BlastDamage(weapon, weapon:GetOwner(), traceres.HitPos, tmpdmg / 2, tmpdmg)
			local fx = EffectData()
			fx:SetOrigin(traceres.HitPos)
			fx:SetNormal(traceres.HitNormal)

			if weapon:GetStatL("Primary.ImpactEffect") then
				TFA.Effects.Create(weapon:GetStatL("Primary.ImpactEffect"), fx)
			elseif tmpdmg > 90 then
				TFA.Effects.Create("HelicopterMegaBomb", fx)
				TFA.Effects.Create("Explosion", fx)
			elseif tmpdmg > 45 then
				TFA.Effects.Create("cball_explode", fx)
			else
				TFA.Effects.Create("MuzzleEffect", fx)
			end

			dmginfo:ScaleDamage(0.15)
		end
	end

	if self:Ricochet(ply, traceres, dmginfo, weapon) then
		if shouldDisplayDebug() then
			DLib.debugoverlay.Text(traceres.HitPos - Vector(0, 0, 12), 'ricochet', 10)
		end

		return
	end

	if penetration_cvar and not penetration_cvar:GetBool() then return end
	if self.PenetrationCount > math.min(penetration_max_cvar:GetInt(100), weapon:GetStatL("Primary.MaxSurfacePenetrationCount", math.huge)) then return end
	-- source engine quirk - if bullet is fired too close to brush surface
	-- it is assumed to be fired right in front of it, rather than exact
	-- position you specified.
	if previousStartPos and previousStartPos:Distance(traceres.HitPos) < 0.05 then return end
	local oldTraceResHitPos = Vector(traceres.HitPos)

	local mult = weapon:GetPenetrationMultiplier(traceres.MatType)
	local newdir = (traceres.HitPos - traceres.StartPos):GetNormalized()
	local desired_length = l_mathClamp(self.PenetrationPower / mult, 0, l_mathClamp(sv_tfa_bullet_penetration_power_mul:GetFloat() * 100, 1000, 8000))
	local penetrationoffset = newdir * desired_length

	local pentrace = {
		start = traceres.HitPos,
		endpos = traceres.HitPos + penetrationoffset,
		mask = MASK_SHOT,
		filter = penetrated
	}

	local isent = IsValid(traceres.Entity)
	local startpos, decalstartpos

	if isent then
		table.insert(penetrated, traceres.Entity)
	else
		pentrace.start:Add(traceres.Normal)
		pentrace.start:Add(traceres.Normal)
		pentrace.collisiongroup = COLLISION_GROUP_WORLD
		pentrace.filter = NULL
	end

	local pentraceres = util.TraceLine(pentrace)
	local pentraceres2, pentrace2
	local loss
	local realstartpos

	if not isent then
		local acc_length = pentraceres.HitPos:Distance(pentraceres.StartPos)

		local ostart = pentrace.start
		local FractionLeftSolid = pentraceres.FractionLeftSolid
		local iter = 0

		local cond = (pentraceres.AllSolid or not IsInWorld2(pentraceres.HitPos)) and acc_length < desired_length

		while (pentraceres.AllSolid or not IsInWorld2(pentraceres.HitPos)) and acc_length <= desired_length and iter < MAX_CORRECTION_ITERATIONS do
			iter = iter + 1

			pentrace.start = pentraceres.HitPos + newdir * 8

			if shouldDisplayDebug() then
				DLib.debugoverlay.Cross(pentrace.start, 8, 10, Color(iter / MAX_CORRECTION_ITERATIONS * 255, iter / MAX_CORRECTION_ITERATIONS * 255, iter / MAX_CORRECTION_ITERATIONS * 255), true)
			end

			pentraceres = util.TraceLine(pentrace)
			acc_length = acc_length + pentraceres.HitPos:Distance(pentraceres.StartPos) + 8
		end

		if cond and not (pentraceres.AllSolid or not IsInWorld2(pentraceres.HitPos)) then
			pentraceres.FractionLeftSolid = ostart:Distance(pentrace.start) / ostart:Distance(pentrace.endpos) + pentraceres.FractionLeftSolid + 0.02
			pentrace.start = ostart
			pentraceres.StartPos = ostart
		else
			pentraceres.FractionLeftSolid = FractionLeftSolid
			pentrace.start = ostart
			pentraceres.StartPos = ostart
		end
	end

	if isent then
		startpos = pentraceres.HitPos - newdir
		local ent = traceres.Entity

		pentrace2 = {
			start = startpos,
			endpos = pentrace.start,
			mask = MASK_SHOT,
			ignoreworld = true,
			filter = function(ent2)
				return ent2 == ent
			end
		}

		pentraceres2 = util.TraceLine(pentrace2)
		loss = pentraceres2.HitPos:Distance(pentrace.start) * mult

		if pentraceres2.HitPos:Distance(pentrace.start) < 0.01 then
			-- bullet stuck in
			loss = self.PenetrationPower
		end

		decalstartpos = pentraceres2.HitPos + newdir * 3

		if shouldDisplayDebug() then
			nextdebugcol = (nextdebugcol + 1) % #debugcolors
			DLib.debugoverlay.Line(pentrace.start, pentrace.endpos, 10, debugcolors[nextdebugcol + 1], true)
			DLib.debugoverlay.Cross(pentrace.start, 8, 10, debugsphere1, true)
			DLib.debugoverlay.Cross(pentraceres2.HitPos, 8, 10, debugsphere2, true)
		end

		if self.IsBallistics then
			startpos = decalstartpos
		end

		realstartpos = decalstartpos
	else
		startpos = LerpVector(pentraceres.FractionLeftSolid, pentrace.start, pentrace.endpos) + newdir * 4
		realstartpos = startpos
		decalstartpos = startpos + newdir * 2
		loss = startpos:Distance(pentrace.start) * mult

		if shouldDisplayDebug() then
			nextdebugcol = (nextdebugcol + 1) % #debugcolors
			DLib.debugoverlay.Line(pentrace.start, pentrace.endpos, 10, debugcolors[nextdebugcol + 1], true)
			DLib.debugoverlay.Cross(pentrace.start, 8, 10, debugsphere1, true)
			DLib.debugoverlay.Cross(startpos, 8, 10, debugsphere2, true)
		end

		if pentraceres.AllSolid then
			return
		elseif not IsInWorld(pentraceres.HitPos) then
			return
		end

		if not IsInWorld2(startpos) then
			for i = 1, 10 do
				startpos = LerpVector(pentraceres.FractionLeftSolid, pentrace.start, pentrace.endpos) + newdir * ((4 - i) * 3)

				if IsInWorld2(startpos) then break end

				startpos = LerpVector(pentraceres.FractionLeftSolid, pentrace.start, pentrace.endpos) + newdir * ((4 + i) * 3)

				if IsInWorld2(startpos) then break end
			end

			if not IsInWorld2(startpos) then
				return
			end
		end
	end

	if self.PenetrationPower - loss <= 0 then
		if shouldDisplayDebug() then
			DLib.debugoverlay.Text(startpos, string.format('Lost penetration power %.3f %.3f', self.PenetrationPower, loss), 10)
		end

		return
	end

	self.PenetrationCount = self.PenetrationCount + 1
	local prev = self.PenetrationPower
	self.PenetrationPower = self.PenetrationPower - loss

	local mfac = self.PenetrationPower / self.InitialPenetrationPower

	if shouldDisplayDebug() and weapon.Primary.RangeFalloffLUTBuilt then
		DLib.debugoverlay.Text(traceres.HitPos + Vector(0, 0, 12), string.format('NEW Damage falloff final %.3f %.3f %.3f %.3f', self.InitialPosition:Distance(traceres.HitPos), self:CalculateFalloff(traceres.HitPos), mfac * self.InitialDamage * self:CalculateFalloff(traceres.HitPos), mfac), 12)
	end

	local Damage = self.InitialDamage * self:CalculateFalloff(realstartpos) * mfac

	local bul = {
		PenetrationPower = self.PenetrationPower,
		PenetrationCount = self.PenetrationCount,
		InitialPenetrationPower = self.InitialPenetrationPower,
		InitialDamage = self.InitialDamage,
		InitialForce = self.InitialForce,
		CalculateFalloff = self.CalculateFalloff,
		InitialPosition = self.InitialPosition,
		Src = startpos,
		Dir = newdir,
		Tracer = 1,
		TracerName = self.TracerName,
		IgnoreEntity = traceres.Entity,

		Num = 1,
		Force = self.InitialForce * mfac,
		Damage = Damage,
		Penetrate = self.Penetrate,
		MakeDoor = self.MakeDoor,
		HandleDoor = self.HandleDoor,
		Ricochet = self.Ricochet,
		Spread = vector_origin,
		Wep = weapon,
	}

	if shouldDisplayDebug()  then
		DLib.debugoverlay.Text(startpos, string.format('penetrate %.3f->%.3f %d %.3f', prev, self.PenetrationPower, self.PenetrationCount, mfac), 10)
	end

	function bul.Callback(attacker, trace, dmginfo2)
		if shouldDisplayDebug()  then
			DLib.debugoverlay.Cross(trace.HitPos, 8, 10, debugsphere3, true)
			DLib.debugoverlay.Text(trace.HitPos - Vector(0, 0, 7), string.format('hit %.3f %d', mfac, bul.PenetrationCount, bul.PenetrationPower), 10)
		end

		dmginfo2:SetInflictor(IsValid(bul.Wep) and bul.Wep or IsValid(ply) and ply or Entity(0))

		bul.Damage = self.InitialDamage * self:CalculateFalloff(trace.HitPos) * mfac
		dmginfo2:SetDamage(bul.Damage)

		hook.Run("TFA_BulletPenetration", bul, attacker, trace, dmginfo2)

		-- TODO: User died while bullet make penetration
		-- handle further penetrations even when user is dead
		if IsValid(bul.Wep) then
			bul:Penetrate(attacker, trace, dmginfo2, bul.Wep, penetrated, oldTraceResHitPos)
		end
	end

	decalbul.Dir = -newdir
	decalbul.Src = decalstartpos
	decalbul.Callback = DisableOwnerDamage

	if shouldDisplayDebug()  then
		DLib.debugoverlay.Cross(decalbul.Src, 8, 10, debugsphere4, true)
		DLib.debugoverlay.Cross(decalbul.Src + decalbul.Dir * decalbul.Distance, 8, 10, debugsphere5, true)
	end

	if self.PenetrationCount <= 1 and IsValid(weapon) then
		weapon:PCFTracer(self, pentraceres.HitPos or traceres.HitPos, true)
	end

	local fx = EffectData()
	fx:SetOrigin(bul.Src)
	fx:SetNormal(bul.Dir)

	fx:SetMagnitude((bul.PenetrationCount + 1) * 1000)
	fx:SetEntity(weapon)

	if IsValid(pentraceres.Entity) and pentraceres.Entity.EntIndex then
		fx:SetScale(pentraceres.Entity:EntIndex())
	end

	fx:SetRadius(bul.Damage / 32)
	TFA.Effects.Create("tfa_penetrate", fx)

	if cv_decalbul:GetBool() then
		ply:FireBullets(decalbul)
	end

	BallisticFirebullet(ply, bul, true)
end

local RicochetChanceEnum = {
	[MAT_GLASS] = 0,
	[MAT_PLASTIC] = 0.01,
	[MAT_DIRT] = 0.01,
	[MAT_GRASS] = 0.01,
	[MAT_SAND] = 0.01,
	[MAT_CONCRETE] = 0.15,
	[MAT_METAL] = 0.7,
	[MAT_DEFAULT] = 0.5,
	[MAT_FLESH] = 0.0
}

function SWEP.MainBullet:Ricochet(ply, traceres, dmginfo, weapon)
	if ricochet_cvar and not ricochet_cvar:GetBool() then return end
	maxpen = math.min(penetration_max_cvar and penetration_max_cvar:GetInt() - 1 or 1, weapon:GetStatL("Primary.MaxSurfacePenetrationCount", math.huge))
	if self.PenetrationCount > maxpen then return end
	local ricochetchance = RicochetChanceEnum[traceres.MatType] or RicochetChanceEnum[MAT_DEFAULT]
	local dir = traceres.HitPos - traceres.StartPos
	dir:Normalize()
	local dp = dir:Dot(traceres.HitNormal * -1)
	ricochetchance = ricochetchance * weapon:GetAmmoRicochetMultiplier()
	local riccbak = ricochetchance / 0.7
	local ricothreshold = 0.6
	ricochetchance = l_mathClamp(ricochetchance * ( 1 + l_mathClamp(1 - (dp + ricothreshold), 0, 1) ), 0, 1)
	if dp <= ricochetchance and math.Rand(0, 1) < ricochetchance then
		local ric = {}
		ric.Ricochet = self.Ricochet
		ric.Penetrate = self.Penetrate
		ric.MakeDoor = self.MakeDoor
		ric.HandleDoor = self.HandleDoor
		ric.Damage = self.Damage * 0.5
		ric.Force = self.Force * 0.5
		ric.Num = 1
		ric.Spread = vector_origin
		ric.Tracer = 0
		ric.Src = traceres.HitPos
		ric.Dir = ((2 * traceres.HitNormal * dp) + traceres.Normal) + (VectorRand() * 0.02)
		ric.PenetrationCount = self.PenetrationCount + 1
		self.PenetrationCount = self.PenetrationCount + 1

		if TFA.GetRicochetEnabled() then
			local fx = EffectData()
			fx:SetOrigin(ric.Src)
			fx:SetNormal(ric.Dir)
			fx:SetMagnitude(riccbak)
			TFA.Effects.Create("tfa_ricochet", fx)
		end

		BallisticFirebullet(ply, ric, true)

		return true
	end
end

local defaultdoorhealth = 250
local cv_doorres = GetConVar("sv_tfa_door_respawn")

function SWEP.MainBullet:MakeDoor(ent, dmginfo)
	local dir = dmginfo:GetDamageForce():GetNormalized()
	local force = dir * math.max(math.sqrt(dmginfo:GetDamageForce():Length() / 1000), 1) * 1000
	local pos = ent:GetPos()
	local ang = ent:GetAngles()
	local mdl = ent:GetModel()
	local ski = ent:GetSkin()
	ent:SetNotSolid(true)
	ent:SetNoDraw(true)
	local prop = ents.Create("prop_physics")
	prop:SetPos(pos + dir * 16)
	prop:SetAngles(ang)
	prop:SetModel(mdl)
	prop:SetSkin(ski or 0)
	prop:Spawn()
	prop:SetVelocity(force)
	prop:GetPhysicsObject():ApplyForceOffset(force, dmginfo:GetDamagePosition())
	prop:SetPhysicsAttacker(dmginfo:GetAttacker())
	prop:EmitSound("physics/wood/wood_furniture_break" .. tostring(math.random(1, 2)) .. ".wav", 110, math.random(90, 110))

	if cv_doorres and cv_doorres:GetInt() ~= -1 then
		timer.Simple(cv_doorres:GetFloat(), function()
			if IsValid(prop) then
				prop:Remove()
			end

			if IsValid(ent) then
				ent.TFADoorHealth = defaultdoorhealth
				ent:SetNotSolid(false)
				ent:SetNoDraw(false)
			end
		end)
	end
end

local cv_doordestruction = GetConVar("sv_tfa_bullet_doordestruction")
local sv_tfa_bullet_doordestruction_keep = GetConVar("sv_tfa_bullet_doordestruction_keep")

function SWEP.MainBullet:HandleDoor(ply, traceres, dmginfo, wep)
	-- Don't do anything if door desstruction isn't enabled
	if not cv_doordestruction:GetBool() then return end
	local ent = traceres.Entity
	if not IsValid(ent) then return end
	if not IsValid(ply) then return end
	if not ents.Create then return end
	if not ply.SetName then return end
	if ent.TFADoorUntouchable and ent.TFADoorUntouchable > CurTime() then return end
	ent.TFADoorHealth = ent.TFADoorHealth or defaultdoorhealth
	if ent:GetClass() ~= "func_door_rotating" and ent:GetClass() ~= "prop_door_rotating" then return end
	local realDamage = dmginfo:GetDamage() * self.Num
	ent.TFADoorHealth = l_mathClamp(ent.TFADoorHealth - realDamage, 0, defaultdoorhealth)
	if ent.TFADoorHealth > 0 then return end
	ply:EmitSound("ambient/materials/door_hit1.wav", 100, math.random(90, 110))

	if not sv_tfa_bullet_doordestruction_keep:GetBool() and self.Damage * self.Num > 100 then
		self:MakeDoor(ent, dmginfo)
		ent.TFADoorUntouchable = CurTime() + 0.5

		return
	end

	ply.oldname = ply:GetName()
	ply:SetName("bashingpl" .. ply:EntIndex())
	ent:Fire("unlock", "", .01)
	ent:SetKeyValue("Speed", "500")
	ent:SetKeyValue("Open Direction", "Both directions")
	ent:SetKeyValue("opendir", "0")
	ent:Fire("openawayfrom", "bashingpl" .. ply:EntIndex(), .01)

	timer.Simple(0.02, function()
		if IsValid(ply) then
			ply:SetName(ply.oldname)
		end
	end)

	timer.Simple(0.3, function()
		if IsValid(ent) then
			ent:SetKeyValue("Speed", "100")
		end
	end)

	timer.Simple(5, function()
		if IsValid(ent) then
			ent.TFADoorHealth = defaultdoorhealth
		end
	end)

	ent.TFADoorUntouchable = CurTime() + 5
end