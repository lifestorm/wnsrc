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
ENT.Model = {"models/creatures/headcrabs/headcrab.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_TINY
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_zombieclassic","npc_vj_hla_zombiearmored","npc_vj_hla_zombiereviver","npc_vj_hla_zombiegunner","npc_vj_hla_zombieclassic_hl2","npc_vj_hla_bcrab_hl2"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
//ENT.DeathCorpseModel = {"models/hla/headcrab_rdoll.mdl"} -- The corpse model that it will spawn when it dies | Leave empty to use the NPC's model | Put as many models as desired, the base will pick a random one.
ENT.UsesBoneAngle = true -- This can be used to stop the corpse glitching or flying on death
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 3 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {"ACT_FLINCH_PHYSICS"} -- If it uses normal based animation, use this
------ Melee Attack Variables ------
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
------ Leap Attack Variables ------
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.LeapAttackDamage = GetConVarNumber("vj_hla_hcrab_d")
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.AnimTbl_LeapAttack = {"ACT_RANGE_ATTACK1"} -- Melee Attack Animations
ENT.LeapAttackAnimationFaceEnemy = false -- true = Face the enemy the entire time! | 2 = Face the enemy UNTIL it jumps! | false = Don't face the enemy AT ALL!
ENT.TimeUntilLeapAttackDamage = 2.4 -- How much time until it runs the leap damage code?
ENT.TimeUntilLeapAttackVelocity = 1.8 -- How much time until it runs the velocity code?
ENT.NextLeapAttackTime = 1.5 -- How much time until it can use a leap attack?
	-- ====== Distance Variables ====== --
ENT.LeapDistance = 200 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go?
ENT.LeapAttackAngleRadius = 10 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
	-- ====== Velocity Variables ====== --
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 225 -- How much upward force should it apply?
	-- ====== Movement & Idle Variables ====== --
ENT.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
ENT.AnimTbl_Walk = {ACT_WALK} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_RUN_STIMULATED}
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.FootStepTimeRun = .09 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = .4 -- Next foot step sound when it is walking
	-- ====== File Path Variables ====== --
ENT.SoundTbl_Idle = {"creatures/headcrab_classic/idle_chirp_01.wav","creatures/headcrab_classic/idle_chirp_02.wav","creatures/headcrab_classic/idle_chirp_03.wav","creatures/headcrab_classic/idle_chirp_04.wav","creatures/headcrab_classic/idle_chirp_05.wav","creatures/headcrab_classic/idle_chirp_06.wav","creatures/headcrab_classic/idle_chirp_07.wav","creatures/headcrab_classic/idle_chirp_08.wav","creatures/headcrab_classic/idle_chirp_09.wav","creatures/headcrab_classic/idle_chirp_10.wav","creatures/headcrab_classic/idle_chirp_11.wav","creatures/headcrab_classic/idle_chirp_12.wav","creatures/headcrab_classic/idle_chirp_13.wav","creatures/headcrab_classic/idle_chirp_14.wav","creatures/headcrab_classic/idle_chirp_15.wav"}
ENT.SoundTbl_LeapAttackJump = {"creatures/headcrab_classic/attack_grunt_01.wav","creatures/headcrab_classic/attack_grunt_02.wav","creatures/headcrab_classic/attack_grunt_03.wav","creatures/headcrab_classic/attack_grunt_04.wav","creatures/headcrab_classic/attack_grunt_05.wav","creatures/headcrab_classic/attack_grunt_06.wav"}
ENT.SoundTbl_LeapAttackDamage = {"player/damage/hc_bite_01.wav","player/damage/hc_bite_02.wav","player/damage/hc_bite_03.wav"}
ENT.SoundTbl_Pain = {"creatures/headcrab_classic/pain_01.wav","creatures/headcrab_classic/pain_02.wav","creatures/headcrab_classic/pain_03.wav","creatures/headcrab_classic/pain_04.wav","creatures/headcrab_classic/pain_05.wav","creatures/headcrab_classic/pain_06.wav"}
ENT.SoundTbl_Death = {"creatures/headcrab_classic/death_01.wav","creatures/headcrab_classic/death_02.wav","creatures/headcrab_classic/death_03.wav","creatures/headcrab_classic/death_04.wav"}
ENT.SoundTbl_Impact = {"physics/bullet_impacts/flesh_npc_01.wav",
					   "physics/bullet_impacts/flesh_npc_02.wav",
					   "physics/bullet_impacts/flesh_npc_03.wav",
				   	   "physics/bullet_impacts/flesh_npc_04.wav",
				   	   "physics/bullet_impacts/flesh_npc_05.wav",
				   	   "physics/bullet_impacts/flesh_npc_06.wav",
				   	   "physics/bullet_impacts/flesh_npc_07.wav",
				   	   "physics/bullet_impacts/flesh_npc_08.wav"}
