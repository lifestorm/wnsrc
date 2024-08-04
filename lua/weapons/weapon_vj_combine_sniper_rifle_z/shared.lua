--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Combine Sniper Rifle"
SWEP.Author = "Zippy"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.Category = "VJ Base"

SWEP.MadeForNPCsOnly = true
SWEP.WorldModel = "models/weapons/w_combine_sniper.mdl"
SWEP.ViewModel = "models/weapons/w_combine_sniper.mdl"
SWEP.HoldType = "ar2"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-15, 180, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(2, -20, 2)

SWEP.PrimaryEffects_MuzzleAttachment = "muzzle"
SWEP.PrimaryEffects_MuzzleParticles = {"vj_rifle_full"}
SWEP.PrimaryEffects_DynamicLightColor = Color(255, 150, 60)

SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.ClipSize = 3
SWEP.Primary.Damage = 60
SWEP.Primary.Force = 2
SWEP.Primary.TracerType = "HelicopterTracer"

SWEP.NPC_NextPrimaryFire = 2
SWEP.NPC_TimeUntilFire = 1
SWEP.NPC_FiringDistanceScale = 2
SWEP.NPC_CustomSpread = 0.5

SWEP.Primary.Sound = {"weapons/357_fire2.wav"}
SWEP.Primary.DistantSound = {"npc/sniper/echo1.wav"}

SWEP.Primary.DistantSoundLevel = 110 -- Distant sound level
SWEP.Primary.DistantSoundVolume	= 0.9 -- Distant sound volume

if CLIENT then
	function SWEP:CustomOnInitialize()

		self.SinRandMult1 = math.Rand(0.9, 1.1)
		self.SinRandMult2 = math.Rand(0.9, 1.1)

	end
end

function SWEP:CustomOnThink()

	local owner = self:GetOwner()

	if IsValid(owner) then
		if owner:IsPlayer() then
			self:SetNWVector("EnemyDir", self:EyeAngles():Forward())
		else
			local enemy = self:GetOwner():GetEnemy()

			if IsValid(enemy) && owner:Visible(enemy) && self:Clip1() > 0 then
				self:SetNWVector("EnemyDir", ( (enemy:GetPos() + enemy:OBBCenter()) - (self:GetPos() + self:OBBCenter()) ):GetNormalized() )
			elseif self:Clip1() < 1 then
				self:SetNWVector("EnemyDir", Vector(0,0,0))
			else
				self:SetNWVector("EnemyDir", self:GetAngles():Forward()*-100)
			end
		end
	end

end

function SWEP:CustomOnPrimaryAttackEffects()

	timer.Simple(0.5,function() if IsValid(self) && self:Clip1() != 0 then self:EmitSound( "NPC_Sniper.Reload", 100, math.random(85,115)) end end)
	local muzzle_pos = self:GetPos() + self:GetForward() * -30
	local expLight = ents.Create("light_dynamic")
	expLight:SetKeyValue("brightness", "4")
	expLight:SetKeyValue("distance", "200")
	expLight:Fire("Color", "0 75 255")
	expLight:SetPos(muzzle_pos)
	expLight:Spawn()
	expLight:Activate()
	expLight:Fire("TurnOn", "", 0)
	timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
	ParticleEffect("vj_rifle_full_blue", muzzle_pos, Angle(0,0,0), self)
	ParticleEffect( "hunter_muzzle_flash",muzzle_pos, self:GetAngles(), self )
	return false

end

function SWEP:CustomOnPrimaryAttack_BulletCallback(attacker, tr, dmginfo)
	-- local effectdata = EffectData()
	-- effectdata:SetOrigin(tr.HitPos)
	-- effectdata:SetNormal(tr.HitNormal)
	-- effectdata:SetRadius( 5 )
	-- util.Effect( "cball_bounce", effectdata )

	timer.Simple(0.1, function() sound.Play("npc/sniper/sniper1.wav", tr.HitPos, 130) end)
end

function SWEP:CustomOnReload()

	timer.Simple(1.5,function() if IsValid(self) then self:EmitSound( "NPC_Sniper.Reload", 100, math.random(85,115)) end end)

end


if SERVER then return end

SWEP.DefaultRenderBoundsSet = true

local laser2mat = Material("effects/blueblacklargebeam")
local laserdotmat = Material("particle/particle_glow_03")
local laserwidth = 2
local laserMaxDist = 10000

function SWEP:CustomOnDrawWorldModel()

	local laserstartpos = self:GetPos()
	local IdealPos = laserstartpos + self:GetNWVector("EnemyDir") * laserMaxDist

	--if !self.DefaultRenderBoxMins && !self.DefaultRenderBoxMaxs then
		--self.DefaultRenderBoxMins,self.DefaultRenderBoxMaxs = self:GetRenderBounds()
	--end

	if IdealPos != laserstartpos then

		local sin1 = math.sin(CurTime()*2)*self.SinRandMult1
		local sin2 = math.sin(CurTime()*2)*self.SinRandMult2

		if !self.trEndPos then
			self.trEndPos = IdealPos
		end

		self.trEndPos = LerpVector(0.15, self.trEndPos, IdealPos)

		local lasertracer = util.TraceLine({
			start = laserstartpos,
			endpos = self.trEndPos + Vector(sin1,sin2,sin1)*75,
			mask = MASK_SHOT,
			filter = {self,self:GetOwner()},
		})

		-- render.SetMaterial(laser1mat)
		-- render.SetShadowsDisabled(true)
		-- render.DrawBeam(laserstartpos, lasertracer.HitPos, laserwidth, 0, 20)
	
		render.SetMaterial(laser2mat)
		render.SetShadowsDisabled(true)
		render.DrawBeam(laserstartpos, lasertracer.HitPos, laserwidth, 0, 1, Color(0,100,255))

		render.SetMaterial(laserdotmat)
		render.DrawSprite(lasertracer.HitPos, laserwidth*3, laserwidth*3, Color(0,200,255))

		--self:SetRenderBoundsWS(laserstartpos, lasertracer.HitPos)
		--self.DefaultRenderBoundsSet = false

	elseif !self.DefaultRenderBoundsSet then

		--self:SetRenderBounds(self.DefaultRenderBoxMins,self.DefaultRenderBoxMaxs)
		--self.DefaultRenderBoundsSet = true
		--print("default render bounds set: " .. tostring(self.DefaultRenderBoxMins) .. ", " .. tostring(self.DefaultRenderBoxMaxs))
	
	end

	return true

end