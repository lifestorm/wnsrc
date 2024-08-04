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
ENT.Model = {"models/zombiesci/zombiesci.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("npc_vj_zombiegiant_h")
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
//ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
//ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
//ENT.MeleeAttackDamageDistance = 60 -- How far does the damage go?
//ENT.MeleeAttackExtraTimers = {1.4} -- Extra melee attack timers | it will run the damage code after the given amount of seconds
//ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
//ENT.NextAnyAttackTime_Melee = 0.4 -- How much time until it can use any attack again? | Counted in Seconds
ENT.MeleeAttackDamage = GetConVarNumber("npc_vj_zombiegiant_d")
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.4 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {"Diesimple", "Diebackward", "Dieforward", "Dieheadshot", "Dieheadshot2"} -- Death Animations
ENT.DeathAnimationTime = 6 -- Time until the SNPC spawns its corpse and gets removed
ENT.GeneralSoundPitch1 = 50
ENT.GeneralSoundPitch2 = 50
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {"Flinch", "Bigflinch", "Smallflinch", "Laflinch", "Liflinch", "Raflinch", "Riflinch"} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"player/pl_step1.wav","player/pl_step2.wav","player/pl_step3.wav","player/pl_step4.wav"}
ENT.SoundTbl_Idle = {"zombie/zo_idle1.wav","zombie/zo_idle2.wav","zombie/zo_idle3.wav","zombie/zo_idle4.wav"}
ENT.SoundTbl_Alert = {"zombie/zo_alert10.wav","zombie/zo_alert20.wav","zombie/zo_alert30.wav"}
ENT.SoundTbl_MeleeAttack = {"zombie/zo_attack1.wav","zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zombie/claw_miss1.wav","zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"zombie/zo_pain1.wav","zombie/zo_pain2.wav"} 
ENT.SoundTbl_Death = {"zombie/zo_pain1.wav","zombie/zo_pain2.wav"} 
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
    local randattack = math.random(1,2)

		if randattack == 1 then
		self.MeleeAttackDistance = 30
		self.TimeUntilMeleeAttackDamage = 0.8
		self.MeleeAttackAnimationFaceEnemy = false
		self.AnimTbl_MeleeAttack = {"vjseq_Attack1"}
		self.MeleeAttackExtraTimers = {1.5} 
		self.MeleeAttackDamage = GetConVarNumber("npc_vj_zombiegiant_d")
		self.MeleeAttackDamageDistance = 90
		self.MeleeAttackDamageType = DMG_SLASH
		
		elseif randattack == 2 then
		self.MeleeAttackDistance = 30
		self.TimeUntilMeleeAttackDamage = 0.7
		self.MeleeAttackAnimationFaceEnemy = false
		self.AnimTbl_MeleeAttack = {"vjseq_Attack2"}
		self.MeleeAttackExtraTimers = {} 
		self.MeleeAttackDamage = GetConVarNumber("npc_vj_zombiegiant_d")
		self.MeleeAttackDamageDistance = 90
		self.MeleeAttackDamageType = DMG_SLASH
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize() 

	self:SetModel( Model("models/zombiesci/zombiesci.mdl") ) 
	self:SetSkin(0)
	self:SetModelScale(2.0)
	self:Activate()
	self:SetPlaybackRate(0.8)
	
	self:SetCollisionBounds(Vector(18, 18, 70), Vector(-18, -18, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/