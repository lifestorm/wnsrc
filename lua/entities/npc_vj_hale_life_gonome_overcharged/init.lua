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
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 500
ENT.DeathAnimationChance = 2
ENT.DeathAnimationTime = 1.7
ENT.AnimTbl_IdleStand = {"ACT_IDLE"}
ENT.AnimTble_Run = {"ACT_RUN","ACT_RUN_2","ACT_RUN_3"}
ENT.AnimTble_Walk = {"ACT_WALK","ACT_WALK_2","Walk_New"}
ENT.MaxJumpLegalDistance = VJ_Set(1000,1500)
ENT.TimeUntilEnemyLost = 99999999999999999 
ENT.LastSeenEnemyTimeUntilReset = 100-- Time until it resets its enemy if its current enemy is not visible
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.InvestigateSoundDistance = 200 -- How far away can the SNPC hear sounds? | This number is timed by the calculated volume of the detectable sound.
ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation
ENT.GibOnDeathDamagesTable = {"UseDefault"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.8 -- Next foot step sound when it is walking
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.HasBloodParticle = true -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true -- Does it spawn a decal when damaged?
ENT.HasBloodPool = true -- Does it have a blood pool?
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.MeleeAttackBleedEnemy = true -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 3 -- Chance that the enemy bleeds | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 4.5 -- How much damage per repetition
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next repetition?
ENT.MeleeAttackBleedEnemyReps = 5 -- How many repetitions?
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 70 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 90 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 40 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 60 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = math.random(12,30) -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = math.random(8,24) -- How far it will push you right | Second in math.random
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.MeleeAttackWorldShakeOnMiss = true -- Should it shake the world when it misses during melee attack?
ENT.MeleeAttackWorldShakeOnMissAmplitude = 2 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.AnimTbl_RangeAttack = {"Attack3"} -- Range Attack Animations
ENT.RangeAttackAnimationStopMovement = true
ENT.RangeAttackEntityToSpawn = "obj_vj_gonome_spit" -- The entity that is spawned when range attacking
ENT.RangeDistance = 35000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 300 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "Blood_Right" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 1.7 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 5 -- How much time until it can use any attack again? | Counted in Seconds

ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"Diesimple","Dieheadshot_1","Dieheadshot_1"} -- Death Animations
ENT.HasHitGroupFlinching = true 
ENT.HitGroupFlinching_DefaultWhenNotHit = true
ENT.HitGroupFlinching_Values = {
{HitGroup = {HITGROUP_HEAD}, Animation = {"big_flinch_2","big_flinch"}}, 
{HitGroup = {HITGROUP_STOMACH}, Animation = {"big_flinch_2","big_flinch"}}, 
{HitGroup = {HITGROUP_CHEST}, Animation = {"big_flinch_2","big_flinch"}}, 
{HitGroup = {HITGROUP_LEFTARM}, Animation = {"ACT_SMALL_FLINCH"}}, 
{HitGroup = {HITGROUP_RIGHTARM}, Animation = {"ACT_SMALL_FLINCH"}}, 
{HitGroup = {HITGROUP_LEFTLEG}, Animation = {"ACT_SMALL_FLINCH"}}, 
{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"ACT_SMALL_FLINCH"}}}

function ENT:CustomOnRangeAttack_BeforeStartTimer(seed)
    if !IsValid(self) then return false end
    local ParticleDelay = math.Rand(1, 1.3)
    timer.Simple(ParticleDelay, function()
        if IsValid(self) then
            VJ_EmitSound(self, "physics/body/body_medium_break2.wav",75,100)
            ParticleEffectAttach("antlion_spit_02", PATTACH_POINT_FOLLOW, self, self:EntIndex())
            ParticleEffectAttach("antlion_gib_02_floaters", PATTACH_POINT_FOLLOW, self, self:EntIndex())
            if self:LookupAttachment("Blood_Right") then
                ParticleEffectAttach("vomit_barnacle", PATTACH_POINT_FOLLOW, self, self:LookupAttachment("Blood_Right"))
            end
            if self:LookupAttachment("maw") then
                ParticleEffectAttach("vomit_barnacle", PATTACH_POINT_FOLLOW, self, self:LookupAttachment("maw")) 
                ParticleEffectAttach("vomit_barnacle_b", PATTACH_POINT_FOLLOW, self, self:LookupAttachment("maw")) 
            end
        end
    end)
end

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.PushProps = true -- Should it push props when trying to move?
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 2000 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = false -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_Postures = "Moving" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 500 -- How close does it have to be until it starts to face the enemy?

ENT.HasLeapAttack = true
ENT.NextLeapAttackTime = 10
ENT.LeapAttackDamage = 10
ENT.AnimTbl_LeapAttack = {"Jump1"} -- Melee Attack Animations
ENT.LeapDistance = 2000 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 900 -- How close does it have to be until it uses melee?
ENT.DisableLeapAttackAnimation = false -- if true, it will disable the animation code
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.LeapAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.LeapAttackAnimationFaceEnemy = 2 -- true = Face the enemy the entire time! | 2 = Face the enemy UNTIL it jumps! | false = Don't face the enemy AT ALL!
ENT.LeapAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.TimeUntilLeapAttackVelocity = 0

