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

ENT.Model = {"models/police2.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 85
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} 
ENT.Passive_RunOnDamage = false
ENT.DisableTakeDamageFindEnemy = true
ENT.NextFollowPlayerTime = 9999999999999999999999999999999999999999999 -- Time until it runs to the player again
ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?
ENT.PlayerFriendly = true
ENT.WeaponSpread = 0
ENT.BloodColor = "Red" 
ENT.SightDistance = 6000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 1 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
	ENT.FootStepSoundLevel = 60
ENT.ShootDistance = 2800
ENT.AnimTbl_MeleeAttack = {ACT_IDLE_ANGRY_MELEE}
ENT.MeleeAttackDamage = 35
ENT.SquadName = "metrocop" -- Squad name, console error will happen if two groups that are enemy and try to squad!
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


ENT.SoundTbl_BecomeEnemyToPlayer = {"npc/metropolice/vo/11-99officerneedsassistance.wav","npc/metropolice/vo/contactwith243suspect.wav","npc/metropolice/vo/issuingmalcompliantcitation.wav"}

ENT.HasOnPlayerSight = true
ENT.SoundTbl_OnPlayerSight = {"npc/metropolice/vo/move.wav","npc/metropolice/vo/movealong.wav","npc/metropolice/vo/movealong3.wav"}
ENT.SoundTbl_OnPlayerSight2 = {"npc/metropolice/vo/allrightyoucango.wav","npc/metropolice/vo/lookingfortrouble.wav","npc/metropolice/vo/movebackrightnow.wav","npc/metropolice/vo/youwantamalcomplianceverdict.wav"}

ENT.OnPlayerSightDistance = 80 -- How close should the player be until it runs the code?
ENT.OnPlayerSightDispositionLevel = 1 -- 0 = Run it every time | 1 = Run it only when friendly to player | 2 = Run it only when enemy to player
ENT.OnPlayerSightOnlyOnce = false -- Should it only run the code once?
ENT.OnPlayerSightNextTime1 = 9999999999999999999999 -- How much time should it pass until it runs the code again? | First number in math.random
ENT.OnPlayerSightNextTime2 = 9999999999999999999999 -- How much time should it pass until it runs the code again? | Second number in math.random
ENT.OnPlayerSightNextTime3 = 10 -- How much time should it pass until it runs the code again? | First number in math.random
ENT.OnPlayerSightNextTime4 = 10 -- How much time should it pass until it runs the code again? | Second number in math.random
ENT.OnPlayerSightNextT2 = 0
ENT.SoundTbl_OnKilledEnemy = {"npc/metropolice/vo/11-chuckle.wav","npc/metropolice/vo/clearno647no10-107.wav","npc/metropolice/vo/expired.wav","npc/metropolice/vo/finalverdictadministered.wav","npc/metropolice/vo/isdown.wav","npc/metropolice/vo/pacifying.wav","npc/metropolice/vo/protectioncomplete.wav","npc/metropolice/vo/sentencedelivered.wav"}
ENT.SoundTbl_WeaponReload = {"npc/metropolice/vo/runninglowonverdicts.wav"}



ENT.SoundTbl_AllyDeath = {"npc/metropolice/vo/officerdowncode3tomy10-20.wav","npc/metropolice/vo/officerdowniam10-99.wav","npc/metropolice/vo/wegotadbherecancel10-102.wav"}
ENT.AllyDeathSoundChance = 1

	-- ====== Sound File Paths ====== --
