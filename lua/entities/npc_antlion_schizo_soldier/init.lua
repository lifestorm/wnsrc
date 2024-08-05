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
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/antlion.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 30
ENT.HullType = HULL_HUMAN
ENT.SightDistance = 10000000000
ENT.SightAngle = 180
ENT.MaxJumpLegalDistance = VJ_Set(1000,1000)
ENT.AllowMovementJumping = true
ENT.JumpVars = {
	MaxRise = 440, -- How high it can jump up ((S -> A) AND (S -> E))
	MaxDrop = 760, -- How low it can jump down (E -> S)
	MaxDistance = 1024, -- Maximum distance between Start and End
}
ENT.CanInvestigate = true
ENT.InvestigateSoundDistance = 100000000
ENT.NoChaseAfterCertainRange = false
ENT.FindEnemy_UseSphere = true
ENT.FindEnemy_CanSeeThroughWalls = true
ENT.TimeUntilEnemyLost = 60

ENT.AttackProps = false
ENT.PushProps = false
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ANTLION"} -- NPCs with the same class with be allied to each other
ENT.CustomBlood_Particle = {"blood_impact_yellow_01"} -- Particles to spawn when it's damaged
ENT.CustomBlood_Decal = {"yellowblood"} -- Decals to spawn when it's damaged
ENT.CustomBlood_Pool = {"vj_bleedout_yellow"} -- Blood pool types after it dies
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"pounce1","pounce2"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 125 -- How far does the damage go?
ENT.MeleeAttackDamage = 5
ENT.NextAnyAttackTime_Melee = 0.4 -- How much time until it can use a attack again? | Counted in SecondsENT.MeleeAttackDamage = 15
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = false -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.FootStepTimeRun = 0.25 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.AnimTbl_CallForHelp = {"distract_arrived"} -- Call For Help Animations
ENT.Immune_AcidPoisonRadiation = false -- Immune to Acid, Poison and Radiation

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {"Jump_start"} -- Melee Attack Animations
ENT.LeapAttackDamage = 10
ENT.LeapAttackAnimationFaceEnemy = false
ENT.LeapAttackDamageType = DMG_SLASH
ENT.NextStrafeTime = CurTime()

ENT.HasLeapAttackJumpSound = true -- If set to false, it won't play any sounds when it leaps at the enemy while leap attacking

ENT.HasDeathRagdoll = false

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/antlion/foot1.wav","npc/antlion/foot2.wav","npc/antlion/foot3.wav","npc/antlion/foot4.wav"}
ENT.SoundTbl_Idle = {"npc/antlion/idle1.wav","npc/antlion/idle2.wav","npc/antlion/idle3.wav","npc/antlion/idle4.wav","npc/antlion/idle5.wav"}
ENT.SoundTbl_Alert = {"npc/antlion/attack_double1.wav","npc/antlion/attack_double2.wav","npc/antlion/attack_double3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/antlion/attack_single1.wav","npc/antlion/attack_single2.wav","npc/antlion/attack_single3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_alienswarm/drone/swipe01.wav","vj_alienswarm/drone/swipe02.wav","vj_alienswarm/drone/swipe03.wav"}
ENT.SoundTbl_LeapAttackJump = {"npc/antlion/fly1.wav"}
ENT.SoundTbl_LeapAttackDamage = {"npc/antlion/land1.wav"}
ENT.SoundTbl_LeapAttackDamageMiss = {}
ENT.SoundTbl_Pain = {"npc/antlion/pain1.wav","npc/antlion/pain2.wav"}
ENT.SoundTbl_Death = {"npc/antlion/pain1.wav","npc/antlion/pain2.wav"}

