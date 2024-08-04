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
ENT.Model = {"models/creatures/headcrabs/headcrab_reviver.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_TINY
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_zombieclassic","npc_vj_hla_zombiearmored","npc_vj_hla_zombiereviver"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Blue" -- The blood type, this will determine what it should use (decal, particle, etc.)
//ENT.CustomBlood_Particle = {"blood_impact_blue_01_hla"} -- Particles to spawn when it's damaged
ENT.Immune_Electricity = true -- Immune to electrical-type damages | Example: shock or laser
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
-- ====== Death Animation Variables ====== --
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIESIMPLE} -- Death Animations
	-- ====== Item Drops On Death Variables ====== --
ENT.HasItemDropsOnDeath = true -- Should it drop items on death?
ENT.ItemDropsOnDeathChance = 1 -- If set to 1, it will always drop it
ENT.ItemDropsOnDeath_EntityList = {"obj_vj_reviver_heart"} -- List of items it will randomly pick from | Leave it empty to drop nothing or to make your own dropping code (Using CustomOn...)
//ENT.ItemDropsOnDeath_EntityList = {"npc_vj_hla_rheart"} -- List of items it will randomly pick from | Leave it empty to drop nothing or to make your own dropping code (Using CustomOn...)
------ Melee Attack Variables ------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 0
ENT.NextMeleeAttackTime = 25 -- How much time until it can use a melee attack?
------ Range Attack Variables ------
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_reviver_spit" -- The entity that is spawned when range attacking
ENT.NextRangeAttackTime = 1.5 -- How much time until it can use a range attack? //2.33333
	-- ====== Distance Variables ====== --
ENT.RangeDistance = 400 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 25 -- How close does it have to be until it uses melee?
ENT.RangeAttackPos_Up = 20 -- Up/Down spawning position for range attack
ENT.RangeAttackPos_Forward = 0 -- Forward/Backward spawning position for range attack
------ Leap Attack Variables ------
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.LeapAttackDamage = GetConVarNumber("vj_hla_hcrab_d")
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.AnimTbl_LeapAttack = {ACT_SPECIAL_ATTACK1} -- Melee Attack Animations
ENT.LeapAttackAnimationFaceEnemy = false -- true = Face the enemy the entire time! | 2 = Face the enemy UNTIL it jumps! | false = Don't face the enemy AT ALL!
ENT.TimeUntilLeapAttackDamage = 1 -- How much time until it runs the leap damage code?
ENT.TimeUntilLeapAttackVelocity = .85 -- How much time until it runs the velocity code?
ENT.NextLeapAttackTime = 1 -- How much time until it can use a leap attack?
	-- ====== Distance Variables ====== --
ENT.LeapDistance = 100 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 50 -- How far does the damage go?
ENT.LeapAttackAngleRadius = 10 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
	-- ====== Velocity Variables ====== --
ENT.LeapAttackVelocityForward = 150 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 200 -- How much upward force should it apply?
	-- ====== Movement & Idle Variables ====== --
ENT.AnimTbl_IdleStand = {"ACT_IDLE","ACT_IDLE2","ACT_IDLE3"} -- The idle animation when AI is enabled
ENT.AnimTbl_Walk = {ACT_RUN} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_RUN} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.FootStepTimeRun = .1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = .1 -- Next foot step sound when it is walking
	-- ====== File Path Variables ====== --
ENT.SoundTbl_Idle = {"creatures/headcrab_reviver/vox/idle_01.wav","creatures/headcrab_reviver/vox/idle_02.wav","creatures/headcrab_reviver/vox/idle_03.wav","creatures/headcrab_reviver/vox/idle_04.wav","creatures/headcrab_reviver/vox/idle_05.wav","creatures/headcrab_reviver/vox/idle_06.wav","creatures/headcrab_reviver/vox/idle_07.wav","creatures/headcrab_reviver/vox/idle_08.wav","creatures/headcrab_reviver/vox/idle_09.wav","creatures/headcrab_reviver/vox/idle_10.wav"}
ENT.SoundTbl_CombatIdle = {"creatures/headcrab_reviver/vox/run_grunt_01.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_02.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_03.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_04.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_05.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_06.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_07.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_08.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_09.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_10.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_11.wav",
						   "creatures/headcrab_reviver/vox/run_grunt_12.wav"}
