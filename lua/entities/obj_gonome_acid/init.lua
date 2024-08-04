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
ENT.Model = {"models/gibs/humans/sgib_01.mdl","models/gibs/humans/sgib_02.mdl","models/gibs/humans/sgib_03.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.DecalTbl_DeathDecals = {"Blood"}
ENT.SoundTbl_Idle = {"physics/flesh/flesh_bloody_impact_hard1.wav"}
ENT.SoundTbl_OnCollide = {"physics/flesh/flesh_squishy_impact_hard3.wav","physics/flesh/flesh_squishy_impact_hard1.wav","physics/flesh/flesh_squishy_impact_hard2.wav","physics/flesh/flesh_squishy_impact_hard4.wav"}
ENT.RadiusDamageRadius = 180 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 15 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_ACID -- Damage type
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = 30 -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_ACID -- Damage type
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	//phys:SetMass(1)
	phys:SetBuoyancyRatio(0)
	phys:EnableDrag(false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	ParticleEffectAttach("vj_impact1_red", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	ParticleEffectAttach("vj_impact1_red", PATTACH_ABSORIGIN_FOLLOW, self, 1)
//self:SetColor(Color(255,0,0,255))

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	ParticleEffectAttach("vj_impact1_red", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	ParticleEffectAttach("vj_impact1_red", PATTACH_ABSORIGIN_FOLLOW, self, 1)
	
end
---------------------------------------------------------------------------------------------------------------------------------------------

/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/