ENT.FootStep = {"creatures/headcrab_classic/step_claw_01.wav",
						 "creatures/headcrab_classic/step_claw_02.wav",
						 "creatures/headcrab_classic/step_claw_03.wav",
						 "creatures/headcrab_classic/step_claw_04.wav",
						 "creatures/headcrab_classic/step_claw_05.wav",
						 "creatures/headcrab_classic/step_claw_06.wav",
						 "creatures/headcrab_classic/step_claw_07.wav",
						 "creatures/headcrab_classic/step_claw_08.wav"} 
-- Custom --
ENT.Alert = {"creatures/headcrab_classic/alerted_01.wav","creatures/headcrab_classic/alerted_02.wav","creatures/headcrab_classic/vox/attack_warning_01.wav","creatures/headcrab_classic/vox/attack_warning_02.wav","creatures/headcrab_classic/vox/attack_warning_03.wav","creatures/headcrab_classic/vox/attack_warning_04.wav"}
ENT.AlertGrowl = {"creatures/headcrab_classic/vox/yawn_01.wav","creatures/headcrab_classic/vox/yawn_02.wav","creatures/headcrab_classic/hideout/bold_hiss_01.wav","creatures/headcrab_classic/hideout/bold_hiss_02.wav","creatures/headcrab_classic/hideout/bold_hiss_03.wav","creatures/headcrab_classic/hideout/bold_hiss_04.wav"}
ENT.JumpWhoosh = {"creatures/headcrab_classic/movement/jump_attack_whoosh_01.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_02.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_03.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_04.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_05.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_06.wav"}
ENT.FleshImpactLayer = {"physics/bullet_impacts/flesh_layer_01.wav",
					    "physics/bullet_impacts/flesh_layer_02.wav"}
ENT.AttackHiss = {"creatures/headcrab_classic/vox/attack_hiss_01.wav","creatures/headcrab_classic/vox/attack_hiss_02.wav","creatures/headcrab_classic/vox/attack_hiss_03.wav","creatures/headcrab_classic/vox/attack_hiss_04.wav"}
ENT.Drowning = false
ENT.BodyImpact = {"creatures/headcrab_classic/movement/body_impact_02.wav","creatures/headcrab_classic/movement/body_impact_01.wav","creatures/headcrab_classic/movement/body_impact_03.wav","creatures/headcrab_classic/movement/body_impact_04.wav","creatures/headcrab_classic/movement/body_impact_05.wav","creatures/headcrab_classic/movement/body_impact_06.wav"}
ENT.Ragdolling = false
ENT.Running = false
ENT.sibuyas = false
ENT.olevels = false
ENT.BRUH = false
-----------------------------------------------------------------------------
function ENT:CustomOnFootStepSound()
	VJ_EmitSound(self,self.Step,70,100)
end

function ENT:CustomOnPreInitialize()
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		self.StartHealth = 28
		self.LeapAttackDamage = 20
	else
		self.StartHealth = 20
		self.LeapAttackDamage = 10
	end
end

function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(2.5, 2.5, 10), Vector(-2.5, -2.5, 0))
	if self:WaterLevel() == 3 then
		self.AnimTbl_IdleStand = {ACT_DIEVIOLENT} -- The idle animation when AI is enabled
		self.AnimTbl_Walk = {ACT_DIEVIOLENT}
		self.AnimTbl_Run = {ACT_DIEVIOLENT}
		self.DisableWandering = true -- Disables wandering when the SNPC is idle
		self.DisableChasingEnemy = true -- Disables the SNPC chasing the enemy
	else
		self.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN_STIMULATED}
		self.DisableWandering = false -- Disables wandering when the SNPC is idle
		self.DisableChasingEnemy = false -- Disables the SNPC chasing the enemy
	end
end

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	if evOptions == "headcrabfast_step" then
		VJ_EmitSound(self,self.FootStep,70,100)
	end
