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
ENT.Model = {"models/ez2/npc/gonome.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 650
ENT.HullType = HULL_WIDE_HUMAN
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.HasDeathRagdoll = true -- If set to false, it will not spawn the regular ragdoll of the SNPC
ENT.HasDeathAnimation = false
ENT.DeathAnimationChance = 2
ENT.DeathAnimationTime = 1.7
ENT.AnimTbl_IdleStand = {"ACT_IDLE","Idle1","Idle2"}
ENT.AnimTble_Run = {"ACT_RUN","ACT_RUN_2","ACT_RUN_3"}
ENT.AnimTble_Walk = {"ACT_WALK","ACT_WALK_2","Walk_New"}
ENT.MaxJumpLegalDistance = VJ_Set(1000,2500)
ENT.TimeUntilEnemyLost = 99999999999999999 
ENT.CanEat = true
ENT.CallForHelpDistance = 12000
ENT.CallForBackUpOnDamageDistance = 12800 -- How far away does the call for help go?
ENT.CallForBackUpOnDamageLimit = 0
ENT.HasHitGroupFlinching = true 
ENT.HitGroupFlinching_DefaultWhenNotHit = true
ENT.HitGroupFlinching_Values = {
{HitGroup = {HITGROUP_HEAD}, Animation = {"big_flinch2","vjges_g_head_flinch"}}, 
{HitGroup = {HITGROUP_STOMACH}, Animation = {"big_flinch2","vjges_g_chest_flinch","vjges_g_small_flinch","vjges_g_big_flinch"}}, 
{HitGroup = {HITGROUP_CHEST}, Animation = {"big_flinch2","vjges_g_chest_flinch","vjges_g_small_flinch","vjges_g_big_flinch"}}, 
{HitGroup = {HITGROUP_LEFTARM}, Animation = {"ACT_SMALL_FLINCH","vjges_g_small_flinch","vjges_g_big_flinch"}}, 
{HitGroup = {HITGROUP_RIGHTARM}, Animation = {"ACT_SMALL_FLINCH","vjges_g_small_flinch","vjges_g_big_flinch"}}, 
{HitGroup = {HITGROUP_LEFTLEG}, Animation = {"ACT_SMALL_FLINCH","vjges_g_small_flinch","vjges_g_big_flinch"}}, 
{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"ACT_SMALL_FLINCH","vjges_g_small_flinch","vjges_g_big_flinch"}}}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.InvestigateSoundDistance = 200 -- How far away can the SNPC hear sounds? | This number is timed by the calculated volume of the detectable sound.
ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation
ENT.GibOnDeathDamagesTable = {"UseDefault"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.9 -- Next foot step sound when it is walking
ENT.Immune_AcidPoisonRadiation = true -- Makes the SNPC not get damage from Acid, posion, radiation
ENT.HasBloodParticle = true -- Does it spawn a particle when damaged?
ENT.HasBloodDecal = true -- Does it spawn a decal when damaged?
ENT.HasBloodPool = true -- Does it have a blood pool?
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle, etc.)

ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 70 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 90 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 40 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 60 -- How far it will push you up | Second in math.random
ENT.MeleeAttackKnockBack_Right1 = math.random(12,30) -- How far it will push you right | First in math.random
ENT.MeleeAttackKnockBack_Right2 = math.random(8,24) -- How far it will push you right | Second in math.random
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.MeleeAttackWorldShakeOnMiss = true -- Should it shake the world when it misses during melee attack?
ENT.MeleeAttackWorldShakeOnMissAmplitude = 8 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.MeleeAttackBleedEnemy = true -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 3 -- Chance that the enemy bleeds | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 4.5 -- How much damage per repetition
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next repetition?
ENT.MeleeAttackBleedEnemyReps = 5 -- How many repetitions?
ENT.SlowPlayerOnMeleeAttack = true -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"vjges_g_attack3"} -- Range Attack Animations
ENT.RangeAttackAnimationStopMovement = false
ENT.RangeAttackEntityToSpawn = "obj_vj_gonome_spit" -- The entity that is spawned when range attacking
ENT.RangeDistance = 35000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 500 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "0" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 1.7 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.PushProps = true -- Should it push props when trying to move?
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemy_Postures = "Standing" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 2000 -- How close does it have to be until it starts to face the enemy?
ENT.NoChaseAfterCertainRange = false -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.ConstantlyFaceEnemy = true -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_Postures = "Moving" -- "Both" = Moving or standing | "Moving" = Only when moving | "Standing" = Only when standing
ENT.ConstantlyFaceEnemyDistance = 500 -- How close does it have to be until it starts to face the enemy?

ENT.HasLeapAttack = true
ENT.NextLeapAttackTime = 10
ENT.LeapAttackDamage = 10
ENT.AnimTbl_LeapAttack = {"Jump1"} -- Melee Attack Animations
ENT.LeapDistance = 2000 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 900 -- How close does it have to be until it uses melee?
ENT.DisableLeapAttackAnimation = false -- if true, it will disable the animation code
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
	-- ====== Animation Variables ====== --
ENT.LeapAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.LeapAttackAnimationFaceEnemy = 2 -- true = Face the enemy the entire time! | 2 = Face the enemy UNTIL it jumps! | false = Don't face the enemy AT ALL!
ENT.LeapAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.TimeUntilLeapAttackVelocity = 0

	-- ====== Velocity Variables ====== --
ENT.LeapAttackVelocityForward = 200
ENT.LeapAttackVelocityUp = 200
ENT.LeapAttackVelocityRight = 0 -- How much right force should it apply?

function ENT:CustomOnLeapAttackVelocityCode()
self:SetGroundEntity(NULL)
self:ForceMoveJump(self:CalculateProjectile("Curve", self:GetPos(), self:GetEnemy():GetPos(),math.Clamp(self:GetEnemy():GetPos():Distance(self:GetPos()),600,1100)))
return true
end

ENT.DamageByPlayerDispositionLevel = 0
ENT.DamageByPlayerTime = VJ_Set(2, 2)
---------------------------------------------------------------------------------------------------------------------------------------------
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 1 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 3 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.AnimTbl_Flinch = {"Flinch","Big_Flinch"} -- If it uses normal based animation, use this
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.CallForHelpDistance = 4000 -- -- How far away the SNPC's call for help goes | Counted in World 
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
    local enemy = self:GetEnemy()
    -- Trace to predict enemy position
    local tr = util.TraceLine({
        start = enemy:GetPos(),
        endpos = enemy:GetPos() + Vector(0, 0, 800),
        filter = enemy
    })
    local offset = VectorRand() * 50
    if tr.Hit then
        return self:CalculateProjectile("Curve", projectile:GetPos(), enemy:GetPos() + enemy:OBBCenter() + offset, 1200)
    end
    local distanceToEnemy = self:GetPos():Distance(enemy:GetPos())
    local rangeAdjustment = 0
    if distanceToEnemy <= 900 then
        rangeAdjustment = 1400  -- Straight shot for close range
    else
        rangeAdjustment = 1600  -- Longer shot for far range
    end
    return self:CalculateProjectile("Curve", projectile:GetPos(), enemy:GetPos() + offset, rangeAdjustment)
