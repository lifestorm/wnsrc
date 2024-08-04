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
ENT.StartHealth = 115
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} 

ENT.Weapon_FiringDistanceFar = 20000
ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?
ENT.DisableWandering = true
ENT.WeaponSpread = 0
ENT.BloodColor = "Red" 
ENT.SightDistance = 20000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.ShootDistance = 11000
ENT.MeleeAttackDamage = 35
ENT.SquadName = "combine_sniper" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking

ENT.FindEnemy_UseSphere = true
 -- This will decrease the time until it starts moving or attack again. Use it to fix animation pauses until it chases the enemy.
ENT.NextWanderTime = 100000000000000
ENT.LastSeenEnemyTimeUntilReset = -1
ENT.ConstantlyFaceEnemy_Postures = "Standing"
ENT.CallForHelp = true -- Does the SNPC call for help? hide
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




---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()

	
	if self.ForceChase == true then
	self:InvasionChase(self)
	end

	self:Relations(self)
	
	self:Drowning(self)
	
	self:FallDamage(self)
	
	self:DamageEffects(self)

	self:FallBack(self)
	

	
	if IsValid(self:GetEnemy()) then
	PushTarget = self:GetEnemy()
	if self:GetActivity() == 64 then
	if self.MeleeNoLoop == false then
	self.MeleeNoLoop = true
	self:PlayScene("scenes/snipermeleefix.vcd")
	end
	timer.Simple(0.001, function()
	if IsValid(self) then
	self:StopMoving()
	self:PushIt(PushTarget)
	end
	end)
	end
	end
	
	local CAM = ents.FindInSphere(self:GetPos(), 999999 )
	for _, CAMO in pairs( CAM ) do
	if(CAMO:IsPlayer() and IsValid(CAMO) and self:GetPos():Distance(CAMO:GetPos()) > 500) then
	self:SetMaterial("models/shadertest/predator")
	end
	if(CAMO:IsPlayer() and IsValid(CAMO) and self:GetPos():Distance(CAMO:GetPos()) <= 500) then
	self:SetMaterial("")
	end
	end

	if IsValid( sniperp ) then
	end

end
ENT.FallDamageHeight = 0
ENT.HealthNow = 0


function ENT:PushIt(ent)
if IsValid(ent) then
if(self.Push == false)then return end
	self.Push = false
	end
	if IsValid(ent) and IsValid(self) then
	if !IsValid(self:GetEnemy()) then
	timer.Simple(0.0001, function()
	self.Push = true
	end)
	end
	if IsValid(self:GetEnemy()) then
	local PushHimBack2 = self:GetEnemy()
	local DistanceToPush2 = (PushHimBack2:GetPos()-self:GetPos()):Length()
	if DistanceToPush2 <= 60 and IsValid(PushHimBack2) then 
	if ent:IsNPC() then
	ent:SetVelocity(self:GetForward() * 2000 + Vector(0,0,5))
	ent:SetSchedule(SCHED_BIG_FLINCH)
	elseif ent:IsPlayer() then
	ent:SetVelocity(self:GetForward() * 600 + Vector(0,0,5))
	ent:ViewPunch(Angle( math.random(-5,-20),math.random(-20,20),0 )) 
	end
	end
	timer.Simple(0.0001, function()
	self.Push = true
	end)
	end		
	end
	end
--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	self:SetKeyValue( "spawnflags", "256" + "8192" )
	self:SetKeyValue("additionalequipment","weapon_vj_csniper_hl2")
	self:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
		self:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
		self.Needmeds = true
		self.MeleeNoLoop = false
				self.FallDamageHeight = 12 * 16
						self:SetParent(self)
		timer.Simple(0.0001,function()
	if IsValid(self) then
	self:SetPos(self:GetPos()+Vector(0,0,6))


	self.HealthNow = self:Health()
	end
	end)
end
--------------------------------------------------------------------------------------

function ENT:FallDamage(ent)
if IsValid(ent) then
if ent:IsOnGround() and self.FallDeath == true then
ent:EmitSound("physics/flesh/flesh_break1.wav", 75, 100)
ent:StopSound("CUPfall.Play")
ent:StopSound("CUPfall2.Play")
fleshimpact	= EffectData()
fleshimpact:SetEntity(ent)
fleshimpact:SetOrigin(ent:GetPos())
fleshimpact:SetNormal(ent:GetPos())
util.Effect("BloodImpact", fleshimpact)
ent:TakeDamage(ent:Health(), ent, DMG_FALL)
end
if not ent:IsOnGround() then
ent.m_fLastFallVelocity = ent:GetVelocity( ):Length( )
elseif ( ent.m_fLastFallVelocity or 0 ) > self.FallDamageHeight then
ent:TakeDamage(ent.m_fLastFallVelocity/16, ent, DMG_FALL)
ent.m_fLastFallVelocity = 0
end
if not ent:IsOnGround() then
if ent.m_fLastFallVelocity/16 >= 50 or ent.m_fLastFallVelocity/16 >= ent:Health() then
self.FallDeath = true
if self.HeightScream == false then
self.HeightScream = true
ent:EmitSound("CUPfall.Play")
ent:EmitSound("CUPfall2.Play")
end
else
self.HeightScream = false
end
end
end
end
 