ENT.DamageByPlayerDispositionLevel = 0
ENT.DamageByPlayerTime = VJ_Set(2, 2)
ENT.HasStompAttack = false
---------------------------------------------------------------------------------------------------------------------------------------------

function ENT:CustomDeathAnimationCode(dmginfo,hitgroup)
if !IsValid(self) then return false end
    self.DeathAnimationDecreaseLengthAmount = math.Rand(0,0.325)
	if self:IsMoving() then 
	   self.AnimTbl_Death = {"Dieforward"}	
       end	
end

function ENT:LandOnGround()
return false
end

function ENT:CustomOnInitialize()
local GonomeModel = math.random(1,2)
if GonomeModel == 1 then
self:SetModel( Model("models/overchraged_gonome/gonome.mdl") )
self:SetBodygroup(1,math.random(1,1))

elseif GonomeModel == 2 then
self:SetModel( Model("models/overchraged_gonome/gonome_ov.mdl") )
self:SetBodygroup(1,math.random(1,1))
end

if GetConVarNumber("vj_can_gonomes_have_worldshake") == 1 then
self.HasWorldShakeOnMove = false
end
end

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 100
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 100

function ENT:MultipleMeleeAttacks()
local randAttack = math.random(1,2)
if randAttack == 1 then
self.AnimTbl_MeleeAttack = {"Attack2_Npc"}
self.TimeUntilMeleeAttackDamage = 0.25
self.MeleeAttackDamage = math.random(15,25)
self.HasExtraMeleeAttackSounds = true
self.MeleeAttackExtraTimers = {0.75,0.9,1} 
self.MeleeAttackDamageType = DMG_SLASH

elseif randAttack == 2 then
self.AnimTbl_MeleeAttack = {"Attack1_Npc"}
self.TimeUntilMeleeAttackDamage = 0.25
self.MeleeAttackDamage = math.random(15,25)
self.MeleeAttackExtraTimers = {0.8} 
self.HasExtraMeleeAttackSounds = true
self.MeleeAttackDamageType = DMG_SLASH
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_BeforeMeleeAttack = {"npc/zombie/zo_attack1.wav","npc/zombie/zo_attack2.wav","snpc/halflife2betaxenians/betazombie/zo_attack1.wav","snpc/halflife2betaxenians/betazombie/zo_attack2.wav"}
ENT.SoundTbl_FootStep = {"gonome/gonome_step1.wav","gonome/gonome_step2.wav","gonome/gonome_step3.wav","gonome/gonome_step4.wav","gonome/gonome_run.wav"}
ENT.SoundTbl_Idle = {"npc/zombie/zombie_voice_idle1.wav","npc/zombie/zombie_voice_idle2.wav","npc/zombie/zombie_voice_idle3.wav","npc/zombie/zombie_voice_idle4.wav","npc/zombie/zombie_voice_idle5.wav","npc/zombie/zombie_voice_idle6.wav","npc/zombie/zombie_voice_idle7.wav","npc/zombie/zombie_voice_idle8.wav","npc/zombie/zombie_voice_idle9.wav","npc/zombie/zombie_voice_idle10.wav","npc/zombie/zombie_voice_idle11.wav","npc/zombie/zombie_voice_idle12.wav","npc/zombie/zombie_voice_idle13.wav","npc/zombie/zombie_voice_idle14.wav","gonome/gonome_idle1.wav","gonome/gonome_idle2.wav","gonome/gonome_idle3.wav"}
ENT.SoundTbl_MeleeAttack = {"gonome/gonome_melee1.wav","gonome/gonome_melee2.wav","gonome_pl_fallpain1","gonome/pl_burnpain"}
ENT.SoundTbl_MeleeAttackMiss = {"snpc/halflife2betaxenians/betazombie/claw_miss1.wav","snpc/halflife2betaxenians/betazombie/claw_miss2.wav","snpc/halflife2betaxenians/betazombie/zombie_swing.wav"}
ENT.SoundTbl_Pain = {"npc/zombie/zombie_pain1.wav","npc/zombie/zombie_pain2.wav","npc/zombie/zombie_pain3.wav","npc/zombie/zombie_pain4.wav","npc/zombie/zombie_pain5.wav","npc/zombie/zombie_pain6.wav","gonome/gonome_pain1.wav","gonome/gonome_pain2.wav","gonome/gonome_pain3.wav","gonome/gonome_pain4.wav"}
ENT.SoundTbl_Death = {"gonome/gonome_death2.wav","gonome/gonome_death3.wav","gonome/gonome_death4.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"npc/zombie/zombie_alert1.wav","npc/zombie/zombie_alert2.wav","npc/zombie/zombie_alert3.wav"}
ENT.SoundTbl_Alert = {"npc/zombie/zombie_alert1.wav","npc/zombie/zombie_alert2.wav","npc/zombie/zombie_alert3.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/