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

ENT.Model = {"models/humans/group03/male_02.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 105
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CITIZEN","CLASS_AMERICA_FRIENDLY","CIVILAN"} 
ENT.PlayerFriendly = true
ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?
ENT.Passive_RunOnDamage = false
ENT.DisableTakeDamageFindEnemy = true
ENT.NextFollowPlayerTime = 9999999999999999999999999999999999999999999 -- Time until it runs to the player again
ENT.WeaponSpread = 0.1
ENT.BloodColor = "Red" 
ENT.SightDistance = 6000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
	ENT.FootStepSoundLevel = 60
ENT.ShootDistance = 2100
ENT.MeleeAttackDamage = 40
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
ENT.NextThrowGrenadeTime1 = 10 -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = 15 -- Time until it runs the throw grenade code again | The second # in math.random
ENT.ThrowGrenadeChance = 1 -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.GrenadeAttackThrowDistance = 1000 -- How far it can throw grenades
ENT.GrenadeAttackThrowDistanceClose = 500 -- How close until it stops throwing grenades
	-- ====== Sound File Paths ====== --
ENT.SoundTbl_FootStep = {"npc/footsteps/hardboot_generic1.wav","npc/footsteps/hardboot_generic2.wav","npc/footsteps/hardboot_generic3.wav","npc/footsteps/hardboot_generic4.wav","npc/footsteps/hardboot_generic5.wav","npc/footsteps/hardboot_generic6.wav",}
ENT.SoundTbl_Idle = {
"vo/npc/male01/answer01.wav",
"vo/npc/male01/answer02.wav",
"vo/npc/male01/answer03.wav",
"vo/npc/male01/answer04.wav",
"vo/npc/male01/answer05.wav",
"vo/npc/male01/answer07.wav",
"vo/npc/male01/answer08.wav",
"vo/npc/male01/answer09.wav",
"vo/npc/male01/answer10.wav",
"vo/npc/male01/answer11.wav",
"vo/npc/male01/answer12.wav",
"vo/npc/male01/answer13.wav",
"vo/npc/male01/answer14.wav",
"vo/npc/male01/answer15.wav",
"vo/npc/male01/answer16.wav",
"vo/npc/male01/answer17.wav",
"vo/npc/male01/answer18.wav",
"vo/npc/male01/answer19.wav",
"vo/npc/male01/answer20.wav",
"vo/npc/male01/answer21.wav",
"vo/npc/male01/answer22.wav",
"vo/npc/male01/answer23.wav",
"vo/npc/male01/answer24.wav",
"vo/npc/male01/answer25.wav",
"vo/npc/male01/answer26.wav",
"vo/npc/male01/answer27.wav",
"vo/npc/male01/answer28.wav",
"vo/npc/male01/answer29.wav",
"vo/npc/male01/answer30.wav",
"vo/npc/male01/answer31.wav",
"vo/npc/male01/answer32.wav",
"vo/npc/male01/answer33.wav",
"vo/npc/male01/answer34.wav",
"vo/npc/male01/answer35.wav",
"vo/npc/male01/answer36.wav",
"vo/npc/male01/answer37.wav",
"vo/npc/male01/answer38.wav",
"vo/npc/male01/answer39.wav",
"vo/npc/male01/answer40.wav",
"vo/npc/male01/question01.wav",
"vo/npc/male01/question02.wav",
"vo/npc/male01/question03.wav",
"vo/npc/male01/question04.wav",
"vo/npc/male01/question05.wav",
"vo/npc/male01/question06.wav",
"vo/npc/male01/question07.wav",
"vo/npc/male01/question08.wav",
"vo/npc/male01/question09.wav",
"vo/npc/male01/question10.wav",
"vo/npc/male01/question11.wav",
"vo/npc/male01/question12.wav",
"vo/npc/male01/question13.wav",
"vo/npc/male01/question14.wav",
"vo/npc/male01/question15.wav",
"vo/npc/male01/question16.wav",
"vo/npc/male01/question17.wav",
"vo/npc/male01/question18.wav",
"vo/npc/male01/question19.wav",
"vo/npc/male01/question20.wav",
"vo/npc/male01/question21.wav",
"vo/npc/male01/question22.wav",
"vo/npc/male01/question23.wav",
"vo/npc/male01/question25.wav",
"vo/npc/male01/question26.wav",
"vo/npc/male01/question27.wav",
"vo/npc/male01/question28.wav",
"vo/npc/male01/question29.wav",
"vo/npc/male01/question30.wav",
"vo/npc/male01/question31.wav",
"vo/npc/male01/upthere01.wav",
"vo/npc/male01/upthere02.wav",
"vo/npc/male01/vanswer01.wav",
"vo/npc/male01/vanswer02.wav",
"vo/npc/male01/vanswer03.wav",
"vo/npc/male01/vanswer04.wav",
"vo/npc/male01/vanswer05.wav",
"vo/npc/male01/vanswer06.wav",
"vo/npc/male01/vanswer07.wav",
"vo/npc/male01/vanswer08.wav",
"vo/npc/male01/vanswer09.wav",
"vo/npc/male01/vanswer10.wav",
"vo/npc/male01/vanswer11.wav",
"vo/npc/male01/vanswer12.wav",
"vo/npc/male01/vanswer13.wav",
"vo/npc/male01/vanswer14.wav",
"vo/npc/male01/vquestion01.wav",
"vo/npc/male01/vquestion02.wav",
"vo/npc/male01/vquestion03.wav",
"vo/npc/male01/vquestion04.wav",
"vo/npc/male01/vquestion05.wav",
"vo/npc/male01/vquestion06.wav",
"vo/npc/male01/vquestion07.wav",
}
ENT.SoundTbl_Alert = {
"vo/npc/male01/behindyou01.wav",
"vo/npc/male01/behindyou02.wav",
"vo/npc/male01/busy02.wav",
"vo/npc/male01/heretheycome01.wav",
"vo/npc/male01/incoming02.wav",
}
ENT.SoundTbl_CombatIdle = {
"vo/npc/male01/runforyourlife01.wav",
"vo/npc/male01/runforyourlife02.wav",
"vo/npc/male01/runforyourlife03.wav",
"vo/npc/male01/getdown02.wav",
"vo/npc/male01/getgoingsoon.wav",
"vo/npc/male01/gethellout.wav",
"vo/npc/male01/moan01.wav",
"vo/npc/male01/moan02.wav",
"vo/npc/male01/moan03.wav",
"vo/npc/male01/moan04.wav",
"vo/npc/male01/moan05.wav",
"vo/npc/male01/upthere01.wav",
"vo/npc/male01/upthere02.wav",
"vo/npc/male01/help01.wav",

}
ENT.SoundTbl_OnGrenadeSight = {
"vo/npc/male01/cps01.wav",
"vo/npc/male01/cps02.wav",
"vo/npc/male01/hacks01.wav",
"vo/npc/male01/hacks02.wav",
}
ENT.SoundTbl_Pain = {
"vo/npc/male01/pain01.wav",
"vo/npc/male01/pain02.wav",
"vo/npc/male01/pain03.wav",
"vo/npc/male01/pain04.wav",
"vo/npc/male01/pain05.wav",
"vo/npc/male01/pain06.wav",
"vo/npc/male01/pain07.wav",
"vo/npc/male01/pain08.wav",
"vo/npc/male01/pain09.wav",
"vo/npc/male01/myarm01.wav",
"vo/npc/male01/myarm02.wav",
"vo/npc/male01/mygut02.wav",
"vo/npc/male01/myleg01.wav",
"vo/npc/male01/myleg02.wav",
"vo/npc/male01/imhurt01.wav",
"vo/npc/male01/imhurt02.wav",
"vo/npc/male01/no01.wav",
"vo/npc/male01/no02.wav",
}
ENT.SoundTbl_Death = {
"vo/npc/male01/ohno.wav",
"vo/npc/male01/ow01.wav",
"vo/npc/male01/ow02.wav",
"vo/npc/male01/pain08.wav",
"vo/npc/male01/pain09.wav",
}
ENT.SoundTbl_FollowPlayer = {
"vo/npc/male01/letsgo01.wav",
"vo/npc/male01/letsgo02.wav",
"vo/npc/male01/leadon01.wav",
"vo/npc/male01/leadon02.wav",
"vo/npc/male01/squad_reinforce_single01.wav",
"vo/npc/male01/squad_reinforce_single02.wav",
"vo/npc/male01/squad_reinforce_single03.wav",
"vo/npc/male01/squad_reinforce_single04.wav",
"vo/npc/male01/squad_follow01.wav",
"vo/npc/male01/squad_follow02.wav",
"vo/npc/male01/squad_follow03.wav",
"vo/npc/male01/squad_follow04.wav",
}
ENT.SoundTbl_UnFollowPlayer = {
"vo/npc/male01/readywhenyouare01.wav",
"vo/npc/male01/readywhenyouare02.wav",
"vo/npc/male01/outofyourway02.wav",
"vo/npc/male01/yeah02.wav",
"vo/npc/male01/watchout.wav",
"vo/npc/male01/waitingsomebody.wav",
"vo/npc/male01/ok01.wav",
"vo/npc/male01/ok02.wav",
"vo/npc/male01/okimready01.wav",
"vo/npc/male01/okimready02.wav",
"vo/npc/male01/okimready03.wav",
}
ENT.SoundTbl_OnPlayerSight = {
"vo/npc/male01/nice.wav",
"vo/npc/male01/heydoc01.wav",
"vo/npc/male01/heydoc02.wav",
"vo/npc/male01/freeman.wav",
"vo/npc/male01/ahgordon01.wav",
"vo/npc/male01/ahgordon02.wav",
"vo/npc/male01/goodgod.wav",
"vo/npc/male01/doingsomething.wav",
"vo/npc/male01/docfreeman01.wav",
"vo/npc/male01/docfreeman02.wav",
"vo/npc/male01/hi01.wav",
"vo/npc/male01/hi02.wav",
}
ENT.SoundTbl_DamageByPlayer = {
"vo/npc/male01/watchout.wav",
"vo/npc/male01/watchwhat.wav",
"vo/npc/male01/wetrustedyou01.wav",
"vo/npc/male01/wetrustedyou02.wav",
"vo/npc/male01/notthemanithought01.wav",
"vo/npc/male01/notthemanithought02.wav",
"vo/npc/male01/stopitfm.wav",
}

ENT.DefaultSoundTbl_MeleeAttack = {"physics/body/body_medium_impact_hard1.wav","physics/body/body_medium_impact_hard2.wav","physics/body/body_medium_impact_hard3.wav","physics/body/body_medium_impact_hard4.wav","physics/body/body_medium_impact_hard5.wav","physics/body/body_medium_impact_hard6.wav"}
ENT.DefaultSoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.DefaultSoundTbl_Impact = {"physics/flesh/flesh_impact_bullet1.wav","physics/flesh/flesh_impact_bullet2.wav","physics/flesh/flesh_impact_bullet3.wav","physics/flesh/flesh_impact_bullet4.wav","physics/flesh/flesh_impact_bullet5.wav"}
ENT.DefaultSoundTbl_MedicAfterHeal = {"items/smallmedkit1.wav"}


ENT.HasOnPlayerSight = true

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
			if v:IsPlayer() and v.SquadName == "vj_combine"then
		self.PlayerFriendly = false
	
		
end
end
end
end

ENT.BreathSoundPitch1 = 90
ENT.BreathSoundPitch2 = 90
ENT.IdleSoundPitch1 = 90
ENT.IdleSoundPitch2 = 90
ENT.CombatIdleSoundPitch1 = 90
ENT.CombatIdleSoundPitch2 = 90
ENT.OnReceiveOrderSoundPitch1 = 90
ENT.OnReceiveOrderSoundPitch2 = 90
ENT.MoveOutOfPlayersWaySoundPitch1 = 90
ENT.MoveOutOfPlayersWaySoundPitch2 = 90
ENT.BeforeHealSoundPitch1 = 90
ENT.BeforeHealSoundPitch2 = 90
ENT.AfterHealSoundPitch1 = 90
ENT.AfterHealSoundPitch2 = 90
ENT.MedicReceiveHealSoundPitch1 = 90
ENT.MedicReceiveHealSoundPitch2 = 90
ENT.OnPlayerSightSoundPitch1 = 90
ENT.OnPlayerSightSoundPitch2 = 90
ENT.AlertSoundPitch1 = 90
ENT.AlertSoundPitch2 = 90
ENT.CallForHelpSoundPitch1 = 90
ENT.CallForHelpSoundPitch2 = 90
ENT.BecomeEnemyToPlayerPitch1 = 90
ENT.BecomeEnemyToPlayerPitch2 = 90
ENT.SuppressingPitch1 = 90
ENT.SuppressingPitch2 = 90
ENT.WeaponReloadSoundPitch1 = 90
ENT.WeaponReloadSoundPitch2 = 90
ENT.GrenadeAttackSoundPitch1 = 90
ENT.GrenadeAttackSoundPitch2 = 90
ENT.OnGrenadeSightSoundPitch1 = 90
ENT.OnGrenadeSightSoundPitch2 = 90
ENT.OnKilledEnemySoundPitch1 = 90
ENT.OnKilledEnemySoundPitch2 = 90
ENT.PainSoundPitch1 = 90
ENT.PainSoundPitch2 = 90
ENT.ImpactSoundPitch1 = 80
ENT.ImpactSoundPitch2 = 90
ENT.DamageByPlayerPitch1 = 90
ENT.DamageByPlayerPitch2 = 90
ENT.DeathSoundPitch1 = 90
ENT.DeathSoundPitch2 = 90


function ENT:CustomOnFollowPlayer(key,activator,caller,data)

	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 100 ) ) do
			if v:IsPlayer() then
					v.friclass = "CLASS_PLAYER_ALLY"
					v.SquadName = "vj_rebel"
					v.Class = "CLASS_PLAYER_ALLY"
					v.Classify = "CLASS_PLAYER_ALLY" 
					v.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
					v.GetClass = "CLASS_PLAYER_ALLY"
					v.SetClass = "CLASS_PLAYER_ALLY"   
                    v.PlayerAIUser = true
					v.FreedomUser = true
	self.Phantom3 = ents.Create("weapon_frag")
	self.Phantom3:SetPos(self:GetPos() +self:GetForward()*40 +self:GetUp()*50)
	self.Phantom3:SetAngles(self:GetAngles())
	self.Phantom3:Spawn()
	self.Phantom4 = ents.Create("item_ammo_smg1_grenade")
	self.Phantom4:SetPos(self:GetPos() +self:GetForward()*40 +self:GetUp()*50)
	self.Phantom4:SetAngles(self:GetAngles())
	self.Phantom4:Spawn()
	self.Phantom5 = ents.Create("item_ammo_smg1_large")
	self.Phantom5:SetPos(self:GetPos() +self:GetForward()*40 +self:GetUp()*50)
	self.Phantom5:SetAngles(self:GetAngles())
    self.Phantom5:Spawn()
	self.Phantom7 = ents.Create("weapon_smg1")
	self.Phantom7:SetPos(self:GetPos() +self:GetForward()*40 +self:GetUp()*50)
	self.Phantom7:SetAngles(self:GetAngles())
	self.Phantom7:Spawn()
                    v:SendLua( "Derma_Message( \"YOU JOINED OUT REBELS\", \"CONGRATULATE\", \"OK\" )" )
