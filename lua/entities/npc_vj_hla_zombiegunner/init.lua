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
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/creatures/zombies/zombine_gunner.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.HullType = HULL_HUMAN
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_bcrab_hl2"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
------ AI / Relationship Variables ------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
	-- ====== Blood-Related Variables ====== --
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
	-- ====== Movement & Idle Variables ====== --
ENT.AnimTbl_IdleStand = {ACT_IDLE_SMG1} -- The idle animation table when AI is enabled | DEFAULT: {ACT_IDLE}
ENT.AnimTbl_Walk = {ACT_RUN_RIFLE} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_RUN_RIFLE} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
ENT.DisableWandering = true -- Disables wandering when the SNPC is idle
--ENT.CanThrowBackDetectedGrenades = false -- Should it pick up the detected grenade and throw it away or to the enemy?
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Melee Attack Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 10
	-- ====== Animation Variables ====== --
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.NextMeleeAttackTime = 4 -- How much time until it can use a melee attack?
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {} -- Death Animations
--ENT.DeathCorpseModel = {"models/creatures/zombies/zombine.mdl"} -- The corpse model that it will spawn when it dies | Leave empty to use the NPC's model | Put as many models as desired, the base will pick a random one.
ENT.DeathCorpseSetBoneAngles = true -- This can be used to stop the corpse glitching or flying on death
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 1 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {} -- If it uses normal based animation, use this
	-- ====== Standing-Firing Variables ====== --
--ENT.Weapon_FiringDistanceFar = 1000 -- How far away it can shoot
--ENT.Weapon_FiringDistanceClose = 0 -- How close until it stops shooting
ENT.WeaponBackAway_Distance = 0 -- When the enemy is this close, the SNPC will back away | 0 = Never back away
--ENT.HasWeaponBackAway = false -- Should the SNPC back away if the enemy is close?
ENT.AnimTbl_WeaponAim = {ACT_IDLE_ANGRY_SMG1} -- Animations played when the NPC is supposed to raise/aim its weapon | EX: Gun is out of ammo, combat idle, etc.| DEFAULT: {ACT_IDLE_ANGRY}
ENT.AnimTbl_WeaponAttack = {ACT_IDLE_ANGRY_SMG1} -- Animation played when the SNPC does weapon attack
ENT.AnimTbl_WeaponAttackCrouch = {ACT_CROUCHIDLE} -- Animation played when the SNPC does weapon attack while crouching | For VJ Weapons
ENT.AnimTbl_WeaponAttackFiringGesture = {ACT_GESTURE_RANGE_ATTACK_SMG1} -- Firing Gesture animations used when the SNPC is firing the weapon
	-- ====== Moving-Firing Variables ====== --
ENT.HasShootWhileMoving = false -- Can it shoot while moving?
	-- ====== Move Randomly While Firing Variables ====== --
ENT.MoveRandomlyWhenShooting = false -- Should it move randomly when shooting?
	-- ====== Reloading Variables ====== --
ENT.AllowWeaponReloading = true -- If false, the SNPC will no longer reload
ENT.AnimTbl_WeaponReload = {ACT_RELOAD} -- Animations that play when the SNPC reloads-- ====== File Path Variables ====== --
------ Grenade Attack Variables ------
ENT.HasGrenadeAttack = true -- Should the SNPC have a grenade attack?
ENT.GrenadeAttackEntity = "obj_vj_xen_grenade" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.GrenadeAttackAttachment = "anim_attachment_LH" -- The attachment that the grenade will spawn at | false = Custom position
	-- ====== Animation Variables ====== --
ENT.AnimTbl_GrenadeAttack = {"ACT_COMBINE_THROW_GRENADE"} -- Grenade Attack Animations
ENT.TimeUntilGrenadeIsReleased = 1.4 -- Time until the grenade is released
	-- ====== Distance & Chance Variables ====== --