ENT.FootStepSoundLevel = 70
ENT.IdleSoundLevel = 100
ENT.LeapAttackJumpSoundLevel = 125
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 90
ENT.ThinkNumber = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetCollisionBounds(Vector(15, 15, 70), Vector(-15, -15, 0))
    self:SetSkin(math.random(0,3))
    self:SetNoDraw(true)
    timer.Simple(0.05,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("digout",true,false,true) end end)

    VJ_EmitSound(self, {"npc/antlion/digup1.wav"}, 100, math.random(100,100))

    timer.Simple(0.2, function()
        if (IsValid(self)) then
            self:SetNoDraw(false) end
        end
    )

    self.targetsUpdateTimerID = "updateJumpTargets_"..math.random(1000, 9999)
    timer.Create(self.targetsUpdateTimerID, 0.25, 0, function ()
        if (self and IsValid(self)) then
            self:updateJumpTarget()
        end
    end)
end

function ENT:CustomOnRemove()
    timer.Remove(self.targetsUpdateTimerID)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnCallForHelp()
	timer.Simple(1,function()
		if IsValid(self) then
			ParticleEffectAttach("antlion_gib_02_gas",PATTACH_POINT_FOLLOW,self,6)
			ParticleEffectAttach("antlion_gib_02_floaters",PATTACH_POINT_FOLLOW,self,6)
		end
	end)
end
------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
    local enemy = self:GetEnemy()
    if (!enemy or !IsValid(enemy)) then
        return
    end

    local enemyDistanceSqr = self:GetPos():DistToSqr(enemy:GetPos())
    if (enemyDistanceSqr > 0 && enemyDistanceSqr < 10000) then
        local randAttackClose = math.random(1, 3)
        self.MeleeAttackDistance = 45
        self.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
        self.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
        self.MeleeAttackDamageDistance = 150
        self.NextAnyAttackTime_Melee = 0.4
        self.MeleeAttackDamage = 5
        self.MeleeAttackDamageType = DMG_SLASH    
        self.SoundTbl_BeforeMeleeAttack = {
            "npc/antlion/attack_single1.wav",
            "npc/antlion/attack_single2.wav",
            "npc/antlion/attack_single3.wav"
        }
        if (randAttackClose == 1) then
            self.AnimTbl_MeleeAttack = {"pounce","pounce2"} -- Quick slash --
        elseif randAttackClose == 2 then
            self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Charged slash --
			self.MeleeAttackDamage = 4
        elseif (randAttackClose == 3) then 
            self.AnimTbl_MeleeAttack = {"Attack6","Attack2"} -- Double slash --
            self.MeleeAttackDamage = 6
            self.SoundTbl_BeforeMeleeAttack = {
                "npc/antlion/attack_double1.wav",
                "npc/antlion/attack_double2.wav",
                "npc/antlion/attack_double3.wav"
            }
        end
    end
end
------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(TheHitEntity)
if TheHitEntity:IsNPC() && TheHitEntity:GetClass() == "npc_combine_s" then
TheHitEntity:TakeDamage(60,self,self)
ParticleEffect("blood_impact_red_01",TheHitEntity:GetPos(),Angle(0,0,0),nil)
elseif TheHitEntity:IsNPC() then
TheHitEntity:TakeDamage(15,self,self)
end
end
------------------------------------------------------------------------
function ENT:CustomOnLeapAttack()
timer.Simple(0,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("jump_glide",true,1.1,false)
VJ_EmitSound(self,"vj_as_egg/pain1.wav",80,80)
end end)
timer.Simple(0.6,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY("jump_glide",true,1.1,false)
end end)
end

function ENT:CustomOnLeapAttack_AfterChecks(hitEnt)
	VJ_STOPSOUND(self.CurrentLeapAttackJumpSound)
end

function ENT:CustomOnLeapAttack_Miss()
	timer.Simple( 1, function() VJ_STOPSOUND(self.CurrentLeapAttackJumpSound) end )
	timer.Simple( 1, function() self:PlaySoundSystem("LeapAttackDamage", nil, VJ_EmitSound) end )
end

function ENT:CustomOnAcceptInput(event,activator,caller,data)
	--//Wings\\--
	if event == "OpenWings" then
		WingSFX:Stop()
		WingSFX = CreateSound(self, "npc/antlion/fly1.wav")
		WingSFX:SetSoundLevel(70)
		WingSFX:Play()
	
	elseif event == "CloseWings" then
		WingSFX:Stop()
	end
