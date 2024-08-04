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

ENT.Model = {"models/police.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 95
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} 

ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?
	ENT.FootStepSoundLevel = 60
ENT.WeaponSpread = 0.8
ENT.BloodColor = "Red" 
ENT.SightDistance = 6000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 1 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.ShootDistance = 2600
ENT.MeleeAttackDamage = 30
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


ENT.FootStepPitch1 = 100
ENT.FootStepPitch2 = 100

ENT.HasOnPlayerSight = false
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
"npc/metropolice/vo/administer.wav",
"npc/metropolice/vo/affirmative.wav",
"npc/metropolice/vo/affirmative2.wav",
"npc/metropolice/vo/ismovingin.wav",
"npc/metropolice/vo/isgo.wav",
"npc/metropolice/vo/isreadytogo.wav",
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

ENT.SARY = false
ENT.SARY2 = false
ENT.att = false
ENT.att1 = false
ENT.att2 = false
function ENT:CustomOnThink_AIEnabled()
self.Weapon_FiringDistanceFar = self.ShootDistance
if self:GetEnemy() != nil then


if self.att == false then
if !IsValid(self.manha1) then
self.att = true
self.att1 = true

timer.Simple(math.random(10,505),function() if IsValid(self) then 
self:VJ_ACT_PLAYACTIVITY("deploy",true,3.4,false)
self.manha1 = ents.Create("npc_manhack")
self.manha1:SetPos(self:GetPos() + self:GetUp()*math.random(30,50) +self:GetRight()*math.random(-50,50))
self.manha1:SetAngles(self:GetAngles())
self.manha1:Spawn()
self.manha1:SetModelScale(1)
self.manha1:Activate()
self.manha1:SetOwner(self)

end end)
 timer.Simple(1.3,function() if IsValid(self) then self.att1 = false end end)
timer.Simple(math.random(15,26),function() if IsValid(self) then self.att = false end end)
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