end

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.IsMedicSNPC = true 
ENT.AnimTbl_Medic_GiveHealth = {"Wallpound"}
ENT.Medic_TimeUntilHeal = 2
ENT.Medic_CheckDistance = 12000
ENT.Medic_HealthAmount = math.random(10,80)
ENT.Medic_HealDistance = math.random(50,100)
ENT.Medic_NextHealTime = VJ_Set(10, 15)
ENT.Medic_DisableAnimation = false
ENT.Medic_CanBeHealed = true 
ENT.Medic_SpawnPropOnHealModel = "models/weapons/w_bugbait.mdl" 

ENT.DisableFootStepSoundTimer = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(ent, attacker, inflictor)

    if attacker == self && IsValid(self) then
        local healthBonus = math.random(50,125) 
        self:SetHealth(self:Health() + healthBonus)

        local bloodeffect = EffectData()
        bloodeffect:SetOrigin(ent:GetPos() + ent:OBBCenter())
        bloodeffect:SetColor(VJ_Color2Byte(Color(130, 19, 10)))
        bloodeffect:SetScale(math.random(40,100))
        util.Effect("VJ_Blood1", bloodeffect)
        local bloodspray = EffectData()
        bloodspray:SetOrigin(ent:GetPos() + ent:OBBCenter())
        bloodspray:SetScale(math.random(1,3))
        bloodspray:SetFlags(3)
        bloodspray:SetColor(0)
        util.Effect("bloodspray", bloodspray)
        util.Effect("bloodspray", bloodspray)

    end

if GetConVarNumber("vj_can_gonomes_dance") == 0 then return false end
self:VJ_ACT_PLAYACTIVITY("Sohappy", false, false, false, 0, {vTbl_SequenceInterruptible=true})
end

ENT.IsHeavyAttack = false
ENT.NormalAttack = false
ENT.HeavyAttackCooldown = 0
ENT.WhiteFlashCooldown = 0
ENT.WhiteFlashTriggered = false
ENT.RedTintDuration = math.random(9,13) 
ENT.DefaultFOV = 90 

function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp) 
if IsValid(self) && IsValid(hitEnt) then
if hitEnt:IsPlayer() or hitEnt:IsNPC() or hitEnt:IsNextBot() then
ParticleEffectAttach("antlion_gib_02_floaters",PATTACH_POINT_FOLLOW,hitEnt, hitEnt:EntIndex())
ParticleEffectAttach("blood_zombie_split",PATTACH_POINT_FOLLOW,hitEnt, hitEnt:EntIndex())
ParticleEffectAttach("vomit_barnacle",PATTACH_POINT_FOLLOW,hitEnt, hitEnt:EntIndex())
ParticleEffectAttach("blood_impact_red_01", PATTACH_ABSORIGIN_FOLLOW,hitEnt, hitEnt:EntIndex())
end
end

if IsValid(self) && IsValid(hitEnt) then
if hitEnt:IsPlayer() or hitEnt:IsNPC() or hitEnt:IsNextBot() then
local healthBonus = math.random(15,45) 
self:SetHealth(self:Health() + healthBonus)
end
end 

if self:IsOnFire() && IsValid(self) && IsValid(hitEnt) then
hitEnt:Ignite(math.random(2,8))
end

if GetConVarNumber("vj_can_gonomes_knock_player_weapons") == 1 then 
if hitEnt:IsPlayer() && !hitEnt.Dead && IsValid(hitEnt:GetActiveWeapon()) && math.random(1, 3) == 1 then
local wep = hitEnt:GetActiveWeapon()
hitEnt:DropWeapon(wep)
end
end

    local RandomRedFadeColour = math.random(54, 124)
    if IsValid(self) and IsValid(hitEnt) then
        self.WhiteFlashTriggered = false
        self.NormalAttack = false

if GetConVarNumber("vj_can_gonomes_screen_fx") == 1 then return false end 
    if hitEnt:IsPlayer() && !hitEnt:Alive() then
        return false
    end
        
        -- DSP Audio change, Screenshake, and viewpunch -- 
        local RNGDSPSOUND = math.random(131, 133)
        if hitEnt:IsPlayer() && IsValid(hitEnt) && !hitEnt.Dead && hitEnt:Alive() then
            local pitch = math.random(-155, 145)
            local yaw = math.random(-155, 145)
            hitEnt:ViewPunch(Angle(pitch, yaw, math.random(15, 45)))
            util.ScreenShake(hitEnt:GetPos(), 25, 6, 6, math.random(3500, 5500))
            hitEnt:SetLaggedMovementValue(0.5)
            hitEnt:SendLua("RunConsoleCommand('pp_motionblur', '1')")
            hitEnt:SendLua("RunConsoleCommand('pp_dof', '1')")
            hitEnt:SetDSP(RNGDSPSOUND)
            print("Dsp Equals " .. RNGDSPSOUND)

            -- Store the player's default FOV if not already stored
            if !hitEnt.DefaultFOV then
                hitEnt.DefaultFOV = hitEnt:GetFOV()
            end

            -- Modify FOV here, clamped between 40 and 120
            local initialFOV = hitEnt:GetFOV()
            local fovChange = math.Rand(-65, 65)
            local newFOV = math.Clamp(initialFOV + fovChange, 60, 120)
            hitEnt:SetFOV(newFOV, 0.5) 

            -- Screen tint effect
            hitEnt:ScreenFade(SCREENFADE.IN, Color(255, 0, 0, 128), self.RedTintDuration, 0)

            if math.random(1, 4) == 1 and not self.IsHeavyAttack and CurTime() > (self.HeavyAttackCooldown or 0) then
                print("Heavy Attack!")
                self.IsHeavyAttack = true
                hitEnt:ViewPunch(Angle(pitch, yaw, math.random(55, 65)))
                local pitch = math.random(-100, 225)
                local yaw = math.random(-100, 225)
                hitEnt:ScreenFade(SCREENFADE.IN, Color(255, 255, 255), math.random(5, 7), 2)
                util.ScreenShake(hitEnt:GetPos(), math.random(15, 35), 5, 5, math.random(5899, 8000))
                self.HeavyAttackCooldown = CurTime() + math.random(5, 15)
            else
                print("Normal Attack!")
                self.NormalAttack = true
                hitEnt:ScreenFade(SCREENFADE.IN, Color(RandomRedFadeColour, 0, 0), math.random(8, 12), 0)

                -- Additional screen fade effect for both normal and heavy attacks -- 
                if !self.WhiteFlashTriggered && CurTime() > (self.WhiteFlashCooldown or 0) then
                    hitEnt:ScreenFade(SCREENFADE.IN, Color(255, 0, 0, 128), 0.95, 0)
                    self.WhiteFlashTriggered = true
                    self.WhiteFlashCooldown = CurTime() + math.random(12, 17)
                end
            end

            local delay = math.random(7, 12)
            if self.AttackTimer then
                delay = delay + self.AttackTimer
                timer.Remove("AttackTimer_" .. self:EntIndex())
            end

            timer.Create("AttackTimer_" .. self:EntIndex(), delay, 1, function()
                if IsValid(hitEnt) and not hitEnt.Dead then
                    hitEnt:SetLaggedMovementValue(1)
                    hitEnt:SendLua("RunConsoleCommand('pp_motionblur', '0')")
                    hitEnt:SendLua("RunConsoleCommand('pp_dof', '0')")
                    hitEnt:SetDSP(0)

                    if  !self.WhiteFlashTriggered and CurTime() > (self.WhiteFlashCooldown or 0) then
                        hitEnt:ScreenFade(SCREENFADE.IN, Color(255, 255, 255), 0.95, 0)
                        self.WhiteFlashTriggered = true
                        self.WhiteFlashCooldown = CurTime() + math.random(12, 17)
                    end

                    -- Reset FOV back to the initial value
                    hitEnt:SetFOV(hitEnt.DefaultFOV, 0.5)

                    self.IsHeavyAttack = false 
                    self.NormalAttack = false
                    self.AttackTimer = nil
                end
            end)
        end
    end