ENT.SoundTbl_FootStep = {"npc/footsteps/hardboot_generic1.wav","npc/footsteps/hardboot_generic2.wav","npc/footsteps/hardboot_generic3.wav","npc/footsteps/hardboot_generic4.wav","npc/footsteps/hardboot_generic5.wav","npc/footsteps/hardboot_generic6.wav",}
ENT.SoundTbl_Idle = {
"npc/metropolice/vo/404zone.wav",
"npc/metropolice/vo/acquiringonvisual.wav",
"npc/metropolice/vo/affirmative2.wav",
"npc/metropolice/vo/affirmative.wav",
"npc/metropolice/vo/airwatchsubjectis505.wav",
"npc/metropolice/vo/anyonepickup647e.wav",
"npc/metropolice/vo/apply.wav",
"npc/metropolice/vo/assaultpointsecureadvance.wav",
"npc/metropolice/vo/atcheckpoint.wav",
"npc/metropolice/vo/blockisholdingcohesive.wav",
"npc/metropolice/vo/canal.wav",
"npc/metropolice/vo/canalblock.wav",
"npc/metropolice/vo/catchthatbliponstabilization.wav",
"npc/metropolice/vo/cauterize.wav",
"npc/metropolice/vo/checkformiscount.wav",
"npc/metropolice/vo/citizen.wav",
"npc/metropolice/vo/citizensummoned.wav",
"npc/metropolice/vo/classifyasdbthisblockready.wav",
"npc/metropolice/vo/clearandcode100.wav",
"npc/metropolice/vo/code7.wav",
"npc/metropolice/vo/code100.wav",
"npc/metropolice/vo/condemnedzone.wav",
"npc/metropolice/vo/confirmpriority1sighted.wav",
"npc/metropolice/vo/contactwithpriority2.wav",
"npc/metropolice/vo/control100percent.wav",
"npc/metropolice/vo/covermegoingin.wav",
"npc/metropolice/vo/cpbolforthat243.wav",
"npc/metropolice/vo/cpiscompromised.wav",
"npc/metropolice/vo/cprequestsallunitsreportin.wav",
"npc/metropolice/vo/dispupdatingapb.wav",
"npc/metropolice/vo/externaljurisdiction.wav",
"npc/metropolice/vo/holdingon10-14duty.wav",
"npc/metropolice/vo/ihave10-30my10-20responding.wav",
"npc/metropolice/vo/inpositiononeready.wav",
"npc/metropolice/vo/investigating10-103.wav",
"npc/metropolice/vo/is10-108.wav",
"npc/metropolice/vo/is415b.wav",
"npc/metropolice/vo/ivegot408hereatlocation.wav",
"npc/metropolice/vo/localcptreportstatus.wav",
"npc/metropolice/vo/loyaltycheckfailure.wav",
"npc/metropolice/vo/matchonapblikeness.wav",
"npc/metropolice/vo/needanyhelpwiththisone.wav",
"npc/metropolice/vo/novisualonupi.wav",
"npc/metropolice/vo/pickingupnoncorplexindy.wav",
"npc/metropolice/vo/possible10-103alerttagunits.wav",
"npc/metropolice/vo/possible404here.wav",
"npc/metropolice/vo/possible647erequestairwatch.wav",
"npc/metropolice/vo/possiblelevel3civilprivacyviolator.wav",
"npc/metropolice/vo/preparefor1015.wav",
"npc/metropolice/vo/prepareforjudgement.wav",
"npc/metropolice/vo/preparingtojudge10-107.wav",
"npc/metropolice/vo/priority2anticitizenhere.wav",
"npc/metropolice/vo/reportsightingsaccomplices.wav",
"npc/metropolice/vo/requestsecondaryviscerator.wav",
"npc/metropolice/vo/searchingforsuspect.wav",
"npc/metropolice/vo/shit.wav",
"npc/metropolice/vo/stabilizationjurisdiction.wav",
"npc/metropolice/vo/standardloyaltycheck.wav",
"npc/metropolice/vo/stillgetting647e.wav",
"npc/metropolice/vo/subjectis505.wav",
"npc/metropolice/vo/suspect11-6my1020is.wav",
"npc/metropolice/vo/tag10-91d.wav",
"npc/metropolice/vo/ten97suspectisgoa.wav",
"npc/metropolice/vo/unitis10-8standingby.wav",
"npc/metropolice/vo/unitisonduty10-8.wav",
"npc/metropolice/vo/unitreportinwith10-25suspect.wav",
"npc/metropolice/vo/wearesociostablethislocation.wav",
"npc/overwatch/radiovoice/question30.wav",
"npc/overwatch/radiovoice/question31.wav",
"npc/overwatch/radiovoice/upthere01.wav",
"npc/overwatch/radiovoice/upthere02.wav",
"npc/overwatch/radiovoice/vanswer01.wav",
"npc/overwatch/radiovoice/vanswer02.wav",
"npc/overwatch/radiovoice/vanswer03.wav",
"npc/overwatch/radiovoice/vanswer04.wav",
"npc/overwatch/radiovoice/vanswer05.wav",
"npc/overwatch/radiovoice/vanswer06.wav",
"npc/overwatch/radiovoice/vanswer07.wav",
"npc/overwatch/radiovoice/vanswer08.wav",
"npc/overwatch/radiovoice/vanswer09.wav",
"npc/overwatch/radiovoice/vanswer10.wav",
"npc/overwatch/radiovoice/vanswer11.wav",
"npc/overwatch/radiovoice/vanswer12.wav",
"npc/overwatch/radiovoice/vanswer13.wav",
"npc/overwatch/radiovoice/vanswer14.wav",
"npc/overwatch/radiovoice/vquestion01.wav",
"npc/overwatch/radiovoice/vquestion02.wav",
"npc/overwatch/radiovoice/vquestion03.wav",
"npc/overwatch/radiovoice/vquestion04.wav",
"npc/overwatch/radiovoice/vquestion05.wav",
"npc/overwatch/radiovoice/vquestion06.wav",
"npc/overwatch/radiovoice/vquestion07.wav",
}
ENT.SoundTbl_Alert = {
"npc/metropolice/vo/allunitscloseonsuspect.wav",
"npc/metropolice/vo/allunitscode2.wav",
"npc/metropolice/vo/allunitsrespondcode3.wav",
"npc/metropolice/vo/anticitizen.wav",
"npc/metropolice/vo/confirmadw.wav",
"npc/metropolice/vo/dispatchineed10-78.wav",
"npc/metropolice/vo/dispreportssuspectincursion.wav",
"npc/metropolice/vo/gothimagainsuspect10-20at.wav",
"npc/metropolice/vo/level3civilprivacyviolator.wav",
"npc/metropolice/vo/malcompliant10107my1020.wav",
"npc/metropolice/vo/minorhitscontinuing.wav",
"npc/metropolice/vo/outbreak.wav",
"npc/metropolice/vo/sacrificecode1maintaincp.wav",
"npc/metropolice/vo/shotsfiredhostilemalignants.wav",
"npc/metropolice/vo/sociocide.wav",
"npc/metropolice/vo/unlawfulentry603.wav",
}
ENT.SoundTbl_CombatIdle = {
"npc/metropolice/vo/allunitsbol34sat.wav",
"npc/metropolice/vo/allunitsmaintainthiscp.wav",
"npc/metropolice/vo/allunitsmovein.wav",
"npc/metropolice/vo/allunitsreportlocationsuspect.wav",
"npc/metropolice/vo/amputate.wav",
"npc/metropolice/vo/backmeupimout.wav",
"npc/metropolice/vo/backup.wav",
"npc/metropolice/vo/breakhiscover.wav",
"npc/metropolice/vo/firetodislocateinterpose.wav",
"npc/metropolice/vo/firingtoexposetarget.wav",
"npc/metropolice/vo/get11-44inboundcleaningup.wav",
"npc/metropolice/vo/gota10-107sendairwatch.wav",
"npc/metropolice/vo/hesupthere.wav",
"npc/metropolice/vo/hidinglastseenatrange.wav",
"npc/metropolice/vo/holditrightthere.wav",
"npc/metropolice/vo/holdthisposition.wav",
"npc/metropolice/vo/isclosingonsuspect.wav",
"npc/metropolice/vo/movingtocover.wav",
"npc/metropolice/vo/officerneedsassistance.wav",
"npc/metropolice/vo/officerneedshelp.wav",
"npc/metropolice/vo/officerunderfiretakingcover.wav",

}
ENT.SoundTbl_OnGrenadeSight = {
"npc/metropolice/vo/getdown.wav",
"npc/metropolice/vo/grenade.wav",
"npc/metropolice/vo/watchit.wav",

}
ENT.SoundTbl_Pain = {
"npc/metropolice/criminaltrespass63.wav",
"npc/metropolice/pain2.wav",
"npc/metropolice/pain3.wav",
"npc/metropolice/pain4.wav",
"npc/metropolice/pain1.wav",
"npc/metropolice/knockout.wav",

}
ENT.SoundTbl_Death = {
"npc/metropolice/die1.wav",
"npc/metropolice/die2.wav",
"npc/metropolice/die3.wav",
"npc/metropolice/die4.wav",
"npc/metropolice/pain09.wav",
}
ENT.SoundTbl_FollowPlayer = {

"npc/metropolice/vo/readytojudge.wav",
"npc/metropolice/vo/readytoprosecute.wav",

}
ENT.SoundTbl_UnFollowPlayer = {
"npc/metropolice/vo/copy.wav",
"npc/metropolice/vo/reinforcementteamscode3.wav",

}

