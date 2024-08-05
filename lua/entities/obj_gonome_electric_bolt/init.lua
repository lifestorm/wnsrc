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
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/spitball_medium.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 100 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 25 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_SHOCK -- Damage type
ENT.DelayedRemove = 1 -- Change this to a number greater than 0 to delay the removal of the entity
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_BeforeRangeAttack = {"alien_slave/vort_charge.wav"}
ENT.SoundTbl_Startup = {"alien_slave/vort_shoot.wav"}
ENT.SoundTbl_OnCollide = {"alien_slave/vort_explode1.wav","alien_slave/vort_explode2.wav"}
ENT.VJ_IsPickupableDanger = true

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
phys:Wake()
phys:EnableDrag(false)
phys:EnableGravity(false)
phys:SetBuoyancyRatio(0)
end
------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
self:SetNoDraw(true)
util.SpriteTrail(self,10,Color(0,255,255),true,100,0.6,0.6,12/(20+20)*30,"VJ_Base/sprites/vj_trial1.vmt")
util.SpriteTrail(self,10,Color(0,255,255),true,100,0.6,0.6,12/(20+20)*30,"VJ_Base/sprites/vj_trial1.vmt")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
ParticleEffect("electrical_arc_01_system",self:GetPos(),Angle(0,0,0),nil)
ParticleEffect("aurora_shockwave",self:GetPos(),Angle(0,0,0),nil)
ParticleEffect("hunter_projectile_explosion_1",data.HitPos,Angle(0,0,0),nil)
ParticleEffect("hunter_projectile_explosion_1",data.HitPos,Angle(0,0,0),nil)
end
--------------------------------------------------------------------------------------
function ENT:CustomOnThink()
ParticleEffectAttach("electrical_arc_01_system",PATTACH_POINT_FOLLOW,self,0)
ParticleEffectAttach("striderbuster_break_lightning", PATTACH_ABSORIGIN_FOLLOW, self, 0)
ParticleEffectAttach("striderbuster_break_lightning", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/