ENT.SoundTbl_MeleeAttack = {"creatures/headcrab_reviver/smoke_release.wav"}
ENT.SoundTbl_RangeAttack = {"creatures/headcrab_reviver/ranged_shoot_01.wav","creatures/headcrab_reviver/ranged_shoot_02.wav","creatures/headcrab_reviver/ranged_shoot_03.wav"}
ENT.SoundTbl_LeapAttackJump = {"creatures/headcrab_reviver/vox/snap_at_player.wav"}
ENT.SoundTbl_LeapAttackDamage = {"creatures/headcrab_reviver/bite/bite_01.wav","creatures/headcrab_reviver/bite/bite_02.wav","creatures/headcrab_reviver/bite/bite_03.wav","creatures/headcrab_reviver/bite/bite_04.wav","creatures/headcrab_reviver/bite/bite_05.wav","creatures/headcrab_reviver/bite/bite_06.wav","creatures/headcrab_reviver/bite/bite_07.wav","creatures/headcrab_reviver/bite/bite_08.wav","creatures/headcrab_reviver/bite/bite_09.wav"}
ENT.SoundTbl_Pain = {"creatures/headcrab_reviver/vox/pain_01.wav","creatures/headcrab_reviver/vox/pain_02.wav","creatures/headcrab_reviver/vox/pain_03.wav","creatures/headcrab_reviver/vox/pain_04.wav","creatures/headcrab_reviver/vox/pain_05.wav","creatures/headcrab_reviver/vox/pain_06.wav"}
ENT.SoundTbl_Death = {"creatures/headcrab_reviver/vox/death.wav"}
ENT.SoundTbl_Impact = {"physics/bullet_impacts/flesh_npc_01.wav",
					   "physics/bullet_impacts/flesh_npc_02.wav",
					   "physics/bullet_impacts/flesh_npc_03.wav",
				   	   "physics/bullet_impacts/flesh_npc_04.wav",
				   	   "physics/bullet_impacts/flesh_npc_05.wav",
				   	   "physics/bullet_impacts/flesh_npc_06.wav",
				   	   "physics/bullet_impacts/flesh_npc_07.wav",
				   	   "physics/bullet_impacts/flesh_npc_08.wav"}
ENT.SoundTbl_FootStep = {"creatures/headcrab_reviver/steps/step_01.wav",
						 "creatures/headcrab_reviver/steps/step_02.wav",
						 "creatures/headcrab_reviver/steps/step_03.wav",
						 "creatures/headcrab_reviver/steps/step_04.wav",
						 "creatures/headcrab_reviver/steps/step_05.wav",
						 "creatures/headcrab_reviver/steps/step_06.wav",
						 "creatures/headcrab_reviver/steps/step_07.wav",
						 "creatures/headcrab_reviver/steps/step_08.wav",
						 "creatures/headcrab_reviver/steps/step_09.wav",
						 "creatures/headcrab_reviver/steps/step_10.wav",}
 -- Custom --
ENT.Alert = {"creatures/headcrab_reviver/vox/growl_01.wav","creatures/headcrab_reviver/vox/growl_02.wav"}
ENT.FleshImpactLayer = {"physics/bullet_impacts/flesh_layer_01.wav",
					    "physics/bullet_impacts/flesh_layer_02.wav"}
ENT.AlertLayer = {"creatures/headcrab_reviver/ranged_warning_layer_01.wav","creatures/headcrab_reviver/ranged_warning_layer_02.wav"}
ENT.Stamp = {"creatures/headcrab_reviver/steps/stamp_01.wav","creatures/headcrab_reviver/steps/stamp_02.wav","creatures/headcrab_reviver/steps/stamp_03.wav"}
ENT.StepLayer = {"creatures/headcrab_reviver/steps/step_layer_01.wav",
				 "creatures/headcrab_reviver/steps/step_layer_02.wav",
				 "creatures/headcrab_reviver/steps/step_layer_03.wav",
				 "creatures/headcrab_reviver/steps/step_layer_04.wav",
				 "creatures/headcrab_reviver/steps/step_layer_05.wav",
				 "creatures/headcrab_reviver/steps/step_layer_06.wav",
				 "creatures/headcrab_reviver/steps/step_layer_07.wav",
				 "creatures/headcrab_reviver/steps/step_layer_08.wav",
				 "creatures/headcrab_reviver/steps/step_layer_09.wav",
				 "creatures/headcrab_reviver/steps/step_layer_10.wav",}
