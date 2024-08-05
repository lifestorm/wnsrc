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
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/headcrabblack.mdl"
ENT.StartHealth = 50
ENT.HullType = HULL_TINY
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE","CLASS_HEADCRAB"}
ENT.LastSeenEnemyTimeUntilReset = 999999999999999 -- Time until it resets its enemy if its current enemy is not visible
ENT.HasDeathAnimation = true-- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"Die"} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
ENT.DeathAnimationChance = 2 -- Put 1 if you want it to play the animation all the time
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 1 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {"Flinch1"} -- If it uses normal based animation, use this
ENT.TimeUntilEnemyLost = 99999999999999999 
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the range attack animation?
ENT.RangeAttackEntityToSpawn = "obj_vj_corrosive_proj" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {"Spitattack"} -- Range Attack Animations
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.RangeDistance = 2000 -- This is how far away it can shoot
ENT.RangeAttackReps = 1 -- How many times does it run the projectile code?
ENT.TimeUntilRangeAttackProjectileRelease = 0.8
ENT.NextRangeAttackTime = 3 -- How much time until it can use a range attack?
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 70 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 90 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 40 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 60 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = math.random(12,30) -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = math.random(8,24) -- How far it will push you right | Second in math.random
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = false
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_RANGE_ATTACK1} -- Melee Attack Animations
ENT.LeapDistance = 250 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 1.5 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 1.8 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 1.8 -- How much time until it can use any attack again? | Counted in Seconds
ENT.TimeUntilLeapAttackVelocity = 1.48 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 50 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 250 -- How much upward force should it apply?
ENT.LeapAttackDamageType = DMG_POISON
ENT.LeapAttackExtraTimers = {1.6,1.8,2} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.StopLeapAttackAfterFirstHit = true
ENT.LeapAttackDamageDistance = 40 -- How far does the damage go?
ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.LeapAttackDamage = 99
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Bleeds = true 
ENT.BloodColor = "Yellow"
ENT.HasBloodParticle = true 
ENT.HasBloodDecal = true 
ENT.HasBloodPool = true 
ENT.NextRangeAttackTime = 6
ENT.AnimTbl_IdleStand = {"Idle01","Idle01fast","IdleSumo","IdleSniff"}
ENT.InvestigateSoundDistance = 200 -- How far away can the SNPC hear sounds? | This number is timed by the calculated volume of the detectable sound.
ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation
ENT.GibOnDeathDamagesTable = {"UseDefault"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.AnimTbl_IdleStand = {ACT_IDLE} 
ENT.AnimTbl_Walk = {ACT_WALK}
ENT.AnimTbl_Run = {ACT_RUN} 
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.CallForHelpDistance = 4000 -- -- How far away the SNPC's call for help goes | Counted in World 
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
    return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(math.random(-30,30),math.random(-30,30),math.random(20,30))))*2 + self:GetUp()*300
end

function ENT:CustomOnAlert(ent)
if math.random(1,3) == 1 then
self:VJ_ACT_PLAYACTIVITY("Threatdisplay",true,false,false)
self.CallForHelp = true 
self.CallForHelpDistance = 500000000000
ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)

elseif math.random(1,3) == 2 then
self:VJ_ACT_PLAYACTIVITY("Telegraph_B",true,false,false)
self.CallForHelp = true 
self.CallForHelpDistance = 50000000000
ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)

elseif math.random(1,3) == 3 then
self:VJ_ACT_PLAYACTIVITY("Telegraph_B2",true,false,false)
self.CallForHelp = true 
self.CallForHelpDistance = 500000000000
ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)
end
end

function ENT:CustomOnCallForHelp()
if math.random(1,3) == 1 then
self:VJ_ACT_PLAYACTIVITY("Threatdisplay",true,false,false)
self.CallForHelp = true 
self.CallForHelpDistance = 500000000000
ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)

elseif math.random(1,3) == 2 then
self:VJ_ACT_PLAYACTIVITY("Telegraph_B",true,false,false)
self.CallForHelp = true 
self.CallForHelpDistance = 50000000000
ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)

elseif math.random(1,3) == 3 then
self:VJ_ACT_PLAYACTIVITY("Telegraph_B2",true,false,false)
self.CallForHelp = true 
self.CallForHelpDistance = 500000000000
ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)
end
end

function ENT:CustomOnThink()
if self:WaterLevel() > 1 then
self.MovementType = VJ_MOVETYPE_STATIONARY
self.SightDistance = 1 
self.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE
self.IsGuard = true
self.CallForHelp = false
self:VJ_TASK_IDLE_STAND("TASK_IDLE_STAND")
self:SetVelocity(Vector(0,0,2))
self.AnimTbl_IdleStand = {"drown"}
self.Bleeds = false
self.HasLeapAttack = false
self.HasRangeAttack = false
self:TakeDamage(1)
end

