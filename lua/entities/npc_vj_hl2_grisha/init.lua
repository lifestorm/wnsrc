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

ENT.Model = {"models/monk.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 125
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CITIZEN","CLASS_AMERICA_FRIENDLY","CIVILAN"} 
ENT.PlayerFriendly = true
ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?

ENT.WeaponSpread = 0
ENT.BloodColor = "Red" 
ENT.SightDistance = 7000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
	ENT.FootStepSoundLevel = 60
ENT.ShootDistance = 3000
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


ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
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
	ENT.SoundTbl_OnKilledEnemy = {"vo/ravenholm/cartrap_better.wav","vo/ravenholm/exit_darkroad.wav","vo/ravenholm/firetrap_welldone.wav","vo/ravenholm/monk_kill01.wav","vo/ravenholm/monk_kill02.wav","vo/ravenholm/monk_kill03.wav","vo/ravenholm/monk_kill04.wav","vo/ravenholm/monk_kill05.wav","vo/ravenholm/monk_kill06.wav","vo/ravenholm/monk_kill07.wav","vo/ravenholm/monk_kill08.wav","vo/ravenholm/monk_kill09.wav","vo/ravenholm/monk_kill10.wav","vo/ravenholm/monk_kill11.wav"}

ENT.HasOnPlayerSight = true	
	ENT.SoundTbl_FootStep = {"npc/footsteps/hardboot_generic1.wav","npc/footsteps/hardboot_generic2.wav","npc/footsteps/hardboot_generic3.wav","npc/footsteps/hardboot_generic4.wav","npc/footsteps/hardboot_generic5.wav","npc/footsteps/hardboot_generic6.wav",}
ENT.SoundTbl_Idle = {
"vo/ravenholm/bucket_almost.wav",
"vo/ravenholm/bucket_guardwell.wav",
"vo/ravenholm/bucket_patience.wav",
"vo/ravenholm/cartrap_iamgrig.wav",
"vo/ravenholm/exit_goquickly.wav",
"vo/ravenholm/exit_nag01.wav",
"vo/ravenholm/nlo_cub_wherewasi.wav",
"vo/ravenholm/nlo_cub_youllmakeit.wav",
"vo/ravenholm/firetrap_vigil.wav",
"vo/ravenholm/monk_coverme03.wav",
"vo/ravenholm/monk_coverme04.wav",
"vo/ravenholm/monk_coverme07.wav",
"vo/ravenholm/firetrap_lookout.wav",
"vo/ravenholm/monk_rant02.wav",
"vo/ravenholm/monk_rant01.wav",
"vo/ravenholm/monk_rant03.wav",
"vo/ravenholm/monk_rant04.wav",
"vo/ravenholm/monk_rant05.wav",
"vo/ravenholm/monk_rant06.wav",
"vo/ravenholm/monk_rant07.wav",
"vo/ravenholm/monk_rant08.wav",
"vo/ravenholm/monk_rant09.wav",
"vo/ravenholm/monk_rant10.wav",
"vo/ravenholm/monk_rant11.wav",
"vo/ravenholm/monk_rant12.wav",
"vo/ravenholm/monk_rant13.wav",
"vo/ravenholm/monk_rant14.wav",
"vo/ravenholm/monk_rant15.wav",
"vo/ravenholm/monk_rant16.wav",
"vo/ravenholm/monk_rant17.wav",
"vo/ravenholm/monk_rant18.wav",
"vo/ravenholm/monk_rant19.wav",
"vo/ravenholm/monk_rant20.wav",
"vo/ravenholm/monk_rant21.wav",
"vo/ravenholm/monk_rant22.wav",
}
ENT.SoundTbl_Alert = {
"vo/ravenholm/monk_danger01.wav",
"vo/ravenholm/monk_danger02.wav",
"vo/ravenholm/monk_danger03.wav",
}
ENT.SoundTbl_CombatIdle = {
"vo/ravenholm/aimforhead.wav",
"vo/ravenholm/engage01.wav",
"vo/ravenholm/engage02.wav",
"vo/ravenholm/engage03.wav",
"vo/ravenholm/engage04.wav",
"vo/ravenholm/engage05.wav",
"vo/ravenholm/engage06.wav",
"vo/ravenholm/engage07.wav",
"vo/ravenholm/engage08.wav",
"vo/ravenholm/engage09.wav",
"vo/ravenholm/madlaugh01.wav",
"vo/ravenholm/madlaugh02.wav",
"vo/ravenholm/madlaugh03.wav",
"vo/ravenholm/madlaugh04.wav",
"vo/ravenholm/monk_blocked01.wav",
"vo/ravenholm/monk_coverme01.wav",
"vo/ravenholm/monk_coverme02.wav",
"vo/ravenholm/monk_coverme02.wav",
"vo/ravenholm/monk_coverme02.wav",
"vo/ravenholm/monk_coverme02.wav",
"vo/ravenholm/monk_helpme01.wav",
"vo/ravenholm/monk_helpme02.wav",
"vo/ravenholm/monk_helpme03.wav",
"vo/ravenholm/monk_helpme04.wav",
"vo/ravenholm/monk_helpme05.wav",
"vo/ravenholm/monk_helpme01.wav",
}
ENT.SoundTbl_OnGrenadeSight = {

}
ENT.SoundTbl_Pain = {
"vo/ravenholm/male01/monk_pain01.wav",
"vo/ravenholm/male01/monk_pain02.wav",
"vo/ravenholm/male01/monk_pain03.wav",
"vo/ravenholm/male01/monk_pain04.wav",
"vo/ravenholm/male01/monk_pain05.wav",
"vo/ravenholm/male01/monk_pain06.wav",
"vo/ravenholm/male01/monk_pain07.wav",
"vo/ravenholm/male01/monk_pain08.wav",
"vo/ravenholm/male01/monk_pain09.wav",
"vo/ravenholm/male01/monk_pain10.wav",
"vo/ravenholm/male01/monk_pain12.wav",
}
ENT.SoundTbl_Death = {
"vo/ravenholm/male01/monk_death07.wav",
}
ENT.SoundTbl_FollowPlayer = {
"vo/ravenholm/grave_follow.wav",
"vo/ravenholm/grave_stayclose.wav",
"vo/ravenholm/monk_followme.wav",

}
ENT.SoundTbl_UnFollowPlayer = {
"vo/ravenholm/pyre_anotherlife.wav",
"vo/ravenholm/pyre_keepeye.wav",
"vo/ravenholm/shotgun_moveon.wav",
"vo/ravenholm/shotgun_stirreduphell.wav",
"vo/ravenholm/yard_shepherd.wav",
}
ENT.SoundTbl_OnPlayerSight = {
"vo/ravenholm/attic_apologize.wav",
"vo/ravenholm/bucket_thereyouare.wav",
"vo/ravenholm/monk_coverme05.wav",
"vo/ravenholm/nlo_cub_ledtobelieve.wav",

}
ENT.SoundTbl_DamageByPlayer = {

}

ENT.DefaultSoundTbl_MeleeAttack = {"physics/body/body_medium_impact_hard1.wav","physics/body/body_medium_impact_hard2.wav","physics/body/body_medium_impact_hard3.wav","physics/body/body_medium_impact_hard4.wav","physics/body/body_medium_impact_hard5.wav","physics/body/body_medium_impact_hard6.wav"}
ENT.DefaultSoundTbl_MeleeAttackMiss = {"ravenholm/zombie/claw_miss1.wav","ravenholm/zombie/claw_miss2.wav"}
ENT.DefaultSoundTbl_Impact = {"physics/flesh/flesh_impact_bullet1.wav","physics/flesh/flesh_impact_bullet2.wav","physics/flesh/flesh_impact_bullet3.wav","physics/flesh/flesh_impact_bullet4.wav","physics/flesh/flesh_impact_bullet5.wav"}
ENT.DefaultSoundTbl_MedicAfterHeal = {"items/smallmedkit1.wav"}




---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 300 ) ) do
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
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 300 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "vj_combine" then
		self.PlayerFriendly = false
	
		
end
end
end
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