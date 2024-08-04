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
ENT.Model = {"models/creatures/headcrabs/headcrab_black.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_TINY
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_zombieclassic","npc_vj_hla_zombiearmored","npc_vj_hla_zombiereviver","npc_vj_hla_zombiegunner","npc_vj_hla_zombieclassic_hl2","npc_vj_hla_bcrab_hl2"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
	-- ====== Miscellaneous Variables ====== --
ENT.PushProps = true -- Should it push props when trying to move?
//ENT.AnimTbl_IdleStand = {"ACT_IDLE","ACT_IDLE2"}
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.UsesBoneAngle = true -- This can be used to stop the corpse glitching or flying on death
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 3 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
------ Melee Attack Variables ------
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
------ Leap Attack Variables ------
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.LeapAttackDamage = GetConVarNumber("vj_hla_hcrab_d")
ENT.LeapAttackDamageType = DMG_POISON -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.AnimTbl_LeapAttack = {} -- Melee Attack Animations
ENT.LeapAttackAnimationFaceEnemy = false -- true = Face the enemy the entire time! | 2 = Face the enemy UNTIL it jumps! | false = Don't face the enemy AT ALL!
//ENT.AnimTbl_LeapAttack = {"ACT_RANGE_ATTACK1","ACT_RANGE_ATTACK4"} -- Melee Attack Animations
//ENT.TimeUntilLeapAttackDamage = 1.7 -- How much time until it runs the leap damage code?
//ENT.TimeUntilLeapAttackVelocity = 1.2 -- How much time until it runs the velocity code?
//ENT.TimeUntilLeapAttackDamage = 2.1 -- How much time until it runs the leap damage code?
//ENT.TimeUntilLeapAttackVelocity = 1.6 -- How much time until it runs the velocity code?
//ENT.TimeUntilLeapAttackDamage = 1.9 -- How much time until it runs the leap damage code?
//ENT.TimeUntilLeapAttackVelocity = 1.4 -- How much time until it runs the velocity code?
ENT.NextLeapAttackTime = 1.5 -- How much time until it can use a leap attack?
	-- ====== Distance Variables ====== --
ENT.LeapDistance = 200 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go?
ENT.LeapAttackAngleRadius = 10 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
	-- ====== Velocity Variables ====== --
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 250 -- How much upward force should it apply?
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.FootStepTimeRun = .1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = .5 -- Next foot step sound when it is walking
	-- ====== File Path Variables ====== --
ENT.SoundTbl_Idle = {"creatures/headcrab_black/idle_01.wav","creatures/headcrab_black/idle_02.wav","creatures/headcrab_black/idle_03.wav","creatures/headcrab_black/idle_04.wav","creatures/headcrab_black/idle_05.wav","creatures/headcrab_black/idle_06.wav","creatures/headcrab_black/idle_07.wav","creatures/headcrab_black/idle_08.wav","creatures/headcrab_black/idle_09.wav","creatures/headcrab_black/idle_10.wav","creatures/headcrab_black/idle_clicks_01.wav","creatures/headcrab_black/idle_clicks_02.wav","creatures/headcrab_black/idle_clicks_03.wav","creatures/headcrab_black/idle_clicks_04.wav","creatures/headcrab_black/idle_clicks_05.wav"}
ENT.SoundTbl_LeapAttackJump = {"creatures/headcrab_black/attack_grunt_01.wav","creatures/headcrab_black/attack_grunt_02.wav","creatures/headcrab_black/attack_grunt_03.wav","creatures/headcrab_black/attack_grunt_04.wav"}
ENT.SoundTbl_LeapAttackDamage = {"creatures/headcrab_black/bite_01.wav","creatures/headcrab_black/bite_02.wav","creatures/headcrab_black/bite_03.wav","creatures/headcrab_black/bite_04.wav"}
ENT.SoundTbl_Pain = {"creatures/headcrab_black/pain_01.wav","creatures/headcrab_black/pain_02.wav","creatures/headcrab_black/pain_03.wav","creatures/headcrab_black/pain_04.wav","creatures/headcrab_black/pain_05.wav","creatures/headcrab_black/pain_06.wav"}
ENT.SoundTbl_Death = {"creatures/headcrab_black/die_01.wav","creatures/headcrab_black/die_02.wav","creatures/headcrab_black/die_03.wav"}
ENT.SoundTbl_Impact = {"physics/bullet_impacts/flesh_npc_01.wav",
					   "physics/bullet_impacts/flesh_npc_02.wav",
					   "physics/bullet_impacts/flesh_npc_03.wav",
				   	   "physics/bullet_impacts/flesh_npc_04.wav",
				   	   "physics/bullet_impacts/flesh_npc_05.wav",
				   	   "physics/bullet_impacts/flesh_npc_06.wav",
				   	   "physics/bullet_impacts/flesh_npc_07.wav",
				   	   "physics/bullet_impacts/flesh_npc_08.wav"}
ENT.SoundTbl_FootStep = {"creatures/headcrab_black/step_01.wav","creatures/headcrab_black/step_02.wav","creatures/headcrab_black/step_03.wav","creatures/headcrab_black/step_04.wav","creatures/headcrab_black/step_05.wav","creatures/headcrab_black/step_06.wav","creatures/headcrab_black/step_07.wav","creatures/headcrab_black/step_08.wav","creatures/headcrab_black/step_09.wav","creatures/headcrab_black/step_10.wav"}
 -- Custom --
ENT.Alert = {"creatures/headcrab_black/attack_growl_01.wav","creatures/headcrab_black/attack_growl_02.wav","creatures/headcrab_black/attack_growl_03.wav"}
ENT.AlertLayer = {"creatures/headcrab_black/attack_growl_layer_01.wav","creatures/headcrab_black/attack_growl_layer_02.wav","creatures/headcrab_black/attack_growl_layer_03.wav","creatures/headcrab_black/attack_growl_layer_04.wav","creatures/headcrab_black/attack_growl_layer_05.wav"}
ENT.JumpWhoosh = {"creatures/headcrab_black/movement/jump_attack_whoosh_01.wav","creatures/headcrab_black/movement/jump_attack_whoosh_02.wav","creatures/headcrab_black/movement/jump_attack_whoosh_03.wav","creatures/headcrab_black/movement/jump_attack_whoosh_04.wav","creatures/headcrab_black/movement/jump_attack_whoosh_05.wav","creatures/headcrab_black/movement/jump_attack_whoosh_06.wav"}
ENT.Threat = {"creatures/headcrab_black/vox/threaten_01.wav","creatures/headcrab_black/vox/threaten_02.wav","creatures/headcrab_black/vox/threaten_03.wav"}
ENT.Warning = {"creatures/headcrab_black/vox/attack_tell_01.wav","creatures/headcrab_black/vox/attack_tell_02.wav","creatures/headcrab_black/vox/attack_tell_03.wav","creatures/headcrab_black/vox/attack_tell_04.wav","creatures/headcrab_black/vox/attack_tell_05.wav"}
ENT.AttackScreech = {"creatures/headcrab_black/vox/attack_screech_01.wav","creatures/headcrab_black/vox/attack_screech_02.wav","creatures/headcrab_black/vox/attack_screech_03.wav","creatures/headcrab_black/vox/attack_screech_04.wav","creatures/headcrab_black/vox/attack_screech_05.wav","creatures/headcrab_black/vox/attack_screech_06.wav","creatures/headcrab_black/vox/attack_screech_07.wav","creatures/headcrab_black/vox/attack_screech_08.wav"}
ENT.AttackGruntLayer = {"creatures/headcrab_black/vox/attack_grunt_layer_01.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_02.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_03.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_04.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_05.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_06.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_07.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_08.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_09.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_10.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_11.wav",
						"creatures/headcrab_black/vox/attack_grunt_layer_12.wav"
						}
ENT.IdleClicks = {"creatures/headcrab_black/vox/idle_clicks_01.wav",
						"creatures/headcrab_black/vox/idle_clicks_02.wav",
						"creatures/headcrab_black/vox/idle_clicks_03.wav",
						"creatures/headcrab_black/vox/idle_clicks_04.wav",
						"creatures/headcrab_black/vox/idle_clicks_05.wav",
						"creatures/headcrab_black/vox/idle_clicks_06.wav"
						}
ENT.GruntShort = {"creatures/headcrab_black/vox/grunt_short_01.wav",
						"creatures/headcrab_black/vox/grunt_short_02.wav",
						"creatures/headcrab_black/vox/grunt_short_03.wav",
						"creatures/headcrab_black/vox/grunt_short_04.wav",
						"creatures/headcrab_black/vox/grunt_short_05.wav",
						"creatures/headcrab_black/vox/grunt_short_06.wav",
						"creatures/headcrab_black/vox/grunt_short_07.wav",
						"creatures/headcrab_black/vox/grunt_short_08.wav",
						"creatures/headcrab_black/vox/grunt_short_09.wav",
						"creatures/headcrab_black/vox/grunt_short_10.wav",
						"creatures/headcrab_black/vox/grunt_short_11.wav"
						}
ENT.GruntSoft = {"creatures/headcrab_black/vox/grunt_soft_01.wav",
						"creatures/headcrab_black/vox/grunt_soft_02.wav",
						"creatures/headcrab_black/vox/grunt_soft_03.wav",
						"creatures/headcrab_black/vox/grunt_soft_04.wav",
						"creatures/headcrab_black/vox/grunt_soft_05.wav"
						}
ENT.FleshImpactLayer = {"physics/bullet_impacts/flesh_layer_01.wav",
					    "physics/bullet_impacts/flesh_layer_02.wav"}
ENT.RattleWarningLayer = {"creatures/headcrab_black/rattle_warning_layer_01.wav","creatures/headcrab_black/rattle_warning_layer_02.wav","creatures/headcrab_black/rattle_warning_layer_03.wav","creatures/headcrab_black/rattle_warning_layer_04.wav","creatures/headcrab_black/rattle_warning_layer_05.wav","creatures/headcrab_black/rattle_warning_layer_06.wav"}
ENT.BodyImpact = {"creatures/headcrab_black/movement/body_impact_02.wav","creatures/headcrab_black/movement/body_impact_01.wav","creatures/headcrab_black/movement/body_impact_03.wav","creatures/headcrab_black/movement/body_impact_04.wav","creatures/headcrab_black/movement/body_impact_05.wav","creatures/headcrab_black/movement/body_impact_06.wav"}
ENT.RattleDeathLayer = {"creatures/headcrab_black/rattle_death_layer_01.wav","creatures/headcrab_black/rattle_death_layer_02.wav","creatures/headcrab_black/rattle_death_layer_03.wav","creatures/headcrab_black/rattle_death_layer_04.wav"}
ENT.StepLayer = {"creatures/headcrab_black/step_layer_01.wav",
				 "creatures/headcrab_black/step_layer_02.wav",
				 "creatures/headcrab_black/step_layer_03.wav",
				 "creatures/headcrab_black/step_layer_04.wav",
				 "creatures/headcrab_black/step_layer_05.wav",
				 "creatures/headcrab_black/step_layer_06.wav",
				 "creatures/headcrab_black/step_layer_07.wav",
				 "creatures/headcrab_black/step_layer_08.wav",
				 "creatures/headcrab_black/step_layer_09.wav",
				 "creatures/headcrab_black/step_layer_10.wav"}
ENT.Jump1 = false
ENT.Idle2 = false
ENT.Idle3 = false
ENT.Drowning = false
ENT.Running = false
ENT.sibuyas = false
ENT.olevels = false
ENT.BRUH = false
-----------------------------------------------------------------------------
function ENT:CustomOnFootStepSound()
	VJ_EmitSound(self,self.StepLayer,65,100)
end

function ENT:CustomOnPreInitialize()
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		self.StartHealth = 65
		self.LeapAttackDamage = 20
	else
		self.StartHealth = 50
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
		self.AnimTbl_Run = {ACT_RUN}
		self.DisableWandering = false -- Disables wandering when the SNPC is idle
		self.DisableChasingEnemy = false -- Disables the SNPC chasing the enemy
	end
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

function ENT:CustomOnLeapAttack_BeforeStartTimer()
	VJ_EmitSound(self,self.Warning,75,100)
	timer.Simple(.6,function()
		if self:IsValid() then
			VJ_EmitSound(self,self.Alert,75,100)
			VJ_EmitSound(self,self.AlertLayer,75,100)
			VJ_EmitSound(self,self.RattleWarningLayer,75,100)
		end
	end)
end

function ENT:CustomOnAlert(ent)
	if self:WaterLevel() ~= 3 and self.olevels == false then
		if math.random(1,2) == 1 then
			self:VJ_ACT_PLAYACTIVITY("ACT_IDLE2",true,2.76667,false)
			timer.Simple(2.76667,function()
				if self:IsValid() then
					self.olevels = true
				end
			end)
		else
			self:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1.5,false)
			timer.Simple(.5,function()
				if self:IsValid() then
					VJ_EmitSound(self,self.Threat,80,100)
				end
			end)
			timer.Simple(1.5,function()
				if self:IsValid() then
					self.olevels = true
				end
			end)
		end
	end
