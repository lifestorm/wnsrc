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
ENT.SoundTbl_Idle = {"creatures/headcrab_reviver/ranged_projectile_passby_01.wav","creatures/headcrab_reviver/ranged_projectile_passby_02.wav","creatures/headcrab_reviver/ranged_projectile_passby_03.wav","creatures/headcrab_reviver/ranged_projectile_passby_04.wav"}
ENT.SoundTbl_OnCollide = {"creatures/headcrab_reviver/ranged_impact_01.wav","creatures/headcrab_reviver/ranged_impact_02.wav"}
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
//	self:SetNoDraw(true)
//	ParticleEffectAttach("reviver_spit_projectile_v3",PATTACH_ABSORIGIN_FOLLOW,self,1)
	ParticleEffectAttach("reviver_spit_trail",PATTACH_ABSORIGIN_FOLLOW,self,1)
	ParticleEffectAttach("reviver_spit_projectile",PATTACH_ABSORIGIN_FOLLOW,self,1)
--	ParticleEffectAttach("spit_projectile",PATTACH_ABSORIGIN_FOLLOW,self,1)
	self:SetColor(Color(0,120,180,255))
end

function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:EnableGravity(true)
	phys:EnableDrag(true)
	phys:SetBuoyancyRatio(0)
end
/*
function ENT:CustomOnThink()
	local phys = self:GetPhysicsObject()
	if phys:IsValid() and self.dragonfruit == false then
		self.dragonfruit = true
		phys:ApplyForceCenter(self:GetForward()*2+Vector(0,0,250)) //250
	end
end
*/
function ENT:CustomOnRemove()
	ParticleEffect("reviver_spit_splash",self:GetPos()+Vector(0,0,5),self:GetAngles())
end