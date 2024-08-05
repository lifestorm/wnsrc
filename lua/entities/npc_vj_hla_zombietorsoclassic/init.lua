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

ENT.Model = {"models/creatures/zombies/zombie_v2_torso.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
		
--		 ENT.Model = {"models/creatures/zombies/zombie_citizen.mdl"}
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_bcrab_hl2"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
--ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
	-- ====== Miscellaneous Variables ====== --
ENT.PushProps = true -- Should it push props when trying to move?
-- ====== Death Animation Variables ====== --
ENT.DeathCorpseSetBoneAngles = true -- This can be used to stop the corpse glitching or flying on death
ENT.DeathCorpseApplyForce = false -- Disables the damage force on death | Useful for SNPCs with Death Animations
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
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
	-- ====== Distance Variables ====== --
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.NextMeleeAttackTime = 0.8 -- How much time until it can use a melee attack?
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.MeleeAttackReps = 1 -- How many times does it run the melee attack code?
ENT.FootStepTimeRun = 0.6 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.6 -- Next foot step sound when it is walking
--------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootStep = {"creatures/zombie/foley/move_01.wav","creatures/zombie/foley/move_02.wav","creatures/zombie/foley/move_03.wav","creatures/zombie/foley/move_04.wav","creatures/zombie/foley/move_05.wav","creatures/zombie/foley/move_06.wav","creatures/zombie/foley/move_07.wav","creatures/zombie/foley/move_08.wav","creatures/zombie/foley/move_09.wav","creatures/zombie/foley/move_10.wav","creatures/zombie/foley/move_11.wav","creatures/zombie/foley/move_12.wav","creatures/zombie/foley/move_13.wav","creatures/zombie/foley/move_14.wav"}
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
--------------------------------------------------------------------------------------------------------------------
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
ENT.Idling = false
ENT.Bloater = false
ENT.itsmarcosingtime = false
ENT.alamano = nil
ENT.inflatonrate = false
ENT.pain = {"world/infestation/xen_bloater_mini_pain_01.wav","world/infestation/xen_bloater_mini_pain_02.wav","world/infestation/xen_bloater_mini_pain_03.wav","world/infestation/xen_bloater_mini_pain_04.wav","world/infestation/xen_bloater_mini_pain_05.wav"}
ENT.Bloaterded = false
ENT.rice = false
ENT.bloater1 = false
ENT.bloater2 = false
ENT.bloater3 = false
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

function ENT:CustomOnFootStepSound()
	VJ_EmitSound(self,self.StepLayer,75,100)
end

function ENT:CustomOnInitialize()
	self:SetBodygroup(self:FindBodygroupByName("armored"),1)
	self:SetFlexWeight(0,1)
	
	if GetConVarNumber("vj_hla_enable_zombie_bloaters") == 1 then
		if self.bloater1 == true then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),1)
			self.Bloater = true
		elseif self.bloater2 == true then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),2)
			self.Bloater = true
		elseif self.bloater3 == true then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),3)
			self.Bloater = true
		elseif math.random(1,2) == 1 and self.bloater1 == false and self.bloater2 == false and self.bloater3 == false then
			self:SetBodygroup(self:FindBodygroupByName("bloaters"),math.random(1,3))
			self.Bloater = true
		else
			self.Bloater = false
		end
	end
end

function ENT:CustomOnMeleeAttack_BeforeChecks()
	VJ_EmitSound(self,self.AttackGrunt,75,100)
	VJ_EmitSound(self,self.AttackWhoosh,75,100)
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if hitgroup == 11 then
		self:AddGesture(ACT_FLINCH_HEAD)
		if dmginfo:IsBulletDamage() then
			dmginfo:ScaleDamage(1.75)
		end
		ParticleEffect("blood_impact_antlion_01",dmginfo:GetDamagePosition(),self:GetAngles())
	else
		ParticleEffect("blood_impact_red_01",dmginfo:GetDamagePosition(),self:GetAngles())
	end
	if GetConVarNumber("vj_hla_enable_zombie_bloaters") == 1 then
		if dmginfo:GetDamageType() == DMG_BULLET or dmginfo:GetDamageType() == DMG_BUCKSHOT or dmginfo:GetDamageType() == DMG_SNIPER then
			self.rice = true
			if hitgroup == 14 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 1 or hitgroup == 13 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 2 or hitgroup == 12 and self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 3 then
				self:Alamano()
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

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	VJ_EmitSound(self,self.FleshImpactLayer,60,100)
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
	
	if self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 1 then
		self:SetBodygroup(self:FindBodygroupByName("bloaters"),4)
	elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 2 then
		self:SetBodygroup(self:FindBodygroupByName("bloaters"),5)
	elseif self:GetBodygroup(self:FindBodygroupByName("bloaters")) == 3 then
		self:SetBodygroup(self:FindBodygroupByName("bloaters"),6)
	end

	if hitgroup == 11 and GetConVarNumber("vj_hla_enable_hard_difficulty") == 0 or self.Bloater == true then
		local crabdead = ents.Create("prop_ragdoll")
		crabdead:SetModel("models/creatures/headcrabs/headcrab_classic.mdl")
		crabdead:SetPos(self:GetPos())
		crabdead:SetAngles(self:GetAngles())
		crabdead:Spawn()
		crabdead:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	else
		local crab = ents.Create("npc_vj_hla_hcrab")
		crab:SetPos(self:GetPos())
		crab:SetAngles(self:GetAngles())
		crab:Spawn()
		crab.ALERTPLS = true
	end
end
-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base