ENT.GruntHard = {"creatures/headcrab_reviver/vox/grunt_hard_01.wav","creatures/headcrab_reviver/vox/grunt_hard_02.wav","creatures/headcrab_reviver/vox/grunt_hard_03.wav","creatures/headcrab_reviver/vox/grunt_hard_04.wav","creatures/headcrab_reviver/vox/grunt_hard_05.wav"}
ENT.GruntShort = {"creatures/headcrab_reviver/vox/grunt_short_01.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_02.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_03.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_04.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_05.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_06.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_07.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_08.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_09.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_10.wav",
				 "creatures/headcrab_reviver/vox/grunt_short_11.wav"}
ENT.GruntSoft = {"creatures/headcrab_reviver/vox/grunt_soft_01.wav","creatures/headcrab_reviver/vox/grunt_soft_02.wav","creatures/headcrab_reviver/vox/grunt_soft_03.wav","creatures/headcrab_reviver/vox/grunt_soft_04.wav","creatures/headcrab_reviver/vox/grunt_soft_05.wav"}
ENT.BodyImpact = {"creatures/headcrab_classic/movement/body_impact_02.wav","creatures/headcrab_classic/movement/body_impact_01.wav","creatures/headcrab_classic/movement/body_impact_03.wav","creatures/headcrab_classic/movement/body_impact_04.wav","creatures/headcrab_classic/movement/body_impact_05.wav","creatures/headcrab_classic/movement/body_impact_06.wav"}
ENT.ShakeSubtle = {"creatures/headcrab_reviver/vox/shake_subtle_01.wav","creatures/headcrab_reviver/vox/shake_subtle_02.wav"}
ENT.Smoke = false
ENT.Smoke2 = false
ENT.FoundParent = false
ENT.TouchParent = false
ENT.Spawning = false
ENT.alamano = false
ENT.blengblong = false
ENT.sunblock = false
ENT.Idle2 = false
ENT.Idle3 = false
ENT.Running = false
ENT.poopoo = false
-----------------------------------------------------------------------------
function ENT:CustomOnFootStepSound()
	VJ_EmitSound(self,self.Stamp,60,100)
	VJ_EmitSound(self,self.StepLayer,70,100)
end

function ENT:CustomOnPreInitialize()
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		self.StartHealth = 100
		self.LeapAttackDamage = 20
	else
		self.StartHealth = 92
		self.LeapAttackDamage = 10
	end
end

function ENT:CustomOnInitialize()
	ParticleEffectAttach("reviver_ambient_speks",PATTACH_ABSORIGIN_FOLLOW,self,1)
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	VJ_EmitSound(self,self.FleshImpactLayer,70,100)
end

function ENT:CustomOnMeleeAttack_BeforeStartTimer(seed)
	timer.Simple(.1,function()
		if self:IsValid() then
			VJ_EmitSound(self,"creatures/headcrab_reviver/vox/smoke_warning.wav",75,100)
		end
	end)
	timer.Simple(.6,function()
		if self:IsValid() then
			VJ_EmitSound(self,"creatures/headcrab_reviver/smoke_release_layer.wav",75,100)
		end
	end)
end

function ENT:CustomOnMeleeAttack_AfterStartTimer(seed)
	if self.Smoke == false and self.Smoke2 == false then
		self.Smoke2 = true
		timer.Simple(.5,function()
			if self:IsValid() then
				ParticleEffect("reviver_smoke_bomb",self:GetPos()+Vector(0,0,5),self:GetAngles())
				timer.Simple(.4,function()
					if self:IsValid() then
						ParticleEffect("reviver_smoke_bomb_dazzle",self:GetPos()+Vector(0,0,5),self:GetAngles()+Angle(0,30,0))
					end
				end)
				timer.Simple(.8,function()
					if self:IsValid() then
						ParticleEffect("reviver_smoke_bomb_dazzle",self:GetPos()+Vector(0,0,5),self:GetAngles()+Angle(0,60,0))
					end
				end)
			end
		end)
		timer.Simple(1.66667,function()
			if self:IsValid() then
				if self.alamano == false then
					self.alamano = true
				end
			end
		end)
	end
end

