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

ENT.Model = {"models/alyx2.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 175
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CITIZEN","CLASS_AMERICA_FRIENDLY","CIVILAN"} 
ENT.PlayerFriendly = true
ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?

ENT.WeaponSpread = 0
ENT.BloodColor = "Red" 
ENT.SightDistance = 8000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
	ENT.FootStepSoundLevel = 60
ENT.ShootDistance = 3500
ENT.MeleeAttackDamage = 65
ENT.SquadName = "alex" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.FindEnemy_UseSphere = true
 -- This will decrease the time until it starts moving or attack again. Use it to fix animation pauses until it chases the enemy.

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

	-- ====== Sound File Paths ====== --
	ENT.SoundTbl_OnKilledEnemy = {"vo/npc/alyx/brutal02.wav","vo/streetwar/alyx_gate/al_thatsit.wav",}

ENT.HasOnPlayerSight = true	
	ENT.SoundTbl_FootStep = {"npc/footsteps/hardboot_generic1.wav","npc/footsteps/hardboot_generic2.wav","npc/footsteps/hardboot_generic3.wav","npc/footsteps/hardboot_generic4.wav","npc/footsteps/hardboot_generic5.wav","npc/footsteps/hardboot_generic6.wav",}
ENT.SoundTbl_Idle = {
"vo/streetwar/alyx_gate/al_commandcenter.wav",
"vo/streetwar/alyx_gate/al_scout.wav",
"vo/streetwar/alyx_gate/al_usedtobe.wav",
"vo/trainyard/al_overhere.wav",
"vo/trainyard/al_suspicious_b.wav",
}
ENT.SoundTbl_Alert = {
"vo/npc/alyx/ohgod01.wav",
"vo/streetwar/alyx_gate/al_theysawus.wav",
}
ENT.SoundTbl_CombatIdle = {
"vo/npc/alyx/coverme01.wav",
"vo/npc/alyx/coverme02.wav",
"vo/npc/alyx/coverme03.wav",
"vo/npc/alyx/lookout01.wav",
"vo/npc/alyx/lookout02.wav",
"vo/npc/alyx/ohno_startle01.wav",
"vo/npc/alyx/ohno_startle02.wav",
"vo/npc/alyx/watchout01.wav",
"vo/npc/alyx/watchout02.wav",
"vo/streetwar/alyx_gate/al_ahno.wav",
}
ENT.SoundTbl_OnGrenadeSight = {

}
ENT.SoundTbl_Pain = {
"vo/npc/alyx/gasp02.wav",
"vo/npc/alyx/gasp03.wav",
"vo/npc/alyx/getback01.wav",
"vo/npc/alyx/getback02.wav",
"vo/npc/alyx/gordon_dist01.wav",
"vo/npc/alyx/hurt04.wav",
"vo/npc/alyx/hurt05.wav",
"vo/npc/alyx/hurt06.wav",
"vo/npc/alyx/hurt07.wav",
"vo/npc/alyx/uggh01.wav",
"vo/npc/alyx/uggh02.wav",
"vo/streetwar/alyx_gate/al_ah.wav",
}
ENT.SoundTbl_Death = {
"vo/npc/alyx/no01.wav",
"vo/npc/alyx/no02.wav",
"vo/npc/alyx/no03.wav",
}
ENT.SoundTbl_FollowPlayer = {
"vo/npc/alyx/youreload01.wav",
"vo/npc/alyx/youreload02.wav",

}
ENT.SoundTbl_UnFollowPlayer = {
"vo/npc/alyx/al_excuse03.wav",
"vo/streetwar/alyx_gate/al_readywhenyou.wav",
}
ENT.SoundTbl_OnPlayerSight = {
"vo/npc/alyx/al_excuse02.wav",
"vo/streetwar/alyx_gate/al_hey.wav",
"vo/trainyard/al_thisday.wav",
}
ENT.SoundTbl_DamageByPlayer = {

}

ENT.DefaultSoundTbl_MeleeAttack = {"physics/body/body_medium_impact_hard1.wav","physics/body/body_medium_impact_hard2.wav","physics/body/body_medium_impact_hard3.wav","physics/body/body_medium_impact_hard4.wav","physics/body/body_medium_impact_hard5.wav","physics/body/body_medium_impact_hard6.wav"}
ENT.DefaultSoundTbl_MeleeAttackMiss = {"npc/alyx/zombie/claw_miss1.wav","npc/alyx/zombie/claw_miss2.wav"}
ENT.DefaultSoundTbl_Impact = {"physics/flesh/flesh_impact_bullet1.wav","physics/flesh/flesh_impact_bullet2.wav","physics/flesh/flesh_impact_bullet3.wav","physics/flesh/flesh_impact_bullet4.wav","physics/flesh/flesh_impact_bullet5.wav"}
ENT.DefaultSoundTbl_MedicAfterHeal = {"items/smallmedkit1.wav"}



function ENT:SpawnFunction( ply, tr )
if ( !tr.Hit ) then return end

local SpawnPos = tr.HitPose + tr.HitNormal * 6
self.Spawn_angles = ply:GetAngles()
self.Spawn_angles.pitch = 0
self.Spawn_angles.roll = 0
self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180

local ent = ents.Create( "npc_vj_hl2_alex" )
ent:SetKeyValue( "disableshadows", "1" )
ent:SetPos( SpawnPos )
ent:SetAngles( self.Spawn_angles )
ent:Spawn()
ent:Activate()

return ent
end

function ENT:FollowPlayerCode(key,activator,caller,data)
	if self.FollowPlayer == false or GetConVarNumber("ai_disabled") == 1 or GetConVarNumber("ai_ignoreplayers") == 1 then return end
	if key == self.FollowPlayerKey && activator:IsValid() && activator:Alive() && activator:IsPlayer() then
		if self:Disposition(activator) == D_HT then
			if self.AllowPrintingInChat == true && self.FollowPlayerChat == true then
				activator:PrintMessage(HUD_PRINTTALK, self:GetName().." doesn't like you, therefore it won't follow you.")
			end
			return
		elseif self:Disposition(activator) == D_NU then
			if self.AllowPrintingInChat == true && self.FollowPlayerChat == true then
				activator:PrintMessage(HUD_PRINTTALK, self:GetName().." is neutral to you, therefore it won't follow you.")
			end
			return
		end
		self:CustomOnFollowPlayer(key,activator,caller,data)
		if self.MovementType == VJ_MOVETYPE_STATIONARY or self.MovementType == VJ_MOVETYPE_PHYSICS then
			if self.AllowPrintingInChat == true && self.FollowPlayerChat == true then
				activator:PrintMessage(HUD_PRINTTALK, self:GetName().." is currently stationary, therefore it's unable follow you.")
			end
			return
		end
		if self.FollowingPlayer == false then
			//self:FaceCertainEntity(activator,false)
			if self.AllowPrintingInChat == true && self.FollowPlayerChat == true then
			activator:PrintMessage(HUD_PRINTTALK, self:GetName().." is now following you.") end
			self.FollowingPlayer_WanderValue = self.DisableWandering
			self.FollowingPlayer_ChaseValue = self.DisableChasingEnemy
			self.DisableWandering = true
			self.DisableChasingEnemy = true
			self:SetTarget(activator)
			self.FollowingPlayerName = activator
			if self:BusyWithActivity() == false then
				self:StopMoving()
				self:VJ_TASK_FACE_X("TASK_FACE_TARGET",function(x) x.RunCode_OnFinish = function()
					local DistanceToPly = self:GetPos():Distance(self.FollowingPlayerName:GetPos())
					local movetype = "TASK_RUN_PATH"
					if DistanceToPly < 220 then
						movetype = "TASK_WALK_PATH"
					end
					self:VJ_TASK_GOTO_TARGET(movetype,function(x) x.CanShootWhenMoving = true x.ConstantlyFaceEnemy = true end) 
				end end)
			end
			//timer.Simple(0.15,function() if self:IsValid() && self.VJ_PlayingSequence == false then self:VJ_SetSchedule(SCHED_TARGET_FACE) end end)
			//if self.VJ_PlayingSequence == false then self:VJ_SetSchedule(SCHED_IDLE_STAND) end
			//timer.Simple(0.1,function() if self:IsValid() then self:VJ_TASK_GOTO_TARGET() end end)
			self:FollowPlayerSoundCode()
			self.FollowingPlayer = true
		else
			self:UnFollowPlayerSoundCode()
			if self:BusyWithActivity() == false then
				self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
			end
			//if self.VJ_PlayingSequence == false then self:VJ_SetSchedule(SCHED_TARGET_FACE) end
			self:FollowPlayerReset()
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

	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 30000 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "vj_combine"then
		self.PlayerFriendly = false
	
		
end
end
end
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/