hook.Add("DoPlayerDeath", "ResetPlayerScreenFX", function(ply)
    if IsValid(ply) then
        ply:SetLaggedMovementValue(1)
        ply:SendLua("RunConsoleCommand('pp_motionblur', '0')")
        ply:SendLua("RunConsoleCommand('pp_dof', '0')")
        ply:SetDSP(0)
        ply:SetFOV(90, 0.5) 
    end
end)

    return false
end


function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
dmginfo:ScaleDamage(0.85)
end

function ENT:CustomOnInitialize()
if GetConVarNumber("vj_can_gonomes_have_worldshake") == 1 then
self.HasWorldShakeOnMove = false
end
end


function ENT:MeleeAttackKnockbackVelocity(hitEnt)
return self:GetForward()*math.random(170,240) + self:GetUp()*math.random(50,75)
end

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 115 
ENT.MeleeAttackDamageDistance = 135

function ENT:MultipleMeleeAttacks()
local randAttack = math.random(1,3)
if randAttack == 1 then
self.AnimTbl_MeleeAttack = {"Attack2"}
self.TimeUntilMeleeAttackDamage = 0.2
self.MeleeAttackDamage = 15
self.HasExtraMeleeAttackSounds = true
self.MeleeAttackExtraTimers = {0.75,0.9,1} 
self.MeleeAttackDamageType = DMG_SLASH
self.NextMeleeAttackTime = 0.5
self.SoundTbl_MeleeAttack = {"gonome/gonome_melee1.wav","gonome/gonome_melee2.wav","gonome_pl_fallpain1","gonome/pl_burnpain"}
self.SoundTbl_MeleeAttackMiss = {"snpc/halflife2betaxenians/betazombie/claw_miss1.wav","snpc/halflife2betaxenians/betazombie/claw_miss2.wav","snpc/halflife2betaxenians/betazombie/zombie_swing.wav"}
self.MeleeAttackDistance = 115 
self.MeleeAttackDamageDistance = 135
elseif randAttack == 2 then
self.AnimTbl_MeleeAttack = {"Attack1"}
self.TimeUntilMeleeAttackDamage = 0.2
self.MeleeAttackDamage = 25
self.MeleeAttackExtraTimers = {0.8} 
self.HasExtraMeleeAttackSounds = true
self.NextMeleeAttackTime = 0.5
self.SoundTbl_MeleeAttack = {"gonome/gonome_melee1.wav","gonome/gonome_melee2.wav","gonome_pl_fallpain1","gonome/pl_burnpain"}
self.SoundTbl_MeleeAttackMiss = {"snpc/halflife2betaxenians/betazombie/claw_miss1.wav","snpc/halflife2betaxenians/betazombie/claw_miss2.wav","snpc/halflife2betaxenians/betazombie/zombie_swing.wav"}
self.MeleeAttackDamageType = DMG_SLASH
self.MeleeAttackDistance = 115 
self.MeleeAttackDamageDistance = 135
end
end

ENT.HasStompAttack = true

