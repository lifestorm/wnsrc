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
include("shared.lua")


ENT.Model = {"models/VJ_Hunter_Z.mdl"}
ENT.StartHealth = 235
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.TurningSpeed = 30

ENT.MeleeAttackDamage = 20
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 200 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 300 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackBleedEnemy = true -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 1 -- Chance that the enemy bleeds | 1 = always
ENT.MeleeAttackBleedEnemyTime = 0.33 -- How much time until the next repetition?
ENT.MeleeAttackBleedEnemyReps = 10 -- How many repetitions?

ENT.PoseParameterLooking_Names = {pitch={"aim_Pitch","body_pitch"}, yaw={"aim_yaw","body_yaw"}} -- Custom pose parameters to use, can put as many as needed

ENT.InvestigateSoundDistance = 36
ENT.CallForHelpDistance = 10000 -- -- How far away the SNPC's call for help goes | Counted in World Units

ENT.BloodColor = "White"
--ENT.CustomBlood_Particle = {"blood_impact_synth_01"}

ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {
    "death_stagger_e",
    "death_stagger_s",
    "death_stagger_se",
    "death_stagger_sw",
    "death_stagger_w",
}

ENT.DeathCorpseSetBoneAngles = false -- This can be used to stop the corpse glitching or flying on death

ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 1 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextFlinchTime = 0 -- How much time until it can flinch again?
ENT.AnimTbl_Flinch = {
    "staggere",
    "staggern",
    "staggers",
    "staggerw",
}

ENT.AttackCooldown = 3

ENT.ChargeDistance = 1500
ENT.MinChargeDistance = 300
ENT.ChargeCooldown = 12
ENT.ChargeDamage = 50

ENT.MiniShootBurstCooldown = 1

ENT.RangeAttackCooldown = {
    min = 6,
    max = 12,
}
ENT.RangeAttackDuration = {
    min = 1.5,
    max = 2.5,
}


ENT.ShootDistance = 3000
ENT.MinShootDist = 200
ENT.FlechetteSpeed = 2750
ENT.ShootInaccuracy = 25

ENT.SoundTbl_FootStep = {
"npc/ministrider/ministrider_footstep1.wav",
"npc/ministrider/ministrider_footstep2.wav",
"npc/ministrider/ministrider_footstep3.wav",
"npc/ministrider/ministrider_footstep4.wav",
"npc/ministrider/ministrider_footstep5.wav"
}
ENT.SoundTbl_CombatIdle = {
"npc/ministrider/hunter_angry1.wav",
"npc/ministrider/hunter_angry2.wav",
"npc/ministrider/hunter_angry3.wav",
"npc/ministrider/hunter_defendstrider1.wav",
"npc/ministrider/hunter_defendstrider2.wav",
"npc/ministrider/hunter_defendstrider3.wav",
"npc/ministrider/hunter_flank_announce1.wav",
"npc/ministrider/hunter_flank_announce2.wav",
"npc/ministrider/hunter_laugh1.wav",
"npc/ministrider/hunter_laugh2.wav",
"npc/ministrider/hunter_laugh3.wav",
"npc/ministrider/hunter_laugh4.wav",
"npc/ministrider/hunter_laugh5.wav",
}
ENT.SoundTbl_Alert = {
"npc/ministrider/hunter_alert1.wav",
"npc/ministrider/hunter_alert2.wav",
"npc/ministrider/hunter_alert3.wav",
"npc/ministrider/hunter_foundenemy1.wav",
"npc/ministrider/hunter_foundenemy2.wav",
"npc/ministrider/hunter_foundenemy3.wav",
"npc/ministrider/hunter_foundenemy_ack1.wav",
"npc/ministrider/hunter_foundenemy_ack2.wav",
"npc/ministrider/hunter_foundenemy_ack3.wav",
}