end end

self:VJ_ACT_PLAYACTIVITY(self.AnimTbl_IdleStand,true,1.1,false,0,{SequenceDuration=self.DeathFlinchTime})
 end
ENT.NextFollowUpdateTime = 999990

function ENT:CustomOnUnFollowPlayer(ply)
self:FollowPlayerReset()
self:VJ_ACT_PLAYACTIVITY(self.AnimTbl_IdleStand,true,1.1,false,0,{SequenceDuration=self.DeathFlinchTime})
 end

function ENT:FollowPlayerReset()

	if self.AllowPrintingInChat == true && self.FollowPlayerChat == true then  end
	self.FollowingPlayer = true

for k, v in pairs( ents.FindInSphere( self:GetPos( ), 300 ) ) do
				if v.PlayerAIUser == true then
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() then
					v.friclass = "CLASS_PLAYER_ALLY"
					v.SquadName = "vj_neutral"
					v.Class = "CLASS_PLAYER_ALLY"
					v.Classify = "CLASS_PLAYER_ALLY" 

                    v.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
					v.GetClass = "CLASS_PLAYER_ALLY"
					v.SetClass = "CLASS_PLAYER_ALLY"	   
                    v.PlayerAIUser = false
					v.FreedomUser = false
                   v:SendLua( "Derma_Message( \"YOU LEFT FACTION REBELS. NOW YOU NEUTRAL\", \"WARNING\", \"OK\" )" )
			end
		end
	end
	end

	self.RunningAfter_FollowPlayer = false
	self.FollowingPlayerName = NULL
	self.DisableWandering = self.FollowingPlayer_WanderValue
	self.DisableChasingEnemy = self.FollowingPlayer_ChaseValue
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/