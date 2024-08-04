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
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/props/xen_infestation_v2/xen_v2_floater_jellybobber.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_TINY
ENT.Behavior =  VJ_BEHAVIOR_PASSIVE_NATURE -- The behavior of the SNPC
	-- ====== Health ====== --
ENT.StartHealth = 20 -- The starting health of the NPC
	-- ====== Movement Variables ====== --
	-- Types: VJ_MOVETYPE_GROUND | VJ_MOVETYPE_AERIAL | VJ_MOVETYPE_AQUATIC | VJ_MOVETYPE_STATIONARY | VJ_MOVETYPE_PHYSICS
ENT.MovementType = VJ_MOVETYPE_AERIAL -- How does the SNPC move?
	-- ====== Blood-Related Variables ====== --
	-- Leave custom blood tables empty to let the base decide depending on the blood type
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Blue" -- The blood type, this will determine what it should use (decal, particle, etc.)
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 1 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.SoundTbl_Death = {"damage/break_npc_critter_01.wav","damage/break_npc_critter_02.wav","damage/break_npc_critter_03.wav"}
ENT.onions = false
-----------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	ParticleEffectAttach("reviver_ambient_speks",PATTACH_ABSORIGIN_FOLLOW,self,1)
	self:SetCollisionBounds(Vector(-10,-10,0),Vector(10,10,40))
end

function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup) -- because flinching nor mal code doesnt awork!!!! or maybe im just stupid
	if math.random(1,5) == 5 and self.onions == false then
		self.onions = true
		self:VJ_ACT_PLAYACTIVITY("ACT_FLINCH_PHYSICS",true,4,false)
		timer.Simple(5, function()
			if self:IsValid() then
				self.onions = false
			end
		end)
	end
end
/*----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/