ENT.SoundTbl_DamageByPlayer = {
"npc/metropolice/vo/finalwarning.wav",

}

ENT.DefaultSoundTbl_MeleeAttack = {"physics/body/body_medium_impact_hard1.wav","physics/body/body_medium_impact_hard2.wav","physics/body/body_medium_impact_hard3.wav","physics/body/body_medium_impact_hard4.wav","physics/body/body_medium_impact_hard5.wav","physics/body/body_medium_impact_hard6.wav"}
ENT.DefaultSoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.DefaultSoundTbl_Impact = {"physics/flesh/flesh_impact_bullet1.wav","physics/flesh/flesh_impact_bullet2.wav","physics/flesh/flesh_impact_bullet3.wav","physics/flesh/flesh_impact_bullet4.wav","physics/flesh/flesh_impact_bullet5.wav"}
ENT.DefaultSoundTbl_MedicAfterHeal = {"items/smallmedkit1.wav"}




---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
self.DisableWandering = true
self.AnimTbl_IdleStand = {ACT_DOD_WALK_AIM_PSCHRECK}
self.AnimTbl_Walk = {ACT_DOD_WALK_AIM_PSCHRECK}
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 300000 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "resistance"then
		self.PlayerFriendly = false
	
		
end
end
end
end
--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
self.DisableWandering = true
self.Weapon_FiringDistanceFar = self.ShootDistance
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 3000000 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "resistance"then
		self.PlayerFriendly = false
	
		