end

function ENT:CustomOnLeapAttackVelocityCode()
	VJ_EmitSound(self,self.JumpWhoosh,75,100)
	VJ_EmitSound(self,self.AttackScreech,75,100)
	VJ_EmitSound(self,self.AttackGruntLayer,75,100)
	
	if self:GetEnemy():OBBMaxs().z > 75 or self:GetEnemy():OBBMaxs().z < 10 or self:GetPos():Distance(self:GetEnemy():GetPos()) > 300 then
		self:SetLocalVelocity((self:GetPos()+self:GetForward() - self:LocalToWorld(Vector(0, 0, 0)))*400 + self:GetForward()*self.LeapAttackVelocityForward + self:GetUp()*self.LeapAttackVelocityUp + self:GetRight()*self.LeapAttackVelocityRight)
--		return false
	elseif self:GetEnemy():OBBMaxs().z <= 36 then
		self:SetLocalVelocity(self:GetForward()*(self:GetPos():Distance(self:GetEnemy():GetPos()))*2 + self:GetUp()*(self:GetEnemy():OBBMaxs()+self:GetEnemy():OBBCenter())*4)
	else
		self:SetLocalVelocity(self:GetForward()*(self:GetPos():Distance(self:GetEnemy():GetPos()))*2 + self:GetUp()*(self:GetEnemy():OBBMaxs())*4)
	end
	return true
