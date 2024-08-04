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

ENT.Model = {"models/combine_super_soldier.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 155
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} 

ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?
ENT.HasPoseParameterLooking = false -- Does it look at its enemy using poseparameters?
ENT.PoseParameterLooking_InvertPitch = true -- Inverts the pitch poseparameters (X)
ENT.PoseParameterLooking_InvertYaw = true -- Inverts the yaw poseparameters (Y)
ENT.PoseParameterLooking_InvertRoll = true -- Inverts the roll poseparameters (Z)
ENT.PoseParameterLooking_TurningSpeed = 1 -- How fast does the parameter turn?
ENT.WeaponSpread = 0.4
ENT.BloodColor = "Red" 
ENT.SightDistance = 8400 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.ShootDistance = 2600
ENT.Weapon_FiringDistanceFar = 2600
ENT.MeleeAttackDamage = 65
ENT.SquadName = "combine_elit" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking

ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.CallForHelpDistance = 600 -- -- How far away the SNPC's call for help goes | Counted in World Units
ENT.HasCallForHelpAnimation = true -- if true, it will play the call for help animation
ENT.AnimTbl_CallForHelp = {ACT_SIGNAL_ADVANCE,ACT_SIGNAL_FORWARD,ACT_SIGNAL_GROUP} -- Call For Help Animations
ENT.NextCallForHelpTime = 10 -- Time until it calls for help again
ENT.WaitForEnemyToComeOutTime1 = 2 -- How much time should it wait until it starts chasing the enemy? | First number in math.random
ENT.WaitForEnemyToComeOutTime2 = 3 -- How much time should it wait until it starts chasing the enemy? | Second number in math.random
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this



ENT.HasGrenadeAttack = true -- Should the SNPC have a grenade attack?
ENT.GrenadeAttackEntity = "npc_grenade_frag" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.GrenadeAttackModel = "models/weapons/w_grenade.mdl" -- The model for the grenade entity
	-- ====== Animation Variables ====== --
ENT.AnimTbl_GrenadeAttack = {"grenThrow"} -- Grenade Attack Animations
ENT.GrenadeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.GrenadeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the grenade attack animation?
	-- ====== Distance & Chance Variables ====== --
ENT.NextThrowGrenadeTime1 = math.random(15,20) -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = math.random(10,13)-- Time until it runs the throw grenade code again | The second # in math.random
ENT.ThrowGrenadeChance = 1 -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.GrenadeAttackThrowDistance = 1000 -- How far it can throw grenades
ENT.GrenadeAttackThrowDistanceClose = 500 -- How close until it stops throwing grenades
ENT.FootStepPitch1 = 100
ENT.FootStepPitch2 = 100
	-- ====== Sound File Paths ====== --
	ENT.FootStepSoundLevel = 60
ENT.SoundTbl_AllyDeath = {"npc/combine_soldier/vo/isfinalteamunitbackup.wav","npc/combine_soldier/vo/onedutyvacated.wav","npc/combine_soldier/vo/overwatchteamisdown.wav"}
ENT.AllyDeathSoundChance = 1
	ENT.SoundTbl_OnKilledEnemy = {"npc/combine_soldier/vo/contained.wav","npc/combine_soldier/vo/onecontained.wav","npc/combine_soldier/vo/onedown.wav","npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav","npc/combine_soldier/vo/overwatchtarget1sterilized.wav","npc/combine_soldier/vo/overwatchtargetcontained.wav"}
ENT.SoundTbl_WeaponReload = {"npc/combine_soldier/vo/runninglowonverdicts.wav"}