end
end
end

end

function ENT:CustomOnFollowPlayer(key,activator,caller,data)

	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 100 ) ) do
			if v:IsPlayer() then
					v.friclass = "CLASS_COMBINE"
					v.SquadName = "vj_combine"
					v.Class = "CLASS_COMBINE"
					v.Classify = "CLASS_COMBINE" 
					v.VJ_NPC_Class = {"CLASS_COMBINE"}
					v.GetClass = "CLASS_COMBINE"
					v.SetClass = "CLASS_COMBINE"   
                    v.PlayerAIUser = true
					v.FreedomUser = true
				   	self:FollowPlayerSoundCode()
							self.Phantom1 = ents.Create("weapon_stunstick")
	self.Phantom1:SetPos(self:GetPos() +self:GetForward()*40 +self:GetUp()*50)
	self.Phantom1:SetAngles(self:GetAngles())
	self.Phantom1:Spawn()
	self.Phantom2 = ents.Create("item_ammo_357")
	self.Phantom2:SetPos(self:GetPos() +self:GetForward()*40 +self:GetUp()*50)
	self.Phantom2:SetAngles(self:GetAngles())
	self.Phantom2:Spawn()
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
	self.Phantom6 = ents.Create("weapon_357")
	self.Phantom6:SetPos(self:GetPos() +self:GetForward()*40 +self:GetUp()*50)
	self.Phantom6:SetAngles(self:GetAngles())
	self.Phantom6:Spawn()
	self.Phantom7 = ents.Create("weapon_smg1")
	self.Phantom7:SetPos(self:GetPos() +self:GetForward()*40 +self:GetUp()*50)
	self.Phantom7:SetAngles(self:GetAngles())
	self.Phantom7:Spawn()
	self.Phantom8 = ents.Create("item_battery")
	self.Phantom8:SetPos(self:GetPos() +self:GetForward()*40)
	self.Phantom8:SetAngles(self:GetAngles())
	self.Phantom8:Spawn()
	self.Phantom9 = ents.Create("item_battery")
	self.Phantom9:SetPos(self:GetPos() +self:GetForward()*40)
	self.Phantom9:SetAngles(self:GetAngles())
	self.Phantom9:Spawn()
                    v:SendLua( "Derma_Message( \"YOU JOINED OUT COMBINE\", \"CONGRATULATE\", \"OK\" )" )