end

function ENT:CustomOnLeapAttack_BeforeStartTimer()
	timer.Simple(.3,function()
		if self:IsValid() then
			VJ_EmitSound(self,self.Alert,80,100)
		end
	end)
end

function ENT:CustomAttackCheck_LeapAttack()
	if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 150 and self:GetPos():Distance(self:GetEnemy():GetPos()) < 200 or self:GetPos():Distance(self:GetEnemy():GetPos()) >= 150 and self.Running == true and self:GetPos():Distance(self:GetEnemy():GetPos()) < 200 or self:GetPos():Distance(self:GetEnemy():GetPos()) < 150 and self.Running == true and !(self:IsMoving()) and self.BRUH == true then
		self.Running = false
		if self.BRUH == true then
			self.BRUH = false 
		end
		self:SetLastPosition(self:GetPos())
		return true
	elseif self:GetPos():Distance(self:GetEnemy():GetPos()) >= 150 and self:GetPos():Distance(self:GetEnemy():GetPos()) >= 200 and self:IsMoving() and self.Running == false then
		self.Running = true
		self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
		return false
	elseif self:GetPos():Distance(self:GetEnemy():GetPos()) < 150 and self.olevels == true and self.sibuyas == false and self.Running == false and self.BRUH == false then
		self.Running = true
		self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH")
		timer.Simple(1,function()
			if self:IsValid() then
				self.BRUH = true
			end
		end)
		return false
	end
end -- Not returning true will not let the leap attack code run!

function ENT:CustomOnLeapAttackVelocityCode()
	VJ_EmitSound(self,self.JumpWhoosh,75,100)
	VJ_EmitSound(self,self.AttackHiss,65,100)

	if self:GetEnemy():OBBMaxs().z > 75 or self:GetEnemy():OBBMaxs().z < 10 or self:GetPos():Distance(self:GetEnemy():GetPos()) > 200 then
		self:SetLocalVelocity((self:GetPos()+self:GetForward() - self:LocalToWorld(Vector(0, 0, 0)))*400 + self:GetForward()*self.LeapAttackVelocityForward + self:GetUp()*self.LeapAttackVelocityUp + self:GetRight()*self.LeapAttackVelocityRight)
--		return false
	elseif self:GetEnemy():OBBMaxs().z <= 36 then
		self:SetLocalVelocity(self:GetForward()*(self:GetPos():Distance(self:GetEnemy():GetPos()))*2 + self:GetUp()*(self:GetEnemy():OBBMaxs()+self:GetEnemy():OBBCenter())*4)
	else
		self:SetLocalVelocity(self:GetForward()*(self:GetPos():Distance(self:GetEnemy():GetPos()))*2 + self:GetUp()*(self:GetEnemy():OBBMaxs())*4)
	end
	return true
end -- Return true here to override the default velocity code

function ENT:CustomOnAlert(ent)
	if self:WaterLevel() ~= 3 and self.olevels == false then
		self:VJ_ACT_PLAYACTIVITY("ACT_RANGE_ATTACK2",true,1.5,false)
		timer.Simple(.4,function()
			if self:IsValid() then
				VJ_EmitSound(self,self.AlertGrowl,80,100)
			end
		end)
		timer.Simple(1.5,function()
			if self:IsValid() then
				self.olevels = true
			end
		end)
	end
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	VJ_EmitSound(self,self.FleshImpactLayer,60,100)
end