ENT.SoundTbl_FootStep = {"npc/combine_soldier/gear1.wav","npc/combine_soldier/gear2.wav","npc/combine_soldier/gear3.wav","npc/combine_soldier/gear4.wav","npc/combine_soldier/gear5.wav","npc/combine_soldier/gear6.wav"}
ENT.SoundTbl_Idle = {
"npc/combine_soldier/vo/prison_soldier_activatecentral.wav",
"npc/combine_soldier/vo/prison_soldier_boomersinbound.wav",
"npc/combine_soldier/vo/prison_soldier_bunker1.wav",
"npc/combine_soldier/vo/prison_soldier_bunker2.wav",
"npc/combine_soldier/vo/prison_soldier_bunker3.wav",
"npc/combine_soldier/vo/prison_soldier_containd8.wav",
"npc/combine_soldier/vo/prison_soldier_fallback_b4.wav",
"npc/combine_soldier/vo/prison_soldier_freeman_antlions.wav",
"npc/combine_soldier/vo/prison_soldier_fullbioticoverrun.wav",
"npc/combine_soldier/vo/prison_soldier_leader9dead.wav",
"npc/combine_soldier/vo/prison_soldier_negativecontainment.wav",
"npc/combine_soldier/vo/prison_soldier_prosecuted7.wav",
"npc/combine_soldier/vo/prison_soldier_sundown3dead.wav",
"npc/combine_soldier/vo/prison_soldier_tohighpoints.wav",
"npc/combine_soldier/vo/prison_soldier_visceratorsa5.wav",


}
ENT.SoundTbl_Alert = {
"npc/combine_soldier/vo/alert1.wav",
"npc/combine_soldier/vo/anticitizenone.wav",
"npc/combine_soldier/vo/contact.wav",
"npc/combine_soldier/vo/contactconfim.wav",
"npc/combine_soldier/vo/gosharp.wav",
"npc/combine_soldier/vo/gosharpgosharp.wav",
"npc/combine_soldier/vo/outbreak.wav",
"npc/combine_soldier/vo/outbreakstatusiscode.wav",
"npc/combine_soldier/vo/readyweapons.wav",
"npc/combine_soldier/vo/targetcontactat.wav",
}
ENT.SoundTbl_CombatIdle = {
"npc/combine_soldier/vo/affirmativewegothimnow.wav",
"npc/combine_soldier/vo/callhotpoint.wav",
"npc/combine_soldier/vo/confirmsectornotsterile.wav",
"npc/combine_soldier/vo/closing.wav",
"npc/combine_soldier/vo/closing2.wav",
"npc/combine_soldier/vo/contactconfirmprosecuting.wav",
"npc/combine_soldier/vo/containmentproceeding.wav",
"npc/combine_soldier/vo/cover.wav",
"npc/combine_soldier/vo/coverhurt.wav",
"npc/combine_soldier/vo/designatetargetas.wav",
"npc/combine_soldier/vo/engagedincleanup.wav",
"npc/combine_soldier/vo/executingfullresponse.wav",
"npc/combine_soldier/vo/fixsightlinesmovein.wav",
"npc/combine_soldier/vo/gridsundown46.wav",
"npc/combine_soldier/vo/hardenthatposition.wav",
"npc/combine_soldier/vo/heavyresistance.wav",
"npc/combine_soldier/vo/overwatchrequestreinforcement.wav",
"npc/combine_soldier/vo/overwatchrequestreserveactivation.wav",
"npc/combine_soldier/vo/overwatchrequestskyshield.wav",
"npc/combine_soldier/vo/overwatchrequestwinder.wav",
"npc/combine_soldier/vo/overwatchsectoroverrun.wav",
"npc/combine_soldier/vo/sectionlockupdash4.wav",
"npc/combine_soldier/vo/sectorisnotsecure.wav",
"npc/combine_soldier/vo/ripcordripcord.wav",
"npc/combine_soldier/vo/swarmoutbreakinsector.wav",
"npc/combine_soldier/vo/targetcompromisedmovein.wav",
"npc/combine_soldier/vo/unitisclosing.wav",
"npc/combine_soldier/vo/unitisinbound.wav",
"npc/combine_soldier/vo/unitismovingin.wav",
"npc/combine_soldier/vo/visualonexogens.wav",

}
ENT.SoundTbl_OnGrenadeSight = {
"npc/combine_soldier/vo/bouncerbouncer.wav",
"npc/combine_soldier/vo/extractoraway.wav",
"npc/combine_soldier/vo/extractorislive.wav",

}
ENT.SoundTbl_Pain = {
"npc/combine_soldier/pain1.wav",
"npc/combine_soldier/pain2.wav",
"npc/combine_soldier/pain3.wav",

}
ENT.SoundTbl_Death = {
"npc/combine_soldier/die1.wav",
"npc/combine_soldier/die2.wav",
"npc/combine_soldier/die3.wav",

}
ENT.SoundTbl_FollowPlayer = {
"npc/combine_soldier/vo/delivered.wav",
"npc/combine_soldier/vo/standingby.wav",

}
ENT.SoundTbl_UnFollowPlayer = {
"npc/combine_soldier/vo/copy.wav",
"npc/combine_soldier/vo/copythat.wav",

}
ENT.SoundTbl_OnPlayerSight = {

}
ENT.SoundTbl_DamageByPlayer = {

}