end end

self:VJ_ACT_PLAYACTIVITY(self.AnimTbl_IdleStand,true,1.1,false,0,{SequenceDuration=self.DeathFlinchTime})
 end
ENT.NextFollowUpdateTime = 999990

function ENT:CustomOnUnFollowPlayer(ply)
self:FollowPlayerReset()
self:VJ_ACT_PLAYACTIVITY(self.AnimTbl_IdleStand,true,1.1,false,0,{SequenceDuration=self.DeathFlinchTime})
 end
function ENT:FollowPlayerReset()
	self.FollowingPlayer = true
for k, v in pairs( ents.FindInSphere( self:GetPos( ), 100) ) do
				if v.PlayerAIUser == true then
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
					v:EmitSound("group1.ogg",100,100)
                    v:SendLua( "Derma_Message( \"YOU LEFT FACTION COMBINE. NOW YOU REBEL\", \"WARNING\", \"OK\" )" )
			self:UnFollowPlayerSoundCode()	
			self.PlayerFriendly = false
end
end
end
end	

function ENT:OnPlayerSightSoundCode(CustomTbl)
	if self.HasSounds == false or self.HasOnPlayerSightSounds == false then return end
	local randomplayersound = math.random(1,self.OnPlayerSightSoundChance)
	local soundtbl = self.SoundTbl_OnPlayerSight
	local soundtble = self.SoundTbl_UnFollowPlayer2
	if CustomTbl != nil && #CustomTbl != 0 then soundtbl = CustomTbl end
	if randomplayersound == 1 && VJ_PICKRANDOMTABLE(soundtbl) != false then
		VJ_STOPSOUND(self.CurrentIdleSound)
		VJ_STOPSOUND(self.CurrentOnPlayerSightSound)
		VJ_STOPSOUND(self.CurrentWeaponReloadSound)
		VJ_STOPSOUND(self.CurrentAlertSound)
		self.NextIdleSoundT_RegularChange = CurTime() + math.random(3,4)
		self.NextAlertSoundT = CurTime() + math.random(1,2)
		self.CurrentOnPlayerSightSound = VJ_CreateSound(self,soundtbl,self.OnPlayerSightSoundLevel,self:VJ_DecideSoundPitch(self.OnPlayerSightSoundPitch1,self.OnPlayerSightSoundPitch2))
	end
end



function ENT:OnPlayerSightSoundCode2(CustomTbl)
	if self.HasSounds == false or self.HasOnPlayerSightSounds == false then return end
	local randomplayersound = math.random(1,self.OnPlayerSightSoundChance)
	local soundtbl = self.SoundTbl_OnPlayerSight2
	if CustomTbl != nil && #CustomTbl != 0 then soundtbl = CustomTbl end
	if randomplayersound == 1 && VJ_PICKRANDOMTABLE(soundtbl) != false then
		VJ_STOPSOUND(self.CurrentIdleSound)
		VJ_STOPSOUND(self.CurrentOnPlayerSightSound)
		VJ_STOPSOUND(self.CurrentWeaponReloadSound)
		VJ_STOPSOUND(self.CurrentAlertSound)
		self.NextIdleSoundT_RegularChange = 10 + math.random(3,4)
		self.NextAlertSoundT = 10 + math.random(1,2)
		self.CurrentOnPlayerSightSound = VJ_CreateSound(self,soundtbl,self.OnPlayerSightSoundLevel,self:VJ_DecideSoundPitch(self.OnPlayerSightSoundPitch1,self.OnPlayerSightSoundPitch2))
	end