ENT.SoundTbl_Idle = {"npc/ministrider/hunter_idle1.wav","npc/ministrider/hunter_idle2.wav","npc/ministrider/hunter_idle3.wav"}
ENT.SoundTbl_Investigate = {"npc/ministrider/hunter_scan1.wav","npc/ministrider/hunter_scan2.wav","npc/ministrider/hunter_scan3.wav","npc/ministrider/hunter_scan4.wav"}
ENT.SoundTbl_Pain = {"npc/ministrider/hunter_pain2.wav","npc/ministrider/hunter_pain4.wav"}
ENT.SoundTbl_Death = {"npc/ministrider/hunter_die2.wav","npc/ministrider/hunter_die3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/ministrider/hunter_prestrike1.wav"}

ENT.FootStepSoundLevel = 90

ENT.BeforeMeleeAttackSoundPitch = VJ_Set(85, 115)
ENT.BeforeMeleeAttackSoundLevel = 100

local huntervoicevolume = 90
ENT.AlertSoundLevel = huntervoicevolume
ENT.PainSoundLevel = huntervoicevolume
ENT.DeathSoundLevel = huntervoicevolume
ENT.CombatIdleSoundLevel = huntervoicevolume
ENT.InvestigateSoundLevel = huntervoicevolume

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "MiniStrider.body_joint", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(20, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

    self:SetCollisionBounds(Vector(-16,-16,0), Vector(16,16,90))

    self.NextMainRangeAttackTime = CurTime()
    self.NextAnyAttackTime = CurTime()
    self.NextChargeTime = CurTime()

    self.ShootSound = CreateSound(self, "npc/ministrider/hunter_fire_loop3.wav")
    self.ShootSound:SetSoundLevel(90)

    self.PreShootSound = CreateSound(self, "npc/ministrider/ministrider_preflechette.wav")
    self.PreShootSound:SetSoundLevel(90)

    self.ShootTimerName = "VJHunterZShootTimer" .. self:EntIndex()
    self.BurstTimerName = "VJHunterZBurstTimer" .. self:EntIndex()

    --self:SetBloodColor(BLOOD_COLOR_MECH)

    self.DropshipDrop_ShouldCheckHitGround = false
    timer.Simple(0.66, function() if IsValid(self) then self.DropshipDrop_ShouldCheckHitGround = true end end)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)

    if ev == 2050 or ev == 2051 then
        self:FootStepSoundCode()
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()

    local rand = math.random(1, 3)
    self.MeleeAttackExtraTimers = nil

    if rand == 1 then
        self.AnimTbl_MeleeAttack = {"meleeleft","meleert"}
    elseif rand == 2 then
        self.AnimTbl_MeleeAttack = {"melee_02"}
    elseif rand == 3 then
        self.AnimTbl_MeleeAttack = {"hunter_cit_throw_ground"}
        self.MeleeAttackExtraTimers = {1.33}
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AllowedToRegularShoot()
    local seq = self:GetSequenceName(self:GetSequence())

    if self.ShootPos && (seq == "shoot_minigun" or seq == "plant") then
        return true
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AllowedToWalkShoot()
    local seq = self:GetSequenceName(self:GetSequence())

    if self.ShootPos && (seq == "canter_all" or seq == "prowl_all" or seq == "walk_all" or seq == "plant") then
        return true
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopShooting()
    timer.Remove(self.ShootTimerName)
    timer.Remove(self.BurstTimerName)

    self.ShootSound:Stop()

    if self.DoingMainRangeAttack then

        self.DoingMainRangeAttack = false

        self.NextAnyAttackTime = CurTime() + self.AttackCooldown
        self.NextMainRangeAttackTime = CurTime() + math.Rand( self.RangeAttackCooldown.min , self.RangeAttackCooldown.max )
        self.NextMiniShootBurstTime = nil

        if !self.DeathAnimationCodeRan then
            self:VJ_ACT_PLAYACTIVITY("unplant",true,1,false)
        end

    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Shoot(shoot_attachment)
    if !self.ShootSound:IsPlaying() then
        self.ShootSound:Play()
        self.ShootSound:ChangeVolume(0.66)
        self.ShootSound:ChangePitch(math.random(100,110))
    end

    local source = self:GetAttachment(shoot_attachment).Pos
    local shootdir = self.ShootPos+VectorRand()*self.ShootInaccuracy - source

    ParticleEffectAttach("vj_rifle_full_blue",PATTACH_POINT_FOLLOW,self,shoot_attachment)
    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "3")
    expLight:SetKeyValue("distance", "250")
    expLight:Fire("Color", "0 75 255")
    expLight:SetPos(source)
    expLight:Spawn()
    expLight:SetParent(self,shoot_attachment)
    expLight:Fire("TurnOn", "", 0)
    timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
    self:DeleteOnRemove(expLight)

    local flechette = ents.Create("obj_vj_flechette_z")
    flechette:SetOwner(self)
    flechette:SetPos(source)
    flechette:SetAngles(shootdir:Angle())
    flechette:Spawn()
    flechette:GetPhysicsObject():SetVelocity(shootdir:GetNormalized() * self.FlechetteSpeed)
    flechette.VJ_NPC_Class = self.VJ_NPC_Class

    self:EmitSound("npc/ministrider/ministrider_fire1.wav",110,math.random(90, 110),0.66,CHAN_WEAPON)

    if math.abs( self:WorldToLocalAngles(shootdir:Angle()).y ) > 45 then
        self:SetIdealYawAndUpdate( shootdir:Angle().y )
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttack(times)
    times = times or 0
    local IsMainRangeAttack = false
    if times == 0 then IsMainRangeAttack = true end

    local shoot_attachment = 5

    local timername = self.ShootTimerName
    if times != 0 then
        timername = self.BurstTimerName
    end

    timer.Create(self.ShootTimerName, 0.1, times, function()
        if IsValid(self) then
            if (IsMainRangeAttack && self:AllowedToRegularShoot()) or (!IsMainRangeAttack && self:AllowedToWalkShoot()) then
                self:Shoot(shoot_attachment)

                if shoot_attachment == 5 then
                    shoot_attachment = 4
                elseif shoot_attachment == 4 then
                    shoot_attachment = 5
                end
            else
                self:StopShooting()
            end

            if timer.RepsLeft(self.ShootTimerName) == 0 then
                self:StopShooting()
            end
        else
            timer.Remove(timername)
        end
    end)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartMainRangeAttack()
    if self.DoingMainRangeAttack then return end
    self.DoingMainRangeAttack = true

    local deploytime = self:SequenceDuration(self:LookupSequence("plant"))
    self:VJ_ACT_PLAYACTIVITY("plant",true,deploytime,true)

    self.PreShootSound:Play()
    self.PreShootSound:ChangePitch(140,deploytime)
    self.PreShootSound:ChangeVolume(0.5)

    timer.Simple(deploytime, function() if IsValid(self) && !self.DeathAnimationCodeRan then

        self.PreShootSound:Stop()

        local duration = math.Rand(self.RangeAttackDuration.min, self.RangeAttackDuration.max)

        self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,true,duration,false)
        self:RangeAttack()

        timer.Simple(duration, function() if IsValid(self) && self.DoingMainRangeAttack then
            
            self:StopShooting()

        end end)
    
    end end)

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp) -- return true to disable the attack and move onto the next entity!

    if IsValid(hitEnt) && !isProp then self:EmitSound("npc/ministrider/ministrider_skewer1.wav",80,math.random(85, 115)) end