end
-------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
ParticleEffect("blood_zombie_split_spray",self:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:updateJumpTarget()
    local enemy = self:GetEnemy()
    if (!enemy or !IsValid(enemy)) then
        return
    end

    local enemyDistanceSqr = self:GetPos():DistToSqr(enemy:GetPos())
    self.LeapAttackDamageDistance = 100
    self.LeapToMeleeDistance = math.random(100, 300)
    if (enemyDistanceSqr > 2250000) then -- 1k hmr units = approx 25 meters
        self.LeapDistance = 1500
        self.LeapAttackVelocityForward = 450
        self.LeapAttackVelocityUp = 550
    elseif (enemyDistanceSqr > 202500 and enemyDistanceSqr < 2250000) then -- between aprox 12 and 25 meters
        self.LeapDistance = 1000
        self.LeapAttackVelocityForward = 500
        self.LeapAttackVelocityUp = 400
    elseif (enemyDistanceSqr < 202500) then -- 450 hmr units = approx 12 meters
        self.LeapDistance = 450
        self.LeapAttackVelocityForward = 550
        self.LeapAttackVelocityUp = 240
    end
end


------------------------------------------------------------------------
function ENT:VJ_TASK_GOTO_TARGET(MoveType,CustomCode)
	MoveType = MoveType or "TASK_RUN_PATH"
	local vsched = ai_vj_schedule.New("vj_goto_target")
	vsched:EngTask("TASK_GET_PATH_TO_ENEMY_LOS", 0)
	vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
	vsched:EngTask("TASK_FACE_TARGET", 1)
	vsched:EngTask("TASK_FIND_COVER_FROM_ENEMY")
	vsched.IsMovingTask = true
	if MoveType == "TASK_RUN_PATH" then self:SetMovementActivity(VJ_PICKRANDOMTABLE(self.AnimTbl_Run)) vsched.IsMovingTask_Run = true else self:SetMovementActivity(VJ_PICKRANDOMTABLE(self.AnimTbl_Walk)) vsched.IsMovingTask_Walk = true end
	if (CustomCode) then CustomCode(vsched) end
	self:StartSchedule(vsched)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo,hitgroup)
	if dmginfo:GetDamageForce():Length() > 7500 then
	self.HasDeathRagdoll = false
	ParticleEffect("antliongib",self:GetPos(),Angle(0,0,0),nil)
	ParticleEffect("blood_zombie_split_spray",self:GetPos(),Angle(0,0,0),nil)
	ParticleEffect("blood_zombie_split",self:GetPos(),Angle(0,0,0),nil)
	end
end
------------------------------------------------------------------------
function ENT:StrafingMechanics()
local canstrafe = self:VJ_CheckAllFourSides(120)
if canstrafe.Right == true and canstrafe.Left == true then
local randstrafe = math.random(1,2)
if randstrafe == 1 then self:VJ_ACT_PLAYACTIVITY(ACT_TURN_LEFT,true,1.3,false) else self:VJ_ACT_PLAYACTIVITY(ACT_TURN_RIGHT,true,1.3,false) end
elseif canstrafe.Left == true and canstrafe.Right == false then
self:VJ_ACT_PLAYACTIVITY(ACT_TURN_LEFT,true,1.3,false)
elseif canstrafe.Right == true and canstrafe.Left == false then
self:VJ_ACT_PLAYACTIVITY(ACT_TURN_RIGHT,true,1.3,false)
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	if dmginfo:IsDamageType( DMG_PHYSGUN ) then
		self:VJ_ACT_PLAYACTIVITY("flip1",true,4,false)
		self.MovementType = VJ_MOVETYPE_STATIONARY
		self.CanTurnWhileStationary = false
		self.HasMeleeAttack = false
		timer.Simple(5,function() if IsValid(self) then
		self.HasMeleeAttack = true
		self.MovementType = VJ_MOVETYPE_GROUND
		end
	end)
end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/