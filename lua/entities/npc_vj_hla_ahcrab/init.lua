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
ENT.Model = {"models/creatures/headcrabs/headcrab_armored.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
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
	-- ====== No Chase After Certain Distance Variables ====== --
ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 175 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 0 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.UsesBoneAngle = true -- This can be used to stop the corpse glitching or flying on death
ENT.DeathCorpseSkin = 1 -- Used to override the death skin | -1 = Use the skin that the SNPC had before it died
	-- ====== Death Animation Variables ====== --
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"ACT_DIE_HEADSHOT","ACT_DIE_BACKSHOT","ACT_DIE_GUTSHOT","ACT_DIE_CHESTSHOT"} -- Death Animations
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
ENT.AnimTbl_LeapAttack = {"ACT_RANGE_ATTACK2"} -- Melee Attack Animations
ENT.LeapAttackAnimationFaceEnemy = false -- true = Face the enemy the entire time! | 2 = Face the enemy UNTIL it jumps! | false = Don't face the enemy AT ALL!
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.TimeUntilLeapAttackDamage = 2.4 -- How much time until it runs the leap damage code?
ENT.TimeUntilLeapAttackVelocity = 1.8 -- How much time until it runs the velocity code?
ENT.NextLeapAttackTime = 1.5 -- How much time until it can use a leap attack?
ENT.LeapAttackAngleRadius = 10 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
	-- ====== Distance Variables ====== --
ENT.LeapDistance = 200 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go? -- 50
	-- ====== Velocity Variables ====== --
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply? -- 100
ENT.LeapAttackVelocityUp = 225 -- How much upward force should it apply? -- 225
	-- ====== Movement & Idle Variables ====== --
ENT.AnimTbl_IdleStand = {"ACT_IDLE","ACT_IDLE2"} -- The idle animation when AI is enabled
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.FootStepTimeRun = .1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = .2 -- Next foot step sound when it is walking
	-- ====== File Path Variables ====== --
ENT.SoundTbl_Breath = {}
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
ENT.SoundTbl_FootStep = {"creatures/headcrab_classic/step_claw_01.wav",
						 "creatures/headcrab_classic/step_claw_02.wav",
						 "creatures/headcrab_classic/step_claw_03.wav",
						 "creatures/headcrab_classic/step_claw_04.wav",
						 "creatures/headcrab_classic/step_claw_05.wav",
						 "creatures/headcrab_classic/step_claw_06.wav",
						 "creatures/headcrab_classic/step_claw_07.wav",
						 "creatures/headcrab_classic/step_claw_08.wav"}
 -- Custom --
ENT.Alert = {"creatures/headcrab_classic/alerted_01.wav","creatures/headcrab_classic/alerted_02.wav","creatures/headcrab_classic/vox/attack_warning_01.wav","creatures/headcrab_classic/vox/attack_warning_02.wav","creatures/headcrab_classic/vox/attack_warning_03.wav","creatures/headcrab_classic/vox/attack_warning_04.wav"}
ENT.Grunt = {"creatures/headcrab_classic/grunt_01.wav","creatures/headcrab_classic/grunt_02.wav","creatures/headcrab_classic/grunt_03.wav","creatures/headcrab_classic/grunt_04.wav","creatures/headcrab_classic/grunt_05.wav","creatures/headcrab_classic/grunt_06.wav","creatures/headcrab_classic/grunt_07.wav","creatures/headcrab_classic/grunt_08.wav","creatures/headcrab_classic/grunt_09.wav","creatures/headcrab_classic/grunt_10.wav","creatures/headcrab_classic/grunt_11.wav","creatures/headcrab_classic/grunt_12.wav"}
ENT.JumpWhoosh = {"creatures/headcrab_classic/movement/jump_attack_whoosh_01.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_02.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_03.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_04.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_05.wav","creatures/headcrab_classic/movement/jump_attack_whoosh_06.wav"}
ENT.AlertGrowl = {"creatures/headcrab_classic/vox/yawn_01.wav","creatures/headcrab_classic/vox/yawn_02.wav","creatures/headcrab_classic/hideout/bold_hiss_01.wav","creatures/headcrab_classic/hideout/bold_hiss_02.wav","creatures/headcrab_classic/hideout/bold_hiss_03.wav","creatures/headcrab_classic/hideout/bold_hiss_04.wav"}
ENT.Warning = {"creatures/headcrab_classic/vox/attack_warning_growl_01.wav","creatures/headcrab_classic/vox/attack_warning_growl_02.wav","creatures/headcrab_classic/vox/attack_warning_growl_03.wav","creatures/headcrab_classic/vox/attack_warning_growl_04.wav","creatures/headcrab_classic/vox/attack_warning_growl_05.wav"}
ENT.ArmorImpact = {"physics/bullet_impacts/npc_armor_01.wav",
				   "physics/bullet_impacts/npc_armor_02.wav",
				   "physics/bullet_impacts/npc_armor_03.wav",
				   "physics/bullet_impacts/npc_armor_04.wav",
				   "physics/bullet_impacts/npc_armor_05.wav",
				   "physics/bullet_impacts/npc_armor_06.wav",
				   "physics/bullet_impacts/npc_armor_07.wav",
				   "physics/bullet_impacts/npc_armor_08.wav"}
