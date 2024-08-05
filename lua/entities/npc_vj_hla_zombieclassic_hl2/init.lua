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
ENT.StartHealth = 50
ENT.Model = {"models/creatures/zombies/zombie_classic.mdl"}
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
ENT.AnimTbl_IdleStand = {"ACT_IDLE"} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
ENT.DeathCorpseSetBoneAngles = true -- This can be used to stop the corpse glitching or flying on death
ENT.DeathCorpseApplyForce = false -- Disables the damage force on death | Useful for SNPCs with Death Animations
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.DeathCorpseSetBodyGroup = true -- Should it get the models bodygroups and set it to the corpse? When set to false, it uses the model's default bodygroups
-- ====== Death Animation Variables ====== --
ENT.HasDeathAnimation = false -- Does it play an animation when it dies?
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Melee Attack Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = GetConVarNumber("vj_hla_hzomb_d")
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.AnimTbl_MeleeAttack = {} -- Melee Attack Animations
ENT.MeleeAttackDamage = 10
	-- ====== Distance Variables ====== --
ENT.MeleeAttackDistance = 35 -- How close does it have to be until it attacks?
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.MeleeAttackReps = 1 -- How many times does it run the melee attack code?
ENT.FootStepTimeWalk = .9 -- Next foot step sound when it is walking
ENT.FootStepTimeRun = .9 -- Next foot step sound when it is walking
--------------------------------------------------------------------------------------------------------------------
ENT.FootStep = {"npc/zombie/foot1.wav","npc/zombie/foot2.wav","npc/zombie/foot3.wav"}
ENT.SoundTbl_Idle = {"npc/zombie/zombie_voice_idle1.wav",
					 "npc/zombie/zombie_voice_idle2.wav",
					 "npc/zombie/zombie_voice_idle3.wav",
					 "npc/zombie/zombie_voice_idle4.wav",
					 "npc/zombie/zombie_voice_idle5.wav",
					 "npc/zombie/zombie_voice_idle6.wav",
					 "npc/zombie/zombie_voice_idle7.wav",
					 "npc/zombie/zombie_voice_idle8.wav",
					 "npc/zombie/zombie_voice_idle9.wav",
					 "npc/zombie/zombie_voice_idle10.wav",
					 "npc/zombie/zombie_voice_idle11.wav",
					 "npc/zombie/zombie_voice_idle12.wav",
					 "npc/zombie/zombie_voice_idle13.wav",
					 "npc/zombie/zombie_voice_idle14.wav"}
ENT.SoundTbl_Alert = {"npc/zombie/zombie_alert1.wav","npc/zombie/zombie_alert2.wav","npc/zombie/zombie_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/zombie/zo_attack1.wav","npc/zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Impact = {"physics/bullet_impacts/flesh_npc_01.wav",
					   "physics/bullet_impacts/flesh_npc_02.wav",
					   "physics/bullet_impacts/flesh_npc_03.wav",
				   	   "physics/bullet_impacts/flesh_npc_04.wav",
				   	   "physics/bullet_impacts/flesh_npc_05.wav",
				   	   "physics/bullet_impacts/flesh_npc_06.wav",
				   	   "physics/bullet_impacts/flesh_npc_07.wav",
				   	   "physics/bullet_impacts/flesh_npc_08.wav"}
ENT.SoundTbl_Pain = {"npc/zombie/zombie_pain1.wav","npc/zombie/zombie_pain2.wav","npc/zombie/zombie_pain3.wav","npc/zombie/zombie_pain4.wav","npc/zombie/zombie_pain5.wav","npc/zombie/zombie_pain6.wav"}
ENT.SoundTbl_Death = {"npc/zombie/zombie_die1.wav","npc/zombie/zombie_die2.wav","npc/zombie/zombie_die3.wav"}
--------------------------------------------------------------------------------------------------------------------
ENT.FleshImpactLayer = {"physics/flesh/flesh_impact_bullet1.wav",
						"physics/flesh/flesh_impact_bullet2.wav",
						"physics/flesh/flesh_impact_bullet3.wav",
						"physics/flesh/flesh_impact_bullet4.wav",
					    "physics/flesh/flesh_impact_bullet5.wav"}
ENT.Idling = false
ENT.Bloater = false
ENT.itsmarcosingtime = false
ENT.alamano = nil
ENT.inflatonrate = false
ENT.rice = false
--------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup(self:FindBodygroupByName("headcrab1"),1)
end

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	if evOptions == "zombie_step" then
		VJ_EmitSound(self,self.FootStep,75,100)
	end
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup)
	VJ_EmitSound(self,self.FleshImpactLayer,60,100)
end

function ENT:CustomOnThink()
	if math.random(1,2) == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_attackB"}
		self.MeleeAttackReps = 2
		self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
	else
		self.AnimTbl_MeleeAttack = {"vjseq_attackA","vjseq_attackC"}
		self.MeleeAttackReps = 1
		self.TimeUntilMeleeAttackDamage = 1.1 -- This counted in seconds | This calculates the time until it hits something
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
	self:SetBodygroup(self:FindBodygroupByName("headcrab1"),0)

	if hitgroup == HITGROUP_HEAD then
		local crabdead = ents.Create("prop_ragdoll")
		crabdead:SetModel("models/headcrabclassic.mdl")
		crabdead:SetPos(self:GetPos()+Vector(0,0,50))
		crabdead:SetAngles(self:GetAngles())
		crabdead:Spawn()
		crabdead:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	else
		local crab = ents.Create("npc_headcrab")
		crab:SetPos(self:GetPos()+Vector(0,0,50))
		crab:SetAngles(self:GetAngles())
		crab:Spawn()
	end
	
	self.AnimTbl_Death = {"ACT_DIESIMPLE"} //"zombie_death_anim_02"
	self.DeathAnimationTime = 1.33333
end

-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base