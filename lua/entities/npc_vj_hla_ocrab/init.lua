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
ENT.Model = {"models/creatures/headcrabs/headcrab_classic_april2020.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_hla_ocrab_h") -- or you can use a convar: GetConVarNumber("vj_dum_dummy_h")
ENT.HullType = HULL_TINY
------ AI / Relationship Variables ------
ENT.HasAllies = true -- Put to false if you want it not to have any allies
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.EntitiesToNoCollide = {"npc_vj_hla_ocrab","npc_vj_hla_hcrab","npc_vj_hla_ahcrab","npc_vj_hla_fcrab","npc_vj_hla_bcrab","npc_vj_hla_rcrab","npc_vj_hla_fhcrab","npc_drg_headcrabv2_mdcversion","npc_drg_poisonheadcrabv2_mdcversion","npc_drg_fastheadcrabv2_mdcversion","npc_vj_hla_zombieclassic","npc_vj_hla_zombiearmored","npc_vj_hla_zombiereviver"} -- Entities to not collide with when HasEntitiesToNoCollide is set to true
------ Damaged / Injured Variables ------
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
	-- ====== Miscellaneous Variables ====== --
ENT.PushProps = true -- Should it push props when trying to move?
------ Killed & Corpse Variables ------
	-- ====== Corpse Variables ====== --
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.UsesBoneAngle = true -- This can be used to stop the corpse glitching or flying on death
ENT.DeathCorpseSetBodyGroup = true -- Should it get the models bodygroups and set it to the corpse? When set to false, it uses the model's default bodygroups
ENT.DeathCorpseBodyGroup = VJ_Set(1,1) -- #1 = the category of the first bodygroup | #2 = the value of the second bodygroup | Set -1 for #1 to let the base decide the corpse's bodygroup
ENT.FadeCorpse = true -- Fades the ragdoll on death
ENT.FadeCorpseTime = 125 -- How much time until the ragdoll fades | Unit = Seconds
	-- ====== Death Animation Variables ====== --
//ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"ACT_DIE_HEADSHOT","ACT_DIE_BACKSHOT","ACT_DIE_GUTSHOT","ACT_DIE_CHESTSHOT"} -- Death Animations
ENT.DeathAnimationDecreaseLengthAmount = .3 -- This will decrease the time until it turns into a corpse
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 3 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
------ Melee Attack Variables ------
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
------ Leap Attack Variables ------
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.LeapAttackDamage = 20
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.AnimTbl_LeapAttack = {ACT_RANGE_ATTACK1} -- Melee Attack Animations
ENT.TimeUntilLeapAttackDamage = 2.9 -- How much time until it runs the leap damage code?
ENT.TimeUntilLeapAttackVelocity = 2.4 -- How much time until it runs the velocity code?
ENT.LeapAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the leap attack animation?
	-- ====== Distance Variables ====== --
ENT.LeapDistance = 300 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.LeapAttackDamageDistance = 75 -- How far does the damage go?
	-- ====== Velocity Variables ====== --
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 250 -- How much upward force should it apply?
	-- ====== Movement & Idle Variables ====== --
ENT.AnimTbl_IdleStand = {"ACT_IDLE","ACT_IDLE2"} -- The idle animation when AI is enabled
------ Sound Variables ------
ENT.HasSounds = true -- Put to false to disable ALL sounds!
ENT.FootStepTimeRun = .1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = .2 -- Next foot step sound when it is walking
	-- ====== File Path Variables ====== --