ENT.FleshImpactLayer = {"physics/bullet_impacts/flesh_layer_01.wav",
					    "physics/bullet_impacts/flesh_layer_02.wav"}
ENT.AttackHiss = {"creatures/headcrab_classic/vox/attack_hiss_01.wav","creatures/headcrab_classic/vox/attack_hiss_02.wav","creatures/headcrab_classic/vox/attack_hiss_03.wav","creatures/headcrab_classic/vox/attack_hiss_04.wav"}
ENT.GruntShort = {"creatures/headcrab_classic/vox/grunt_short_01.wav",
				  "creatures/headcrab_classic/vox/grunt_short_02.wav",
				  "creatures/headcrab_classic/vox/grunt_short_03.wav",
				  "creatures/headcrab_classic/vox/grunt_short_04.wav",
				  "creatures/headcrab_classic/vox/grunt_short_05.wav",
				  "creatures/headcrab_classic/vox/grunt_short_06.wav",
				  "creatures/headcrab_classic/vox/grunt_short_07.wav",
				  "creatures/headcrab_classic/vox/grunt_short_08.wav",
				  "creatures/headcrab_classic/vox/grunt_short_09.wav",
				  "creatures/headcrab_classic/vox/grunt_short_10.wav",
				  "creatures/headcrab_classic/vox/grunt_short_11.wav"}
ENT.Step = {"creatures/headcrab_classic/step_01.wav","creatures/headcrab_classic/step_02.wav","creatures/headcrab_classic/step_03.wav","creatures/headcrab_classic/step_04.wav","creatures/headcrab_classic/step_05.wav","creatures/headcrab_classic/step_06.wav","creatures/headcrab_classic/step_07.wav","creatures/headcrab_classic/step_08.wav"}
ENT.BreakNPCCritter = {"damage/break_npc_critter_01.wav","damage/break_npc_critter_02.wav","damage/break_npc_critter_03.wav"}
ENT.Idle2 = false
ENT.BeforeFlipped = false
ENT.Flipped = false
ENT.ALERTPLS = false
ENT.Drowning = false
ENT.Running = false
ENT.goo = false
ENT.hitg = false
ENT.powerlah = false
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
//	ParticleEffectAttach("heartglow",PATTACH_POINT_FOLLOW,self,1)
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
	if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 150 and self:GetPos():Distance(self:GetEnemy():GetPos()) < 200 or self:GetPos():Distance(self:GetEnemy():GetPos()) >= 150 and self.Running == true and self:GetPos():Distance(self:GetEnemy():GetPos()) < 200 or self:GetPos():Distance(self:GetEnemy():GetPos()) < 150 and self.Running == true and !(self:IsMoving()) and self.BRUH == true or self:GetPos():Distance(self:GetEnemy():GetPos()) < 150 and self.ALERTPLS == true then
		self.Running = false
		self.HasDeathAnimation = true
		if self.BRUH == true then
			self.BRUH = false 
		end
		self:SetLastPosition(self:GetPos())
		return true
	elseif self:GetPos():Distance(self:GetEnemy():GetPos()) >= 150 and self:GetPos():Distance(self:GetEnemy():GetPos()) >= 200 and self:IsMoving() and self.Running == false then
		self.Running = true
		self.HasDeathAnimation = false
		self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
		return false
	elseif self:GetPos():Distance(self:GetEnemy():GetPos()) < 150 and self.olevels == true and self.sibuyas == false and self.Running == false and self.BRUH == false then
		self.Running = true
		self.HasDeathAnimation = false
		self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH")
		timer.Simple(1,function()
			if self:IsValid() then
				self.BRUH = true
			end
		end)
		return false
	end
end -- Not returning true will not let the leap attack code run!

function ENT:CustomOnLeapAttack_BeforeStartTimer(seed)	
	timer.Simple(.4,function()
		if self:IsValid() then
			VJ_EmitSound(self,self.Alert,80,100)
			timer.Simple(.3,function()
				if self:IsValid() then
					VJ_EmitSound(self,self.Warning,80,100)
				end
			end)
		end
	end)