end 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomMeleeDamage(damage) -- Used only for charge attack.

    local realisticRadius = false
    local damaged_ents = util.VJ_SphereDamage(self, self, self:GetPos() + self:GetForward()*50, 30, damage, DMG_CLUB, true, realisticRadius)
    local NPCWasHit = false


    for _,ent in pairs(damaged_ents) do

        local hitpos = ent:GetPos() + ent:OBBCenter()

        local attack_dir = (hitpos - self:GetPos()):GetNormalized()

        if ent:GetClass() == "func_breakable_surf" then
            ent:Fire("Shatter")
        end

        if ent:IsNPC() or ent:IsPlayer() then
            if ent:IsPlayer() then
                ent:SetVelocity( Vector( attack_dir.x , attack_dir.y , 0 ) + Vector(0,0,250) )
            elseif !ent.VJ_IsHugeMonster then
                ent:SetVelocity( Vector( attack_dir.x , attack_dir.y , 0 )*1500 + Vector(0,0,250) )
            end
            NPCWasHit = true
        end

        if ent:GetMoveType() == MOVETYPE_VPHYSICS && ent:IsSolid() then
            local physobj = ent:GetPhysicsObject()

            if IsValid(physobj) then
                physobj:SetVelocity(attack_dir * 400)
            end
        end

    end


    if NPCWasHit then
        self:EmitSound("NPC_Hunter.ChargeHitEnemy")
        return true
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopCharging(UseAnimation,nextcharge)

    if UseAnimation && !self.DeathAnimationCodeRan then self:VJ_ACT_PLAYACTIVITY("charge_miss_slide", true, 0.5, true) end

    self.Charging = false
    self.Charge_ShouldApplyForce = false

    self.NextChargeTime = CurTime() + nextcharge
    self.NextAnyAttackTime = CurTime() + self.AttackCooldown

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChargeAtEnemy(duration)
    if self.Charging then return end
    self.Charging = true
    self.Charge_ApplyForceCountdownStarted = false
    self.Charge_ShouldApplyForce = false

    timer.Simple(1, function() if IsValid(self) && self.Charging then self:EmitSound("npc/ministrider/hunter_charge" .. math.random(3, 4) .. ".wav" , huntervoicevolume ,math.random(85,115),1) end end)

    self:VJ_ACT_PLAYACTIVITY(ACT_SPECIAL_ATTACK1, true, duration, false)

    timer.Simple(duration, function() if IsValid(self) && self.Charging then
        self:StopCharging(true,self.ChargeCooldown)
    end end)

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChargeThink()

    if IsValid(self:GetEnemy()) && self:Visible(self:GetEnemy()) then
        self:SetIdealYawAndUpdate( (self:GetEnemy():GetPos() - self:GetPos() ):Angle().y )
    end

    if !self.Charge_ApplyForceCountdownStarted && self:GetActivity() == ACT_SPECIAL_ATTACK1 then

        self.Charge_ApplyForceCountdownStarted = true

        timer.Simple(0.45, function() if IsValid(self) then
            self.Charge_ShouldApplyForce = true
        end end)

    end

    local speed = 1250
    if self.Charge_ShouldApplyForce && self:IsOnGround() then
        self:SetVelocity(self:GetForward()*speed)
    end


    if self:CustomMeleeDamage(self.ChargeDamage) == true then -- Player or NPC was hit.
        self:StopCharging(true,self.ChargeCooldown)
    end

    local collision_positions = {
        self:GetPos() + self:GetForward()*60,
        self:GetPos() + self:GetForward()*60 + self:GetRight() * 35,
        self:GetPos() + self:GetForward()*60 - self:GetRight() * 35,
    }

    for k,pos in pairs(collision_positions) do
        if bit.band( util.PointContents(pos) , CONTENTS_SOLID ) == CONTENTS_SOLID then
            self:StopCharging(true,self.ChargeCooldown*0.5)
            --print("solid content found at point " .. k)
            break
        end
    end

    local trStartPos = self:GetPos()+self:GetForward()*50
    local tr = util.TraceLine({
        start = trStartPos,
        endpos = trStartPos - Vector(0,0,15),
        mask = MASK_NPCWORLDSTATIC,
    })

    if !tr.Hit then
        --print("no floor to charge on")
        self:StopCharging(true,self.ChargeCooldown*0.5)
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanChargeEnemy()
    if !IsValid(self:GetEnemy()) then return end

    local tr = util.TraceHull({
        start = self:GetPos(),
        endpos = self:GetEnemy():GetPos(),
        mask = MASK_NPCWORLDSTATIC,
        mins = self:OBBMins(),
        maxs = self:OBBMaxs(),
    })

    if self:Visible(self:GetEnemy()) && self:GetEnemy():IsOnGround() && !tr.Hit then
        return true
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Jumping()
    local act = self:GetActivity()

    if act == ACT_JUMP or act == ACT_GLIDE or act == ACT_LAND then
        --print("attack/flinch prevented due to jumping")
        return true
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Attacking()
    if self.Charging or self.DoingMainRangeAttack or self.MeleeAttacking then return true end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
    if self.DeathAnimationCodeRan then return end

    if self.IsBeingDroppedByDropship && self.DropshipDrop_ShouldCheckHitGround then
        if self:IsOnGround() && !self.DropshipDrop_SelfHasHitGround then
            self:VJ_ACT_PLAYACTIVITY("leap_start",true,0.66,false) -- It looks like a jump land animation
            self.DropshipDrop_SelfHasHitGround = true
        end
    end

    if !timer.Exists(self.ShootTimerName) && self:GetActivity() == ACT_RANGE_ATTACK1 then
        self:StopShooting()
        self:VJ_ACT_PLAYACTIVITY(ACT_IDLE,true,0.25,true)
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("MOUSE2 (secondary attack key): Shoot Flechettes")
    ply:ChatPrint("Shoot While Moving: Short Burst")
    ply:ChatPrint("Shoot While Standing Still: Long Burst")
	ply:ChatPrint("SPACE (jump key): Charge Attack")

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
    if self.DeathAnimationCodeRan or self.IsBeingDroppedByDropship then return end

    local enemy = self:GetEnemy()


    if IsValid(enemy) then

        if self.Charging then self:ChargeThink() end

        if self:Visible(enemy) then
            self.ShootPos = enemy:GetPos() + enemy:OBBCenter()
        end

        local enemydist = self:GetPos():Distance(enemy:GetPos())


        if !self.DoingAlertAnim && !self:Attacking() && !self:Jumping() then

            if self.VJ_IsBeingControlled then

                local controller = self.VJ_TheController

                if controller:KeyDown(IN_ATTACK2) && !(self:GetActivity() == ACT_RUN or self:GetActivity() == ACT_WALK) then
                    self:StartMainRangeAttack()
                end

                if controller:KeyDown(IN_JUMP) then
                    self:ChargeAtEnemy(6)
                end

            else

                if self.NextAnyAttackTime < CurTime() then
                    local rand = math.random(1, 2)
                    local attack_successful = false

                    if rand == 1 then

                        local tr = util.TraceLine({
                            start = self:GetPos()+self:OBBCenter(),
                            endpos = enemy:GetPos()+enemy:OBBCenter(),
                            mask = MASK_NPCWORLDSTATIC,
                        })

                        if !tr.Hit && self.ShootPos && self.NextMainRangeAttackTime < CurTime() && enemydist < self.ShootDistance && enemydist > self.MinShootDist then
                            self:StartMainRangeAttack()
                        end
                    elseif rand == 2 then
                        if self:CanChargeEnemy() && self.NextChargeTime < CurTime() && enemydist < self.ChargeDistance && enemydist > self.MinChargeDistance then
                            self:ChargeAtEnemy(6)
                        end
                    end
                end

            end

        end

        if self.VJ_IsBeingControlled then
            local controller = self.VJ_TheController

            if !self.NextMiniShootBurstTime then
                self.NextMiniShootBurstTime = CurTime()
            end

            if controller:KeyDown(IN_ATTACK2) && self.NextMiniShootBurstTime < CurTime() && (self:GetActivity() == ACT_RUN or self:GetActivity() == ACT_WALK) then
                self:RangeAttack(math.random(3,5))
                self.NextMiniShootBurstTime = CurTime() + self.MiniShootBurstCooldown
            end
        else
            local can_walk_shoot = self:Visible(enemy) && self:AllowedToWalkShoot() && enemydist < self.ShootDistance && enemydist > self.MinShootDist

            if !self.NextMiniShootBurstTime && can_walk_shoot then
                self.NextMiniShootBurstTime = CurTime() + self.MiniShootBurstCooldown
                --print("shoot timer started")
            end

            if self.NextMiniShootBurstTime && self.NextMiniShootBurstTime < CurTime() && can_walk_shoot then
                self:RangeAttack(math.random(3,5))
                self.NextMiniShootBurstTime = nil
            end

            -- if self.NextMiniShootBurstTime then
            --     print(self.NextMiniShootBurstTime-CurTime())
            -- end
        end
    
    else

        self:StopShooting()

        if self.Charging then
            self:StopCharging(false,self.ChargeCooldown*0.5)
            self:VJ_ACT_PLAYACTIVITY(ACT_IDLE,true,0.25,false)
        end

        self.ShootPos = nil
        self.NextMiniShootBurstTime = nil

    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnIsJumpLegal(startPos, apex, endPos) -- Return nothing to let base decide, return true to make it jump, return false to disallow jumping
    if self:Attacking() then --print("jump prevented due to attacking")
        return false
    end