--ENT.ThrowGrenadeChance = 1 -- Chance that it will throw the grenade | Set to 1 to throw all the time
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"creatures/zombine_gunner/gear1.wav","creatures/zombine_gunner/gear2.wav","creatures/zombine_gunner/gear3.wav"}
ENT.SoundTbl_Idle = {"creatures/zombine_gunner/zombine_idle1.wav","creatures/zombine_gunner/zombine_idle2.wav","creatures/zombine_gunner/zombine_idle3.wav","creatures/zombine_gunner/zombine_idle4.wav"}
ENT.SoundTbl_Alert = {"creatures/zombine_gunner/zombine_alert1.wav","creatures/zombine_gunner/zombine_alert2.wav","creatures/zombine_gunner/zombine_alert3.wav","creatures/zombine_gunner/zombine_alert4.wav","creatures/zombine_gunner/zombine_alert5.wav","creatures/zombine_gunner/zombine_alert6.wav","creatures/zombine_gunner/zombine_alert7.wav"}
ENT.SoundTbl_GrenadeAttack = {"creatures/zombine_gunner/zombine_readygrenade1.wav","creatures/zombine_gunner/zombine_readygrenade2.wav"}
ENT.SoundTbl_Pain = {"creatures/zombine_gunner/zombine_pain1.wav","creatures/zombine_gunner/zombine_pain2.wav","creatures/zombine_gunner/zombine_pain3.wav","creatures/zombine_gunner/zombine_pain4.wav"}
ENT.SoundTbl_Death = {"creatures/zombine_gunner/zombine_die1.wav","creatures/zombine_gunner/zombine_die2.wav"}

ENT.FootStepTimeRun = 0.35 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.35 -- Next foot step sound when it is walking

ENT.AlertAnim = false
ENT.Alert2Anim = false
ENT.GrenadeLook = false
-------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	if GetConVarNumber("vj_hla_enable_hard_difficulty") == 1 then
		self.StartHealth = 90
	else
		self.StartHealth = 80
	end
end

function ENT:CustomOnThink()
/*
	if self:IsMoving() and not self:GetEnemy() then
		if self:GetPos():Distance(self:GetCurWaypointPos()) <= 30 then
			if self:GetSequenceActivityName(self:GetSequence()) == "ACT_RUN_RIFLE" or self:GetSequenceActivityName(self:GetSequence()) == "ACT_RUN_RIFLE_STIMULATED" then
				self:VJ_ACT_PLAYACTIVITY("vjseq_ACT_RUN_AGITATED",true,1,false)
			end
		end
	end
*/
	if IsValid(self:GetEnemy()) then
		if self:GetPos():Distance(self:GetEnemy():GetPos()) <= 300 and self:Health() >= 20 then
			self.AnimTbl_Run = {ACT_RUN_RIFLE_STIMULATED}
		else
			self.AnimTbl_Run = {ACT_RUN_RIFLE}
		end
	end
	if self:Health() < 20 then
		self.AnimTbl_Walk = {ACT_WALK_HURT}
		self.AnimTbl_Run = {ACT_WALK_HURT}
		self.FootStepTimeWalk = .75
		self.MoveRandomlyWhenShooting = true
		self.WeaponBackAway_Distance = 150
	end
end

function ENT:CustomOnAlert(ent)
	if self.AlertAnim == false and self.Alert2Anim == false then
		if self:GetSequenceActivityName(self:GetSequence()) == "ACT_IDLE_SMG1" then
			self.AlertAnim = true
			self:VJ_ACT_PLAYACTIVITY("ACT_ARM",true,0.916667,true)
			timer.Simple(5,function()
				if self:IsValid() then
					self.AlertAnim = false
				end
			end)
		elseif self:GetSequenceActivityName(self:GetSequence()) == "ACT_IDLE" then
			self.Alert2Anim = true
			self:VJ_ACT_PLAYACTIVITY("ACT_ARM2",true,0.916667,true)
			timer.Simple(5,function()
				if self:IsValid() then
					self.Alert2Anim = false
				end
			end)
		end
	end
	self.AnimTbl_IdleStand = {ACT_IDLE}
end