end -- Return true here to override the default velocity code

function ENT:CustomOnThink()
	if self:GetSequenceName(self:GetSequence()) == "idle_sniff" and self.Idle2 == false then
		self.Idle2 = true
		VJ_EmitSound(self,"creatures/headcrab_black/vox/idle_sniff.wav",75,100)
		timer.Simple(5,function() 
			if self:IsValid() then
				self.Idle2 = false
			end
		end)
	end
	if self:GetSequenceName(self:GetSequence()) == "idle_sumo" and self.Idle3 == false then
		self.Idle3 = true
		VJ_EmitSound(self,self.IdleClicks,75,100)
		timer.Simple(.4,function()
			if self:IsValid() then
				VJ_EmitSound(self,self.GruntShort,75,100)
			end
		end)
		timer.Simple(1.3,function()
			if self:IsValid() then
				VJ_EmitSound(self,self.GruntShort,75,100)
			end
		end)
		timer.Simple(2.1,function()
			if self:IsValid() then
				VJ_EmitSound(self,self.GruntSoft,75,100)
			end
		end)
		timer.Simple(2.76667,function() 
			if self:IsValid() then
				self.Idle3 = false
			end
		end)
	end
	if self:GetEnemy() and self:GetEnemy():IsValid() then
		self.AnimTbl_Walk = {ACT_RUN}
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
		self.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self.DisableWandering = false -- Disables wandering when the SNPC is idle
		self.DisableChasingEnemy = false -- Disables the SNPC chasing the enemy
	end
