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
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/spitball_small.mdl","models/spitball_medium.mdl","models/spitball_medium.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 70 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 20 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_ACID-- Damage type
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 10 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_ACID -- Damage type
ENT.DecalTbl_DeathDecals = {"VJ_Blood_Red"}
ENT.SoundTbl_Idle = {"vj_acid/acid_idle1.wav"}
ENT.SoundTbl_OnCollide = {"vj_acid/acid_splat.wav"}
ENT.VJ_IsPickupableDanger = true

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
ParticleEffectAttach("blood_impact_red_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
ParticleEffectAttach("blood_impact_red_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:CustomOnInitialize()
self:SetKeyValue("rendercolor","172 0 0 255")
ParticleEffectAttach("antlion_spit_trail",PATTACH_ABSORIGIN_FOLLOW,self,0)
ParticleEffect("antlion_spit",self:GetPos(),Angle(0,0,0),nil)
end
function ENT:CustomPhysicsObjectOnInitialize(phys)
phys:Wake()
phys:SetBuoyancyRatio(0)
phys:EnableDrag(false)
end

function ENT:DeathEffects(data,phys)
util.VJ_SphereDamage(self,self,self:GetPos(),300,20,DMG_NERVEGAS,true,true)
ParticleEffect("antliongib",self:GetPos(),Angle(0,0,0),nil)
local bloodeffect = EffectData()
bloodeffect:SetOrigin(self:GetPos()+self:OBBCenter())
bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
bloodeffect:SetScale(100)
util.Effect("VJ_Blood1",bloodeffect)		
local bloodspray = EffectData()
bloodspray:SetOrigin(self:GetPos()+self:OBBCenter())
bloodspray:SetScale(5)
bloodspray:SetFlags(3)
bloodspray:SetColor(0)
util.Effect("bloodspray",bloodspray)
util.Effect("bloodspray",bloodspray)
end