function ENT:CustomOnMeleeAttack_BeforeStartTimer(seed)
    -- Ground Thud Effect -- 
    if math.random(1, 3) == 1 and !self.VJ_PlayingSequence and !self.PlayingAttackAnimation and self:IsOnGround() and not self.Flinching and IsValid(self) and not self.RangeAttacking and not self.PlayingAttackAnimation and self.HasStompAttack then
        self.MeleeAttackAnimationAllowOtherTasks = false
        self.MeleeAttackAnimationFaceEnemy = true
        self.MeleeAttackDamage = math.random(30, 35)
        self.HasMeleeAttackKnockBack = true
        self.MeleeAttackDistance = 80
        self.MeleeAttackDamageDistance = 90
        self.MeleeAttackExtraTimers = false
        self.TimeUntilMeleeAttackDamage = 0.7
        self.MeleeAttackDistance = 125 
        self.MeleeAttackDamageDistance = 155
        self.SoundTbl_MeleeAttackMiss = {"wrhf/ground_thud/pound1.wav", "wrhf/ground_thud/pound2.wav", "wrhf/ground_thud/pound3.wav", "wrhf/ground_thud/pound4.wav"}
        self.SoundTbl_MeleeAttack = {"wrhf/ground_thud/pound1.wav", "wrhf/ground_thud/pound2.wav", "wrhf/ground_thud/pound3.wav", "wrhf/ground_thud/pound4.wav"}
        self.AnimTbl_MeleeAttack = {"Gonome_stomp_gib"}
        self.VJ_PlayingSequence = true
        self.VJ_PlayingInterruptSequence = false
        self.PlayingAttackAnimation = true

        local debrisModels = {
            "models/props_debris/concrete_chunk02a.mdl",
            "models/props_debris/concrete_chunk03a.mdl",
            "models/props_debris/concrete_chunk04a.mdl",
            "models/props_debris/concrete_chunk05g.mdl",
            "models/props_debris/concrete_chunk08a.mdl",
            "models/props_debris/concrete_chunk09a.mdl",
        }

        timer.Simple(0.75, function()
            if IsValid(self) then
                VJ_EmitSound(self, self.SoundTbl_Crash, self.AlertSoundLevel, self:VJ_DecideSoundPitch(self.BeforeMeleeAttackSoundPitch.a, self.BeforeMeleeAttackSoundPitch.b))
                util.ScreenShake(self:GetPos(), 300, 500, 1.6, 1200)
            end
        end)

        timer.Simple(0.76, function()
            if IsValid(self) then
                local pos = self:GetPos()
                ParticleEffect("strider_impale_ground", pos, Angle(0, 0, 0), nil)
                local effectdata = EffectData()
                effectdata:SetOrigin(pos)
                effectdata:SetScale(200)
                util.Effect("ThumperDust", effectdata)
                util.VJ_SphereDamage(self, self, pos, math.random(75, 250), math.random(5, 15), DMG_GENERIC, true, true, {DisableVisibilityCheck = true, Force = 80})
                util.ScreenShake(pos, 300, 500, 1.6, 1200)

                local blastRadius = math.random(150, 250)
                for _, ent in pairs(ents.GetAll()) do
                    if IsValid(ent) and ent:IsNPC() then
                        local distance = ent:GetPos():Distance(pos)
                        if distance <= blastRadius then
                            local forceDir = (ent:GetPos() - pos):GetNormalized()
                            local forceAmount = math.random(320, 670)
                            ent:SetVelocity(forceDir * forceAmount)
                        end
                    end
                end

                local numDebris = math.random(1, 5)
                for i = 1, numDebris do
                    local debris = ents.Create("prop_physics")
                    if IsValid(debris) then
                        debris:SetModel(debrisModels[math.random(1, #debrisModels)])
                        debris:SetPos(pos + Vector(math.random(-30, 70), math.random(-30, 120), 0))
                        debris:Spawn()
                        local force = Vector(math.random(-500, 1500), math.random(-500, 1500), math.random(500, 15000))
                        debris:GetPhysicsObject():ApplyForceCenter(force)
                    end
                end
                self.PlayingAttackAnimation = false
                self.VJ_PlayingSequence = false
            end
        end)
    end
end


function ENT:CustomOnIdleDialogueAnswer(ent) 
if self.VJ_IsBeingControlled or self.VJTags[VJ_TAG_EATING] then return false end
if IsValid(self) && !self:IsBusy() && !self.VJTags[VJ_TAG_EATING] && !self.Flinching && ent:Visible(self) then
local RandResponseAnim = math.random(1,2)
if RandResponseAnim == 1 then
self:VJ_ACT_PLAYACTIVITY("Big_Flinch",true,false,false)
end
return true
end
end

function ENT:CustomOnIdleDialogue(ent, canAnswer)
if self.VJ_IsBeingControlled or self.VJTags[VJ_TAG_EATING] then return false end
if IsValid(self) && !self:IsBusy() && !self.VJTags[VJ_TAG_EATING] && !self.Flinching && ent:Visible(self) then
local RandResponseAnim = math.random(1,2)
if RandResponseAnim == 1 then
self:VJ_ACT_PLAYACTIVITY("Big_Flinch",true,false,false)
end
return true
end
end

function ENT:CustomOnPlyJump()
    if self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_JUMP) then
        local jumpForce = math.random(750,1000) 
        local forwardForce = math.random(530,840) 
        if self:IsOnGround() then
            local jumpDirection = self:GetUp() * jumpForce + self:GetForward() * forwardForce
            self:SetVelocity(jumpDirection)
            self:VJ_ACT_PLAYACTIVITY("Jump_Glide_Mid", true, math.random(1.4,2), false)
        end
    end
end

function ENT:Controller_IntMsg(ply) 
ply:ChatPrint("JUMP = Press Space Bar")
end

function ENT:CustomOnThink()
self:SetCollisionBounds(Vector(-25,-22,100),Vector(35,35,0))
end


ENT.NextZomBreakDoorT = 0 

function ENT:CustomOnKilled(dmginfo, hitgroup)
    ParticleEffect("antlion_gib_02_gas",self:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
    ParticleEffect("antlion_gib_02_juice",self:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
    ParticleEffect("antlion_gib_02_floaters",self:GetPos() + self:GetUp()* 10,Angle(0,0,0),nil)
end

function ENT:CustomOnEat(status, statusInfo)
    if status == "CheckFood" then
        return true 
    elseif status == "BeginEating" then
        VJ_EmitSound(self, "barnacle/bcl_chew2.wav", 65)
        self:SetIdleAnimation({"victoryeat1"}, true, false, false)
        return self:VJ_ACT_PLAYACTIVITY("Big_Flinch", true, false)
    elseif status == "Eat" then
        local randomNum = math.random(1, 15)
        if randomNum <= 3 then
            local gibType = "UseHuman_Small"
            if randomNum == 3 then
                gibType = "UseHuman_Big"
            end
            local food = self.EatingData.Ent
            local gibPos = food:GetPos() + food:OBBCenter() + Vector(0, 0, 10) 
            self:CreateGibEntity("obj_vj_gib", gibType, { Pos = gibPos })
            VJ_EmitSound(self, "wrhf/gibs/fullbodygib-3.wav", 100, 100)
        end

        VJ_EmitSound(self, "barnacle/barnacle_crunch3.wav", 65, 100)
        VJ_EmitSound(self, "barnacle/barnacle_crunch2.wav", 55, 100)

        local food = self.EatingData.Ent
        local damage = math.random(65,95)
        local foodHP = food:Health() 
        local newHealth = self:Health() + math.min(damage, foodHP)
        self:SetHealth(newHealth)

        if foodHP <= 0 then
            food:Remove() -- Remove the corpse if its health reaches zero
        end

        local bloodData = food.BloodData
        if bloodData then
            local bloodPos = food:GetPos() + food:OBBCenter()
            local bloodParticle = "blood_zombie_split_spray"
            if bloodParticle then
                ParticleEffect(bloodParticle, bloodPos, self:GetAngles())
            end
        end

        local vomitParticle = "vomit_barnacle_b"
        if vomitParticle then
            if self:LookupAttachment("0") then
                ParticleEffectAttach(vomitParticle, PATTACH_POINT_FOLLOW, self, self:LookupAttachment("0"))
            end
            if self:LookupAttachment("0") then
                ParticleEffectAttach(vomitParticle, PATTACH_POINT_FOLLOW, self, self:LookupAttachment("0"))
            end
        end

        return 2 
    elseif status == "StopEating" then
        if statusInfo ~= "Dead" and self.EatingData.AnimStatus ~= "None" then
            return self:VJ_ACT_PLAYACTIVITY("Big_Flinch", true, false)
        end
    end
    return 0
end

function ENT:CustomOnAlert(ent)
if self.VJ_IsBeingControlled or self.PlayingAttackAnimation then return false end 
if IsValid(self) && math.random(1,4) == 1 && !self:IsBusy() && !self.Flinching && ent:Visible(self) && !self.MeleeAttacking && !self.RangeAttacking then

            effects.BeamRingPoint(self:GetPos(), 0.3, 2, 100, 15, 0, Color(255, 255, 255), {material = "sprites/physbeama", framerate = 20})
            effects.BeamRingPoint(self:GetPos(), 0.3, 2, 300, 10, 0, Color(255, 255, 255), {material = "sprites/physbeama", framerate = 20})
            effects.BeamRingPoint(self:GetPos(), 0.3, 2, 500, 5, 0, Color(255, 255, 255), {material = "sprites/physbeama", framerate = 20})

            local effectData = EffectData()
            effectData:SetOrigin(self:GetPos())
            effectData:SetScale(400)
            ParticleEffectAttach("blood_impact_antlion_worker_01", PATTACH_POINT_FOLLOW, self, self:EntIndex())
            ParticleEffectAttach("antlion_spit_02", PATTACH_POINT_FOLLOW, self, self:EntIndex())
            ParticleEffectAttach("antlion_gib_02_floaters", PATTACH_POINT_FOLLOW, self, self:EntIndex())
            ParticleEffect("explosion_huge_d",self:GetPos() +self:GetForward()*1,Angle(0,0,0),nil)

            local ExpluseSound = VJ_PICK({"weapons/bugbait/bugbait_squeeze3.wav","weapons/bugbait/bugbait_squeeze2.wav","weapons/bugbait/bugbait_squeeze1.wav"})
            VJ_EmitSound(self,ExpluseSound,85,100)
            VJ_EmitSound(self, {"ez2_gonome/beast_berserk.wav","ez2_gonome/beast_spotted.wav","ez2_gonome/beast_alert.wav","ez2_gonome/beastsighting01.wav","ez2_gonome/beastsighting02.wav"}, 100, math.random(100, 100))
            VJ_EmitSound(self, {"call_for_help/order_smoke.wav"}, 100, math.random(100, 100))

            self.CallForHelp = true 
            self.CallForHelpDistance = 500000000000

            local bloodeffect = EffectData()
            bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
            bloodeffect:SetColor(VJ_Color2Byte(Color(130, 19, 10)))
            bloodeffect:SetScale(150)
            util.Effect("VJ_Blood1", bloodeffect)

            local bloodspray = EffectData()
            bloodspray:SetOrigin(self:GetPos() + self:OBBCenter())
            bloodspray:SetScale(5)
            bloodspray:SetFlags(3)
            bloodspray:SetColor(0)
            util.Effect("bloodspray", bloodspray)
            util.Effect("bloodspray", bloodspray)

            util.ScreenShake(self:GetPos(), 12, 7, 5, 1250) 

            if math.random(1,2) == 1 then
	timer.Simple(0.0,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY({"Big_Flinch"}, true, false, false) end end)
       end
    end
end

function ENT:CustomOnCallForHelp()
if self.VJ_IsBeingControlled or self.IsCrawler or self.IsCrippled or self.IsStrafing or self.PlayingAttackAnimation then return false end 
if IsValid(self) && math.random(1,2) == 1 && !self:IsBusy() && !self.Flinching && !self.MeleeAttacking && !self.RangeAttacking then

            effects.BeamRingPoint(self:GetPos(), 0.3, 2, 100, 15, 0, Color(255, 255, 255), {material = "sprites/physbeama", framerate = 20})
            effects.BeamRingPoint(self:GetPos(), 0.3, 2, 300, 10, 0, Color(255, 255, 255), {material = "sprites/physbeama", framerate = 20})
            effects.BeamRingPoint(self:GetPos(), 0.3, 2, 500, 5, 0, Color(255, 255, 255), {material = "sprites/physbeama", framerate = 20})

            local effectData = EffectData()
            effectData:SetOrigin(self:GetPos())
            effectData:SetScale(400)
            ParticleEffectAttach("blood_impact_antlion_worker_01", PATTACH_POINT_FOLLOW, self, self:EntIndex())
            ParticleEffectAttach("antlion_spit_02", PATTACH_POINT_FOLLOW, self, self:EntIndex())
            ParticleEffectAttach("antlion_gib_02_floaters", PATTACH_POINT_FOLLOW, self, self:EntIndex())

            local ExpluseSound = VJ_PICK({"weapons/bugbait/bugbait_squeeze3.wav","weapons/bugbait/bugbait_squeeze2.wav","weapons/bugbait/bugbait_squeeze1.wav"})
            VJ_EmitSound(self,ExpluseSound,85,100)
            VJ_EmitSound(self, {"ez2_gonome/beast_berserk.wav","ez2_gonome/beast_spotted.wav","ez2_gonome/beast_alert.wav","ez2_gonome/beastsighting01.wav","ez2_gonome/beastsighting02.wav"}, 100, math.random(100, 100))
            VJ_EmitSound(self, {"call_for_help/order_smoke.wav"}, 100, math.random(100, 100))

            self.CallForHelp = true 
            self.CallForHelpDistance = 500000000000

            local bloodeffect = EffectData()
            bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
            bloodeffect:SetColor(VJ_Color2Byte(Color(130, 19, 10)))
            bloodeffect:SetScale(150)
            util.Effect("VJ_Blood1", bloodeffect)

            local bloodspray = EffectData()
            bloodspray:SetOrigin(self:GetPos() + self:OBBCenter())
            bloodspray:SetScale(5)
            bloodspray:SetFlags(3)
            bloodspray:SetColor(0)
            util.Effect("bloodspray", bloodspray)
            util.Effect("bloodspray", bloodspray)

            util.ScreenShake(self:GetPos(), 12, 7, 5, 1250) 

            if math.random(1,2) == 1 then
	timer.Simple(0.0,function() if IsValid(self) then self:VJ_ACT_PLAYACTIVITY({"Big_Flinch"}, true, false, false) end end)
       end
    end
end

function ENT:LandOnGround()
    if self.Flinching or self.Dead or not IsValid(self) or self.MovementType == VJ_MOVETYPE_AQUATIC then 
        return false 
    end

    local onGround = false
    local trace = {}
    trace.start = self:GetPos() + Vector(0, 0, 5)
    trace.endpos = trace.start - Vector(0, 0, 50)
    trace.filter = self
    local groundTrace = util.TraceLine(trace)

    if groundTrace.Hit then
        onGround = true
    else
        onGround = self:IsOnGround()
    end

    -- Check if the SNPC is in water
    local isInWater = self:WaterLevel() > 0

    if not self.Dead and IsValid(self) and not isInWater then
        if not onGround then
            if self.EmplacedOnTheGround then
                self.EmplacedOnTheGround = false
                if CurTime() > (self.NextLandT or 0) then
                end
            end
        elseif onGround then
            if not self.EmplacedOnTheGround or self.LeapAttacking then
                self.EmplacedOnTheGround = true
                if CurTime() > (self.NextLandOnGroundT or 0) then
                    self.NextLandOnGroundT = CurTime() + math.random(1.5, 2.5)
                    self:VJ_ACT_PLAYACTIVITY(ACT_LAND, true, 1, false, false)
                    VJ_EmitSound(self, "npc/antlion/land1.wav", 75, 100)
                end
            end
        end
    end
end

function ENT:CustomOnThink_AIEnabled()
self:LandOnGround()
self:SetCollisionBounds(Vector(-25,-22,100),Vector(35,35,0))
    if !IsValid(self) or self:IsOnFire() or self.MovementType == VJ_MOVETYPE_STATIONARY or self.Medic_Status or self.Flinching or self.IsFollowing == true or self:GetState() == VJ_STATE_ONLY_ANIMATION or self.SelfIsFlipped == true or self.IsDrowning == true or self.VJTags[VJ_TAG_EATING] then 
        return 
    end

    for _,v in ipairs(ents.FindInSphere(self:GetPos(),1250)) do
        if IsValid(self) and IsValid(v) and (self:GetMaxHealth() * 0.99) >= self:Health() and !IsValid(self:GetEnemy()) and !self:IsBusy() then
            if v:GetClass():find("prop_ragdoll") then
                self:SetLastPosition(select(2, self:VJ_GetNearestPointToEntity(v)))
                self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
                local MedicalItemDist = self:VJ_GetNearestPointToEntityDistance(v)

                if MedicalItemDist < math.random(10,25) then
                    self:FaceCertainEntity(v)
                    self:VJ_ACT_PLAYACTIVITY("Victoryeat1",true,false,true)

                    
                    timer.Simple(math.random(4, 4.5), function()
                        if IsValid(self) and IsValid(v) then
                            VJ_EmitSound(self,"wrhf/gibs/fullbodygib-2.wav")
                            self:SetHealth(math.Clamp(self:Health() + math.random(15,50), 0, self:GetMaxHealth()))
                            v:Remove()
                            local bloodeffect = EffectData()
                            ParticleEffect("antliongib",v:GetPos(),Angle(0,0,0),nil)
                            bloodeffect:SetOrigin(v:GetPos() + v:OBBCenter())
                            bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
                            bloodeffect:SetScale(50)
                            util.Effect("VJ_Blood1", bloodeffect)		
                            local bloodspray = EffectData()
                            bloodspray:SetOrigin(v:GetPos() + v:OBBCenter())
                            bloodspray:SetScale(2)
                            bloodspray:SetFlags(3)
                            bloodspray:SetColor(0)
                            util.Effect("bloodspray", bloodspray)
                            util.Effect("bloodspray", bloodspray)
                            local GibSounds = {"wrhf/gibs/fullbodygib-1.wav", "wrhf/gibs/fullbodygib-2.wav", "wrhf/gibs/fullbodygib-3.wav"}
                            local SelectedGibSound = VJ_PICK(GibSounds)
                            self:EmitSound(SelectedGibSound, 80, 100)

                            local gibs = {"models/gibs/humans/heart_gib.mdl","models/gibs/humans/liver_gib.mdl","models/gibs/humans/lung_gib.mdl","models/gibs/humans/liver_gib.mdl","models/gibs/humans/lung_gib.mdl","models/gibs/humans/eye_gib.mdl","models/gibs/hgibs.mdl","models/gibs/hgibs_rib.mdl","models/gibs/hgibs_rib.mdl","models/gibs/hgibs_rib.mdl","models/gibs/hgibs_rib.mdl","models/gibs/hgibs_rib.mdl","models/gibs/hgibs_scapula.mdl","models/gibs/hgibs_spine.mdl","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Small","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big","UseHuman_Big"}

                            for _, gibModel in ipairs(gibs) do
                                local gibEnt = self:CreateGibEntity("obj_vj_gib", gibModel, {Pos = v:GetPos() + v:OBBCenter()})
                            end
                        end
                    end)
                end
				
			-- When eating Gib -- 
            elseif v:GetClass():find("obj_vj_gib") then
                self:SetLastPosition(select(2, self:VJ_GetNearestPointToEntity(v)))
                self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
                local MedicalItemDist = self:VJ_GetNearestPointToEntityDistance(v)

                if MedicalItemDist < math.random(250,300) then
                    self:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH")
                end

                if MedicalItemDist < math.random(10,25) then
                    self:FaceCertainEntity(v)
                    self:VJ_ACT_PLAYACTIVITY("Victoryeat1",true,false,true)

                    timer.Simple(math.random(4, 4.5), function()
                        if IsValid(self) and IsValid(v) then
                            VJ_EmitSound(self,"wrhf/gibs/fullbodygib-2.wav")
                            self:SetHealth(math.Clamp(self:Health() + math.random(15,50), 0, self:GetMaxHealth()))
                            v:Remove()
                            local bloodeffect = EffectData()
                            ParticleEffect("antliongib",v:GetPos(),Angle(0,0,0),nil)
                            bloodeffect:SetOrigin(v:GetPos() + v:OBBCenter())
                            bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
                            bloodeffect:SetScale(50)
                            util.Effect("VJ_Blood1", bloodeffect)		
                            local bloodspray = EffectData()
                            bloodspray:SetOrigin(v:GetPos() + v:OBBCenter())
                            bloodspray:SetScale(2)
                            bloodspray:SetFlags(3)
                            bloodspray:SetColor(0)
                            util.Effect("bloodspray", bloodspray)
                            util.Effect("bloodspray", bloodspray)
                        end
                    end)
                end
            end
        end
    end

     if VJ_AnimationExists(self, ACT_MELEE_ATTACK1) && CurTime() > self.NextZomBreakDoorT  then
        if !IsValid(self.BreakDoor) then
            for _, v in pairs(ents.FindInSphere(self:GetPos(), 70)) do
	       if v:GetClass() == "func_door_rotating" && v:Visible(self) then self.BreakDoor = v end
                if v:GetClass() == "prop_door_rotating" && v:Visible(self) then 
                    local anim = string.lower(v:GetSequenceName(v:GetSequence()))
                    if string.find(anim,"idle") or string.find(anim,"open") /*or string.find(anim,"locked")*/ then
                        self.BreakDoor = v
                        break
                    end
                end
            end
        else
            if self.PlayingAttackAnimation or !self.BreakDoor:Visible(self) /*or (self:GetActivity() == ACT_OPEN_DOOR && dist <= 100)*/ then self.BreakDoor = NULL return end
            if self:GetActivity() != ACT_MELEE_ATTACK1 then
                local ang = self:GetAngles()
                self:SetAngles(Angle(ang.x, (self.BreakDoor:GetPos() - self:GetPos()):Angle().y, ang.z))
                self:VJ_ACT_PLAYACTIVITY("ACT_MELEE_ATTACK1", true, false, false)
		VJ_EmitSound(self,self.SoundTbl_CombatIdle,70,100)
                end
                   

                local door = self.BreakDoor
                local DoorBustSound = VJ_PICK({"wrhf/doorbust1","wrhf/doorbust2"})
                self.NextZomBreakDoorT = CurTime() + math.random(5,15)
                if IsValid(self.BreakDoor) && door:GetClass() == "prop_door_rotating" then
	            VJ_CreateSound(self,self.SoundTbl_BeforeMeleeAttack,self.BeforeMeleeAttackSoundLevel,self:VJ_DecideSoundPitch(self.BeforeMeleeAttackSoundPitch.a, self.BeforeMeleeAttackSoundPitch.b))
		    VJ_EmitSound(self,DoorBustSound..".wav",75,100) 
                    VJ_EmitSound(self, self.SoundTbl_CombatIdle, 70, 100)
                    door:EmitSound("physics/wood/wood_furniture_break" .. math.random(1, 4) .. ".wav", 70, 100)
                    ParticleEffect("strider_impale_ground", door:GetPos(), self:GetAngles(), self)
                    ParticleEffect("door_pound_core", door:GetPos(), self:GetAngles(), self)
                    ParticleEffect("door_explosion_smoke", door:GetPos(), self:GetAngles(), self)
                    ParticleEffect("door_explosion_chunks", door:GetPos(), self:GetAngles(), self)  
                    ParticleEffect("advisor_plat_break", door:GetPos(), self:GetAngles(), self)
                    door:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
                    door:SetSolid(SOLID_NONE)

                    -- Create a new prop to represent the broken door
                    self.BrokenDoorProp = ents.Create("prop_physics")
                    self.BrokenDoorProp:SetModel(door:GetModel())
                    self.BrokenDoorProp:SetPos(door:GetPos())
                    self.BrokenDoorProp:SetAngles(door:GetAngles())
                    self.BrokenDoorProp:Spawn()
                    self.BrokenDoorProp:Activate()

                    -- Set the broken door prop's skin to match the original door
                    self.BrokenDoorProp:SetSkin(door:GetSkin())
                    self.BrokenDoorProp:GetPhysicsObject():ApplyForceCenter(self:GetForward()*5500)
                    door:Remove()

            timer.Simple(math.random(1.7,2.2), function ()
                if IsValid(self) then
                VJ_EmitSound(self,self.SoundTbl_Pain,70,100)
                self:VJ_ACT_PLAYACTIVITY("Big_Flinch", true, 1.2)
                end
            end)
        end
    end
end
    if !IsValid(self.BreakDoor) then
        self:SetState()
    end

if self.VJ_IsBeingControlled then
self:CustomOnPlyJump()   
end
end

function ENT:RetreatFromEnemy()
    local runDecision = math.random(1, 4)
    self:StopAttacks()
    VJ_EmitSound(self, self.SoundTbl_FleeToCover, 75, 100)

    if runDecision == 1 then
        self:VJ_TASK_COVER_FROM_ORIGIN("TASK_RUN_PATH", function(x)
            x.HasRangeAttack = true
            x.DisableChasingEnemy = false
            x.ConstantlyFaceEnemyVisible = true
            x.HasMeleeAttack = true
        end)
    elseif runDecision == 2 then 
        print("Decision 2")
        self:VJ_TASK_COVER_FROM_ORIGIN("TASK_RUN_PATH", function(x)
            x.HasRangeAttack = true
            x.DisableChasingEnemy = false
            x.ConstantlyFaceEnemyVisible = true
            x.HasMeleeAttack = true
        end)
    end
end

function ENT:CustomOnLeapAttack_AfterChecks(hitEnt)
    local RetreatDelay = math.Rand(5, 12)
    timer.Simple(RetreatDelay, function()
        if IsValid(self) then
            self:RetreatFromEnemy()
        end
    end)
end

function ENT:CustomOnLeapAttack_Miss()
    local retreatDelay = math.Rand(5, 12) 
    timer.Simple(retreatDelay, function()
        if IsValid(self) then
            self:RetreatFromEnemy()
        end
    end)
end

function ENT:CustomOnRangeAttack_AfterStartTimer(seed) 
    local retreatDelay = math.Rand(4, 7) 
    timer.Simple(retreatDelay, function()
        if IsValid(self) then
            self:RetreatFromEnemy()
        end
    end)
end

function ENT:CustomOnRangeAttack_BeforeStartTimer(seed)
if !IsValid(self) then return false end
    local ParticleDelay = math.Rand(1, 1.3)
    timer.Simple(ParticleDelay, function()
        if IsValid(self) then
        ParticleEffectAttach("antlion_spit_02", PATTACH_POINT_FOLLOW, self, self:EntIndex())
        ParticleEffectAttach("antlion_gib_02_floaters", PATTACH_POINT_FOLLOW, self, self:EntIndex())
        if self:LookupAttachment("0") then
            ParticleEffectAttach("vomit_barnacle", PATTACH_POINT_FOLLOW, self, self:LookupAttachment("0"))
           end
       end
    end)
end

---------------------------------------------------------------------------------------------------------------------------------------------
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Alert = {"ez2_gonome/beast_berserk.wav","ez2_gonome/beast_spotted.wav","ez2_gonome/beast_alert.wav","ez2_gonome/beastsighting01.wav","ez2_gonome/beastsighting02.wav"}
ENT.SoundTbl_Investigate = {"ez2_gonome/beast_growl2.wav","ez2_gonome/beast_growl3.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"ez2_gonome/slime_zombie_emerge.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"ez2_gonome/beast_attack1.wav"}
ENT.SoundTbl_FootStep = {"ez2_gonome/beast_walk_foot1.wav","ez2_gonome/beast_walk_foot2.wav","ez2_gonome/beast_walk_foot3.wav","ez2_gonome/beast_walk_foot4.wav","ez2_gonome/beast_run_foot1.wav","ez2_gonome/beast_run_foot2.wav","ez2_gonome/beast_run_foot3.wav","ez2_gonome/beast_run_foot4.wav"}
ENT.SoundTbl_Idle = {"ez2_gonome/beast_growl1.wav","ez2_gonome/beast_growl2.wav","ez2_gonome/beast_growl3.wav","ez2_gonome/beast_distant_growl1.wav","ez2_gonome/beast_distant_growl2.wav","ez2_gonome/beast_distant_growl3.wav","ez2_gonome/beast_idle1.wav","ez2_gonome/beast_idle2.wav","ez2_gonome/beast_idle3.wav","ez2_gonome/beast_idle4.wav","ez2_gonome/beast_growl1.wav"}
ENT.SoundTbl_MeleeAttack = {"ez2_gonome/beast_claw_strike1.wav","ez2_gonome/beast_claw_strike2.wav","ez2_gonome/beast_claw_strike3.wav"}
ENT.SoundTbl_Pain = {"ez2_gonome/beast_pain1.wav","ez2_gonome/beast_pain2.wav"}
ENT.SoundTbl_Death = {"ez2_gonome/beast_die1_v2.wav","ez2_gonome/beast_die2_v2.wav"}
ENT.SoundTbl_MoveOutOfPlayersWay = {"ez2_gonome/beast_growl1.wav","ez2_gonome/beast_growl2.wav","ez2_gonome/beast_growl3.wav"}
ENT.SoundTbl_CombatIdle = {"ez2_gonome/beast_growl1.wav","ez2_gonome/beast_growl2.wav","ez2_gonome/beast_growl3.wav","ez2_gonome/beast_idle_hunt1.wav","ez2_gonome/beast_growl2.wav"}
ENT.SoundTbl_LostEnemy = {"ez2_gonome/beast_idle_hunt1.wav","ez2_gonome/beastsighting01.wav","ez2_gonome/beastsighting02.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"snpc/halflife2betaxenians/betazombie/claw_miss1.wav","snpc/halflife2betaxenians/betazombie/claw_miss2.wav","snpc/halflife2betaxenians/betazombie/zombie_swing.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
ParticleEffect("antliongib",self:GetPos(),Angle(0,0,0),nil)
ParticleEffect("antliongib",self:GetPos(),Angle(0,0,0),nil)

self.HasDeathRagdoll = false
self.HasDeathSounds = false
self.HasPainSounds = false
self.HasDeathAnimation = false

local bloodeffect = EffectData()
bloodeffect:SetOrigin(self:GetPos()+self:OBBCenter())
bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
bloodeffect:SetScale(150)
util.Effect("VJ_Blood1",bloodeffect)		
local bloodspray = EffectData()
bloodspray:SetOrigin(self:GetPos()+self:OBBCenter())
bloodspray:SetScale(5)
bloodspray:SetFlags(3)
bloodspray:SetColor(0)
util.Effect("bloodspray",bloodspray)
util.Effect("bloodspray",bloodspray)

local ExplosionShake = DamageInfo()
ExplosionShake:SetDamage(math.random(3,8))
ExplosionShake:SetDamageType(DMG_CRUSH) 
ExplosionShake:SetAttacker(game.GetWorld())
ExplosionShake:SetInflictor(game.GetWorld())
ExplosionShake:SetDamageForce(Vector(0, 0, 0)) 
util.ScreenShake(self:GetPos(), 10, 5, 1, 1000) 
util.VJ_SphereDamage(self,self,self:GetPos(),math.random(120,340),math.random(5,12),DMG_NERVEGAS,true,true)

    local gibs = {
        "models/gibs/humans/heart_gib.mdl",
        "models/gibs/humans/liver_gib.mdl",
        "models/gibs/humans/lung_gib.mdl",
        "models/gibs/humans/liver_gib.mdl",
        "models/gibs/humans/lung_gib.mdl",
        "models/gibs/humans/eye_gib.mdl",
        "models/gibs/hgibs.mdl",
        "models/gibs/hgibs_rib.mdl",
        "models/gibs/hgibs_rib.mdl",
        "models/gibs/hgibs_rib.mdl",
        "models/gibs/hgibs_rib.mdl",
        "models/gibs/hgibs_rib.mdl",
        "models/gibs/hgibs_scapula.mdl",
        "models/gibs/hgibs_spine.mdl",
        "models/gibs/xenians/mgib_01.mdl",
        "models/gibs/xenians/mgib_01.mdl",
        "models/gibs/xenians/mgib_01.mdl",
        "models/gibs/xenians/mgib_01.mdl",
        "models/gibs/xenians/mgib_01.mdl",
        "models/gibs/xenians/mgib_01.mdl",
        "models/gibs/xenians/mgib_01.mdl",
        "models/gibs/xenians/mgib_01.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/sgib_03.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_05.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_04.mdl",
        "models/gibs/xenians/mgib_02.mdl",
        "models/gibs/xenians/mgib_02.mdl",
        "models/gibs/xenians/mgib_02.mdl",
    }

        local GibSounds = {"gib/fullbodygib-1.wav", "gib/fullbodygib-2.wav", "gib/fullbodygib-3.wav"}
        local SelectedGibSound = VJ_PICK(GibSounds)
        self:EmitSound(SelectedGibSound, 80, 100)

    for _, gibModel in ipairs(gibs) do
        local gibEnt = self:CreateGibEntity("obj_vj_gib", gibModel, {Pos = self:GetPos() + self:OBBCenter()})
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.FootStepPitch1 = 100
ENT.FootStepPitch2 = 100
ENT.BreathSoundPitch1 = 100
ENT.BreathSoundPitch2 = 100
ENT.IdleSoundPitch1 = "UseGeneralPitch"
ENT.IdleSoundPitch2 = "UseGeneralPitch"
ENT.CombatIdleSoundPitch1 = "UseGeneralPitch"
ENT.CombatIdleSoundPitch2 = "UseGeneralPitch"
ENT.OnReceiveOrderSoundPitch1 = "UseGeneralPitch"
ENT.OnReceiveOrderSoundPitch2 = "UseGeneralPitch"
ENT.FollowPlayerPitch1 = "UseGeneralPitch"
ENT.FollowPlayerPitch2 = "UseGeneralPitch"
ENT.UnFollowPlayerPitch1 = "UseGeneralPitch"
ENT.UnFollowPlayerPitch2 = "UseGeneralPitch"
ENT.BeforeHealSoundPitch1 = "UseGeneralPitch"
ENT.BeforeHealSoundPitch2 = "UseGeneralPitch"
ENT.AfterHealSoundPitch1 = 100
ENT.AfterHealSoundPitch2 = 100
ENT.OnPlayerSightSoundPitch1 = "UseGeneralPitch"
ENT.OnPlayerSightSoundPitch2 = "UseGeneralPitch"
ENT.AlertSoundPitch1 = "UseGeneralPitch"
ENT.AlertSoundPitch2 = "UseGeneralPitch"
ENT.CallForHelpSoundPitch1 = "UseGeneralPitch"
ENT.CallForHelpSoundPitch2 = "UseGeneralPitch"
ENT.BecomeEnemyToPlayerPitch1 = "UseGeneralPitch"
ENT.BecomeEnemyToPlayerPitch2 = "UseGeneralPitch"
ENT.BeforeMeleeAttackSoundPitch1 = "UseGeneralPitch"
ENT.BeforeMeleeAttackSoundPitch2 = "UseGeneralPitch"
ENT.MeleeAttackSoundPitch1 = "UseGeneralPitch"
ENT.MeleeAttackSoundPitch2 = "UseGeneralPitch"
ENT.ExtraMeleeSoundPitch1 = 100
ENT.ExtraMeleeSoundPitch2 = 100
ENT.MeleeAttackMissSoundPitch1 = 100
ENT.MeleeAttackMissSoundPitch2 = 100
ENT.BeforeRangeAttackPitch1 = "UseGeneralPitch"
ENT.BeforeRangeAttackPitch2 = "UseGeneralPitch"
ENT.RangeAttackPitch1 = "UseGeneralPitch"
ENT.RangeAttackPitch2 = "UseGeneralPitch"
ENT.BeforeLeapAttackSoundPitch1 = "UseGeneralPitch"
ENT.BeforeLeapAttackSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackJumpSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackJumpSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackDamageSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackDamageSoundPitch2 = "UseGeneralPitch"
ENT.LeapAttackDamageMissSoundPitch1 = "UseGeneralPitch"
ENT.LeapAttackDamageMissSoundPitch2 = "UseGeneralPitch"
ENT.OnKilledEnemySoundPitch1 = "UseGeneralPitch"
ENT.OnKilledEnemySoundPitch2 = "UseGeneralPitch"
ENT.PainSoundPitch1 = "UseGeneralPitch"
ENT.PainSoundPitch2 = "UseGeneralPitch"
ENT.ImpactSoundPitch1 = 100
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = "UseGeneralPitch"
ENT.DamageByPlayerPitch2 = "UseGeneralPitch"
ENT.DeathSoundPitch1 = "UseGeneralPitch"
ENT.DeathSoundPitch2 = "UseGeneralPitch"

/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/