end

function ENT:CustomOnLeapAttackVelocityCode()
	VJ_EmitSound(self,self.JumpWhoosh,75,100)
	VJ_EmitSound(self,self.AttackHiss,65,100)
	self.SoundTbl_Breath = {}
	
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

/*
function ENT:CustomOnDoKilledEnemy(ent, attacker, inflictor)
	if ent:GetClass() == "npc_citizen" then
		local npc = ents.Create("npc_vj_hla_zombiearmored")
		npc:SetPos(self:GetPos())
		npc:SetAngles(self:GetAngles())
		npc:Spawn()
		npc:SetModel("models/creatures/zombies/zombie_c17.mdl")
		self:Remove()
	end
end
*/

function ENT:CustomOnLeapAttack_AfterStartTimer(seed)
	if GetConVarNumber("vj_hla_enable_headcrab_ragdolling") == 1 or self:IsEFlagSet(EFL_IS_BEING_LIFTED_BY_BARNACLE) == false then
		timer.Simple(2.5,function()
			if self:IsValid() then
				if self:GetSequenceActivityName(self:GetSequence()) == "ACT_RANGE_ATTACK2" then
					self:SetNoDraw(true)
					self.HasLeapAttack = false
					self.sibuyas = true
					local ragd = ents.Create("prop_ragdoll")
					ragd:SetModel(self:GetModel())
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
						phys:ApplyForceCenter(self:GetAbsVelocity()*7.4452)
					end
					if self:IsValid() then
					//	self:VJ_ACT_PLAYACTIVITY("ACT_FLINCH_HEAD",true,1.56667,false,.4)
						self:SetMoveType(MOVETYPE_NONE)
						self:SetOwner(ragd)
						self:SetParent(ragd)
						self:SetPos(ragd:GetPos())
					end
					if self:GetSequenceActivityName(self:GetSequence()) == "ACT_RANGE_ATTACK2" then
						timer.Simple(math.random(1.5,2),function()
							if self:IsValid() then
								self:SetOwner(nil)
								self:SetParent(nil)
								timer.Simple(0.01,function()
									if ragd:IsValid() then
										ragd:Remove()
									end
									if self:IsValid() then
										self:SetNoDraw(false)
										self.HasLeapAttack = true
										self:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.66667,true)
										VJ_EmitSound(self,self.BodyImpact,60,100)
										self:SetMoveType(MOVETYPE_STEP)
										self:SetLocalVelocity(self:GetBaseVelocity()*0)
										timer.Simple(1.66667,function()
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
				end
			end
		end)
	else
		self:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.66667,true,3)
	end
end

function ENT:CustomOnAlert(ent)
	if self:WaterLevel() ~= 3 and self.olevels == false then
		if self.ALERTPLS == false then
			if math.random(1,2) == 1 then
				self:VJ_ACT_PLAYACTIVITY("ACT_RANGE_ATTACK1",true,1.75,false)
				timer.Simple(.4,function()
					if self:IsValid() then
						VJ_EmitSound(self,self.AlertGrowl,80,100)
					end
				end)
				timer.Simple(1.75,function()
					if self:IsValid() then
						self.olevels = true
					end
				end)
			else
				self:VJ_ACT_PLAYACTIVITY("vjseq_headcrab_classic_threatdisplay",true,1.58333666667,false)
				timer.Simple(.3,function()
				if self:IsValid() then
					VJ_EmitSound(self,self.GruntShort,75,100)
				end
				end)
				timer.Simple(.7,function()
					if self:IsValid() then
						VJ_EmitSound(self,self.GruntShort,75,100)
					end
				end)
				timer.Simple(1.58333666667,function()
					if self:IsValid() then
						self.olevels = true
					end
				end)
			end
		else
			self:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.5,false)
		end
	end
end