function ENT:CustomOnIsAbleToShootWeapon()
	if self:GetPos():Distance(self:GetEnemy():GetPos()) >= 300 then
		self:GetActiveWeapon().NPC_NextPrimaryFire = 1.5 -- 0.9
		self:GetActiveWeapon().NPC_TimeUntilFireExtraTimers = {0.15,0.35,0.55,0.75} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
--		self:GetActiveWeapon().NPC_TimeUntilFireExtraTimers = {0.15,0.35} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
	elseif self:GetPos():Distance(self:GetEnemy():GetPos()) < 300 then
--		self:GetActiveWeapon().NPC_NextPrimaryFire = 0.1
		self:GetActiveWeapon().NPC_NextPrimaryFire = 0.5
		self:GetActiveWeapon().NPC_TimeUntilFireExtraTimers = {0.1,0.2,0.3,0.4,0.5}
--		self:GetActiveWeapon().NPC_TimeUntilFireExtraTimers = {0.1,0.3,0.5,0.7} -- Extra timers, which will make the gun fire again! | The seconds are counted after the self.NPC_TimeUntilFire!
	end
	return true
end

function ENT:CustomOnResetEnemy()
	if self.IsReloadingWeapon == false then
--		self:VJ_ACT_PLAYACTIVITY("vjges_ACT_ARM1",false,10.375,false)
	end
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if hitgroup == 11 then
		self:AddGesture(ACT_FLINCH_HEAD)
		dmginfo:SetDamage(1.5)
		ParticleEffect("blood_impact_antlion_01",dmginfo:GetDamagePosition(),self:GetAngles())
	else
		ParticleEffect("blood_impact_red_01",dmginfo:GetDamagePosition(),self:GetAngles())
	end
	
	if dmginfo:GetDamageType() == DMG_BLAST then
		self.FlinchChance = 1 -- Chance of it flinching from 1 to x | 1 will make it always flinch
		self.AnimTbl_Flinch = {ACT_BIG_FLINCH}
	else
		self.FlinchChance = 5 -- Chance of it flinching from 1 to x | 1 will make it always flinch
		self.AnimTbl_Flinch = {"vjseq_explosion_wince_a_s","vjseq_explosion_wince_b_s","vjseq_explosion_wince_c_s"}
	end
end

