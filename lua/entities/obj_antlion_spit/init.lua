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
	*** Copyright (c) 2012-2020 by Mayhem, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/spitball_medium.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 100 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 15 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_SLASH -- Damage type
//ENT.DecalTbl_DeathDecals = {"BeerSplash"}
ENT.SoundTbl_Startup = {
"npc/creatures/antlion_ranged/poison_projectile_01.mp3",
"npc/creatures/antlion_ranged/poison_projectile_02.mp3",
"npc/creatures/antlion_ranged/poison_projectile_03.mp3",
"npc/creatures/antlion_ranged/poison_projectile_04.mp3",
"npc/creatures/antlion_ranged/poison_projectile_05.mp3",
"npc/creatures/antlion_ranged/poison_projectile_06.mp3",
}
ENT.SoundTbl_Idle = {
"npc/creatures/antlion_ranged/poison_projectile_loop.wav"
}
ENT.SoundTbl_OnCollide = {
"npc/creatures/antlion_ranged/poison_projectile_explode_01.mp3",
"npc/creatures/antlion_ranged/poison_projectile_explode_02.mp3",
"npc/creatures/antlion_ranged/poison_projectile_explode_03.mp3",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetNoDraw(true)
	ParticleEffectAttach("spit_trail_blue", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	ParticleEffect("splat_blue", data.HitPos, Angle(0,0,0), nil)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2020 by Mayhem, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/