function ENT:CustomOnThink()
	local urmom = .5
	self:SetFlexWeight(0,math.Approach(self:GetFlexWeight(0),math.random(0,1),urmom))
	self:SetFlexWeight(1,math.Approach(self:GetFlexWeight(1),math.random(0,1),urmom))
	self:SetFlexWeight(2,math.Approach(self:GetFlexWeight(2),math.random(0,1),urmom))
	self:SetFlexWeight(3,math.Approach(self:GetFlexWeight(3),math.random(0,1),urmom))
	self:SetFlexWeight(4,math.Approach(self:GetFlexWeight(4),math.random(0,1),urmom))
	self:SetFlexWeight(5,math.Approach(self:GetFlexWeight(5),math.random(0,1),urmom))
	if self:GetSequenceActivityName(self:GetSequence()) == "ACT_IDLE2" and self.Idle2 == false then
		self.Idle2 = true
		timer.Simple(.9, function()
			if self:IsValid() then
				VJ_EmitSound(self,self.Grunt,75,100)
				timer.Simple(.7,function()
					if self:IsValid() and self:GetSequenceActivityName(self:GetSequence()) == "ACT_IDLE2" then
						self.Idle2 = false
					end
				end)
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
						self.HasDeathAnimation = false
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

function ENT:CustomOnKilled()
	self:SetNoDraw(false)
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	VJ_EmitSound(self,self.FleshImpactLayer,60,100)
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if hitgroup == HITGROUP_STOMACH then
		self:SetUpGibesOnDeath()
		dmginfo:ScaleDamage(99999999999999999)
		self.HasDeathAnimation = false
		self.HasDeathRagdoll = false
	elseif hitgroup == HITGROUP_HEAD then
		if dmginfo:GetAttacker():IsNPC() or dmginfo:GetAttacker():IsPlayer()  then
			if dmginfo:GetAttacker():GetActiveWeapon():IsValid() then
				if dmginfo:IsDamageType(DMG_BUCKSHOT) == true then
	--			if dmginfo:GetAttacker():GetActiveWeapon():GetClass() == "weapon_vj_hlvr_heavyshotgun" or dmginfo:GetAttacker():GetActiveWeapon():GetClass() == "weapon_vj_hlvr_shotgun" or dmginfo:GetAttacker():GetActiveWeapon():GetClass() == "weapon_vj_spas12" or dmginfo:GetAttacker():GetActiveWeapon():GetClass() == "weapon_vj_bms_spas12" or dmginfo:GetAttacker():GetActiveWeapon():GetClass() == "weapon_vj_hlr1_spas12" or dmginfo:GetAttacker():GetActiveWeapon():GetClass() == "weapon_shotgun" or dmginfo:GetAttacker():GetActiveWeapon():GetClass() == "weapon_vj_hla_shotgun_heavy" or dmginfo:IsDamageType(DMG_BUCKSHOT) == true then
					if self.Flipped == false then
						self.Flipped = true
						self:VJ_ACT_PLAYACTIVITY("ACT_FLINCH_HEAD",true,1.56667,false)
						self:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.66667,false,1.56667)
						timer.Simple(3.23334,function()
							if self:IsValid() then
							self.Flipped = false
							end
						end)
					end
				end
			end
		end
		VJ_EmitSound(self,self.ArmorImpact,75,100)
		dmginfo:ScaleDamage(0)
		local effectdata = EffectData()
		effectdata:SetOrigin(dmginfo:GetDamagePosition())
		util.Effect("StunstickImpact",effectdata)
	end
end

function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	VJ_EmitSound(self,self.BreakNPCCritter,75,100)
	self:CreateGibEntity("obj_vj_gib", "models/creatures/headcrabs/gibs/headcrab_armored/shell.mdl", {Pos=self:GetPos()+self:GetUp()*5,BloodType=""})
	self:CreateGibEntity("prop_ragdoll", "models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib06.mdl", {Pos=self:GetPos()+self:GetForward()*5+self:GetRight()*5,BloodType="Yellow"},function(gib)gib:SetSkin(1) end)
	self:CreateGibEntity("prop_ragdoll", "models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib05.mdl", {Pos=self:GetPos()+self:GetForward()*-1.5+self:GetRight()*1.5,BloodType="Yellow"},function(gib)gib:SetSkin(1) end)
	self:CreateGibEntity("obj_vj_gib", "models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib04.mdl", {Pos=self:GetPos()+self:GetForward()*5,BloodType="Yellow"},function(gib)gib:SetSkin(1) end)
	self:CreateGibEntity("prop_ragdoll", "models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib03.mdl", {Pos=self:GetPos()+self:GetForward()*-1.5+self:GetRight()*-1.5,BloodType="Yellow"},function(gib)gib:SetSkin(1) end)
	self:CreateGibEntity("obj_vj_gib", "models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib02.mdl", {Pos=self:GetPos()+self:GetForward()*15.5+self:GetRight()*-1.5,BloodType="Yellow"},function(gib)gib:SetSkin(1) end)
	self:CreateGibEntity("obj_vj_gib", "models/creatures/headcrabs/gibs/headcrab_classic/headcrab_classic_gib01.mdl", {Pos=self:GetPos()+self:GetForward()*6.5+self:GetRight()*15.5,BloodType="Yellow"},function(gib)gib:SetSkin(1) end)
--	self:Gibbed()
	return true, {DeathAnim=false,AllowCorpse=false}
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/