end

function ENT:OnPlayerSightCode(argent)
	if self.HasOnPlayerSight == false then return end
	if self.OnPlayerSightOnlyOnce == true then if self.OnPlayerSight_AlreadySeen == true then return end end
	if GetConVarNumber("ai_ignoreplayers") == 1 then return end
	if (CurTime() > self.OnPlayerSightNextT) && argent:IsPlayer() && (argent:GetPos():Distance(self:GetPos()) < self.OnPlayerSightDistance) && self:Visible(argent) && (self:GetForward():Dot((argent:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.SightAngle))) then
		if self.OnPlayerSightDispositionLevel == 1 && self:Disposition(argent) != D_LI && self:Disposition(argent) != D_NU then return end
		if self.OnPlayerSightDispositionLevel == 2 && (self:Disposition(argent) == D_LI) then return end
		self.OnPlayerSight_AlreadySeen = true
		self:CustomOnPlayerSight(argent)
		self:OnPlayerSightSoundCode()

		if self.OnPlayerSightOnlyOnce == false then self.OnPlayerSightNextT = CurTime() + math.Rand(self.OnPlayerSightNextTime1,self.OnPlayerSightNextTime2) end
	end
	
		if (CurTime() > self.OnPlayerSightNextT2) && argent:IsPlayer() && (argent:GetPos():Distance(self:GetPos()) < self.OnPlayerSightDistance) && self:Visible(argent) && (self:GetForward():Dot((argent:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.SightAngle))) then


		self:OnPlayerSightSoundCode2()
		if self.OnPlayerSightOnlyOnce == false then self.OnPlayerSightNextT2 = CurTime() + math.Rand(self.OnPlayerSightNextTime3,self.OnPlayerSightNextTime4) end
	end
		if (argent:GetPos():Distance(self:GetPos()) > self.OnPlayerSightDistance) then
		self.OnPlayerSightNextT = CurTime()
		self.OnPlayerSightNextT2 = CurTime() + math.Rand(self.OnPlayerSightNextTime3,self.OnPlayerSightNextTime4)
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
function ENT:FollowPlayerSoundCode(CustomTbl,Type)
	if self.HasSounds == false or self.HasFollowPlayerSounds_Follow == false then return end
	Type = Type or VJ_CreateSound
	local ctbl = VJ_PICK(CustomTbl)
	local sdtbl = VJ_PICK(self.SoundTbl_FollowPlayer)
	if (math.random(1,self.FollowPlayerSoundChance) == 1 && sdtbl != false) or (ctbl != false) then
		if ctbl != false then sdtbl = ctbl end
		self:StopAllCommonSpeechSounds()
		self.NextIdleSoundT_RegularChange = CurTime() + math.random(3,4)
		self.CurrentFollowPlayerSound = Type(self,sdtbl,self.FollowPlayerSoundLevel,self:VJ_DecideSoundPitch(self.FollowPlayerPitch1,self.FollowPlayerPitch2))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:UnFollowPlayerSoundCode(CustomTbl,Type)
	if self.HasSounds == false or self.HasFollowPlayerSounds_UnFollow == false then return end
	Type = Type or VJ_CreateSound
	local ctbl = VJ_PICK(CustomTbl)
	local sdtbl = VJ_PICK(self.SoundTbl_UnFollowPlayer)
	if (math.random(1,self.UnFollowPlayerSoundChance) == 1 && sdtbl != false) or (ctbl != false) then
		if ctbl != false then sdtbl = ctbl end
		self:StopAllCommonSpeechSounds()
		self.NextIdleSoundT_RegularChange = CurTime() + math.random(3,4)
		self.CurrentUnFollowPlayerSound = Type(self,sdtbl,self.UnFollowPlayerSoundLevel,self:VJ_DecideSoundPitch(self.UnFollowPlayerPitch1,self.UnFollowPlayerPitch2))
	end
end


/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/