function ENT:Drowning(ent)
if IsValid(ent) then
if ent:WaterLevel() >= 3 and self.Drown == nil then
self.Drown = true
self.CanWalk = false
self.Jump = 1
ent:PlayScene("scenes/drownsniper.vcd")
ent:SetSchedule(SCHED_NPC_FREEZE)
timer.Simple(0.0001, function()
ent:Fire("becomeragdoll")
end)
end
end
end

function ENT:DamageEffects(ent)
if IsValid(ent) then
if self:Health() < self.HealthNow then
if math.random(1,1)==3 then
ent:SetSchedule( SCHED_BIG_FLINCH )

else
ent:SetSchedule( SCHED_SMALL_FLINCH )

end

self.HealthNow = ent:Health()
end
if self:Health() > self.HealthNow then
self.HealthNow = ent:Health()
end
end
end

function ENT:FallBack(ent)
if IsValid(ent) then
local GetAnyEnemy = ent:GetEnemy()
if GetAnyEnemy and ent:Visible(GetAnyEnemy) and ent:GetPos():Distance(GetAnyEnemy:GetPos()) < 120 and !ent:IsCurrentSchedule( SCHED_FORCED_GO_RUN ) then
ent:SetLastPosition(GetAnyEnemy:GetPos() + GetAnyEnemy:GetForward() * math.random(300,400))
ent:SetSchedule(SCHED_FORCED_GO_RUN)
end
end
end

function ENT:MedicCall(ent)
if IsValid(ent) then
if ent:Health() > 0 and ent:Health() <= ent:GetMaxHealth() * .7 and self.Needmeds == true then
ent:EmitSound("CallMedic.CUP")
self.Needmeds = false
timer.Simple(math.random(0.001,0.001), function()
self.Needmeds = true
end)
end
end
end

function ENT:Relations(ent)
if IsValid(ent) then
for _, enemy in pairs( ents.GetAll() ) do
if ( C_RELATIONS:GetInt() == 1 ) then
self.Format2 = false
if enemy:IsPlayer() then
ent:AddEntityRelationship( enemy, D_LI, 99 )
ent.LikeFilzoPlayers = true
end
end
if ( C_RELATIONS:GetInt() == 0 ) then
if enemy:IsPlayer() then
if self.Format2 == false then
self.Format2 = true
ent:ClearEnemyMemory()
ent:AddEntityRelationship( enemy, D_HT, 99 )
ent.LikeFilzoPlayers = nil
end
end
end
end
end
end

C_RELATIONS = CreateConVar( "cup_companion", "0", FCVAR_CLIENTDLL, "Companion mode." )
C_MEDCALL = CreateConVar( "cup_call_medic", "1", FCVAR_CLIENTDLL, "" )
function ENT:InvasionChase(ent)
if IsValid(ent) then
local GetAnyEnemy = ent:GetEnemy()
if GetAnyEnemy and (not(ent:Visible(GetAnyEnemy))) and !ent:IsCurrentSchedule( SCHED_CHASE_ENEMY ) then
ent:SetSchedule(SCHED_CHASE_ENEMY)
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

function ENT:DoIdleAnimation(RestrictNumber,OverrideWander)
	if self.IsVJBaseSNPC_Tank == true then return end
	if /*self.VJ_PlayingSequence == true or*/ self.VJ_IsBeingControlled == true /*or self.FollowingPlayer == true*/ or self.PlayingAttackAnimation == true or self.Dead == true or (self.NextIdleTime > CurTime()) or (self.CurrentSchedule != nil && self.CurrentSchedule.Name == "vj_act_resetenemy") then return end
	-- 0 = Random | 1 = Wander | 2 = Idle Stand /\ OverrideWander = Wander no matter what
	RestrictNumber = RestrictNumber or 0
	OverrideWander = OverrideWander or false
	if (self.MovementType == VJ_MOVETYPE_STATIONARY) or (self.LastHiddenZone_CanWander == false) or (self.NextWanderTime > CurTime()) then RestrictNumber = 2 end
	if OverrideWander == false && self.DisableWandering == true && (RestrictNumber == 1 or RestrictNumber == 0) then
		RestrictNumber = 2
	end
	if RestrictNumber == 0 then -- kharen: gam ge bidedi, gam ge gena
		if math.random(1,3) == 1 then
			/*self:VJ_SetSchedule(VJ_PICKRANDOMTABLE(self.IdleSchedule_Wander))*/ self:VJ_TASK_IDLE_STAND()
		end
	elseif RestrictNumber == 1 then -- bideder

	elseif RestrictNumber == 2 then -- deghed getser
		self:VJ_TASK_IDLE_STAND()
	end
	if RestrictNumber != 2 then
		self.NextWanderTime = CurTime() + math.Rand(3,6) // self.NextIdleTime
	end
end


/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/