ENT.SoundTbl_Idle = {"creatures/headcrab_classic/idle_chirp_01.wav","creatures/headcrab_classic/idle_chirp_02.wav","creatures/headcrab_classic/idle_chirp_03.wav","creatures/headcrab_classic/idle_chirp_04.wav","creatures/headcrab_classic/idle_chirp_05.wav","creatures/headcrab_classic/idle_chirp_06.wav","creatures/headcrab_classic/idle_chirp_07.wav","creatures/headcrab_classic/idle_chirp_08.wav","creatures/headcrab_classic/idle_chirp_09.wav","creatures/headcrab_classic/idle_chirp_10.wav","creatures/headcrab_classic/idle_chirp_11.wav","creatures/headcrab_classic/idle_chirp_12.wav","creatures/headcrab_classic/idle_chirp_13.wav","creatures/headcrab_classic/idle_chirp_14.wav","creatures/headcrab_classic/idle_chirp_15.wav"}
ENT.SoundTbl_LeapAttackJump = {"creatures/headcrab_classic/attack_grunt_01.wav","creatures/headcrab_classic/attack_grunt_02.wav","creatures/headcrab_classic/attack_grunt_03.wav","creatures/headcrab_classic/attack_grunt_04.wav","creatures/headcrab_classic/attack_grunt_05.wav","creatures/headcrab_classic/attack_grunt_06.wav"}
ENT.SoundTbl_LeapAttackDamage = {"creatures/headcrab_classic/chomp_01.wav","creatures/headcrab_classic/chomp_02.wav","creatures/headcrab_classic/chomp_03.wav","creatures/headcrab_classic/chomp_04.wav","creatures/headcrab_classic/chomp_05.wav","creatures/headcrab_classic/chomp_06.wav","creatures/headcrab_classic/chomp_07.wav","creatures/headcrab_classic/chomp_08.wav","creatures/headcrab_classic/chomp_09.wav","creatures/headcrab_classic/chomp_10.wav"}
ENT.SoundTbl_Pain = {"creatures/headcrab_classic/pain_01.wav","creatures/headcrab_classic/pain_02.wav","creatures/headcrab_classic/pain_03.wav","creatures/headcrab_classic/pain_04.wav","creatures/headcrab_classic/pain_05.wav","creatures/headcrab_classic/pain_06.wav"}
ENT.SoundTbl_Death = {"creatures/headcrab_classic/death_01.wav","creatures/headcrab_classic/death_02.wav","creatures/headcrab_classic/death_03.wav","creatures/headcrab_classic/death_04.wav"}
ENT.SoundTbl_Impact = {"creatures/headcrab_classic/body_impact_01.wav","creatures/headcrab_classic/body_impact_02.wav","creatures/headcrab_classic/body_impact_03.wav","creatures/headcrab_classic/body_impact_04.wav","creatures/headcrab_classic/body_impact_05.wav","creatures/headcrab_classic/body_impact_06.wav"}
ENT.SoundTbl_FootStep = {"creatures/headcrab_classic/step_01.wav","creatures/headcrab_classic/step_02.wav","creatures/headcrab_classic/step_03.wav","creatures/headcrab_classic/step_04.wav","creatures/headcrab_classic/step_05.wav","creatures/headcrab_classic/step_06.wav","creatures/headcrab_classic/step_07.wav","creatures/headcrab_classic/step_08.wav","creatures/headcrab_classic/step_claw_01.wav","creatures/headcrab_classic/step_claw_02.wav","creatures/headcrab_classic/step_claw_03.wav","creatures/headcrab_classic/step_claw_04.wav","creatures/headcrab_classic/step_claw_05.wav","creatures/headcrab_classic/step_claw_06.wav","creatures/headcrab_classic/step_claw_07.wav","creatures/headcrab_classic/step_claw_08.wav"}
 -- Custom --
ENT.Alert = {"creatures/headcrab_classic/alerted_01.wav","creatures/headcrab_classic/alerted_02.wav","creatures/headcrab_classic/vox/attack_warning_01.wav"}
ENT.Grunt = {"creatures/headcrab_classic/grunt_01.wav","creatures/headcrab_classic/grunt_02.wav","creatures/headcrab_classic/grunt_03.wav","creatures/headcrab_classic/grunt_04.wav","creatures/headcrab_classic/grunt_05.wav","creatures/headcrab_classic/grunt_06.wav","creatures/headcrab_classic/grunt_07.wav","creatures/headcrab_classic/grunt_08.wav","creatures/headcrab_classic/grunt_09.wav","creatures/headcrab_classic/grunt_10.wav","creatures/headcrab_classic/grunt_11.wav","creatures/headcrab_classic/grunt_12.wav"}
ENT.Idle2 = false
-----------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
end

function ENT:CustomOnLeapAttack_BeforeStartTimer(seed)	
	timer.Simple(.7,function()
		VJ_EmitSound(self,self.Alert,80,100)
	end)
end

function ENT:CustomOnLeapAttack_AfterStartTimer()
	self:VJ_ACT_PLAYACTIVITY("ACT_VICTORY_DANCE",false,0,false,3.1)
end

function ENT:CustomOnThink()
	if self:GetSequence() == 1 and self.Idle2 == false then
		self.Idle2 = true
		timer.Simple(.9, function()
			VJ_EmitSound(self,self.Grunt,75,100)
			timer.Simple(.7,function() self.Idle2 = false end)
		end)
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/