ENT.DefaultSoundTbl_MeleeAttack = {"physics/body/body_medium_impact_hard1.wav","physics/body/body_medium_impact_hard2.wav","physics/body/body_medium_impact_hard3.wav","physics/body/body_medium_impact_hard4.wav","physics/body/body_medium_impact_hard5.wav","physics/body/body_medium_impact_hard6.wav"}
ENT.DefaultSoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.DefaultSoundTbl_Impact = {"physics/flesh/flesh_impact_bullet1.wav","physics/flesh/flesh_impact_bullet2.wav","physics/flesh/flesh_impact_bullet3.wav","physics/flesh/flesh_impact_bullet4.wav","physics/flesh/flesh_impact_bullet5.wav"}
ENT.DefaultSoundTbl_MedicAfterHeal = {"items/smallmedkit1.wav"}

function ENT:CustomInitialize()
self.Weapon_FiringDistanceFar = self.ShootDistance
end
ENT.BreathSoundPitch1 = 85
ENT.BreathSoundPitch2 = 85

ENT.CombatIdleSoundPitch1 = 85
ENT.CombatIdleSoundPitch2 = 85
ENT.OnReceiveOrderSoundPitch1 = 85
ENT.OnReceiveOrderSoundPitch2 = 85
ENT.MoveOutOfPlayersWaySoundPitch1 = 85
ENT.MoveOutOfPlayersWaySoundPitch2 = 85
ENT.BeforeHealSoundPitch1 = 85
ENT.BeforeHealSoundPitch2 = 85
ENT.AfterHealSoundPitch1 = 85
ENT.AfterHealSoundPitch2 = 85
ENT.MedicReceiveHealSoundPitch1 = 85
ENT.MedicReceiveHealSoundPitch2 = 85
ENT.OnPlayerSightSoundPitch1 = 85
ENT.OnPlayerSightSoundPitch2 = 85
ENT.AlertSoundPitch1 = 85
ENT.AlertSoundPitch2 = 85
ENT.CallForHelpSoundPitch1 = 85
ENT.CallForHelpSoundPitch2 = 85
ENT.BecomeEnemyToPlayerPitch1 = 85
ENT.BecomeEnemyToPlayerPitch2 = 85
ENT.SuppressingPitch1 = 85
ENT.SuppressingPitch2 = 85
ENT.WeaponReloadSoundPitch1 = 85
ENT.WeaponReloadSoundPitch2 = 85
ENT.GrenadeAttackSoundPitch1 = 85
ENT.GrenadeAttackSoundPitch2 = 85
ENT.OnGrenadeSightSoundPitch1 = 85
ENT.OnGrenadeSightSoundPitch2 = 85
ENT.OnKilledEnemySoundPitch1 = 85
ENT.OnKilledEnemySoundPitch2 = 85
ENT.PainSoundPitch1 = 85
ENT.PainSoundPitch2 = 85
ENT.ImpactSoundPitch1 = 80
ENT.ImpactSoundPitch2 = 85
ENT.DamageByPlayerPitch1 = 85
ENT.DamageByPlayerPitch2 = 85
ENT.DeathSoundPitch1 = 85
ENT.DeathSoundPitch2 = 85
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/