if self:Health() <= 10 then
self.AnimTbl_Run = {VJ_SequenceToActivity(self,"Scurry")}
self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"Scurry")}
self.FootStepTimeRun = 0.09
self.FootStepTimeWalk = 0.09
else
self.AnimTbl_Walk = {ACT_WALK}
self.AnimTbl_Run = {ACT_RUN} 

if self:IsOnFire() then
self.AnimTbl_Run = {VJ_SequenceToActivity(self,"Scurry")}
self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"Scurry")}
self.FootStepTimeRun = 0.09
self.FootStepTimeWalk = 0.09
else
self.AnimTbl_Walk = {ACT_WALK}
self.AnimTbl_Run = {ACT_RUN} 
end
end
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
if math.random(1,10) == 1  then 
self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH")
end
end

function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
self.HasDeathRagdoll = false
VJ_EmitSound(self, "gib/bodysplat.wav", 90, 100)
local effectBlood = EffectData()
effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
effectBlood:SetColor(VJ_Color2Byte(Color(255,221,35)))
effectBlood:SetScale(50)
util.Effect("VJ_Blood1",effectBlood)		
local bloodspray = EffectData()
bloodspray:SetOrigin(self:GetPos() + self:OBBCenter())
bloodspray:SetScale(8)
bloodspray:SetFlags(3)
bloodspray:SetColor(1)
util.Effect("bloodspray",bloodspray)
util.Effect("bloodspray",bloodspray)
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_07.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_06.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_06.mdl",{Pos=self:GetPos()+self:OBBCenter()})
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- ====== Sound Pitch ====== --
-- Higher number = Higher pitch | Lower number = Lower pitch
-- Highest number is 254
	-- !!! Important variables !!! --
ENT.UseTheSameGeneralSoundPitch = true 
	-- If set to true, it will make the game decide a number when the SNPC is created and use it for all sound pitches set to "UseGeneralPitch"
	-- It picks the number between the two variables below:
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
	-- This two variables control any sound pitch variable that is set to "UseGeneralPitch"
	-- To not use these variables for a certain sound pitch, just put the desired number in the specific sound pitch
