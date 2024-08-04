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


ENT.Model = {"models/vjcrabsynth_z.mdl"}
ENT.StartHealth = 415
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.TurningSpeed = 12 -- How fast it can turn
ENT.VJ_IsHugeMonster = true

ENT.BloodColor = "Yellow"

ENT.InvestigateSoundDistance = 36
ENT.CallForHelpDistance = 10000 -- -- How far away the SNPC's call for help goes | Counted in World Units

ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {
    "death01",
    "death02",
    "death03",
}

ENT.SoundTbl_FootStep = {"npc/vj_crabsynth_z/cs_step01.wav","npc/vj_crabsynth_z/cs_step02.wav","npc/vj_crabsynth_z/cs_step03.wav"}
ENT.SoundTbl_Idle = {"npc/vj_crabsynth_z/cs_idle01.wav","npc/vj_crabsynth_z/cs_idle02.wav","npc/vj_crabsynth_z/cs_idle03.wav"}
ENT.SoundTbl_CombatIdle = ENT.SoundTbl_Idle
ENT.SoundTbl_Investigate = {"npc/vj_crabsynth_z/cs_distant01.wav","npc/vj_crabsynth_z/cs_distant02.wav"}
ENT.SoundTbl_Alert = {"npc/vj_crabsynth_z/cs_alert01.wav","npc/vj_crabsynth_z/cs_alert02.wav","npc/vj_crabsynth_z/cs_alert03.wav"}
ENT.SoundTbl_Pain = {"npc/vj_crabsynth_z/cs_roar01.wav","npc/vj_crabsynth_z/cs_roar02.wav"}
ENT.SoundTbl_Death = {"npc/vj_crabsynth_z/cs_die.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/vj_crabsynth_z/cs_pissed01.wav"}

ENT.FootStepSoundLevel = 85
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?

ENT.AlertSoundLevel = 100
ENT.PainSoundLevel = 100
ENT.DeathSoundLevel = 100
ENT.InvestigateSoundLevel = 100
ENT.CombatIdleSoundLevel = 100

ENT.BeforeMeleeAttackSoundPitch = VJ_Set(85, 115)
ENT.BeforeMeleeAttackSoundLevel = 100

ENT.BulletSpread = 0.075

ENT.ShootDuration_Far = 5
ENT.ShootDuration_Close = 2

ENT.ShootCooldown_Far = 5
ENT.ShootCooldown_Close = 8

ENT.ChargeDuration = 5
ENT.ChargeCooldown = 5
ENT.ChargeDamage = 60

ENT.DisableDefaultMeleeAttackDamageCode = true -- Disables the default melee attack damage code
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.NextMeleeAttackTime = 0.66 -- How much time until it can use a melee attack?
ENT.MeleeDamage = 40

ENT.MinPrioritizeShootDist = 1000 -- If the enemy is closer than this then start prioritizing the charge attack instead.
ENT.MaxShootDist = 2000
ENT.MinShootDist = 500
ENT.MaxShootHeightDifference = 300

ENT.RunAwayOnUnknownDamage = false -- Should run away on damage

