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
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/gman2.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 9850
ENT.HullType = HULL_HUMAN
ENT.PlayerFriendly = true
---------------------------------------------------------------------------------------------------------------------------------------------
	-- ====== Blood-Related Variables ====== --
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)
ENT.BloodColor = "Oil" -- The blood type, this will detemine what it should use (decal, particle, etc.)
ENT.Immune_Dissolve = true -- Immune to Dissolving | Example: Combine Ball
ENT.VJ_NPC_Class = {"CLASS_CITIZEN","CLASS_AMERICA_FRIENDLY","CIVILAN"} 
ENT.LastSeenEnemyTimeUntilReset = 160
ENT.SightDistance = 99000 -- How far it can see
ENT.SightAngle = 180
	-- Melee Attack ---------------------------------------------------------------------------------------------------------------------------------------------
ENT.MeleeAttackDamageType = DMG_CRUSH
ENT.AnimTbl_IdleStand = {ACT_IDLE} -- The idle animation when AI is enabled
ENT.AnimTbl_Walk = {ACT_DOD_PRONE_AIM_MP44} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_DOD_PRONE_AIM_MP44} -- Set the running animations | Put multiple to let the base pick a random animation when it moves	
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 1 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextMoveAfterFlinchTime = "LetBaseDecide" -- How much time until it can move, attack, etc. | Use this for schedules or else the base will set the time 0.6 if it sees it's a schedule!
ENT.NextFlinchTime = 5 -- How much time until it can flinch again?
ENT.FlinchAnimation_UseSchedule = false -- false = SCHED_ | true = ACT_
ENT.FlinchAnimationDecreaseLengthAmount = 0 -- This will decrease the time it can move, attack, etc. | Use it to fix animation pauses after it finished the flinch animation
ENT.HasHitGroupFlinching = true -- It will flinch when hit in certain hitgroups | It can also have certain animations to play in certain hitgroups
ENT.HitGroupFlinching_DefaultWhenNotHit = false -- If it uses hitgroup flinching, should it do the regular flinch if it doesn't hit any of the specified hitgroups?
ENT.HitGroupFlinching_Values = {{HitGroup = {3}, IsSchedule = false, Animation = {ACT_FLINCH_STOMACH}}, {HitGroup = {1}, IsSchedule = false, Animation = {ACT_FLINCH_HEAD}}, {HitGroup = {2}, IsSchedule = false, Animation = {ACT_FLINCH_CHEST}}, {HitGroup = {4}, IsSchedule = false, Animation = {ACT_FLINCH_LEFTARM}}, {HitGroup = {5}, IsSchedule = false, Animation = {ACT_FLINCH_RIGHTARM}}, {HitGroup = {6}, IsSchedule = false, Animation = {ACT_FLINCH_LEFTLEG}}, {HitGroup = {7}, IsSchedule = false, Animation = {ACT_FLINCH_RIGHTLEG}}} -- if "IsSchedule" is set to true, "Animation" needs to be a schedule


ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = math.random(9335,9350)
ENT.MeleeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.MeleeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the melee attack animation?
ENT.MeleeAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.MeleeAttackDistance = 59 -- How close does it have to be until it attacks?
ENT.MeleeAttackAngleRadius = 200 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.MeleeAttackDamageDistance = 102 -- How far does the damage go?
ENT.MeleeAttackDamageAngleRadius = 200 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.50 -- How much time until it can use any attack again? | Counted in Seconds
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 32 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 45 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 15 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = true -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 1 -- How much chance there is that the enemy will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 5 -- How many reps?

-- ====== Other Variables ====== --
ENT.RunAwayOnUnknownDamage = true -- Should run away on damage


ENT.HasRangeAttack = false -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "wolf_freos" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {"contr_attack"} -- Range Attack Animations
-- ====== Distance Variables ====== --
ENT.TimeUntilRangeAttackProjectileRelease = 1.2 -- How much time until the projectile code is ran?
ENT.RangeAttackPos_Up = 47
ENT.RangeDistance = 10520 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 40 -- How close does it have to be until it uses melee?
ENT.NextAnyAttackTime_Range = 0.1
ENT.CanWander = false
ENT.CanMutate = false
ENT.CONTROLER_PsyAttackTimer = 0
	-- ====== Animation Variables ====== --
ENT.NEXT = false
ENT.NEXT2 = false
ENT.NEXT3 = false


	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play

ENT.DeathSoundLevel = 100
ENT.IdleSoundPitch1 = 100
ENT.IdleSoundPitch2 = 100
ENT.IdleVolume = 100
ENT.DeathSoundPitch1 = 100
ENT.DeathSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

		for k, v in pairs( ents.FindInSphere( self:GetPos( ), 300 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "vj_combine" then
		self.PlayerFriendly = false	
end
end
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 300 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "vj_combine" then
		self.PlayerFriendly = false
end
end
end
if self.NEXT2 == true then
self:StopMoving()
end
	self:RemoveAllDecals()
	self:DrawShadow(true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.ATTACK = false
ENT.ATTACKT = 0

function ENT:CustomOnThink_AIEnabled()
	if self:GetEnemy() != nil && self.NEXT == false then
self:StopParticles()
	if self.ATTACK == false then
	if CurTime() > self.ATTACKT then
	local Poser = self:GetEnemy()
	self.ATTACK = true
timer.Simple(0.2,function() if IsValid(self) then self:SetPos(self:GetPos() + self:GetForward()*9999) 
end end)		
	timer.Simple(2,function() if IsValid(self) && IsValid(Poser) then
	self:SetPos(Poser:GetPos() + Poser:GetForward()*math.random(75,85))
	self.ATTACK = false
	self.ATTACKT = CurTime() + math.random(3,4)
	end end)
end
end
end	
end






---------------------------------------------------------------------------------------------------------------------------------------------

/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/