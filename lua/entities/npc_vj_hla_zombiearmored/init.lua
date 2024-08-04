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


ENT.Model = {"models/creatures/zombies/zombie_citizen.mdl",
			 "models/creatures/zombies/zombine.mdl",
			 "models/creatures/zombies/zombie_hazmat_worker_male.mdl",
			 "models/creatures/zombies/zombie_combine_worker.mdl",
			 "models/creatures/zombies/zombie_combine_worker_2.mdl",
			 "models/creatures/zombies/zombie_hazmat_worker_female.mdl",
			 "models/creatures/zombies/zombie_sweats_citizen.mdl",
			 "models/creatures/zombies/zombie_c17.mdl",
			 "models/creatures/zombies/zombie_security.mdl",
			 "models/creatures/zombies/zombie_zoo.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
		
--		 ENT.Model = {"models/creatures/zombies/zombie_v2.mdl"}
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_bcrab_hl2"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
	-- ====== Miscellaneous Variables ====== --
ENT.PushProps = true -- Should it push props when trying to move?
ENT.AnimTbl_IdleStand = {ACT_IDLE,ACT_IDLE_ANGRY} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 9 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextFlinchTime = 3 -- How much time until it can flinch again?
--ENT.FlinchAnimationDecreaseLengthAmount = 0.5 -- This will decrease the time it can move, attack, etc. | Use it to fix animation pauses after it finished the flinch animation
ENT.AnimTbl_Flinch = {"ACT_FLINCH_HEAD","ACT_FLINCH_CHEST","ACT_FLINCH_STOMACH","ACT_FLINCH_LEFTARM","ACT_FLINCH_RIGHTARM","ACT_FLINCH_LEFTLEG","ACT_FLINCH_RIGHTLEG","ACT_FLINCH_PHYSICS"} -- If it uses normal based animation, use this
-- ====== Death Animation Variables ====== --
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {} -- Death Animations
//ENT.AnimTbl_Death = {"ACT_DIE_HEADSHOT","ACT_DIE_CHESTSHOT","ACT_DIE_GUTSHOT","ACT_DIESIMPLE"} -- Death Animations
//ENT.DeathAnimationTime = .7 -- Time until the SNPC spawns its corpse and gets removed
//ENT.DeathAnimationTime = 1.488235706 -- Time until the SNPC spawns its corpse and gets removed
ENT.DeathCorpseSetBoneAngles = true -- This can be used to stop the corpse glitching or flying on death
ENT.DeathCorpseApplyForce = true -- Disables the damage force on death | Useful for SNPCs with Death Animations
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.DeathCorpseSetBodyGroup = true -- Should it get the models bodygroups and set it to the corpse? When set to false, it uses the model's default bodygroups
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Melee Attack Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = GetConVarNumber("vj_hla_hzomb_d")
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.AnimTbl_MeleeAttack = {} -- Melee Attack Animations
	-- ====== Distance Variables ====== --
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.MeleeAttackReps = 1 -- How many times does it run the melee attack code?
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is walking
--------------------------------------------------------------------------------------------------------------------
ENT.FootStep = {"creatures/zombie/foley/move_01.wav","creatures/zombie/foley/move_02.wav","creatures/zombie/foley/move_03.wav","creatures/zombie/foley/move_04.wav","creatures/zombie/foley/move_05.wav","creatures/zombie/foley/move_06.wav","creatures/zombie/foley/move_07.wav","creatures/zombie/foley/move_08.wav","creatures/zombie/foley/move_09.wav","creatures/zombie/foley/move_10.wav","creatures/zombie/foley/move_11.wav","creatures/zombie/foley/move_12.wav","creatures/zombie/foley/move_13.wav","creatures/zombie/foley/move_14.wav"}
ENT.SoundTbl_Idle = {"creatures/zombie/vox/idle_moan_dry_01.wav","creatures/zombie/vox/idle_moan_dry_02.wav","creatures/zombie/vox/idle_moan_dry_03.wav","creatures/zombie/vox/idle_moan_dry_04.wav","creatures/zombie/vox/idle_moan_dry_05.wav","creatures/zombie/vox/idle_moan_dry_06.wav","creatures/zombie/vox/idle_moan_dry_07.wav","creatures/zombie/vox/idle_moan_dry_08.wav","creatures/zombie/vox/idle_moan_dry_09.wav","creatures/zombie/vox/idle_moan_dry_10.wav","creatures/zombie/vox/idle_moan_dry_11.wav","creatures/zombie/vox/idle_moan_dry_12.wav","creatures/zombie/vox/idle_moan_dry_13.wav","creatures/zombie/vox/idle_moan_dry_14.wav"}
ENT.SoundTbl_Alert = {"creatures/zombie/vox/alert_01.wav","creatures/zombie/vox/alert_02.wav","creatures/zombie/vox/alert_03.wav","creatures/zombie/vox/alert_04.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"creatures/zombie/vox/attack_pre_01.wav","creatures/zombie/vox/attack_pre_02.wav","creatures/zombie/vox/attack_pre_03.wav","creatures/zombie/vox/attack_pre_04.wav"}
ENT.SoundTbl_MeleeAttack = {"creatures/zombie/attack_hit_01.wav","creatures/zombie/attack_hit_02.wav","creatures/zombie/attack_hit_03.wav","creatures/zombie/attack_hit_04.wav","creatures/zombie/attack_hit_05.wav","creatures/zombie/attack_hit_06.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"creatures/zombie/vox/attack_miss_01.wav","creatures/zombie/vox/attack_miss_02.wav","creatures/zombie/vox/attack_miss_03.wav"}
ENT.SoundTbl_Impact = {"physics/bullet_impacts/flesh_npc_01.wav",
					   "physics/bullet_impacts/flesh_npc_02.wav",
					   "physics/bullet_impacts/flesh_npc_03.wav",
				   	   "physics/bullet_impacts/flesh_npc_04.wav",
				   	   "physics/bullet_impacts/flesh_npc_05.wav",
				   	   "physics/bullet_impacts/flesh_npc_06.wav",
				   	   "physics/bullet_impacts/flesh_npc_07.wav",
				   	   "physics/bullet_impacts/flesh_npc_08.wav"}
ENT.SoundTbl_Pain = {"creatures/zombie/vox/pain_01.wav","creatures/zombie/vox/pain_02.wav","creatures/zombie/vox/pain_03.wav","creatures/zombie/vox/pain_04.wav","creatures/zombie/vox/pain_05.wav","creatures/zombie/vox/pain_06.wav","creatures/zombie/vox/pain_07.wav","creatures/zombie/vox/pain_08.wav","creatures/zombie/vox/pain_09.wav"}
ENT.SoundTbl_Death = {"creatures/zombie/vox/death_01.wav","creatures/zombie/vox/death_02.wav","creatures/zombie/vox/death_03.wav","creatures/zombie/vox/death_04.wav","creatures/zombie/vox/death_05.wav","creatures/zombie/vox/death_06.wav","creatures/zombie/vox/death_07.wav","creatures/zombie/vox/death_08.wav","creatures/zombie/vox/death_09.wav"}
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
ENT.AttackGrunt = {"creatures/zombie/vox/attack_grunt_01.wav","creatures/zombie/vox/attack_grunt_02.wav","creatures/zombie/vox/attack_grunt_03.wav","creatures/zombie/vox/attack_grunt_04.wav","creatures/zombie/vox/attack_grunt_05.wav","creatures/zombie/vox/attack_grunt_06.wav","creatures/zombie/vox/attack_grunt_07.wav"}
ENT.AttackWhoosh = {"creatures/zombie/attack_whoosh_01.wav","creatures/zombie/attack_whoosh_02.wav","creatures/zombie/attack_whoosh_03.wav","creatures/zombie/attack_whoosh_04.wav","creatures/zombie/attack_whoosh_05.wav"}
ENT.StepLayer = {"creatures/zombie/step_layer_01.wav",
				 "creatures/zombie/step_layer_02.wav",
				 "creatures/zombie/step_layer_03.wav",
				 "creatures/zombie/step_layer_04.wav",
				 "creatures/zombie/step_layer_05.wav",
				 "creatures/zombie/step_layer_06.wav",
				 "creatures/zombie/step_layer_07.wav"}
ENT.Bloater = false
ENT.itsmarcosingtime = false
ENT.pain = {"world/infestation/xen_bloater_mini_pain_01.wav","world/infestation/xen_bloater_mini_pain_02.wav","world/infestation/xen_bloater_mini_pain_03.wav","world/infestation/xen_bloater_mini_pain_04.wav","world/infestation/xen_bloater_mini_pain_05.wav"}
ENT.Bloaterded = false
ENT.inflatonrate = false
ENT.rice = false
ENT.TORSO = false
--------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		self.StartHealth = 60
		self.MeleeAttackDamage = 35
	else
		self.StartHealth = 45
		self.MeleeAttackDamage = 20
	end
end

function ENT:CustomOnInitialize()
	self:SetSkin(1)
	self:SetFlexWeight(0,1)

	-- 	Different Zombies
	
	if self:GetModel() == "models/creatures/zombies/zombie_sweats_citizen.mdl" then
		if math.random(1,2) == 1 then
			self:SetSkin(2)
		else
			self:SetSkin(3)
		end
	elseif self:GetModel() == "models/creatures/zombies/zombie_citizen.mdl" then
		if math.random(1,2) == 1 then
			self:SetBodygroup(self:FindBodygroupByName("vest"),1)
		end
	end
	
	if GetConVarNumber("vj_hla_enable_zombie_bloaters") == 1 then
		if self:GetModel() == "models/creatures/zombies/zombine.mdl" or self:GetModel() == "models/creatures/zombies/zombie_hazmat_worker_female.mdl" or self:GetModel() == "models/creatures/zombies/zombie_combine_worker_2.mdl" or self:GetModel() == "models/creatures/zombies/zombie_sweats_citizen.mdl" or self:GetModel() == "models/creatures/zombies/zombie_security.mdl" or self:GetModel() == "models/creatures/zombies/zombie_zoo.mdl" then
			if math.random(1,2) == 1 then
				self:SetBodygroup(self:FindBodygroupByName("bloaters"),math.random(1,4))
				self.Bloater = true
			else
				self.Bloater = false
			end
		else
			if math.random(1,2) == 1 then
				self:SetBodygroup(self:FindBodygroupByName("bloaters"),math.random(1,5))
				self.Bloater = true
			else
				self.Bloater = false
			end
		end
	end
end

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	if evOptions == "zombie_step" then
		VJ_EmitSound(self,self.FootStep,75,100)
		VJ_EmitSound(self,self.StepLayer,75,100)
	end
end

function ENT:CustomOnMeleeAttack_BeforeChecks()
	VJ_EmitSound(self,self.AttackGrunt,75,100)
	VJ_EmitSound(self,self.AttackWhoosh,75,100)
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	VJ_EmitSound(self,self.FleshImpactLayer,60,100)
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if hitgroup == 11 then
		VJ_EmitSound(self,self.ArmorImpact,75,100)
		dmginfo:ScaleDamage(0)
		local effectdata = EffectData()
		effectdata:SetOrigin(dmginfo:GetDamagePosition())
		util.Effect("StunstickImpact",effectdata)
	end
	if GetConVarNumber("vj_hla_enable_zombie_bloaters") == 1 then
		if dmginfo:GetDamageType() == DMG_BULLET or dmginfo:GetDamageType() == DMG_BUCKSHOT or dmginfo:GetDamageType() == DMG_SNIPER then
			self.rice = true
			if self:GetModel() == "models/creatures/zombies/zombine.mdl" or self:GetModel() == "models/creatures/zombies/zombie_hazmat_worker_female.mdl" or self:GetModel() == "models/creatures/zombies/zombie_combine_worker_2.mdl" or self:GetModel() == "models/creatures/zombies/zombie_sweats_citizen.mdl" or self:GetModel() == "models/creatures/zombies/zombie_security.mdl" or self:GetModel() == "models/creatures/zombies/zombie_zoo.mdl" then
				if hitgroup == 14 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 1 or hitgroup == 12 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 2 or hitgroup == 15 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 3 or hitgroup == 16 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 4 then
					self:Alamano()
				end
			else
				if hitgroup == 14 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 1 or hitgroup == 13 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 2 or hitgroup == 12 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 3 or hitgroup == 15 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 4 or hitgroup == 16 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 5 then
					self:Alamano()
				end
			end
		end
	end
end

function ENT:Alamano()
	if self.rice == true then
		local pos,ang = self:GetBonePosition(0)
		if self.inflatonrate == false then
			self.inflatonrate = true
			VJ_EmitSound(self,self.pain,100,100)
		end
		timer.Simple(1,function()
			if self:IsValid() then
				self.Bloaterded = true
			//	util.VJ_SphereDamage(self,self,self:GetPos(),25,75,DMG_BLAST,false,false)
			//	for _,x in pairs(ents.FindInSphere(pos,100)) do
			//		util.VJ_SphereDamage(self,self,x:GetPos(),25,75,DMG_BLAST,false,false)
			//	end
				self:TakeDamage(self:GetMaxHealth())
				VJ_EmitSound(self,"world/infestation/xen_bloater_mini_explode_01.wav",500,100)
				ParticleEffect("AntlionGib",pos,ang)
			end
		end)
	end
end

function ENT:CustomOnThink()
	if math.random(1,5) == 5 then
		if math.random(1,2) == 1 then
			if math.random(1,2) == 1 then
				self.AnimTbl_MeleeAttack = {"ACT_MELEE_ATTACK3"}
				self.MeleeAttackReps = 2
				self.TimeUntilMeleeAttackDamage = 0.85 -- This counted in seconds | This calculates the time until it hits something
			else
				self.AnimTbl_MeleeAttack = {"ACT_MELEE_ATTACK1"}
				self.MeleeAttackReps = 1
				self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
			end
		else
			self.AnimTbl_MeleeAttack = {"ACT_ZOM_SWATLEFTLOW","ACT_ZOM_SWATRIGHTLOW","ACT_ZOM_SWATLEFTMID","ACT_ZOM_SWATRIGHTMID"}
			self.MeleeAttackReps = 1
			self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
		end
	else
		if math.random(1,3) == 1 then
			self.AnimTbl_MeleeAttack = {"ACT_MELEE_ATTACK2"}
			self.MeleeAttackReps = 2
			self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
		elseif math.random(1,3) == 2 then
			self.AnimTbl_MeleeAttack = {"ACT_MELEE_ATTACK4"}
			self.MeleeAttackReps = 1
			self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
		else
			self.AnimTbl_MeleeAttack = {"vjseq_zombie_lunge_forward_01"}
			self.MeleeAttackReps = 3
			self.TimeUntilMeleeAttackDamage = 0.75 -- This counted in seconds | This calculates the time until it hits something
		end
	end
end

function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if self.MeleeAttacking == true then
		return false
	else
		return true
	end
end -- Return false to disallow the flinch from playing

function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	self:SetBodygroup(self:FindBodygroupByName("headcrab_classic"),1)
	self:SetBodygroup(self:FindBodygroupByName("armored"),1)
	self:SetFlexWeight(0,0)
	
	if self.Bloaterded == false then
		if math.random(1,23) == 1 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE"} //"zombie_death_anim_02"
			self.DeathAnimationTime = 1.33333
		elseif math.random(1,23) == 2 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE2"} //"zombie_death_anim_03"
			self.DeathAnimationTime = 2.3
		elseif math.random(1,23) == 3 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE3"} //"zombie_death_anim_04"
			self.DeathAnimationTime = 1.86667
		elseif math.random(1,23) == 4 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE4"} //"zombie_death_anim_05"
			self.DeathAnimationTime = 1.2
		elseif math.random(1,23) == 5 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE5"} //"zombie_death_arm_left_01"
			self.DeathAnimationTime = 1.2
		elseif math.random(1,23) == 6 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE6"} //"zombie_death_arm_right_01"
			self.DeathAnimationTime = 2.06667
		elseif math.random(1,23) == 7 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE7"} //"zombie_death_arm_right_02"
			self.DeathAnimationTime = 1.46667
		elseif math.random(1,23) == 8 then
			self.AnimTbl_Death = {"ACT_DIE_CHESTSHOT"} //"zombie_death_chest_fall_02"
			self.DeathAnimationTime = 1.86667
		elseif math.random(1,23) == 9 then
			self.AnimTbl_Death = {"ACT_DIE_CHESTSHOT2"} //"zombie_death_chest_kick_03"
			self.DeathAnimationTime = 1.23333
		elseif math.random(1,23) == 10 then
			self.AnimTbl_Death = {"ACT_DIE_CHESTSHOT3"} //"zombie_death_chest_kick_04"
			self.DeathAnimationTime = 1.23333
		elseif math.random(1,23) == 11 then
			self.AnimTbl_Death = {"ACT_DIE_CHESTSHOT4"} //"zombie_death_chest_misc_04"
			self.DeathAnimationTime = 1.33333
		elseif math.random(1,23) == 12 then
			self.AnimTbl_Death = {"ACT_DIE_CHESTSHOT5"} //"zombie_death_chest_spin_01"
			self.DeathAnimationTime = 0.9
		elseif math.random(1,23) == 13 then
			self.AnimTbl_Death = {"ACT_DIE_HEADSHOT"} //"zombie_death_head_01"
			self.DeathAnimationTime = 1.06667
		elseif math.random(1,23) == 14 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE8"} //"zombie_death_leg_left_01"
			self.DeathAnimationTime = 1.5
		elseif math.random(1,23) == 15 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE9"} //"zombie_death_leg_right_01"
			self.DeathAnimationTime = 1
		elseif math.random(1,23) == 16 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE10"} //"zombie_death_moving_chest_grab_02"
			self.DeathAnimationTime = 0.666667
		elseif math.random(1,23) == 17 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE11"} //"zombie_death_moving_chest_swipe_01"
			self.DeathAnimationTime = 0.666667
		elseif math.random(1,23) == 18 then
			self.AnimTbl_Death = {"ACT_DIESIMPLE12"} //"zombie_death_moving_leg_lknee"
			self.DeathAnimationTime = 0.933333
		elseif math.random(1,23) == 19 then
			self.AnimTbl_Death = {"ACT_DIE_GUTSHOT"} //"zombie_death_stomach_01"
			self.DeathAnimationTime = 1.46667
		elseif math.random(1,23) == 20 then
			self.AnimTbl_Death = {"ACT_DIEVIOLENT"} //"zombie_flinch_kickback_chest_04_death"
			self.DeathAnimationTime = 1.166665
		elseif math.random(1,23) == 21 then
			self.AnimTbl_Death = {"ACT_DIEVIOLENT2"} //"zombie_flinch_kickback_chest_06_death"
			self.DeathAnimationTime = 1.166665
		elseif math.random(1,23) == 22 then
			self.AnimTbl_Death = {"ACT_DIEVIOLENT3"} //"zombie_flinch_stumble_chest_02_death"
			self.DeathAnimationTime = 1.166665
		else
			self.AnimTbl_Death = {"ACT_DIEVIOLENT4"} //"zombie_flinch_stumble_chest_03_death"
			self.DeathAnimationTime = 1.083335
		end
	end
	
	if self:GetModel() == "models/creatures/zombies/zombine.mdl" or self:GetModel() == "models/creatures/zombies/zombie_hazmat_worker_female.mdl" or self:GetModel() == "models/creatures/zombies/zombie_combine_worker_2.mdl" or self:GetModel() == "models/creatures/zombies/zombie_sweats_citizen.mdl" or self:GetModel() == "models/creatures/zombies/zombie_security.mdl" or self:GetModel() == "models/creatures/zombies/zombie_zoo.mdl" then
		if self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 1 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),5)
		elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 2 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),6)
		elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 3 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),7)
		elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 4 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),8)
		end
	else
		if self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 1 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),6)
		elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 2 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),7)
		elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 3 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),8)
		elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 4 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),9)
		elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 5 then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),10)
		end
	end
	
	if self.inflatonrate == true then
		local crabdead = ents.Create("prop_ragdoll")
		crabdead:SetModel("models/creatures/headcrabs/headcrab_armored.mdl")
		crabdead:SetPos(self:GetPos()+Vector(0,0,50))
		crabdead:SetAngles(self:GetAngles())
		crabdead:Spawn()
		crabdead:SetSkin(1)
		crabdead:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	else
		local crab = ents.Create("npc_vj_hla_ahcrab")
		crab:SetPos(self:GetPos()+Vector(0,0,50))
		crab:SetAngles(self:GetAngles())
		crab:Spawn()
		crab.ALERTPLS = true
		crab:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.5,false)
	end
end

-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base