function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	local phys = projectile:GetPhysicsObject()
	if phys:IsValid() then
		phys:ApplyForceCenter(self:GetForward()*2+Vector(0,0,400))
	end
end -- Called after Spawn()

function ENT:CustomOnThink()
	if self:GetSequenceActivityName(self:GetSequence()) == "ACT_IDLE2" and self.Idle2 == false then
		self.Idle2 = true
		timer.Simple(.4,function()
			if self:IsValid() then
				if math.random(1,3) == 1 then
					VJ_EmitSound(self,self.GruntHard,75,100)
				elseif math.random(1,3) == 2 then
					VJ_EmitSound(self,self.GruntShort,75,100)
				else
					VJ_EmitSound(self,self.GruntSoft,75,100)
				end
			end
		end)
		timer.Simple(1.1,function()
			if self:IsValid() then
				if math.random(1,3) == 1 then
					VJ_EmitSound(self,self.GruntHard,75,100)
				elseif math.random(1,3) == 2 then
					VJ_EmitSound(self,self.GruntShort,75,100)
				else
					VJ_EmitSound(self,self.GruntSoft,75,100)
				end
			end
		end)
		timer.Simple(1.9,function()
			if self:IsValid() then
				if math.random(1,3) == 1 then
					VJ_EmitSound(self,self.GruntHard,75,100)
				elseif math.random(1,3) == 2 then
					VJ_EmitSound(self,self.GruntShort,75,100)
				else
					VJ_EmitSound(self,self.GruntSoft,75,100)
				end
			end
		end)
		timer.Simple(2.5,function() 
			if self:IsValid() then
				self.Idle2 = false
			end
		end)
	elseif self:GetSequenceActivityName(self:GetSequence()) == "ACT_IDLE3" and self.Idle3 == false then
		self.Idle3 = true
		timer.Simple(.4,function()
			if self:IsValid() then
				if math.random(1,3) == 1 then
					VJ_EmitSound(self,self.GruntHard,75,100)
				elseif math.random(1,3) == 2 then
					VJ_EmitSound(self,self.GruntShort,75,100)
				else
					VJ_EmitSound(self,self.GruntSoft,75,100)
				end
			end
		end)
		timer.Simple(2.1,function()
			if self:IsValid() then
				if math.random(1,3) == 1 then
					VJ_EmitSound(self,self.GruntHard,75,100)
				elseif math.random(1,3) == 2 then
					VJ_EmitSound(self,self.GruntShort,75,100)
				else
					VJ_EmitSound(self,self.GruntSoft,75,100)
				end
			end
		end)
		timer.Simple(4.1,function()
			if self:IsValid() then
				VJ_EmitSound(self,self.ShakeSubtle,75,100)
			end
		end)
		timer.Simple(6.8,function() 
			if self:IsValid() then
				self.Idle3 = false
			end
		end)
	end
	/*
	for k,v in pairs(ents.FindInCone(self:GetPos(),self:GetForward(),25,math.cos( math.rad(80)))) do
		if v:GetClass() == "prop_ragdoll" and self:Visible(v) and v:GetModel() == "models/creatures/zombies/zombie_c17.mdl" and v:IsValid() and self.blengblong == false then
			self.blengblong = true
			self:FaceCertainPosition(v:GetPos(), 3)
			self:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.83333,false)
			self:VJ_ACT_PLAYACTIVITY("ACT_HOP",true,1.16667,false,1.83333)
		//	self:VJ_ACT_PLAYACTIVITY("vjseq_zombie_reviver_activate_host_infest_v2",true,3,false)
			timer.Simple(3,function()
				if self:IsValid() and v:IsValid() then
					local npc = ents.Create("npc_vj_hla_zombiereviver")
					npc:SetPos(self:GetPos())
					npc:SetAngles(self:GetAngles())
					if self.Spawning == false then
						self.Spawning = true
						npc:Spawn()
						npc:VJ_ACT_PLAYACTIVITY("zombie_reviver_getup_head",true,2.5,false)
					end
					self:Remove()
					v:Remove()
				end
			end)
			timer.Simple(10,function()
				if self:IsValid() then
					self.blengblong = false
					self.FoundParent = false
				end
			end)
		end
	end
	*/
	for k,v in pairs(ents.FindInCone(self:GetPos(),self:GetForward(),10000,math.cos( math.rad(80)))) do
		if v:GetClass() == "nb_jeff" and self:Visible(v) and v:IsValid() then
			self:SetTarget(v)
			self:SetEnemy(v)
		end
	end
	