function ENT:CustomOnLeapAttack_AfterStartTimer(seed)
	if GetConVarNumber("vj_hla_enable_headcrab_ragdolling") == 1 or self:IsEFlagSet(EFL_IS_BEING_LIFTED_BY_BARNACLE) == false then
		timer.Simple(2.4,function()
			if self:IsValid() then
				self:SetNoDraw(true)
				self.HasLeapAttack = false
				self.sibuyas = true
				local ragd = ents.Create("prop_ragdoll")
				ragd:SetModel(self:GetModel())
				ragd:SetPos(self:GetPos())
				ragd:SetAngles(self:GetAngles())
				ragd:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
				ragd:Spawn()
				self.Ragdolling = true
				for i = 0, ragd:GetPhysicsObjectCount() - 1 do
					local crabdoll = ragd:GetPhysicsObjectNum(i)
					local bone_pos,bone_angle = self:GetBonePosition(ragd:TranslatePhysBoneToBone(i))
					crabdoll:SetPos(bone_pos)
					crabdoll:SetAngles(bone_angle)
				end
				local phys = ragd:GetPhysicsObject()
				if phys:IsValid() then
					phys:ApplyForceOffset(self:GetAbsVelocity()*9.30115,self:GetBonePosition(1))
				end
				if self:IsValid() then
					self:SetMoveType(MOVETYPE_NONE)
					self:SetOwner(ragd)
					self:SetParent(ragd)
					self:SetPos(ragd:GetPos())
				end
			//	if self:GetSequenceActivityName(self:GetSequence()) == "ACT_RANGE_ATTACK1" then
					timer.Simple(1.5,function()
						if self:IsValid() then
							self:SetOwner(nil)
							self:SetParent(nil)
							timer.Simple(.01,function()
								if ragd:IsValid() then
									ragd:Remove()
								end
								if self:IsValid() then
									self:SetNoDraw(false)
									self.HasLeapAttack = true
									self:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.5,true)
									VJ_EmitSound(self,self.BodyImpact,60,100)
									self:SetMoveType(MOVETYPE_STEP)
									self:SetLocalVelocity(self:GetBaseVelocity()*0)
									timer.Simple(1.5,function()
										if self:IsValid() then
											self.sibuyas = false
										end
									end)
								end
							end)
						else
							if ragd:IsValid() then
								ragd:Remove()
							end
							if self:IsValid() then
								self:SetNoDraw(false)
							end
						end
					end)
			//	end
			end
		end)
	else
		self:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.5,true,2.6)
	end
end

function ENT:CustomOnThink()
	if self:GetEnemy() and IsValid(self:GetEnemy()) then
		self.AnimTbl_Walk = {ACT_RUN_STIMULATED}
	else
		self.AnimTbl_Walk = {ACT_WALK}
	end
	if self:WaterLevel() == 3 then
		self.HasLeapAttack = false
		if self.Drowning == false then
			self.Drowning = true
			self.AnimTbl_IdleStand = {ACT_DIEVIOLENT} -- The idle animation when AI is enabled
			self.AnimTbl_Walk = {ACT_DIEVIOLENT}
			self.AnimTbl_Run = {ACT_DIEVIOLENT}
			self.DisableWandering = true -- Disables wandering when the SNPC is idle
			self.DisableChasingEnemy = true -- Disables the SNPC chasing the enemy
			self:VJ_ACT_PLAYACTIVITY("ACT_DIEVIOLENT",true,5.4,false)
			timer.Simple(5.4,function()
				if self:IsValid() and self.Drowning == true then
					self.Drowning = false
					if self:WaterLevel() == 3 then
						self:TakeDamage(self:GetMaxHealth(),self,self)
					end
				end
			end)
		end
	else
		self.HasLeapAttack = true
		self.Drowning = false
		if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
			if self:Health() < 14 then
				self.AnimTbl_IdleStand = {ACT_IDLE_AGITATED}
				self.AnimTbl_Walk = {ACT_WALK_AGITATED}
			else
				self.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
				self.AnimTbl_Walk = {ACT_WALK}
			end
		else
			if self:Health() < 10 then
				self.AnimTbl_IdleStand = {ACT_IDLE_AGITATED}
				self.AnimTbl_Walk = {ACT_WALK_AGITATED}
			else
				self.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
				self.AnimTbl_Walk = {ACT_WALK}
			end
		end
		self.DisableWandering = false -- Disables wandering when the SNPC is idle
		self.DisableChasingEnemy = false -- Disables the SNPC chasing the enemy
	end
	
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		if self:Health() >= 14 then return end
		if self:Health() < 14 then
			self.AnimTbl_IdleStand = {ACT_IDLE_AGITATED}
			self.AnimTbl_Walk = {ACT_WALK_AGITATED}
			self.AnimTbl_Run = {ACT_WALK_AGITATED}
			self.FootStepTimeWalk = .4
		end
	else
		if self:Health() >= 10 then return end
		if self:Health() < 10 then
			self.AnimTbl_IdleStand = {ACT_IDLE_AGITATED}
			self.AnimTbl_Walk = {ACT_WALK_AGITATED}
			self.AnimTbl_Run = {ACT_WALK_AGITATED}
			self.FootStepTimeWalk = .4
		end
	end
end
/*----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/