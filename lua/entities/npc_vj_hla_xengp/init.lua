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
ENT.Model = {"models/props/xen_infestation/xen_grenade_plant.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.GodMode = true
ENT.HullType = HULL_MEDIUM_TALL
ENT.MovementType = VJ_MOVETYPE_STATIONARY -- How does the SNPC move?
ENT.CanTurnWhileStationary = false -- Can the NPC turn while it's stationary?
------ AI / Relationship Variables ------
ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE -- The behavior of the SNPC
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
------ Melee Attack Variables ------
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.SoundTbl_Idle = {"world/infestation/xen_grenade_protect_idle_01.mp3","world/infestation/xen_grenade_protect_idle_02.mp3","world/infestation/xen_grenade_protect_idle_03.mp3","world/infestation/xen_grenade_protect_idle_04.mp3","world/infestation/xen_grenade_protect_idle_05.mp3","world/infestation/xen_grenade_protect_idle_06.mp3"}
ENT.PickedMissed = {"world/infestation/xen_grenade_picked_missed_vocal_reaction_01.mp3",
					"world/infestation/xen_grenade_picked_missed_vocal_reaction_02.mp3",
					"world/infestation/xen_grenade_picked_missed_vocal_reaction_03.mp3",
					"world/infestation/xen_grenade_picked_missed_vocal_reaction_04.mp3",
					"world/infestation/xen_grenade_picked_missed_vocal_reaction_05.mp3",
					"world/infestation/xen_grenade_picked_missed_vocal_reaction_06.mp3",
					"world/infestation/xen_grenade_picked_missed_vocal_reaction_07.mp3"}
ENT.Picked = {"world/infestation/xen_grenade_picked_vocal_reaction_01.mp3",
					"world/infestation/xen_grenade_picked_vocal_reaction_02.mp3",
					"world/infestation/xen_grenade_picked_vocal_reaction_03.mp3",
					"world/infestation/xen_grenade_picked_vocal_reaction_04.mp3"}
-- Custom
ENT.YURMOOM = false
ENT.BRUHPLS = false
ENT.CLOUDS = false
ENT.BRUHPLS2 = false
ENT.OOOHSHESALILLTLERUNAAYWY = false
ENT.NERVOUS = false
-----------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	local grenade = ents.Create("prop_dynamic_override")
	grenade:SetModel("models/weapons/w_vr_xen_grenade.mdl")
	grenade:SetPos(self:GetAttachment(1).Pos)
	grenade:SetParent(self,1)
	grenade:Spawn()
	self:DeleteOnRemove(grenade)
end

function ENT:CustomOnThink()
	if self.BRUHPLS == true then
		if self.CLOUDS == false then
			self.CLOUDS = true
			timer.Simple(15,function()
				if IsValid(self) then
					self:VJ_ACT_PLAYACTIVITY("ACT_ARM", true, 2.13333, false, 0)
					self:SetIdleAnimation({ACT_IDLE}, true)
					VJ_EmitSound(self,"world/infestation/xen_grenade_spawn_grenade.mp3",75,100)
				end
			end)
			timer.Simple(16.4,function()
				if IsValid(self) then
					VJ_EmitSound(self,"world/infestation/xen_grenade_protect_intro.mp3",75,100)
					self.BRUHPLS = false
					for k,v in pairs(self:GetChildren()) do
						v:SetNoDraw(false)
					end
					self.BRUHPLS2 = false
					self.OOOHSHESALILLTLERUNAAYWY = false
					self.NERVOUS = false
				end
			end)
		end
	end
	if self.OOOHSHESALILLTLERUNAAYWY == false then
		self.OOOHSHESALILLTLERUNAAYWY = true
		timer.Simple(30,function()
			if IsValid(self) then
				if self.YURMOOM == false and self.BRUHPLS2 == false then
					if self.NERVOUS == false then
						self.NERVOUS = true
						self:VJ_ACT_PLAYACTIVITY("vjseq_grenade_idle_present_intro", true, 0.725, false, 0)
						self:SetIdleAnimation({ACT_IDLE_STIMULATED}, true)
						VJ_EmitSound(self,"world/infestation/xen_grenade_protect_outro.mp3",75,100)
					end
				end
			end
		end)
	end
end

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
end

function ENT:AcceptInput(key, activator, caller, data)
	if activator:IsPlayer() and self.YURMOOM == false and self.BRUHPLS2 == false then
		if self.NERVOUS == false then
			if math.random(1,3) == 1 then
				self.BRUHPLS2 = true
				self.CLOUDS = false
				if self.BRUHPLS == false then
					self.BRUHPLS = true
					for k,v in pairs(self:GetChildren()) do
						v:SetNoDraw(true)
					end
					local xeng = ents.Create("weapon_vj_hla_xen_grenade")
					xeng:SetPos(self:GetAttachment(1).Pos)
					xeng:Spawn()
					
					local phys = xeng:GetPhysicsObject()
					if IsValid(phys) then
						phys:SetVelocity(self:GetForward()*30)
					end
				end
				self:VJ_ACT_PLAYACTIVITY("ACT_DISARM", true, 1.8, false, 0)
				VJ_EmitSound(self,"world/infestation/xen_grenade_picked.mp3",75,100)
				timer.Simple(0.4,function()
					if IsValid(self) then
						VJ_EmitSound(self,self.Picked,75,100)
					end
				end)
				timer.Simple(1.8,function()
					if IsValid(self) then
						self:SetIdleAnimation({ACT_IDLE_RELAXED}, true)
					end
				end)
			else
				self.YURMOOM = true
				self:VJ_ACT_PLAYACTIVITY("vjseq_grenade_idle_protect_intro", true, 0.833333, false, 0)
				VJ_EmitSound(self,"world/infestation/xen_grenade_protect_intro.mp3",75,100)
				VJ_EmitSound(self,self.PickedMissed,75,100)
				self:VJ_ACT_PLAYACTIVITY("vjseq_grenade_idle_protect_outro", true, 1, false, 0.833333)
				timer.Simple(0.833333,function()
					if IsValid(self) then
						-- self:SetIdleAnimation({ACT_IDLE_AGITATED}, true)
						VJ_EmitSound(self,"world/infestation/xen_grenade_protect_outro.mp3",75,100)
						self.YURMOOM = false
					end
				end)
			end
		else
			self.BRUHPLS2 = true
			self.CLOUDS = false
			if self.BRUHPLS == false then
				self.BRUHPLS = true
				for k,v in pairs(self:GetChildren()) do
					v:SetNoDraw(true)
				end
				local xeng = ents.Create("weapon_vj_hla_xen_grenade")
				xeng:SetPos(self:GetAttachment(1).Pos)
				xeng:Spawn()
				
				local phys = xeng:GetPhysicsObject()
				if IsValid(phys) then
					phys:SetVelocity(self:GetForward()*30)
				end
			end
			self:VJ_ACT_PLAYACTIVITY("ACT_DISARM", true, 1.8, false, 0)
				VJ_EmitSound(self,"world/infestation/xen_grenade_picked.mp3",75,100)
				timer.Simple(0.4,function()
					if IsValid(self) then
						VJ_EmitSound(self,self.Picked,75,100)
					end
				end)
			timer.Simple(1.8,function()
				if IsValid(self) then
					self:SetIdleAnimation({ACT_IDLE_RELAXED}, true)
				end
			end)
		end
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/