--	if self.alamano == false or self.Running == false then
--		self.HasMeleeAttack = true
--	elseif self.alamano == true or self.Running == true then
--		self.HasMeleeAttack = false
--	end
--	if self.alamano == false or self.Running == false then
--		self.HasRangeAttack = true
--	elseif self.alamano == true or self.Running == true then
--		self.HasRangeAttack = false
--	end
--	if self.alamano == false or self.Running == false then
--		self.HasLeapAttack = true
--	elseif self.alamano == true or self.Running == true then
--		self.HasLeapAttack = false
--	end
	
end

function ENT:CustomOnRangeAttack_BeforeStartTimer(seed)
	timer.Simple(.5,function()
		if self:IsValid() then
			VJ_EmitSound(self,"creatures/headcrab_reviver/ranged_warning.wav",80,100)
			VJ_EmitSound(self,self.AlertLayer,80,100)
		end
	end)
end

function ENT:oldcode()
--	npc:VJ_ACT_PLAYACTIVITY("zombie_reviver_getup_head",true,2.5,false)
	npc:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1.9,false)
	local node = ents.Create("npc_vj_hla_reviver_node")
	node:SetModel("models/creatures/headcrabs/node_headcrab.mdl")
	node:SetOwner(self)
	node:SetPersistent(true)
	node:Spawn()
	if math.random(1,3) == 0 then
		node:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,4.4,false)
		node:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,4.4)
		node:SetParent(npc,1)
		node:SetPos(npc:GetAttachment(npc:LookupAttachment("head_attachment")).Pos)
		node:SetLocalPos(Vector(3,2,-1))
		node:SetAngles(npc:GetAngles()+Angle(0,30,90))
		ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,npc,1)
		npc.NodePos = "head"
		npc:VJ_ACT_PLAYACTIVITY("ACT_STAND3",true,2.5,false,1.9)
		npc:VJ_ACT_PLAYACTIVITY("ACT_ARM3",true,2.8,false,4.4)
		npc.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
		npc.AnimTbl_Walk = {ACT_WALK_STIMULATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
		npc.AnimTbl_Run = {ACT_WALK_STIMULATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
	elseif math.random(1,3) == 2 then
		node:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,5.4,false)
		node:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,5.4)
		node:SetParent(npc,2)
		node:SetPos(npc:GetAttachment(npc:LookupAttachment("arm_lower_L_TWIST1_attachment")).Pos)
		node:SetLocalPos(Vector(3,2,-1))
		node:SetAngles(npc:GetAngles()+Angle(0,30,90))
		ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,npc,2)
		npc.NodePos = "arm_l"
		npc:VJ_ACT_PLAYACTIVITY("ACT_STAND1",true,3.5,false,1.9)
		npc:VJ_ACT_PLAYACTIVITY("ACT_ARM1",true,2.36667,false,5.4)
		npc.AnimTbl_IdleStand = {ACT_IDLE_RELAXED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
		npc.AnimTbl_Walk = {ACT_WALK_RELAXED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
		npc.AnimTbl_Run = {ACT_WALK_RELAXED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
	else
		node:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,8.35714,false)
		node:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,8.35714)
		node:SetParent(npc,3)
		node:SetPos(npc:GetAttachment(npc:LookupAttachment("arm_lower_R_TWIST1_attachment")).Pos)
		node:SetLocalPos(Vector(3,2,-1))
		node:SetAngles(npc:GetAngles()+Angle(0,30,90))
		ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,npc,3)
		npc.NodePos = "arm_r"
		npc:VJ_ACT_PLAYACTIVITY("ACT_STAND2",true,6.45714,false,1.9)
		npc:VJ_ACT_PLAYACTIVITY("ACT_ARM2",true,1.8,false,8.35714)
		npc.AnimTbl_IdleStand = {ACT_IDLE_AGITATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
		npc.AnimTbl_Walk = {ACT_WALK_AGITATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
		npc.AnimTbl_Run = {ACT_WALK_AGITATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
	end
end

function ENT:CustomOnSchedule()
	if self:Health() > 0 then
		if self.alamano == true then
			self:SetSchedule(SCHED_RUN_FROM_ENEMY_FALLBACK)
			timer.Simple(self.NextMeleeAttackTime/2,function()
				if self:IsValid() then
					self.alamano = false
					timer.Simple(self.NextMeleeAttackTime/2,function()
						if self:IsValid() then
							self.Smoke = false
							self.Smoke2 = false
						end
					end)
				end
			end)
		end
	end
	
	if self.FoundParent == false then
	--	for k,v in pairs(ents.GetAll()) do
		for k,v in pairs(ents.FindInSphere(self:GetPos(),1000)) do
			if v:GetClass() == "prop_ragdoll" then
				if v:GetModel() == "models/creatures/zombies/zombie_c17.mdl" or v:GetModel() == "models/creatures/zombies/zombie_citizen.mdl" or v:GetModel() == "models/creatures/zombies/zombie_combine_worker.mdl" or v:GetModel() == "models/creatures/zombies/zombie_hazmat_worker_male.mdl" then
				--	if self.FoundParent == false then
						self:SetLastPosition(v:GetPos())
						self:SetSchedule(SCHED_FORCED_GO)
						self.Running = true
						if self:GetPos():Distance(v:GetPos()) <= 25 then
							self.FoundParent = true
							self.Running = false
							self:ClearSchedule()
							timer.Simple(.2,function()
								if self:IsValid() then
									self:FaceCertainPosition(v:GetPos(), 3)
									self:VJ_ACT_PLAYACTIVITY("ACT_DISARM",true,1.83333,false)
									ParticleEffectAttach("reviver_node_zombie_fx_ab",PATTACH_POINT_FOLLOW,v,1)
--									ParticleEffect("reviver_node_zombie_fx_ab_infest",v:GetPos(),v:GetAngles())
									timer.Simple(.4,function()
										if self:IsValid() then
											VJ_EmitSound(self,"creatures/headcrab_reviver/vox/host_choose.wav",75,100)
										end
									end)
									self:VJ_ACT_PLAYACTIVITY("ACT_HOP",true,1.16667,false,1.83333)
									timer.Simple(2.7,function()
										if self:IsValid() then
											VJ_EmitSound(self,"creatures/headcrab_reviver/host_attach_gore.wav",75,100)
										end
									end)
									timer.Simple(3,function()
										if self:IsValid() and v:IsValid() and self.blengblong == false then
											self.blengblong = true
											local npc = ents.Create("npc_vj_hla_zombiereviver")
											npc:SetPos(self:GetPos())
											npc:SetAngles(self:GetAngles())
											if v:GetModel() == "models/creatures/zombies/zombie_citizen.mdl" then
												npc.Citizen = true
												if v:GetBodygroup(2) == 1 then
													npc.CitizenShirt = true
												end
											elseif v:GetModel() == "models/creatures/zombies/zombie_combine_worker.mdl" then
												npc.Worker = true
											elseif v:GetModel() == "models/creatures/zombies/zombie_c17.mdl" then
												npc.C17 = true
											elseif v:GetModel() == "models/creatures/zombies/zombie_hazmat_worker_male.mdl" then
												npc.Hazmat = true
											end
											if self.Spawning == false then
												self.Spawning = true
												npc.ReviverSpawned = true
												npc:Spawn()
												local node = ents.Create("npc_vj_hla_reviver_node")
												node:SetModel("models/creatures/headcrabs/node_headcrab.mdl")
												node:SetOwner(self)
												node:SetPersistent(true)
												node:Spawn()
												if math.random(1,1) == 0 then
													node:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,10,false)
													node:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,1.5)
													node:SetParent(npc,1)
													node:SetPos(npc:GetAttachment(npc:LookupAttachment("head_attachment")).Pos)
													node:SetLocalPos(Vector(3,2,-1))
													node:SetAngles(npc:GetAngles()+Angle(0,30,90))
													ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,npc,1)
													npc.NodePos = "head"
													npc:VJ_ACT_PLAYACTIVITY("ACT_STAND3",true,2.5,false)
													npc.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
													npc.AnimTbl_Walk = {ACT_WALK_STIMULATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
													npc.AnimTbl_Run = {ACT_WALK_STIMULATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
												elseif math.random(1,1) == 0 then
													node:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,10,false)
													node:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,1.5)
													node:SetParent(npc,2)
													node:SetPos(npc:GetAttachment(npc:LookupAttachment("arm_lower_L_TWIST1_attachment")).Pos)
													node:SetLocalPos(Vector(3,2,-1))
													node:SetAngles(npc:GetAngles()+Angle(0,30,90))
													ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,npc,2)
													npc.NodePos = "arm_l"
													npc:VJ_ACT_PLAYACTIVITY("ACT_STAND1",true,3.5,false)
													npc.AnimTbl_IdleStand = {ACT_IDLE_RELAXED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
													npc.AnimTbl_Walk = {ACT_WALK_RELAXED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
													npc.AnimTbl_Run = {ACT_WALK_RELAXED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
												else
													node:VJ_ACT_PLAYACTIVITY("ACT_IDLE_RELAXED",true,10,false)
													node:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,1,false,1.5)
													node:SetParent(npc,3)
													node:SetPos(npc:GetAttachment(npc:LookupAttachment("arm_lower_R_TWIST1_attachment")).Pos)
													node:SetLocalPos(Vector(3,2,-1))
													node:SetAngles(npc:GetAngles()+Angle(0,30,90))
													ParticleEffectAttach("reviver_nz_elec",PATTACH_POINT_FOLLOW,npc,3)
													npc.NodePos = "arm_r"
													npc:VJ_ACT_PLAYACTIVITY("ACT_STAND2",true,6.45714,false)
													npc.AnimTbl_IdleStand = {ACT_IDLE_AGITATED} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
													npc.AnimTbl_Walk = {ACT_WALK_AGITATED} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
													npc.AnimTbl_Run = {ACT_WALK_AGITATED} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
												end
												npc.childs = node
											end
											self:Remove()
											v:Remove()
										end
									end)
									timer.Simple(10,function()
										if self:IsValid() then
											self.FoundParent = false
											self.blengblong = false
										end
									end)
								end
							end)
						end
				--	end
				end
			end
		end
	end
	
	for k,v in pairs(ents.FindInCone(self:GetPos(),self:GetForward(),10000,math.cos( math.rad(80)))) do
		if v:GetClass() == "nb_jeff" and self:Visible(v) and v:IsValid() then
			self:SetTarget(v)
			self:SetEnemy(v)
		end
	end
end

function ENT:CustomAttackCheck_MeleeAttack()
	if self.alamano == false or self.Running == false then
		return true
	elseif self.alamano == true or self.Running == true then
		return false
	end
end -- Not returning true will not let the melee attack code run!

function ENT:CustomAttackCheck_RangeAttack()
	if self.alamano == false or self.Running == false then
		return true
	elseif self.alamano == true or self.Running == true then
		return false
	end
end -- Not returning true will not let the melee attack code run!

function ENT:CustomAttackCheck_LeapAttack()
	if self.alamano == false or self.Running == false then
		return true
	elseif self.alamano == true or self.Running == true then
		return false
	end
end -- Not returning true will not let the melee attack code run!

function ENT:CustomOnLeapAttackVelocityCode()
	VJ_EmitSound(self,self.JumpWhoosh,75,100)
	
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

function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if self:Health() > 0 then
		if math.random(1,10) == 5 then
			if self.Smoke == false and self.Smoke2 == false then
				self.Smoke = true
				VJ_EmitSound(self,"creatures/headcrab_reviver/smoke_release.wav",75,100)
				VJ_EmitSound(self,"creatures/headcrab_reviver/smoke_release_layer.wav",75,100)
				local lpos = self:GetPos()
				ParticleEffect("reviver_smoke_bomb",lpos+Vector(0,0,5),self:GetAngles())
				timer.Simple(.4,function()
					if self:IsValid() then
						ParticleEffect("reviver_smoke_bomb_dazzle",lpos+Vector(0,0,5),self:GetAngles()+Angle(0,30,0))
					end
				end)
				timer.Simple(.8,function()
					if self:IsValid() then
						ParticleEffect("reviver_smoke_bomb_dazzle",lpos+Vector(0,0,5),self:GetAngles()+Angle(0,60,0))
					end
				end)
		--		ParticleEffect("reviver_smoke_bomb_elec_beamhold_1",self:GetPos(),self:GetAngles())
		--		ParticleEffect("reviver_smoke_bomb_child_smoke03d_ring",self:GetPos(),self:GetAngles())
		--		ParticleEffect("reviver_smoke_bomb_child_smoke03d_ring_start",self:GetPos(),self:GetAngles())
		--		ParticleEffect("reviver_death_smoke",self:GetPos(),self:GetAngles())
				if self.alamano == false then
					self.alamano = true
				end
			end
		end
	end
	
	if self:Health() >= 20 then return end
	if self:Health() < 20 then
		self.AnimTbl_IdleStand = {ACT_IDLE_AGITATED}
		self.AnimTbl_Walk = {ACT_WALK_AGITATED}
		self.AnimTbl_Run = {ACT_WALK_AGITATED}
		self.SoundTbl_Breath = {"creatures/headcrab_reviver/breath/injured_out_01.wav",
								"creatures/headcrab_reviver/breath/injured_out_02.wav",
								"creatures/headcrab_reviver/breath/injured_out_03.wav",
								"creatures/headcrab_reviver/breath/injured_out_04.wav",
								"creatures/headcrab_reviver/breath/injured_out_05.wav",
								"creatures/headcrab_reviver/breath/injured_out_06.wav",
								"creatures/headcrab_reviver/breath/injured_out_07.wav",
								"creatures/headcrab_reviver/breath/injured_out_08.wav",
								"creatures/headcrab_reviver/breath/fast_out_01.wav",
								"creatures/headcrab_reviver/breath/fast_out_02.wav",
								"creatures/headcrab_reviver/breath/fast_out_03.wav",
								"creatures/headcrab_reviver/breath/fast_out_04.wav",
								"creatures/headcrab_reviver/breath/fast_out_05.wav",
								"creatures/headcrab_reviver/breath/fast_out_06.wav",
								"creatures/headcrab_reviver/breath/fast_out_07.wav",
								"creatures/headcrab_reviver/breath/fast_out_08.wav"}
		self.FootStepTimeWalk = .5
		self.FootStepTimeRun = .5
		self.sunblock = true
	end
end

function ENT:CustomOnLeapAttack_BeforeChecks()
	if IsValid(self:GetEnemy()) and self:GetEnemy():GetClass() == "nb_jeff" then -- Let nextbot take melee damage
		self:GetEnemy():TakeDamage(self.LeapAttackDamage,self,self)
	end
end

function ENT:CustomOnLeapAttack_BeforeStartTimer()
	timer.Simple(.6,function()
		if self:IsValid() then
			VJ_EmitSound(self,self.Alert,100,100)
		end
	end)
end

function ENT:CustomOnLeapAttack_AfterStartTimer(seed)
	timer.Simple(1.6,function()
		if self:IsValid() then
			self:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.63333,false)
			VJ_EmitSound(self,self.BodyImpact,60,100)
		end
	end)
