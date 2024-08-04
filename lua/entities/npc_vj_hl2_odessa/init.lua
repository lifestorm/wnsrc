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

ENT.Model = {"models/odessa.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 115
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CITIZEN","CLASS_AMERICA_FRIENDLY","CIVILAN"} 
ENT.PlayerFriendly = true
ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?

ENT.WeaponSpread = 0.5
ENT.BloodColor = "Red" 
ENT.SightDistance = 7000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
	ENT.FootStepSoundLevel = 60
ENT.ShootDistance = 2500
ENT.MeleeAttackDamage = 35
ENT.SquadName = "resistance" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
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
ENT.NextThrowGrenadeTime1 = 5 -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = 10 -- Time until it runs the throw grenade code again | The second # in math.random
ENT.ThrowGrenadeChance = 1 -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.GrenadeAttackThrowDistance = 1000 -- How far it can throw grenades
ENT.GrenadeAttackThrowDistanceClose = 500 -- How close until it stops throwing grenades
	-- ====== Sound File Paths ====== --
	ENT.SoundTbl_OnKilledEnemy = {"vo/coast/odessa/nlo_cub_class01.wav","vo/coast/odessa/nlo_cub_thatsthat.wav"}
ENT.HasOnPlayerSight = true
	
	ENT.SoundTbl_FootStep = {"npc/footsteps/hardboot_generic1.wav","npc/footsteps/hardboot_generic2.wav","npc/footsteps/hardboot_generic3.wav","npc/footsteps/hardboot_generic4.wav","npc/footsteps/hardboot_generic5.wav","npc/footsteps/hardboot_generic6.wav",}
ENT.SoundTbl_Idle = {
"vo/coast/odessa/nlo_cub_carry.wav",
"vo/coast/odessa/nlo_cub_class02.wav",
"vo/coast/odessa/nlo_cub_radio.wav",
"vo/coast/odessa/nlo_cub_roadahead.wav",
"vo/coast/odessa/nlo_cub_thatsthat.wav",
"vo/coast/odessa/nlo_cub_volunteer.wav",
"vo/coast/odessa/nlo_cub_wherewasi.wav",
"vo/coast/odessa/nlo_cub_youllmakeit.wav",

}
ENT.SoundTbl_Alert = {
"vo/coast/odessa/nlo_cub_warning.wav",

}
ENT.SoundTbl_CombatIdle = {
"vo/coast/odessa/nlo_cub_teachgunship.wav",


}
ENT.SoundTbl_OnGrenadeSight = {

}
ENT.SoundTbl_Pain = {
"vo/coast/odessa/male01/nlo_cubdeath02.wav",

}
ENT.SoundTbl_Death = {
"vo/coast/odessa/male01/nlo_cubdeath02.wav",
}
ENT.SoundTbl_FollowPlayer = {
"vo/coast/odessa/nlo_cub_freeman.wav",
"vo/coast/odessa/nlo_cub_hello.wav",
"vo/coast/odessa/nlo_cub_service.wav",

}
ENT.SoundTbl_UnFollowPlayer = {
"vo/coast/odessa/nlo_cub_farewell.wav",
"vo/coast/odessa/nlo_cub_opengate.wav",

}
ENT.SoundTbl_OnPlayerSight = {
"vo/coast/odessa/nlo_cub_class02.wav",
"vo/coast/odessa/nlo_cub_class03.wav",
"vo/coast/odessa/nlo_cub_corkscrew.wav",
"vo/coast/odessa/nlo_cub_ledtobelieve.wav",

}
ENT.SoundTbl_DamageByPlayer = {

}

ENT.DefaultSoundTbl_MeleeAttack = {"physics/body/body_medium_impact_hard1.wav","physics/body/body_medium_impact_hard2.wav","physics/body/body_medium_impact_hard3.wav","physics/body/body_medium_impact_hard4.wav","physics/body/body_medium_impact_hard5.wav","physics/body/body_medium_impact_hard6.wav"}
ENT.DefaultSoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.DefaultSoundTbl_Impact = {"physics/flesh/flesh_impact_bullet1.wav","physics/flesh/flesh_impact_bullet2.wav","physics/flesh/flesh_impact_bullet3.wav","physics/flesh/flesh_impact_bullet4.wav","physics/flesh/flesh_impact_bullet5.wav"}
ENT.DefaultSoundTbl_MedicAfterHeal = {"items/smallmedkit1.wav"}




---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 30000 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "vj_combine" then
		self.PlayerFriendly = false
	
		
end
end
end
end
--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
self.Weapon_FiringDistanceFar = self.ShootDistance
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 30000 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "vj_combine"then
		self.PlayerFriendly = false
	
		
end
end
end
end
--------------------------------------------------------------------------------------

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