end

function ENT:MultipleLeapAttacks()
	if math.random(1,2) == 1 then
		self.AnimTbl_LeapAttack = {"ACT_RANGE_ATTACK1"}
		self.TimeUntilLeapAttackDamage = 1.7 -- How much time until it runs the leap damage code?
		self.TimeUntilLeapAttackVelocity = 1.2 -- How much time until it runs the velocity code?
	else
		self.AnimTbl_LeapAttack = {"ACT_RANGE_ATTACK4"}
		self.TimeUntilLeapAttackDamage = 2.0 -- How much time until it runs the leap damage code?
		self.TimeUntilLeapAttackVelocity = 1.5 -- How much time until it runs the velocity code?
	end
end


function ENT:CustomOnLeapAttack_AfterStartTimer(seed)
	if GetConVarNumber("vj_hla_enable_headcrab_ragdolling") == 1 or self:IsEFlagSet(EFL_IS_BEING_LIFTED_BY_BARNACLE) == false then
		timer.Simple(1,function()
			if self:IsValid() then
				if self:GetSequenceActivityName(self:GetSequence()) == "ACT_RANGE_ATTACK1" then
					timer.Simple((self.TimeUntilLeapAttackDamage/2),function() //.8 //.75
						if self:IsValid() then
							self:SetNoDraw(true)
							self.HasLeapAttack = false
							self.sibuyas = true
							local ragd = ents.Create("prop_ragdoll")
							ragd:SetModel(self:GetModel())
							ragd:SetSkin(1)
							ragd:SetPos(self:GetPos())
							ragd:SetAngles(self:GetAngles())
							ragd:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
							ragd:Spawn()
							for i = 0, ragd:GetPhysicsObjectCount() - 1 do
								local crabdoll = ragd:GetPhysicsObjectNum(i)
								local bone_pos,bone_angle = self:GetBonePosition(ragd:TranslatePhysBoneToBone(i))
								crabdoll:SetPos(bone_pos)
								crabdoll:SetAngles(bone_angle)
							end
							local phys = ragd:GetPhysicsObject()
							if phys:IsValid() then
								phys:ApplyForceOffset(self:GetAbsVelocity()*33,self:GetBonePosition(1)) -- 
							end
							if self:IsValid() then
								self:SetMoveType(MOVETYPE_NONE)
								self:SetOwner(ragd)
								self:SetParent(ragd)
								self:SetPos(ragd:GetPos())
							end
							timer.Simple(math.random(1.5,2),function()
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
											self:VJ_ACT_PLAYACTIVITY("ACT_RANGE_ATTACK2",true,2.33333,true)
											VJ_EmitSound(self,self.BodyImpact,60,100)
											self:SetMoveType(MOVETYPE_STEP)
											self:SetLocalVelocity(self:GetBaseVelocity()*0)
											timer.Simple(2.33333,function()
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
						end
					end)
			elseif self:GetSequenceActivityName(self:GetSequence()) == "ACT_RANGE_ATTACK4" then
					timer.Simple((self.TimeUntilLeapAttackDamage/2),function() //1.2 //1.0
						if self:IsValid() then
							self:SetNoDraw(true)
							self.HasLeapAttack = false
							self.sibuyas = true
							local ragd = ents.Create("prop_ragdoll")
							ragd:SetModel(self:GetModel())
							ragd:SetSkin(1)
							ragd:SetPos(self:GetPos())
							ragd:SetAngles(self:GetAngles())
							ragd:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
							ragd:Spawn()
							for i = 0, ragd:GetPhysicsObjectCount() - 1 do
								local crabdoll = ragd:GetPhysicsObjectNum(i)
								local bone_pos,bone_angle = self:GetBonePosition(ragd:TranslatePhysBoneToBone(i))
								crabdoll:SetPos(bone_pos)
								crabdoll:SetAngles(bone_angle)
							end
							local phys = ragd:GetPhysicsObject()
							if phys:IsValid() then
								phys:ApplyForceOffset(self:GetAbsVelocity()*33,self:GetBonePosition(1))
							end
							if self:IsValid() then
								self:SetMoveType(MOVETYPE_NONE)
								self:SetOwner(ragd)
								self:SetParent(ragd)
								self:SetPos(ragd:GetPos())
							end
							timer.Simple(math.random(1.5,2),function()
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
											self:VJ_ACT_PLAYACTIVITY("ACT_RANGE_ATTACK2",true,2.33333,true)
											VJ_EmitSound(self,self.BodyImpact,60,100)
											self:SetMoveType(MOVETYPE_STEP)
											self:SetLocalVelocity(self:GetBaseVelocity()*0)
											timer.Simple(2.33333,function()
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
						end
					end)
				end
			end
		end)
	else
		self:VJ_ACT_PLAYACTIVITY("ACT_RANGE_ATTACK2",true,2.33333,true,2.45)
	end
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	VJ_EmitSound(self,self.FleshImpactLayer,60,100)
end

function ENT:CustomOnKilled()
	VJ_EmitSound(self,self.RattleDeathLayer,80,100)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/