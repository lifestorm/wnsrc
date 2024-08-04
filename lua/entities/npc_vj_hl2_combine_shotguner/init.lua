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

ENT.Model = {"models/combine_soldier.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 125
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} 

ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?
ENT.HasPoseParameterLooking = false -- Does it look at its enemy using poseparameters?
ENT.PoseParameterLooking_InvertPitch = true -- Inverts the pitch poseparameters (X)
ENT.PoseParameterLooking_InvertYaw = true -- Inverts the yaw poseparameters (Y)
ENT.PoseParameterLooking_InvertRoll = true -- Inverts the roll poseparameters (Z)
ENT.PoseParameterLooking_TurningSpeed = 1 -- How fast does the parameter turn?
ENT.WeaponSpread = 1
ENT.BloodColor = "Red" 
ENT.SightDistance = 8000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.ShootDistance = 500
ENT.DistanceToRunFromEnemy = 350
ENT.HasShootWhileMoving = true -- Can it shoot while moving?
ENT.Weapon_FiringDistanceFar = 500
ENT.MeleeAttackDamage = 35
ENT.SquadName = "combine" -- Squad name, console error will happen if two groups that are enemy and try to squad!
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



ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
ENT.GrenadeAttackEntity = "npc_grenade_frag" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.GrenadeAttackModel = "models/weapons/w_grenade.mdl" -- The model for the grenade entity
	-- ====== Animation Variables ====== --
ENT.AnimTbl_GrenadeAttack = {"grenThrow"} -- Grenade Attack Animations
ENT.GrenadeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.GrenadeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the grenade attack animation?
	-- ====== Distance & Chance Variables ====== --
ENT.NextThrowGrenadeTime1 = math.random(13,17) -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = math.random(12,25) -- Time until it runs the throw grenade code again | The second # in math.random
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
"npc/combine_soldier/vo/affirmative.wav",
"npc/combine_soldier/vo/affirmative2.wav",
"npc/combine_soldier/vo/block31mace.wav",
"npc/combine_soldier/vo/block64jet.wav",
"npc/combine_soldier/vo/cleaned.wav",
"npc/combine_soldier/vo/hasnegativemovement.wav",
"npc/combine_soldier/vo/isfieldpromoted.wav",
"npc/combine_soldier/vo/isholdingatcode.wav",
"npc/combine_soldier/vo/lostcontact.wav",
"npc/combine_soldier/vo/motioncheckallradials.wav",
"npc/combine_soldier/vo/noviscon.wav",
"npc/combine_soldier/vo/overwatch.wav",
"npc/combine_soldier/vo/overwatchreportspossiblehostiles.wav",
"npc/combine_soldier/vo/ovewatchorders3ccstimboost.wav",
"npc/combine_soldier/vo/prepforcontact.wav",
"npc/combine_soldier/vo/readyweaponshostilesinbound.wav",
"npc/combine_soldier/vo/reportallpositionsclear.wav",
"npc/combine_soldier/vo/reportallradialsfree.wav",
"npc/combine_soldier/vo/reportingclear.wav",
"npc/combine_soldier/vo/requeststimdose.wav",
"npc/combine_soldier/vo/sectionlockupdash4.wav",
"npc/combine_soldier/vo/sectorissecurenovison.wav",
"npc/combine_soldier/vo/secure.wav",
"npc/combine_soldier/vo/sightlineisclear.wav",
"npc/combine_soldier/vo/skyshieldreportslostcontact.wav",
"npc/combine_soldier/vo/stabilizationteamhassector.wav",
"npc/combine_soldier/vo/stabilizationteamholding.wav",
"npc/combine_soldier/vo/stayalertreportsightlines.wav",
"npc/combine_soldier/vo/targetblackout.wav",
"npc/combine_soldier/vo/targetmyradial.wav",
"npc/combine_soldier/vo/teamdeployedandscanning.wav",
"npc/combine_soldier/vo/thatsitwrapitup.wav",
"npc/combine_soldier/vo/weaponsoffsafeprepforcontact.wav",
"npc/combine_soldier/vo/weareinaninfestationzone.wav",

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
 self:SetSkin( 1 )
end

ENT.BreathSoundPitch1 = 100
ENT.BreathSoundPitch2 = 100
ENT.IdleSoundPitch1 = 100
ENT.IdleSoundPitch2 = 100
ENT.CombatIdleSoundPitch1 = 100
ENT.CombatIdleSoundPitch2 = 100
ENT.OnReceiveOrderSoundPitch1 = 100
ENT.OnReceiveOrderSoundPitch2 = 100
ENT.MoveOutOfPlayersWaySoundPitch1 = 100
ENT.MoveOutOfPlayersWaySoundPitch2 = 100
ENT.BeforeHealSoundPitch1 = 100
ENT.BeforeHealSoundPitch2 = 100
ENT.AfterHealSoundPitch1 = 100
ENT.AfterHealSoundPitch2 = 100
ENT.MedicReceiveHealSoundPitch1 = 100
ENT.MedicReceiveHealSoundPitch2 = 100
ENT.OnPlayerSightSoundPitch1 = 100
ENT.OnPlayerSightSoundPitch2 = 100
ENT.AlertSoundPitch1 = 100
ENT.AlertSoundPitch2 = 100
ENT.CallForHelpSoundPitch1 = 100
ENT.CallForHelpSoundPitch2 = 100
ENT.BecomeEnemyToPlayerPitch1 = 100
ENT.BecomeEnemyToPlayerPitch2 = 100
ENT.SuppressingPitch1 = 100
ENT.SuppressingPitch2 = 100
ENT.WeaponReloadSoundPitch1 = 100
ENT.WeaponReloadSoundPitch2 = 100
ENT.GrenadeAttackSoundPitch1 = 100
ENT.GrenadeAttackSoundPitch2 = 100
ENT.OnGrenadeSightSoundPitch1 = 100
ENT.OnGrenadeSightSoundPitch2 = 100
ENT.OnKilledEnemySoundPitch1 = 100
ENT.OnKilledEnemySoundPitch2 = 100
ENT.PainSoundPitch1 = 100
ENT.PainSoundPitch2 = 100
ENT.ImpactSoundPitch1 = 80
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = 100
ENT.DamageByPlayerPitch2 = 100
ENT.DeathSoundPitch1 = 100
ENT.DeathSoundPitch2 = 100
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/