end 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
    if self.IsBeingDroppedByDropship then return end

    self.DoingAlertAnim = true

    local anim = table.Random({
        "hunter_angry",
        "hunter_angry_2",
        --"hunter_cit_stomp", -- naaaah
        "hunter_respond_1",
        "hunter_respond_3",
        "hunter_call_1",
    })
    local duration = self:SequenceDuration(self:LookupSequence(anim)) - 0.33

    self:VJ_ACT_PLAYACTIVITY(anim, true, duration, true)
    timer.Simple(duration, function() if IsValid(self) then self.DoingAlertAnim = false end end)

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

    if math.random(1, 4) == 1 then
        self:AddGesture(ACT_SMALL_FLINCH)
    end

    local infl = dmginfo:GetInflictor()
    local comballdamage = false

    if infl && IsValid(infl) then
        if infl:GetClass() == "prop_combine_ball" then
            infl:Fire("Explode")
            comballdamage = true
        end

        if !infl.DamagedVJ_ZHunter && infl:GetClass() == "obj_vj_combineball" then
            infl.DamagedVJ_ZHunter = true
            infl:DeathEffects()
            comballdamage = true
        end
    end

    if !dmginfo:IsExplosionDamage() && !comballdamage then

        if math.random(1, 4) == 1 then
            self.Bleeds = true
        else
            if math.random(1, 4) == 1 then self:EmitSound("weapons/fx/rics/ric1.wav", 82, math.random(85, 115)) end
            
            local spark = ents.Create("env_spark")
            spark:SetPos(dmginfo:GetDamagePosition())
            spark:Spawn()
            spark:Fire("StartSpark", "", 0)
            spark:Fire("StopSpark", "", 0.001)
            self:DeleteOnRemove(spark)

            self.Bleeds = false
        end

        dmginfo:SetDamage(dmginfo:GetDamage()*0.5)

    end

    if comballdamage then
        dmginfo:SetDamage(150)
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup) -- Return false to disallow the flinch from playing

    if dmginfo:GetDamage() < 80 then
        return false
    end

    if self:Jumping() then return false end

    if self.Charging then
        self:StopCharging(false,self.NextChargeTime*0.5)
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()

    self.ShootSound:Stop()
    self.PreShootSound:Stop()

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------