ENT.FootStepPitch1 = 100
ENT.FootStepPitch2 = 100
ENT.BreathSoundPitch1 = 100
ENT.BreathSoundPitch2 = 100
ENT.IdleSoundPitch1 = "UseGeneralPitch"
ENT.IdleSoundPitch2 = "UseGeneralPitch"
ENT.CombatIdleSoundPitch1 = "UseGeneralPitch"
ENT.CombatIdleSoundPitch2 = "UseGeneralPitch"
ENT.OnReceiveOrderSoundPitch1 = "UseGeneralPitch"
ENT.OnReceiveOrderSoundPitch2 = "UseGeneralPitch"
ENT.FollowPlayerPitch1 = "UseGeneralPitch"
ENT.FollowPlayerPitch2 = "UseGeneralPitch"
ENT.UnFollowPlayerPitch1 = "UseGeneralPitch"
ENT.UnFollowPlayerPitch2 = "UseGeneralPitch"
ENT.BeforeHealSoundPitch1 = "UseGeneralPitch"
ENT.BeforeHealSoundPitch2 = "UseGeneralPitch"
ENT.AfterHealSoundPitch1 = 100
ENT.AfterHealSoundPitch2 = 100
ENT.OnPlayerSightSoundPitch1 = "UseGeneralPitch"
ENT.OnPlayerSightSoundPitch2 = "UseGeneralPitch"
ENT.AlertSoundPitch1 = "UseGeneralPitch"
ENT.AlertSoundPitch2 = "UseGeneralPitch"
ENT.CallForHelpSoundPitch1 = "UseGeneralPitch"
ENT.CallForHelpSoundPitch2 = "UseGeneralPitch"
ENT.BecomeEnemyToPlayerPitch1 = "UseGeneralPitch"
ENT.BecomeEnemyToPlayerPitch2 = "UseGeneralPitch"
ENT.BeforeMeleeAttackSoundPitch1 = "UseGeneralPitch"
ENT.BeforeMeleeAttackSoundPitch2 = "UseGeneralPitch"
ENT.MeleeAttackSoundPitch1 = "UseGeneralPitch"
ENT.MeleeAttackSoundPitch2 = "UseGeneralPitch"
ENT.ExtraMeleeSoundPitch1 = 100
ENT.ExtraMeleeSoundPitch2 = 100
ENT.MeleeAttackMissSoundPitch1 = 100
ENT.MeleeAttackMissSoundPitch2 = 100
ENT.BeforeRangeAttackPitch1 = "UseGeneralPitch"
ENT.BeforeRangeAttackPitch2 = "UseGeneralPitch"
ENT.RangeAttackPitch1 = "UseGeneralPitch"
ENT.RangeAttackPitch2 = "UseGeneralPitch"
ENT.BeforeLeapAttackSoundPitch1 = "UseGeneralPitch"
ENT.BeforeLeapAttackSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackJumpSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackJumpSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackDamageSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackDamageSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackDamageMissSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackDamageMissSoundPitch2 = "UseGeneralPitch"
ENT.OnKilledEnemySoundPitch1 = "UseGeneralPitch"
ENT.OnKilledEnemySoundPitch2 = "UseGeneralPitch"
ENT.PainSoundPitch1 = "UseGeneralPitch"
ENT.PainSoundPitch2 = "UseGeneralPitch"
ENT.ImpactSoundPitch1 = 100
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = "UseGeneralPitch"
ENT.DamageByPlayerPitch2 = "UseGeneralPitch"
ENT.DeathSoundPitch1 = "UseGeneralPitch"
ENT.DeathSoundPitch2 = "UseGeneralPitch"
ENT.SoundTbl_LeapAttackJump = {"npc/headcrab_poison/ph_jump1.wav","npc/headcrab_poison/ph_jump2.wav","npc/headcrab_poison/ph_jump3.wav"}
ENT.SoundTbl_FootStep = {"npc/headcrab_poison/ph_step1.wav","npc/headcrab_poison/ph_step2.wav","npc/headcrab_poison/ph_step3.wav","npc/headcrab_poison/ph_step4.wav"}
ENT.SoundTbl_Alert = {"npc/headcrab_poison/ph_warning1.wav","npc/headcrab_poison/ph_warning2.wav","npc/headcrab_poison/ph_warning3.wav"}
ENT.SoundTbl_CombatIdle = {"npc/headcrab_poison/ph_hiss1.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"npc/headcrab_poison/ph_scream1.wav","npc/headcrab_poison/ph_scream2.wav","npc/headcrab_poison/ph_scream3.wav"}
ENT.SoundTbl_BeforeLeapAttack = {"npc/headcrab_poison/ph_scream1.wav","npc/headcrab_poison/ph_scream2.wav","npc/headcrab_poison/ph_scream3.wav"}
ENT.SoundTbl_LeapAttackDamage = {"npc/headcrab_poison/ph_poisonbite1.wav","npc/headcrab_poison/ph_poisonbite2.wav","npc/headcrab_poison/ph_poisonbite3.wav"}
ENT.SoundTbl_LeapAttackJump = {"npc/headcrab_poison/ph_jump1.wav","npc/headcrab_poison/ph_jump2.wav","npc/headcrab_poison/ph_jump3.wav"}
ENT.SoundTbl_Pain = {"npc/headcrab_poison/ph_pain1.wav","npc/headcrab_poison/ph_pain2.wav","npc/headcrab_poison/ph_pain3.wav","npc/headcrab_poison/ph_wallpain1.wav","npc/headcrab_poison/ph_wallpain2.wav","npc/headcrab_poison/ph_wallpain3.wav"}
ENT.SoundTbl_Death = {"npc/headcrab_poison/ph_rattle1.wav","npc/headcrab_poison/ph_rattle2.wav","npc/headcrab_poison/ph_rattle3.wav"}
ENT.SoundTbl_Idle = {"npc/headcrab_poison/ph_idle1.wav","npc/headcrab_poison/ph_idle2.wav","npc/headcrab_poison/ph_idle3.wav",}
ENT.SoundTbl_IdleDialogue = {"npc/headcrab_poison/ph_talk1.wav","npc/headcrab_poison/ph_talk2.wav","npc/headcrab_poison/ph_talk3.wav",}
ENT.SoundTbl_IdleDialogueAnswer = {"npc/headcrab_poison/ph_talk1.wav","npc/headcrab_poison/ph_talk2.wav","npc/headcrab_poison/ph_talk3.wav",}
ENT.SoundTbl_FollowPlayer = {"npc/headcrab_poison/ph_idle1.wav","npc/headcrab_poison/ph_idle2.wav","npc/headcrab_poison/ph_idle3.wav",}
ENT.SoundTbl_UnFollowPlayer = {"npc/headcrab_poison/ph_talk1.wav","npc/headcrab_poison/ph_talk2.wav","npc/headcrab_poison/ph_talk3.wav",}
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/