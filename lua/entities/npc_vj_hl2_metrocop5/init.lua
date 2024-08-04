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

ENT.Model = {"models/combine_soldier_prisonguard.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 125
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_COMBINE"} 

ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?
	ENT.FootStepSoundLevel = 60
ENT.WeaponSpread = 0.8
ENT.BloodColor = "Red" 
ENT.SightDistance = 7000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 1 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.ShootDistance = 2500
ENT.MeleeAttackDamage = 30
ENT.SquadName = "metrocopg" -- Squad name, console error will happen if two groups that are enemy and try to squad!
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

C_CUPWEAPON = CreateConVar( "cup_weapon", "none", FCVAR_CLIENTDLL, "Give them your own weapon." )
C_CUPPATROLLING = CreateConVar( "cup_patrolling_mode", "1", FCVAR_CLIENTDLL, "Chose patrol type. 1 = Normal / 2 = Patrol Points / 0 = None." )
C_RELATIONS = CreateConVar( "cup_companion", "0", FCVAR_CLIENTDLL, "Companion mode." )
C_RAPPELTYPE = CreateConVar( "cup_rappel_type", "0", FCVAR_CLIENTDLL, "Dont on spawn (0), rappel on spawn (1), rappel when get an enemy (2)." )
C_FLARES = CreateConVar( "cup_flares", "1", FCVAR_CLIENTDLL, "" )
C_MEDCALL = CreateConVar( "cup_call_medic", "1", FCVAR_CLIENTDLL, "" )
C_RELOADCALL = CreateConVar( "cup_call_reload", "1", FCVAR_CLIENTDLL, "" )
	-- ====== Sound File Paths ====== --
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




function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 6
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	
	local ent = ents.Create( "npc_vj_hl2_Metrocop5" )
	ent:SetKeyValue( "disableshadows", "1" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( self.Spawn_angles )
	ent:SetModel( "" )
	ent:SetColor( 255, 255, 255, 0 )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

NS1 = WEAPON_PROFICIENCY_PERFECT
NS2 = WEAPON_PROFICIENCY_PERFECT
NS3 = WEAPON_PROFICIENCY_PERFECT
NS4 = WEAPON_PROFICIENCY_PERFECT
NS5 = WEAPON_PROFICIENCY_PERFECT

local Skill = {}
	Skill[1] = (NS1)
	Skill[2] = (NS2)
	Skill[3] = (NS3)
	Skill[4] = (NS4)
	Skill[5] = (NS5)

Weap1 = "weapon_vj_smg1_hl2"
Weap2 = "weapon_vj_smg1_hl2"
Weap3 = "weapon_vj_smg1_hl2"

local Weapon = {}
	Weapon[1] = (Weap1)
	Weapon[2] = (Weap2)
	Weapon[3] = (Weap3)
	
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
if IsValid( self ) then

	self:Relations(self)
	
	self:Drowning(self)

	self:ShieldUse(self)

	
	self:FallDamage(self)
	
	self:DamageEffects(self)

	self:FallBack(self)

	self:GetReady(self)
	

	
	if IsValid(self) and IsValid(self:GetEnemy()) then
	PushHimBack = self:GetEnemy()
	DistanceToPush = (PushHimBack:GetPos()-self:GetPos()):Length()
	if DistanceToPush <= 60 then
	--if IsValid(self) and self:GetActiveWeapon():GetClass()=="weapon_stunstick" then return end
	self:PushIt(PushHimBack)
	end
	end
	end
	if !IsValid( self ) or self:Health() <= 0 then
	self:Remove()
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
self.Weapon_FiringDistanceFar = self.ShootDistance
	self:SetKeyValue( "additionalequipment", Weapon[math.random(1,3)] )
	self.DontHaveEnemy = 0
	self.HaveEnemy = 0
	self.FallDamageHeight = 12 * 16
	self:SetParent(self)



end
--------------------------------------------------------------------------------------

function ENT:FallDamage(ent)
if IsValid(ent) and self.EnableFall == true then
if ent:IsOnGround() and self.FallDeath == true then


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
self.DrownNow = 1
ent:PlayScene("scenes/drown2.vcd")
ent:SetSchedule(SCHED_NPC_FREEZE)
timer.Simple(3, function()
ent:Fire("becomeragdoll")
end)
end
end
end
ENT.HealthNow = 0
function ENT:DamageEffects(ent)
if IsValid(ent) then
if ent:Health() < self.HealthNow then
if math.random(1,6)==3 then
ent:SetSchedule( SCHED_SMALL_FLINCH )
ent:EmitSound( "cup_sounds/armor" .. math.random(1,3) .. ".wav", 75, 100 )
end
self.spar = ents.Create( "env_spark" )
self.spar:SetPos( ent:GetPos() + Vector(0,0,45) )
self.spar:SetParent( ent )
self.spar:SetKeyValue( "Magnitude", "1" )
self.spar:SetKeyValue( "TrailLength", "1" )
self.spar:SetKeyValue( "spawnflags", "128" )
self.spar:Fire("SparkOnce")
self.spar:Fire("kill",self.spar,0.1)
self.HealthNow = ent:Health()
end
if ent:Health() > self.HealthNow then
self.HealthNow = ent:Health()
end
end
end

function ENT:FallBack(ent)
if IsValid(ent) then
if IsValid(ent:GetActiveWeapon()) then
if ent:GetActiveWeapon():GetClass()=="weapon_stunstick" or ent:GetActiveWeapon():GetClass()=="weapon_crowbar" then return end
end
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
timer.Simple(math.random(8,14), function()
self.Needmeds = true
end)
end
end
end

function ENT:Patroll(ent)
if IsValid(ent) then
if ent:GetEnemy() then
self.Patrolling = false
else
self.Patrolling = true
end
if(self.Patrolling == true and ent.CommandedNPC == false and ent.Commanded == false and self.Spawning == false and self.CanWalk == true and !ent:IsCurrentSchedule( SCHED_IDLE_WANDER )) then
ent:SetSchedule(SCHED_IDLE_WANDER)
ent:Fire("StopPatrolling")
end
end
end

function ENT:PatrollNew(ent)
if IsValid(ent) then
if (table.Count(self.PatrolNodesMemory, PatrolNode)) >= (table.Count(self.PatrolNodesMax, PatrolNode)) then
table.Empty(self.PatrolNodesMemory)
end
if ent:GetEnemy() then
self.Patrolling = false
if self.GetHim == false then
self.GetHim = true
ent:ClearSchedule()
ent:StopMoving()
end
else
self.Patrolling = true
self.GetHim = false
end
for _, PatrolNode in pairs( ents.FindByClass( "cup_patrol_node" ) ) do
if !table.HasValue(self.PatrolNodesMax, PatrolNode) then
table.insert(self.PatrolNodesMax, PatrolNode)
end
if ent:GetPos():Distance(PatrolNode:GetPos()) < 80 then
if self.WaitHereAndCheck > CurTime() then return end
if !table.HasValue(self.PatrolNodesMemory, PatrolNode) then
self.WaitHereAndCheck = CurTime() + math.random(6,12)
table.insert(self.PatrolNodesMemory, PatrolNode)
end
end
end
local RandomNode = table.Random(self.PatrolNodesMax)
if (table.Count(self.PatrolNodesMax, PatrolNode) <= 0) then
table.Empty(self.PatrolNodesMax)
end
if IsValid(RandomNode) and (!table.HasValue(self.PatrolNodesMemory, PatrolNode) and self.Patrolling == true and ent.CommandedNPC == false and ent.Commanded == false and self.Spawning == false and self.CanWalk == true and !ent:IsCurrentSchedule( SCHED_FORCED_GO )) then
ent:SetSaveValue( "m_vecLastPosition", RandomNode:GetPos() )
ent:SetSchedule( SCHED_FORCED_GO )
ent:Fire("StopPatrolling")
end
end
end


function ENT:ShieldUse(ent)

if self.ShieldDeploy == nil then
self.ShieldDeploy = true
local deploypos = ent:GetPos() + ent:GetForward() * 35 + ent:GetUp() * 15 + ent:GetRight() * 3
local deploypos2 = ent:GetPos() + ent:GetForward() * 13 + ent:GetUp() * 10 + ent:GetRight() * -15
self.shield = ents.Create("cup_shield2")
self.shield:SetPos( deploypos )
self.shield:SetParent(ent, 3)
self.shield:SetAngles( ent:GetAngles() + Angle(20,200,30) )
self.shield:SetCollisionGroup(COLLISION_GROUP_WEAPON)
self.shield:SetOwner( ent )
self.shield:Spawn()
self.shield:Activate()

self.shield3 = ents.Create("prop_physics")
self.shield3:SetModel("models/weapons/ballisticshield_mod.mdl")
self.shield3:SetPos( deploypos2 )
self.shield3:SetParent(ent, 3)
self.shield3:SetNoDraw( true )
self.shield3:SetAngles( ent:GetAngles() + Angle(10,200,10) )
self.shield3:SetCollisionGroup(COLLISION_GROUP_WEAPON)
self.shield3:SetOwner( ent )
self.shield3:Spawn()
self.shield3:Activate()
end
if IsValid(ent) then
if !IsValid(self.shield) then
if self.ShieldTakeDown == nil or self.ShieldTakeDown == false then
self.ShieldTakeDown = true

end
if IsValid(self.shield3) then
self.shield3:Remove()
end
end
ActiveShield = ent:GetEnemy()
if IsValid(ActiveShield) and IsValid(self.shield) then
if self.HaveEnemy == 0 then
self.HaveEnemy = 1
self.DontHaveEnemy = 0
ent:StopMoving()
ent:PlayScene("scenes/draw_shield.vcd")
timer.Simple(0.6, function()
if IsValid(self.shield) and IsValid(self.shield3) then
self.shield:SetNoDraw( false )
self.shield3:SetNoDraw( true )
self.shield:SetModel("models/weapons/ballisticshield_mod.mdl")

end
end)
end
else
if self.DontHaveEnemy == 0 then
self.HaveEnemy = 0
self.DontHaveEnemy = 1
ent:StopMoving()
ent:PlayScene("scenes/hide_shield.vcd")
timer.Simple(0.6, function()
if IsValid(self.shield) and IsValid(self.shield3) then
self.shield:SetNoDraw( true )
self.shield3:SetNoDraw( false )
self.shield3:SetModel("models/weapons/ballisticshield_mod.mdl")

end
end)
end
end
end
end



function ENT:GetReady(ent)
if IsValid(ent) then
Prepare = ent:GetEnemy()
if ( IsValid( Prepare ) and ent:Visible( Prepare ) and ent:GetMovementActivity() != ACT_WALK_AIM ) then
ent:SetMovementActivity( ACT_WALK_AIM )
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

function ENT:ChaseEnemy(ent)
if IsValid(ent) then
local GetAnyEnemy = ent:GetEnemy()
if GetAnyEnemy and self.OnGroundNow == true and ent:GetPos():Distance(GetAnyEnemy:GetPos()) > 250 and !ent:IsCurrentSchedule( SCHED_FORCED_GO_RUN ) then
Go1 = GetAnyEnemy:GetForward() * math.random(300,450)
Go2 = GetAnyEnemy:GetRight() * math.random(300,450)
Go3 = GetAnyEnemy:GetForward() * math.random(-450,-300)
Go4 = GetAnyEnemy:GetRight() * math.random(-450,-300)
local Place = {}
Place[1] = (Go1)
Place[2] = (Go2)
Place[3] = (Go3)
Place[4] = (Go4)
ent:SetLastPosition(GetAnyEnemy:GetPos() + Place[math.random(1,4)])
ent:SetSchedule(SCHED_FORCED_GO_RUN)
end
end
end

function ENT:ReloadCall(ent)
if IsValid(ent) then
if (ent:IsCurrentSchedule( SCHED_RELOAD ) or ent:IsCurrentSchedule( SCHED_HIDE_AND_RELOAD )) and (self.Imreload == true or self.Imreload == nil) then
self.Imreload = false
if math.random(1,2)==2 then
ent:EmitSound("ReloadingSoldierMP.CUP")
end
timer.Simple(3, function()
self.Imreload = true
end)
end
end
end

function ENT:RappelNow(ent)
if IsValid(ent) then
local StartRappel = ent:GetEnemy()
if IsValid(StartRappel) and self.RappelLoop == nil then
self.RappelLoop = true
self.Spawning = false
ent:Fire("BeginRappel")
ent:EmitSound("ZipLineSlide.CUP")
end
end
end


function ENT:PushIt(ent)
if IsValid(ent) then
if IsValid(self:GetActiveWeapon()) then
if self:GetActiveWeapon():GetClass()=="weapon_stunstick" or self:GetActiveWeapon():GetClass()=="weapon_crowbar" then return end
end
if(self.Push == false)then return end
	self.Push = false
	self:StopMoving()
	self:PlayScene("scenes/pushback" .. math.random(1,4) .. ".vcd")
	timer.Simple(0.6, function()
	if IsValid(self) and !IsValid(self:GetEnemy()) then
	self.Push = true
	end
	if IsValid(self) and IsValid(self:GetEnemy()) then
	if IsValid(ent) and IsValid(self) then
	local PushHimBack2 = self:GetEnemy()
	local DistanceToPush2 = (PushHimBack2:GetPos()-self:GetPos()):Length()
	if DistanceToPush2 > 60 and IsValid(PushHimBack2) then 
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, 100)
	timer.Simple(1, function()
	self.Push = true
	end)
	return end
	if ent:IsNPC() then
	ent:SetVelocity(self:GetForward() * 2000 + Vector(0,0,5))
	ent:SetSchedule(SCHED_BIG_FLINCH)
	elseif ent:IsPlayer() then
	ent:SetVelocity(self:GetForward() * 600 + Vector(0,0,5))
	ent:ViewPunch(Angle( math.random(-10,-20),math.random(-10,10),math.random(-10,10) )) 
	end
	if IsValid(self:GetActiveWeapon()) then
	ent:TakeDamage(math.random(8,16), self, self.Weapon)
	else
	ent:TakeDamage(math.random(10,40), self, self)
	end
	ent:EmitSound("physics/body/body_medium_impact_hard" .. math.random(1,6) .. ".wav", 75, math.random(90,110))
	timer.Simple(1, function()
	self.Push = true
	end)
	end
	end
	end)
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