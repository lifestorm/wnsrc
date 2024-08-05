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
ENT.Model = {"models/extra_gonome/akagonome.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 620
ENT.HullType = HULL_WIDE_HUMAN
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = false 
ENT.DeathAnimationChance = 1
ENT.DeathAnimationTime = 1.7
ENT.AnimTbl_Death = {"Dieforward","Diebackward","Diesimple","Dieheadshot_1","Dieheadshot_2"}
ENT.AnimTbl_IdleStand = {"ACT_IDLE","Victoryeat1","Idle1","Idle2"}
ENT.AnimTble_Run = {"ACT_RUN","ACT_RUN_2"}
ENT.AnimTble_Walk = {"ACT_WALK"}
ENT.TimeUntilEnemyLost = 99999999999999999 
ENT.LastSeenEnemyTimeUntilReset = 100-- Time until it resets its enemy if its current enemy is not visible
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.InvestigateSoundDistance = 200 -- How far away can the SNPC hear sounds? | This number is timed by the calculated volume of the detectable sound.
ENT.Immune_Fire = true -- Immune to fire-type damages
ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation
ENT.GibOnDeathDamagesTable = {"UseDefault"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.8 -- Next foot step sound when it is walking
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.HasBloodParticle = true -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true -- Does it spawn a decal when damaged?
ENT.HasBloodPool = true -- Does it have a blood pool?
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.AnimTbl_MeleeAttack = {"Attack3"}
ENT.TimeUntilMeleeAttackDamage = 100
ENT.MeleeAttackDamage = 0

ENT.MeleeAttackBleedEnemy = false-- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 3 -- Chance that the enemy bleeds | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 4.5 -- How much damage per repetition
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next repetition?
ENT.MeleeAttackBleedEnemyReps = 5 -- How many repetitions?
ENT.SlowPlayerOnMeleeAttack = false -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 200 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 40 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 70 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = 0 -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = 0 -- How far it will push you right | Second in math.random
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.MeleeAttackWorldShakeOnMiss = true -- Should it shake the world when it misses during melee attack?
ENT.MeleeAttackWorldShakeOnMissAmplitude = 2 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_vj_gonome_spit" -- The entity that is spawned when range attacking
ENT.RangeDistance = 5000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 800 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = false -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "Mouth" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 1.7 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
ENT.NextAnyAttackTime_Range = 5 -- How much time until it can use any attack again? | Counted in Seconds
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
ENT.HasLeapAttack = false
ENT.LeapAttackDamage = 0
ENT.AnimTbl_LeapAttack = {"Jump1"} -- Melee Attack Animations
ENT.LeapDistance = 900 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 800 -- How close does it have to be until it uses melee?
ENT.DisableLeapAttackAnimation = true -- if true, it will disable the animation code
---------------------------------------------------------------------------------------------------------------------------------------------
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 1 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 3 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {"Flinch","Big_Flinch"} -- If it uses normal based animation, use this
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.CallForHelpDistance = 4000 -- -- How far away the SNPC's call for help goes | Counted in World 
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
    return (self:GetEnemy():GetPos() - self:LocalToWorld(Vector(math.random(-30,30),math.random(-30,30),math.random(20,30))))*2 + self:GetUp()*300
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(ent, attacker, inflictor)
if GetConVarNumber("vj_can_gonomes_regain_hp") == 0 then 
if attacker == self then
self:SetHealth(self:Health() + 300)
else
return false 
end
end

if GetConVarNumber("vj_can_gonomes_dance") == 0 then return false end
if math.random(1,1) == 1  then
self:VJ_ACT_PLAYACTIVITY("Sohappy", false, false, false, 0, {vTbl_SequenceInterruptible=true})
end
end

function ENT:CustomOnMeleeAttack_AfterChecks(v, isProp) 
if GetConVarNumber("vj_can_gonomes_screen_fx") == 1 then return false end 
if v:IsPlayer() then
local pitch = math.random(-100, 100)
local yaw = math.random(-100, 100)
v:ViewPunch(Angle(pitch, yaw, 5))
v:ScreenFade(SCREENFADE.IN,Color(64,0,0),10,0)
end
return false
end

function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
			dmginfo:ScaleDamage(0.85)
end

function ENT:CustomOnMeleeAttack_BeforeStartTimer()
self:VJ_ACT_PLAYACTIVITY("ACT_RANGE_ATTACK1", false, false, false, 0, {vTbl_SequenceInterruptible=true})
timer.Simple(1.5,function() if IsValid(self) then
self:TakeDamage(9999999999999999999999999999)
self.HasDeathRagdoll = false
self.HasGibOnDeath = true
self.HasDeathAnimation = false
end
end)
end


function ENT:CustomOnInitialize() 
ParticleEffectAttach("smoke_small_01b",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("head"))
ParticleEffectAttach("smoke_small_01b",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("head"))
ParticleEffectAttach("smoke_small_01b",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("head"))
ParticleEffectAttach("smoke_small_01b",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("head"))
ParticleEffectAttach("smoke_small_01b",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("head"))
ParticleEffectAttach("smoke_small_01b",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("head"))
if GetConVarNumber("vj_can_gonomes_have_worldshake") == 1 then
self.HasWorldShakeOnMove = false
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
ENT.SoundTbl_BeforeRangeAttack = {"physics/body/body_medium_break2.wav"}
ENT.SoundTbl_Alert = {"npc/zombie/zombie_alert1.wav","npc/zombie/zombie_alert2.wav","npc/zombie/zombie_alert3.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------

function ENT:CustomOnKilled(dmginfo,hitgroup)
VJ_EmitSound(self, "gib/bodysplat.wav", 90, 100)
self.DeathAnimationTime = 0
self.DeathAnimationChance = 0
local effectBlood = EffectData()
effects.BeamRingPoint(self:GetPos(), 0.3, 2, 400, 16, 0, Color(255, 255, 255), {material="sprites/flame01", framerate=20})
effects.BeamRingPoint(self:GetPos(), 0.3, 2, 200, 16, 0, Color(255, 255, 255), {material="sprites/flame01", framerate=20})	
util.VJ_SphereDamage(self,self,self:GetPos(),150,math.random(500,600),DMG_BURN,false,true,{Force=80})     
util.BlastDamage(self,self,self:GetPos(),200,350)
util.ScreenShake(self:GetPos(),100,70,5,500)
effectBlood:SetOrigin(self:GetPos() + self:OBBCenter())
effectBlood:SetColor(VJ_Color2Byte(Color(255,221,35)))
effectBlood:SetScale(300)
util.Effect("VJ_Blood1",effectBlood)		
local bloodspray = EffectData()
bloodspray:SetOrigin(self:GetPos() + self:OBBCenter())
bloodspray:SetScale(8)
bloodspray:SetFlags(3)
bloodspray:SetColor(1)
util.Effect("bloodspray",bloodspray)
util.Effect("bloodspray",bloodspray)
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_02.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_02.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_02.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_02.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_04.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_04.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_04.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_04.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_02.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_02.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_02.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_02.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_04.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_04.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_04.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_04.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/mgib_05.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_01.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})
self:CreateGibEntity("obj_vj_gib","models/gibs/xenians/sgib_03.mdl",{Pos=self:GetPos()+self:OBBCenter()})		
end

---------------------------------------------------------------------------------------------------------------------------------------------
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


function ENT:CustomOnThink()
if VJ_AnimationExists(self,ACT_MELEE_ATTACK1) then
if !IsValid(self.BreakDoor) then
for _,v in pairs(ents.FindInSphere(self:GetPos(),40)) do
if v:GetClass() == "prop_door_rotating" && v:Visible(self) then
local anim = string.lower(v:GetSequenceName(v:GetSequence()))
if string.find(anim,"idle") then
self.BreakDoor = v
break
end
end
end
else

if self.PlayingAttackAnimation or !self.BreakDoor:Visible(self) /*or (self:GetActivity() == ACT_MELEE_ATTACK1 && dist <= 100)*/ then self.BreakDoor = NULL return end
if self:GetActivity() != ACT_MELEE_ATTACK1 then
local ang = self:GetAngles()
self:SetAngles(Angle(ang.x,(self.BreakDoor:GetPos() -self:GetPos()):Angle().y,ang.z))
self:VJ_ACT_PLAYACTIVITY("Attack1",true,false,false)
self:SetState(VJ_STATE_ONLY_ANIMATION)
VJ_EmitSound(self,self.SoundTbl_BeforeMeleeAttack,70,100)

if IsValid(self.BreakDoor) then
local door = self.BreakDoor
door:EmitSound("physics/wood/wood_furniture_break" .. math.random(1, 2) .. ".wav", 82, 100)
VJ_EmitSound(self, self.SoundTbl_CombatIdle, 70, 100)
ParticleEffect("door_pound_core", door:GetPos(), door:GetAngles(), nil)
ParticleEffect("door_pound_core", door:GetPos(), door:GetAngles(), nil)
door:Remove()
end
end
end
end
if !IsValid(self.BreakDoor) then
self:SetState()
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/