ENT.DeathCorpseApplyForce = false


ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(-50, 0, 50), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Bip02 Neck", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(25, 0, 25), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

    self:SetCollisionBounds(Vector(-50,-50,0), Vector(50,50,85))

    self.FireGunLoop = CreateSound(self,"npc/vj_crabsynth_z/minigun_loop.wav")
    self.FireGunLoop:SetSoundLevel(140)

    self.NextShootTime = CurTime()
    self.NextChargeTime = CurTime()

	self.Bullseye = ents.Create("obj_vj_Bullseye")
	self.Bullseye:SetModel("models/hunter/blocks/cube1x1x025.mdl")
	self.Bullseye:SetParent(self)
	self.Bullseye:SetPos(self:GetPos() + self:GetForward()*100 + Vector(0,0,15))
	self.Bullseye:Spawn()
	self.Bullseye:SetNoDraw(true)
	self.Bullseye:DrawShadow(false)
	self.Bullseye:SetSolid(SOLID_NONE)
	self.Bullseye.VJ_NPC_Class = self.VJ_NPC_Class

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopFiringRoutine(skipcooldown)
    if !self.GunAttacking or self.DeathAnimationCodeRan then return end

    self.ShootPos = nil
    self.GunAttacking = false

    self.FireGunLoop:Stop()

    self:EmitSound("npc/vj_crabsynth_z/minigun_stop.wav",105,math.random(90, 110))
    self:VJ_ACT_PLAYACTIVITY(ACT_IDLE, true, 0)

    if !skipcooldown then
        self.NextShootTime = CurTime() + self.CurrentShootCoolDown
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartGunAttack(duration)
    if self.GunAttacking then return end
    self.GunAttacking = true

    local timeuntilstartfire = 1.6
    self:EmitSound("npc/vj_crabsynth_z/minigun_start.ogg",105,math.random(90, 110))

    self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, timeuntilstartfire, true)

    timer.Simple(timeuntilstartfire, function() if IsValid(self) && self.GunAttacking && !self.DeathAnimationCodeRan then

        self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1, true, duration, false)

        timer.Simple(duration, function() if IsValid(self) && self.GunAttacking then
            self:StopFiringRoutine()
        end end)
    
    end end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TryUpdateShootPos()

    local enemy = self:GetEnemy()
    
    if IsValid(enemy) && self:Visible(enemy) then
        self.ShootPos = enemy:GetPos() + enemy:OBBCenter()
    end

    local mypos = self:GetPos() + self:OBBCenter()
    if self.ShootPos then
        self.ShootPos = Vector( self.ShootPos.x , self.ShootPos.y , math.Clamp(self.ShootPos.z,mypos.z-self.MaxShootHeightDifference,mypos.z+self.MaxShootHeightDifference) )
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:VisuallyAimGunTowardsEnemy()

    local bullet_source = self:GetAttachment(1).Pos
    local fire_dir = ( self.ShootPos - bullet_source ):GetNormalized()
    local fire_ang = self:WorldToLocalAngles(fire_dir:Angle())

    local poseparam_yaw = math.Clamp( fire_ang.y*2.5, -45, 45 )

    self:SetPoseParameter( "weapon_yaw", poseparam_yaw )
    self:SetPoseParameter( "weapon_pitch", fire_ang.x )

    if math.abs(poseparam_yaw) == 45 then
        self:SetIdealYawAndUpdate(fire_dir:Angle().y)
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopCharging(UseAnimation,nextcharge)
    if self.DeathAnimationCodeRan then return end

    if UseAnimation then self:VJ_ACT_PLAYACTIVITY("chargeend", true, duration, true) end

    self.Charging = false
    self.Charge_ShouldApplyForce = false

    self.NextChargeTime = CurTime() + nextcharge

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChargeAtEnemy(duration)
    if self.Charging then return end
    self.Charging = true
    self.Charge_ApplyForceCountdownStarted = false
    self.Charge_ShouldApplyForce = false

    self:VJ_ACT_PLAYACTIVITY(ACT_SPECIAL_ATTACK1, true, duration, false)

    timer.Simple(duration, function() if IsValid(self) && self.Charging then
        self:StopCharging(true,self.ChargeCooldown)
    end end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterStartTimer(seed)
    timer.Simple(0.2, function() if IsValid(self) && !self.DeathAnimationCodeRan then self:CustomMeleeDamage(self.MeleeDamage) end end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomMeleeDamage(damage,damagetype)

    damagetype = damagetype or DMG_SLASH

    local realisticRadius = false
    local damaged_ents = util.VJ_SphereDamage(self, self, self:GetPos() + self:GetForward()*50, 50, damage, damagetype, true, realisticRadius)
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
        self:EmitSound("npc/vj_crabsynth_z/cs_skewer.wav",85,math.random(90, 110))
        self:EmitSound("NPC_Hunter.ChargeHitEnemy")
        return true
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChargeThink()

    if IsValid(self:GetEnemy()) && self:Visible(self:GetEnemy()) then
        self:SetIdealYawAndUpdate( (self:GetEnemy():GetPos() - self:GetPos() ):Angle().y )
    end

    if !self.Charge_ApplyForceCountdownStarted && self:GetActivity() == ACT_SPECIAL_ATTACK1 then

        self.Charge_ApplyForceCountdownStarted = true

        timer.Simple(0.6, function() if IsValid(self) then
            self.Charge_ShouldApplyForce = true
        end end)

    end

    local speed = 950
    if self.Charge_ShouldApplyForce && self:IsOnGround() then
        self:SetVelocity(self:GetForward()*speed)
    end


    if self:CustomMeleeDamage(self.ChargeDamage, bit.bor(DMG_CLUB,DMG_CRUSH,DMG_SLASH)) == true then -- Player or NPC was hit.
        self:StopCharging(false,self.ChargeCooldown)
        self:VJ_ACT_PLAYACTIVITY("chargestop", true, duration, true)
    end

    local collision_positions = {
        self:GetPos() + self:GetForward()*100,
        self:GetPos() + self:GetForward()*100 + self:GetRight() * 65,
        self:GetPos() + self:GetForward()*100 - self:GetRight() * 65,
    }

    for k,pos in pairs(collision_positions) do
        if bit.band( util.PointContents(pos) , CONTENTS_SOLID ) == CONTENTS_SOLID then
            self:StopCharging(true,self.ChargeCooldown*0.5)
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
        self:StopCharging(true,self.ChargeCooldown*0.5)
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanChargeEnemy()

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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("MOUSE2 (secondary attack key): Fire Minigun")
	ply:ChatPrint("SPACE (jump key): Charge Attack")

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Attacking() if self.Charging or self.GunAttacking or self.MeleeAttacking then return true end end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.CurrentShootCoolDown = ENT.ShootCooldown_Far

function ENT:CustomOnThink_AIEnabled()
    if self.DeathAnimationCodeRan then return end

    local enemy = self:GetEnemy()

    if IsValid(enemy) then

        if self.VJ_IsBeingControlled then

            local controller = self.VJ_TheController

            if !self:Attacking() then

                if controller:KeyDown(IN_ATTACK2) then
                    self:StartGunAttack(3)
                elseif controller:KeyDown(IN_JUMP) && self.NextChargeTime < CurTime() then
                    self:ChargeAtEnemy(5)
                end

            end

        else

            local enemydist = self:GetPos():Distance(enemy:GetPos())

            local fireduration = self.ShootDuration_Far
            self.CurrentShootCoolDown = self.ShootCooldown_Far
        
            if enemydist < self.MinPrioritizeShootDist then

                fireduration = self.ShootDuration_Close
                self.CurrentShootCoolDown = self.ShootCooldown_Close

                if !self:Attacking() && self.NextChargeTime < CurTime() && self:CanChargeEnemy() then
                    self:ChargeAtEnemy(self.ChargeDuration)
                end

            end

            if self:Visible(self:GetEnemy()) then
                self:TryUpdateShootPos()
            end

            if !self:Attacking() && self.NextShootTime < CurTime() && enemydist < self.MaxShootDist && ( enemydist > self.MinShootDist or !self:CanChargeEnemy() ) then
        
                local mypos = self:GetPos() + self:OBBCenter()
                local targetpos = self.ShootPos or enemy:GetPos()

                if (self:Visible(enemy) or self.ShootPos) && math.abs(mypos.z - targetpos.z) < self.MaxShootHeightDifference then
                    self:StartGunAttack(fireduration)
                end
                
            end

            if !self:Visible(enemy) && !self.ShootPos then
                self:StopFiringRoutine(true)
            end
        
        end

        if self.ShootPos && self.GunAttacking then self:VisuallyAimGunTowardsEnemy() end
        if self.Charging then self:ChargeThink() end

    elseif !IsValid(enemy) then

        if self.Charging then
            self:StopCharging(true,self.ChargeCooldown*0.5)
        end

        if self.GunAttacking then
            self:StopFiringRoutine(true)
        end

        self.ShootPos = nil


    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()

    self.Bullseye.VJ_NPC_Class = self.VJ_NPC_Class

    if GetConVar("ai_disabled"):GetInt() == 1 then
        self:StopFiringRoutine(true)
    end

    if !self.GunAttacking && self.FireGunLoop:IsPlaying() then
        self.FireGunLoop:Stop()
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireGun()

    --self:TryUpdateShootPos()

    local bullet_source = self:GetAttachment(1).Pos
    local shootpos = self.ShootPos or bullet_source+self:GetForward()*100
    local fire_dir = ( (shootpos) - bullet_source ):GetNormalized()


    if math.random(1, 2) == 1 then
        local expLight = ents.Create("light_dynamic")
        expLight:SetKeyValue("brightness", "3")
        expLight:SetKeyValue("distance", "250")
        expLight:Fire("Color", "0 75 255")
        expLight:SetPos(bullet_source)
        expLight:Spawn()
        expLight:SetParent(self,1)
        expLight:Fire("TurnOn", "", 0)
        timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
        self:DeleteOnRemove(expLight)
        ParticleEffect("vj_rifle_full_blue",bullet_source,self:GetAttachment(2).Ang)
    end

    self:FireBullets({
        Src = bullet_source,
        Dir = fire_dir,
		Damage = 3,
		Force = 25,
        TracerName = "AirboatGunHeavyTracer",
        Tracer = 2,
        Spread = Vector( self.BulletSpread,self.BulletSpread,self.BulletSpread ),
        Num = 1,
		Callback = function(attacker, tracer)
            if math.random(1, 4) == 1 then
                local effectdata = EffectData()
                effectdata:SetOrigin(tracer.HitPos)
                effectdata:SetNormal(tracer.HitNormal)
                effectdata:SetRadius( 10 )
			    util.Effect( "cball_bounce", effectdata )
            end
            effects.BeamRingPoint( tracer.HitPos, 0.2, 0, 70, 12, 12, Color(255,255,175) )
			util.VJ_SphereDamage(self,self,tracer.HitPos,20,3,DMG_SONIC,true,false,false,false)
		end,
    })

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)

    if ev == 1004 then self:FootStepSoundCode() end

    if ev == 28 && self.GunAttacking then

        self:FireGun()
        
        if !self.FireGunLoop:IsPlaying() then
            self.FireGunLoop:Play()
        end

    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

    self.HasPainSounds = false
    self.Bleeds = false

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

    if !( dmginfo:GetDamagePosition().z < (self:GetPos()+self:OBBCenter()+Vector(0,0,-8)).z && dmginfo:IsExplosionDamage() ) && !comballdamage then

        dmginfo:SetDamage(dmginfo:GetDamage()*0.1)

        if math.random(1, 4) == 1 then
            self.Bleeds = true
            self:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 92, math.random(70, 90))
            self.Spark1 = ents.Create("env_spark")
            self.Spark1:SetPos(dmginfo:GetDamagePosition())
            self.Spark1:Spawn()
            self.Spark1:Fire("StartSpark", "", 0)
            self.Spark1:Fire("StopSpark", "", 0.001)
            self:DeleteOnRemove(self.Spark1)
        end

    else

        self.Bleeds = true
        self.HasPainSounds = true

        if comballdamage then
            dmginfo:SetDamage(150)
        end
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()

    self.FireGunLoop:Stop()

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------