end

function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	local Dissolver = ents.Create( "env_entity_dissolver" )
    timer.Simple(5, function()
        if Dissolver:IsValid() then
            Dissolver:Remove() -- backup edict save on error
        end
    end)

    Dissolver.Target = "dissolve"..self:EntIndex()
    Dissolver:SetKeyValue( "dissolvetype", 0 )
    Dissolver:SetKeyValue( "magnitude", 0 )
    Dissolver:SetPos( self:GetPos() )
    Dissolver:SetPhysicsAttacker( dmginfo:GetAttacker() )
    Dissolver:Spawn()

    self:SetName( Dissolver.Target )

    Dissolver:Fire( "Dissolve", Dissolver.Target, 0 )
    Dissolver:Fire( "Kill", "", 0.1 )

    return Dissolver
	
	-- credits to whoever coded this in the FacePunch website!
	-- source: https://wiki.facepunch.com/gmod/Entity:TakeDamageInfo
end

function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	local prop = ents.Create("prop_physics")
	prop:SetModel("models/props_junk/popcan01a.mdl")
	prop:SetPos(self:GetPos())
	prop:SetColor(Color(0,0,0,0))
	prop:SetRenderMode(RENDERMODE_TRANSCOLOR)
	prop:Spawn()
	if self:IsOnGround() then
		ParticleEffectAttach("Weapon_Combine_Ion_Cannon_Explosion_Vilomah",PATTACH_ABSORIGIN,prop,1)
	end
	timer.Simple(1,function()
		if prop:IsValid() then
			prop:Remove()
		end
	end)
end
/*----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/