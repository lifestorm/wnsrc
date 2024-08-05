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
AddCSLuaFile("shared.lua")
include("shared.lua")
/*--------------------------------------------------
	=============== Projectile Base ===============
	*** Copyright (c) 2012-2022 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Core Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/spitball_Medium.mdl"} -- The models it should spawn with | Picks a random one from the table
------ Collision / Damage Variables ------
ENT.RemoveOnHit = true -- Should it remove itself when it touches something? | It will run the hit sound, place a decal, etc.
	-- ====== Direct Damage Variables ====== --
ENT.DoesDirectDamage = true -- Should it do a direct damage when it hits something?
ENT.DirectDamage = GetConVarNumber("vj_hla_rcrab_d1") -- How much damage should it do when it hits something
ENT.DirectDamageType = DMG_SHOCK -- Damage type
----------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_Idle = {"creatures/zombie_revived/shockwave_projectile_loop.wav"}
ENT.SoundTbl_OnCollide = {"creatures/zombie_revived/shockwave_projectile_end_01.wav","creatures/zombie_revived/shockwave_projectile_end_02.wav","creatures/zombie_revived/shockwave_projectile_end_03.wav"}
ENT.ProjectileEndLayer = {"creatures/zombie_revived/shockwave_projectile_end_layer_01.wav","creatures/zombie_revived/shockwave_projectile_end_layer_02.wav"}
----------------------------------------------------------------------------------------------------------------------
ENT.dragonfruit = false
----------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		self.DirectDamage = 10
	else
		self.DirectDamage = 5
	end
end

function ENT:CustomOnInitialize()
	self:SetNoDraw(true)
--	util.SpriteTrail(self,0,Color(185,51,13,255),false,20,20,2,1 / ( 20 + 20 ) * 0.5,"particle/electrical/electrical_arc_looping_c.vmt")
	util.SpriteTrail(self,0,Color(125,34,9,255),false,20,20,2,1 / ( 20 + 20 ) * 0.5,"particle/electrical/electrical_arc_looping_c.vmt")
end

function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(false)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
end

function ENT:CustomOnThink()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect("StunstickImpact", effectdata)
	ParticleEffectAttach("reviver_shockwave_tracer_glow",PATTACH_ABSORIGIN_FOLLOW,self,1)
end

function ENT:CustomOnRemove()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	util.Effect("ManhackSparks", effectdata)
	VJ_EmitSound(self,self.ProjectileEndLayer,80,100)
end