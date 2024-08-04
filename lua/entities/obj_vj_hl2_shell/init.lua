--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/Items/AR2_Grenade.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 250 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 80 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_BLAST -- Damage type
ENT.RadiusDamageForce = 1 -- Put the force amount it should apply | false = Don't apply any force
ENT.ShakeWorldOnDeath = true -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 16 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 300 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathtDuration = 1 -- How long the screen shake will last, in seconds
ENT.ShakeWorldOnDeathFrequency = 100 -- The frequency
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_OnCollide = {"weapons/hegrenade/he_bounce-1.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(true)
	phys:SetMass(30)
	phys:SetBuoyancyRatio(0)
end


function ENT:CustomOnThink()

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPhysicsCollide(data,phys)
	getvelocity = phys:GetVelocity()
	velocityspeed = getvelocity:Length()
	//print(velocityspeed)
	if velocityspeed > 300 then -- Or else it will go flying!
		phys:SetVelocity(getvelocity * 0.9)
	end
	
	if velocityspeed > 50 then -- If the grenade is going faster than 100, then play the touch sound
		self:OnCollideSoundCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	//effectdata:SetScale( 500 )
	util.Effect( "HelicopterMegaBomb", effectdata )
	util.Effect( "ThumperDust", effectdata )
	util.Effect( "Explosion", effectdata )
	util.Effect( "VJ_Small_Explosion1", effectdata )

	self.ExplosionLight1 = ents.Create("light_dynamic")
	self.ExplosionLight1:SetKeyValue("brightness", "4")
	self.ExplosionLight1:SetKeyValue("distance", "300")
	self.ExplosionLight1:SetLocalPos(self:GetPos())
	self.ExplosionLight1:SetLocalAngles( self:GetAngles() )
	self.ExplosionLight1:Fire("Color", "255 150 0")
	self.ExplosionLight1:SetParent(self)
	self.ExplosionLight1:Spawn()
	self.ExplosionLight1:Activate()
	self.ExplosionLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(self.ExplosionLight1)
	util.ScreenShake(self:GetPos(), 100, 200, 1, 2500)

	self:SetLocalPos(Vector(self:GetPos().x,self:GetPos().y,self:GetPos().z +4)) -- Because the entity is too close to the ground
	local tr = util.TraceLine({
	start = self:GetPos(),
	endpos = self:GetPos() - Vector(0, 0, 100),
	filter = self })
	util.Decal(VJ_PICKRANDOMTABLE(self.DecalTbl_DeathDecals),tr.HitPos+tr.HitNormal,tr.HitPos-tr.HitNormal)
	
	self:DoDamageCode()
	self:SetDeathVariablesTrue(nil,nil,false)
	self:Remove()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/