function ENT:CustomOnInitialKilled(dmginfo, hitgroup)
	self:SetBodygroup(self:FindBodygroupByName("headcrab_classic"),1)
	
	if hitgroup == 11 and GetConVarNumber("vj_hla_enable_hard_difficulty") == 0 then
		local crabdead = ents.Create("prop_ragdoll")
		crabdead:SetModel("models/creatures/headcrabs/headcrab_classic.mdl")
		crabdead:SetPos(self:GetPos()+Vector(0,0,50))
		crabdead:SetAngles(self:GetAngles())
		crabdead:Spawn()
		crabdead:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	else
		local crab = ents.Create("npc_vj_hla_hcrab")
		crab:SetPos(self:GetPos()+Vector(0,0,50))
		crab:SetAngles(self:GetAngles())
		crab:Spawn()
		crab.ALERTPLS = true
		crab:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",true,1.5,false)
	end

	if math.random(1,60) == 1 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE"} //"death_rear"
		self.DeathAnimationTime = 0.416667
	elseif math.random(1,60) == 2 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE2"} //"death_shoulder_a"
		self.DeathAnimationTime = 1.20833
	elseif math.random(1,60) == 3 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE3"} //"new_death_01"
		self.DeathAnimationTime = 0.708333
	elseif math.random(1,60) == 4 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE4"} //"new_death_01_run"
		self.DeathAnimationTime = 0.833333
	elseif math.random(1,60) == 5 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE5"} //"new_death_02"
		self.DeathAnimationTime = 0.541667
	elseif math.random(1,60) == 6 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE6"} //"new_death_05"
		self.DeathAnimationTime = 0.666667
	elseif math.random(1,60) == 7 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE7"} //"new_death_05_run"
		self.DeathAnimationTime = 0.666667
	elseif math.random(1,60) == 8 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE8"} //"new_death_06"
		self.DeathAnimationTime = 1.125
	elseif math.random(1,60) == 9 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE9"} //"new_death_07"
		self.DeathAnimationTime = 0.75
	elseif math.random(1,60) == 10 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE10"} //"new_death_09"
		self.DeathAnimationTime = 0.583333
	elseif math.random(1,60) == 11 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE11"} //"new_death_10"
		self.DeathAnimationTime = 0.75
	elseif math.random(1,60) == 12 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE12"} //"new_death_11"
		self.DeathAnimationTime = 0.708333
	elseif math.random(1,60) == 13 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE13"} //"new_death_12"
		self.DeathAnimationTime = 1.125
	elseif math.random(1,60) == 14 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE14"} //"new_death_13"
		self.DeathAnimationTime = 1.95833
	elseif math.random(1,60) == 15 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE15"} //"new_death_14"
		self.DeathAnimationTime = 1.58333
	elseif math.random(1,60) == 16 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE16"} //"new_death_15"
		self.DeathAnimationTime = 1.58333
	elseif math.random(1,60) == 17 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE17"} //"new_death_16"
		self.DeathAnimationTime = 0.958333
	elseif math.random(1,60) == 18 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE18"} //"new_death_17"
		self.DeathAnimationTime = 1.125
	elseif math.random(1,60) == 19 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE19"} //"new_death_18"
		self.DeathAnimationTime = 1.08333
	elseif math.random(1,60) == 20 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE20"} //"new_death_20"
		self.DeathAnimationTime = 0.708333
	elseif math.random(1,60) == 21 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE21"} //"new_death_20_run"
		self.DeathAnimationTime = 0.666667
	elseif math.random(1,60) == 22 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE22"} //"new_death_21"
		self.DeathAnimationTime = 1.83333
	elseif math.random(1,60) == 23 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE23"} //"new_death_22"
		self.DeathAnimationTime = 1.25
	elseif math.random(1,60) == 24 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE24"} //"new_death_24"
		self.DeathAnimationTime = 0.833333
	elseif math.random(1,60) == 25 then
		self.AnimTbl_Death = {"ACT_DIESIMPLE25"} //"new_death_24_run"
		self.DeathAnimationTime = 0.75
	elseif math.random(1,60) == 26 then
		self.AnimTbl_Death = {"vjseq_new_location_death_01"}
		self.DeathAnimationTime = 0.94167
	elseif math.random(1,60) == 27 then
		self.AnimTbl_Death = {"vjseq_new_location_death_02"}
		self.DeathAnimationTime = 1.25
	elseif math.random(1,60) == 28 then
		self.AnimTbl_Death = {"vjseq_new_location_death_03"}
		self.DeathAnimationTime = 0.791667
	elseif math.random(1,60) == 29 then
		self.AnimTbl_Death = {"vjseq_new_location_death_04"}
		self.DeathAnimationTime = 1.375
	elseif math.random(1,60) == 30 then
		self.AnimTbl_Death = {"vjseq_new_location_death_05"}
		self.DeathAnimationTime = 1.375
	elseif math.random(1,60) == 31 then
		self.AnimTbl_Death = {"vjseq_new_location_death_06"}
		self.DeathAnimationTime = 1.375
	elseif math.random(1,60) == 32 then
		self.AnimTbl_Death = {"vjseq_new_location_death_07"}
		self.DeathAnimationTime = 1.20833
	elseif math.random(1,60) == 33 then
		self.AnimTbl_Death = {"vjseq_new_location_death_08"}
		self.DeathAnimationTime = 1.20833
	elseif math.random(1,60) == 34 then
		self.AnimTbl_Death = {"vjseq_new_location_death_09"}
		self.DeathAnimationTime = 0.541667
	elseif math.random(1,60) == 35 then
		self.AnimTbl_Death = {"vjseq_new_location_death_10"}
		self.DeathAnimationTime = 1.83333
	elseif math.random(1,60) == 36 then
		self.AnimTbl_Death = {"vjseq_new_location_death_11"}
		self.DeathAnimationTime = 2.33333
	elseif math.random(1,60) == 37 then
		self.AnimTbl_Death = {"vjseq_new_location_death_13"}
		self.DeathAnimationTime = 1.29167
	elseif math.random(1,60) == 38 then
		self.AnimTbl_Death = {"vjseq_new_location_death_14"}
		self.DeathAnimationTime = 2.66667
	elseif math.random(1,60) == 39 then
		self.AnimTbl_Death = {"vjseq_new_location_death_15"}
		self.DeathAnimationTime = 2.16667
	elseif math.random(1,60) == 40 then
		self.AnimTbl_Death = {"vjseq_new_location_death_16"}
		self.DeathAnimationTime = 1.375
	elseif math.random(1,60) == 41 then
		self.AnimTbl_Death = {"vjseq_new_location_death_17"}
		self.DeathAnimationTime = 1.91667
	elseif math.random(1,60) == 42 then
		self.AnimTbl_Death = {"vjseq_new_location_death_18"}
		self.DeathAnimationTime = 2.875
	elseif math.random(1,60) == 43 then
		self.AnimTbl_Death = {"vjseq_new_location_death_19"}
		self.DeathAnimationTime = 1.5
	elseif math.random(1,60) == 44 then
		self.AnimTbl_Death = {"vjseq_new_location_death_20"}
		self.DeathAnimationTime = 1.875
	elseif math.random(1,60) == 45 then
		self.AnimTbl_Death = {"vjseq_new_location_death_21"}
		self.DeathAnimationTime = 1.5
	elseif math.random(1,60) == 46 then
		self.AnimTbl_Death = {"vjseq_new_location_death_22"}
		self.DeathAnimationTime = 1.70833333333
	elseif math.random(1,60) == 47 then
		self.AnimTbl_Death = {"vjseq_new_location_death_23"}
		self.DeathAnimationTime = 1.5
	elseif math.random(1,60) == 48 then
		self.AnimTbl_Death = {"vjseq_new_location_death_24"}
		self.DeathAnimationTime = 1.66667
	elseif math.random(1,60) == 49 then
		self.AnimTbl_Death = {"vjseq_new_location_death_25"}
		self.DeathAnimationTime = 1.625
	elseif math.random(1,60) == 50 then
		self.AnimTbl_Death = {"vjseq_new_location_death_26"}
		self.DeathAnimationTime = 1.375
	elseif math.random(1,60) == 51 then
		self.AnimTbl_Death = {"vjseq_new_location_death_27"}
		self.DeathAnimationTime = 1.33333
	elseif math.random(1,60) == 52 then
		self.AnimTbl_Death = {"vjseq_new_location_death_28"}
		self.DeathAnimationTime = 2.08333
	elseif math.random(1,60) == 53 then
		self.AnimTbl_Death = {"vjseq_new_location_death_29"}
		self.DeathAnimationTime = 1.75
	elseif math.random(1,60) == 54 then
		self.AnimTbl_Death = {"vjseq_new_location_death_30"}
		self.DeathAnimationTime = 1.125
	elseif math.random(1,60) == 55 then
		self.AnimTbl_Death = {"vjseq_new_location_death_31"}
		self.DeathAnimationTime = 1.75
	elseif math.random(1,60) == 56 then
		self.AnimTbl_Death = {"vjseq_new_location_death_32"}
		self.DeathAnimationTime = 1.45833
	elseif math.random(1,60) == 57 then
		self.AnimTbl_Death = {"vjseq_new_location_death_33"}
		self.DeathAnimationTime = 1.41667
	elseif math.random(1,60) == 58 then
		self.AnimTbl_Death = {"vjseq_new_location_death_34"}
		self.DeathAnimationTime = 2
	elseif math.random(1,60) == 59 then
		self.AnimTbl_Death = {"vjseq_new_location_death_35"}
		self.DeathAnimationTime = 1.94167
	else
		self.AnimTbl_Death = {"vjseq_new_location_death_36"}
		self.DeathAnimationTime = 1.44167
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/