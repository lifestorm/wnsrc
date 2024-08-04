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

ENT.Model = {"models/Combine_Helicopter.mdl"}
ENT.SightAngle = 100
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.StartHealth = 525
ENT.MovementType = VJ_MOVETYPE_AERIAL
ENT.TurningSpeed = 4
ENT.VJ_IsHugeMonster = true

ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.Aerial_FlyingSpeed_Calm = 400 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking compared to ground SNPCs
ENT.Aerial_FlyingSpeed_Alerted = 800 -- The speed it should fly with, when it's chasing an enemy, moving away quickly, etc. | Basically running compared to ground SNPCs
ENT.AA_GroundLimit = 750

ENT.ConstantlyFaceEnemy = false -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemyDistance = 10000 -- How close does it have to be until it starts to face the enemy?
ENT.HasMeleeAttack = false

ENT.HasGibOnDeathSounds = false
ENT.GibOnDeathDamagesTable = {"All"}
ENT.HasDeathRagdoll = false -- If set to false, it will not spawn the regular ragdoll of the SNPC

ENT.SoundTbl_Alert = {"npc/attack_helicopter/aheli_megabomb_siren1.wav"}
ENT.SoundTbl_Pain = {"npc/attack_helicopter/aheli_damaged_alarm1.wav"}

ENT.PainSoundLevel = 95
ENT.AlertSoundLevel = 95

ENT.ShootDist = 3000
ENT.BulletSpread = 0.066
ENT.BulletsUntilReload = 60
ENT.GunCooldownTime = 2.5

ENT.Heli_MinChaseDist = ENT.ShootDist
ENT.Heli_BackAwayFromEnemyDist = 1000

ENT.BombDropDelay = 0.66
ENT.MaxBombDistFromEnemy = 1000

ENT.HeliLights = true
ENT.Heli_CanCrash = true
ENT.Heli_CanBomb = true
ENT.CrashAlarmSound = "npc/attack_helicopter/aheli_crash_alert2.wav"

ENT.AimYawPoseParam = "weapon_yaw"
ENT.AimPitchPoseParam = "weapon_pitch"
ENT.FlipAimPitchPoseParam = true

ENT.RotorSound = "NPC_AttackHelicopter.Rotors"
ENT.ShootSound = "npc/attack_helicopter/aheli_weapon_fire_loop3.wav"

ENT.HasRockets = true
ENT.RocketDistance = 4500
ENT.RocketCoolDown = {
    min = 2.5,
    max = 5,
}

ENT.DiveCooldown = 16

ENT.CanShootDownRockets = false


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

	ply:ChatPrint("NOTE: Controlling is not really supported for this SNPC!!")

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomHeliInit() end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

    -- Used by gunship.
    self.body_vert_noise = 0
    self.body_horz_noise = 0

    self.NextDiveTime = CurTime()

    self:SetCollisionBounds(Vector(125,125,90), Vector(-125,-125,-90))
	timer.Simple(0.01,function() if IsValid(self) then self:SetPos(self:GetPos() + self:GetUp() * 400) end end)

    self.CurrentAimPoseParamAng = Angle(0,0,0)

    self.AngleNoiseOffset = math.Rand(0, 2*math.pi)
    self.pitchAdd_NoiseSpeedOffset = math.Rand(0.9, 1.1)
    self.rollAdd_NoiseSpeedOffset = math.Rand(0.9, 1.1)

    self.MoveNoiseOffset = math.Rand(0,2*math.pi)
    self.MoveX_NoiseSpeedOffset = math.Rand(0.9, 1.1)
    self.MoveY_NoiseSpeedOffset = math.Rand(0.9, 1.1)
    self.MoveZ_NoiseSpeedOffset = math.Rand(0.9, 1.1)

    self.RotorSoundLoop = CreateSound(self, self.RotorSound)
    self.RotorSoundLoop:SetSoundLevel(130)
    self.RotorSoundLoop:Play()

    self.ShootGunLoop = CreateSound(self, self.ShootSound)
    self.ShootGunLoop:SetSoundLevel(140)
    self.ShootGunLoop:ChangePitch(88)

    self.NextRocketTime = CurTime()

    self.DisableChasingEnemy = true -- This gets changed when an enemy is present.

    self.BulletsFired = 0
    self.GunHasCooledDown = true

    self.NextDropBombTime = CurTime()
    self.ExplosiveRollerMine = NULL

    if self.Heli_CanCrash then
        self.WaitBeforeDeathTime = 5 -- Time until the SNPC spawns its corpse and gets removed
    end

    self:CustomHeliInit()


    if !self.HeliLights then return end

    for i = 9,11 do
        local light = ents.Create( "env_sprite" )
        light:SetKeyValue( "rendercolor","200 0 0" )
        --light:SetKeyValue( "renderfx","8" )
        light:SetKeyValue( "rendermode","9" )
        light:SetKeyValue( "model","sprites/blueflare1.spr" )
        light:SetKeyValue( "scale","1" )
        light:SetPos( self:GetAttachment(i).Pos )
        light:Spawn()
        light:SetParent( self , i )
        self:DeleteOnRemove(light)

        light.IsOn = true

        local timername = "VJHeli" .. self:EntIndex() .. "BlinkTimer" .. i

        timer.Create(timername, 0.5, 0, function()
    
            if !IsValid(light) then
                timer.Remove(timername)
                return
            end

            if light.IsOn then
                light.IsOn = false
                light:SetKeyValue( "rendercolor","0 0 0" )
            else
                light.IsOn = true
                light:SetKeyValue( "rendercolor","200 0 0" )
            end

        end)

    end

    self.Spotlight = ents.Create("point_spotlight")
    self.Spotlight:SetPos( self:GetAttachment(12).Pos )
    self.Spotlight:SetAngles( self:GetAttachment(12).Ang )
    self.Spotlight:SetKeyValue( "spawnflags", "1" )
    self.Spotlight:SetKeyValue( "spotlightlength", "300" )
    self.Spotlight:SetKeyValue( "spotlightwidth", "30" )
    self.Spotlight:SetColor(Color(150,150,150,255))
    self.Spotlight:SetParent(self)
    self.Spotlight:Spawn()
    self.Spotlight:Activate()

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ENT.CurPitchAdd = 0
-- ENT.CurRollAdd = 0

-- ENT.Past_Pitch_Add = 0
-- ENT.Past_Roll_Add = 0

-- ENT.Current_Angle_to_apply = Angle(0,0,0)

function ENT:MovementThink()

    ----------------------------------------------------------------------------------------
     -- Crash movement:
    ----------------------------------------------------------------------------------------
    if self.Crashing then
        self:SetVelocity(Vector(0,0,-25) + self.CrashDir * 25)
        return
    end


    ----------------------------------------------------------------------------------------
    local sin = math.sin
    local time = CurTime()

    ----------------------------------------------------------------------------------------
     -- Movement pitch and roll:
    ----------------------------------------------------------------------------------------
    -- local ideal_pitch_add = math.Clamp( self:WorldToLocal( self:GetPos()+self:GetVelocity() ).x , -45, 45)
    -- local ideal_pitch_roll = ideal_angle_add.z

    -- print("pitch input: " .. ideal_pitch_add)

    -- local newangle = self:GetAngles() + Angle( ideal_pitch_add - self.Past_Pitch_Add , 0 , 0 )


    -- self.Current_Pitch_to_apply = newangle.
    -- print("pitch output: " .. self.Current_Pitch_to_apply)

    -- self:SetAngles( self.Current_Angle_to_apply )

    -- self.Past_Pitch_Add = ideal_pitch_add
    -- self.Past_Roll_Add = ideal_pitch_roll

    ----------------------------------------------------------------------------------------
     -- Angle noise:
    ----------------------------------------------------------------------------------------

    local AngleNoiseSpeedMult = 2
    local pitchAdd_noise = sin(time*self.pitchAdd_NoiseSpeedOffset*AngleNoiseSpeedMult + self.AngleNoiseOffset) 
    local rollAdd_noise = sin(time*self.rollAdd_NoiseSpeedOffset*AngleNoiseSpeedMult + self.AngleNoiseOffset)

    self:SetAngles( self:GetAngles() + Angle(pitchAdd_noise*0.5, 0, rollAdd_noise*0.5) )

    ----------------------------------------------------------------------------------------
     -- Move noise:
    ----------------------------------------------------------------------------------------

    local MoveNoiseIntensity = 15
    local move_x_noise = sin(time*self.MoveX_NoiseSpeedOffset + self.MoveNoiseOffset) 
    local move_y_noise = sin(time*self.MoveY_NoiseSpeedOffset + self.MoveNoiseOffset) 
    local move_z_noise = sin(time*self.MoveZ_NoiseSpeedOffset + self.MoveNoiseOffset)

    if self.AA_CurrentMovePos or self.MovementType == VJ_MOVETYPE_STATIONARY then
        self:SetVelocity(  Vector(move_x_noise,move_y_noise,move_z_noise)*MoveNoiseIntensity )
    else
        self:SetLocalVelocity(  Vector(move_x_noise,move_y_noise,move_z_noise)*MoveNoiseIntensity )
    end

    ----------------------------------------------------------------------------------------
     -- Hover thing:
    ----------------------------------------------------------------------------------------
    if self.MovementType == VJ_MOVETYPE_STATIONARY then
        self:SetLocalVelocity(self:GetVelocity() * 0.7) -- Ease in velocity when movetype is stationary.
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:UnchargeGun()

    self.GunCharged = false
    self:EmitSound( "npc/combine_gunship/attack_stop2.wav", 100, 85)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ConsiderDive()
    if self.Diving or self.NextDiveTime > CurTime() then return end

    if math.random(1,2) == 1 then
        self.Diving = true
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoGunAttack()

    local bullet_source = self:GetAttachment(2).Pos
    local fire_dir = (self.ShootPos - bullet_source):GetNormalized()

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "5")
    expLight:SetKeyValue("distance", "250")
    expLight:Fire("Color", "0 75 255")
    expLight:SetPos(bullet_source)
    expLight:Spawn()
    expLight:SetParent(self,2)
    expLight:Fire("TurnOn", "", 0)
    timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
    self:DeleteOnRemove(expLight)
    ParticleEffectAttach("vj_rifle_full_blue",PATTACH_POINT_FOLLOW,self,2)

    self:FireBullets({
        Src = bullet_source,
        Dir = fire_dir,
		Damage = 2,
		Force = 25,
        TracerName = "AirboatGunHeavyTracer",
        Spread = Vector( self.BulletSpread,self.BulletSpread,self.BulletSpread ),
        Num = 2,
		Callback = function(attacker, tracer)
            if math.random(1, 4) == 1 then
                local effectdata = EffectData()
                effectdata:SetOrigin(tracer.HitPos)
                effectdata:SetNormal(tracer.HitNormal)
                effectdata:SetRadius( 10 )
			    util.Effect( "cball_bounce", effectdata )
            end
            effects.BeamRingPoint( tracer.HitPos, 0.2, 0, 70, 12, 12, Color(255,255,175) )
			util.VJ_SphereDamage(self,self,tracer.HitPos,20,2,DMG_SONIC,true,false,false,false)
		end,
    })

    self.BulletsFired = self.BulletsFired + 1

    if self.BulletsFired >= self.BulletsUntilReload then

        self:UnchargeGun()

        self.GunHasCooledDown = false
        timer.Simple(self.GunCooldownTime, function() if IsValid(self) then self.GunHasCooledDown = true end end)

        if self.Diving then self.Diving = false end
        self:ConsiderDive()

    end

    self.GunFiring = true

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChargeGun()

    if self.GunCharging then return end

    self.GunCharging = true
    self.BulletsFired = 0

    self:EmitSound("npc/attack_helicopter/aheli_charge_up.wav", 100,  math.random(110, 120))
    self:EmitSound("weapons/cguard/charging.wav", 100, math.random(70, 80) , 0.3)
    self:EmitSound( "npc/combine_gunship/attack_start2.wav", 100, 85)

    local gun_charge_time = 2

    timer.Simple(gun_charge_time, function() if IsValid(self) then

        self.GunCharged = true
        self.GunCharging = false

    end end)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AimGun()
    local enemy = self:GetEnemy()

    if IsValid(self.EnemyRocket) && self:Visible(self.EnemyRocket) then
        self.ShootPos = self.EnemyRocket:GetPos()
    elseif self:Visible(enemy) then
        self.ShootPos = enemy:GetPos() + enemy:OBBCenter()
    end

    if self.ShootPos then
        self:FaceCertainPosition(self.ShootPos,0.2)
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Explode(dmginfo, hitgroup)

	self:EmitSound("NPC_CombineGunship.Explode", 120, 100)
    self:EmitSound( "Explo.ww2bomb", 130, 100)

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )

	ParticleEffect("vj_explosion1", self:GetPos(), Angle(0,0,0), nil)
    ParticleEffect( "striderbuster_explode_dummy_core", self:GetPos(), self:GetAngles() )

    util.VJ_SphereDamage(self,self,self:GetPos(),600,150,DMG_BLAST,true,true,false,false)

    local _,boneang = self:GetBonePosition(1)

    self:CreateGibEntity("obj_vj_gib","models/gibs/helicopter_brokenpiece_01.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/helicopter_brokenpiece_02.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/helicopter_brokenpiece_03.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/helicopter_brokenpiece_02.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/helicopter_brokenpiece_03.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/helicopter_brokenpiece_05_tailfan.mdl",{BloodType = "", Pos = self:LocalToWorld(Vector(-200,0,0)), Ang = boneang, Vel = self:GetVelocity(), AngVel = VectorRand()*50, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/helicopter_brokenpiece_06_body.mdl",{BloodType = "", Ang = boneang, Vel = self:GetVelocity(), AngVel = VectorRand()*50, CollideSound = {"SolidMetal.ImpactSoft"}})

    self:Remove()

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Crash()

    if self.Crashing then return end

	if self.HeliLights && IsValid(self.Spotlight) then
		self.Spotlight:SetParent()
		self.Spotlight:Fire("lightoff")
		self.Spotlight:Fire("kill",self.Spotlight, 0.5)
	end

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )

	ParticleEffect("vj_explosion1", self:GetPos(), Angle(0,0,0), nil)
    ParticleEffect( "striderbuster_explode_dummy_core", self:GetPos(), self:GetAngles() )
    ParticleEffectAttach("burning_engine_01",PATTACH_ABSORIGIN_FOLLOW,self,0)

    self.Crashing = true
    self.ConstantlyFaceEnemy = false

    self:VJ_ACT_PLAYACTIVITY("tailspin_loop" , true , 100 , false)
    
	self:EmitSound("NPC_CombineGunship.Explode", 120, 100)
    self:EmitSound( "Explo.ww2bomb", 130, 100)

    self.CrashAlarm = CreateSound(self, self.CrashAlarmSound)
    self.CrashAlarm:SetSoundLevel(100)
    self.CrashSound = CreateSound(self, "npc/attack_helicopter/aheli_crashing_loop1.wav")
    self.CrashSound:SetSoundLevel(125)

    self.RotorSoundLoop:Stop()
    self.CrashAlarm:Play()
    self.CrashSound:Play()

    local ang_rand = AngleRand()
    self.CrashDir = Angle(0, ang_rand.y, ang_rand.z):Forward():GetNormalized()

    self.StartTouch = function()
        self:Explode()
    end

    timer.Simple(4, function() if IsValid(self) then self:Explode() end end)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomHeliThink() end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()

    self:CustomHeliThink()

    if self.Heli_CanCrash && self:Health() < 1 then self:Crash() end


    self:MovementThink()


    if self.GunFiring && !self.ShootGunLoop:IsPlaying() then
        self.ShootGunLoop:Play()
    elseif !self.GunFiring && self.ShootGunLoop:IsPlaying() then
        self.ShootGunLoop:Stop()
    end
    self.GunFiring = false -- Is set to true automaticly when firing.


    -- if self.HeavyDamagePoint then
    --     if !self.CurrentRepelSpeed then
    --         self.CurrentRepelSpeed = 350
    --     end
    --     self.CurrentRepelSpeed = self.CurrentRepelSpeed - 25

    --     if self.CurrentRepelSpeed < 1 then
    --         self.HeavyDamagePoint = nil
    --         self.CurrentRepelSpeed = nil
    --     else
    --         print(self.CurrentRepelSpeed)
    --         self:SetVelocity( (self:GetPos()-self.HeavyDamagePoint):GetNormalized()*self.CurrentRepelSpeed )
    --     end
    -- end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:EnemyInBombDistance()

    local tr = util.TraceLine({
        start = self:GetPos(),
        endpos = self:GetPos() - Vector(0,0,10000),
        mask = MASK_NPCWORLDSTATIC,
    })

    local BombSpot = tr.HitPos

    if self:GetEnemy():GetPos():Distance(BombSpot) < self.MaxBombDistFromEnemy then
        return true
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DropBomb(bombent)

    local bomb = ents.Create(bombent)
    bomb:SetPos(self:GetAttachment(3).Pos)
    bomb:Spawn()
    bomb:GetPhysicsObject():SetVelocity(self:GetVelocity())
    --constraint.NoCollide(self, bomb)

    if bombent == "npc_vj_rollermine_explosive_z" then
        bomb.VJ_NPC_Class = self.VJ_NPC_Class
        self.ExplosiveRollerMine = bomb
    end

    self:AddGesture(self:GetSequenceActivity(self:LookupSequence("Deploy")))

    self:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav", 110 , math.random(80, 100))

    if self.Diving then
        self.Diving = false
        self.NextDiveTime = CurTime() + self.DiveCooldown
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DiveBehavior()
    local enemy = self:GetEnemy()
    if self.Diving && IsValid(enemy) && util.TraceLine({start = enemy:GetPos(), endpos = enemy:GetPos()-Vector(0,0,self.MaxBombDistFromEnemy), mask = MASK_NPCWORLDSTATIC}).Hit then
        self.Heli_MinChaseDist = self.MaxBombDistFromEnemy*0.66
        self.Heli_BackAwayFromEnemyDist = self.MaxBombDistFromEnemy*0.66
    else
        self.Heli_MinChaseDist = self.ShootDist
        self.Heli_BackAwayFromEnemyDist = 1000
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local find_rocket_radius = 1500

function ENT:FindEnemyRocket()
    for _,ent in pairs(ents.FindInSphere(self:GetPos(), find_rocket_radius)) do
        if ent:GetClass() == "rpg_missile" then
            self.EnemyRocket = ent
            break
        end
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.Cur_Move_Away_Speed = 0

function ENT:CustomOnThink_AIEnabled()

    if self.Crashing then return end

    local enemy = self:GetEnemy()
    local enemyexists = IsValid(enemy)

    if enemyexists then

        if self.CanShootDownRockets then
            self:FindEnemyRocket()
        end

        ---------------------------------------------------------------------------
            -- Movement:
        ---------------------------------------------------------------------------

        self:DiveBehavior()

        local enemydist = self:GetPos():Distance(enemy:GetPos())
        
        if !self.DisableChasingEnemy && enemydist <= self.Heli_MinChaseDist then
            self.DisableChasingEnemy = true
        elseif self.DisableChasingEnemy && enemydist > self.Heli_MinChaseDist then
            self.DisableChasingEnemy = false
        end

        if !self:Visible(enemy) && self.MovementType != VJ_MOVETYPE_STATIONARY then
            self.MovementType = VJ_MOVETYPE_STATIONARY
        elseif self:Visible(enemy) && self.MovementType != VJ_MOVETYPE_AERIAL then
            self.MovementType = VJ_MOVETYPE_AERIAL
        end

        local myposXY = Vector( self:GetPos().x , self:GetPos().y , 0 )
        local enemyposXY = Vector( enemy:GetPos().x , enemy:GetPos().y , 0)
        local enemydistXY = myposXY:Distance(enemyposXY)
        local move_away_dir = (myposXY - enemyposXY):GetNormalized()

        local move_away_speed_max = 600
        local ideal_move_away_speed = math.Clamp(move_away_speed_max - enemydistXY, 0, move_away_speed_max)
        local accelspeed = 30

        if enemydist < self.Heli_BackAwayFromEnemyDist then
            self.Cur_Move_Away_Speed = math.Clamp(self.Cur_Move_Away_Speed + accelspeed, 0, ideal_move_away_speed)
        else
            self.Cur_Move_Away_Speed = math.Clamp(self.Cur_Move_Away_Speed - accelspeed, 0, ideal_move_away_speed)
        end

        --print(self.Cur_Move_Away_Speed)

        if self.Cur_Move_Away_Speed < move_away_speed_max then
            self:SetVelocity( Vector( move_away_dir.x*self.Cur_Move_Away_Speed, move_away_dir.y*self.Cur_Move_Away_Speed, 0)  )
        end

        ---------------------------------------------------------------------------
            -- Gun Attack:
        ---------------------------------------------------------------------------

        self:AimGun() -- Update self.ShootPos and face it.

        if self.ShootPos then

            if !self.GunCharged && self.GunHasCooledDown && enemydist < self.ShootDist then
                self:ChargeGun()
            end

            if self.GunCharged then
                self.GunFiring = true
                self:DoGunAttack()
            end

        end

        ---------------------------------------------------------------------------
            -- Rocket Attack:
        ---------------------------------------------------------------------------
        if self.HasRockets && GetConVar("vj_zippycombines_chopper_hasmissiles"):GetInt() == 1 then

            if self:Visible(enemy) && self.NextRocketTime < CurTime() && enemydist < self.RocketDistance then

                local dir = enemy:GetPos()+enemy:OBBCenter() - self:GetPos()
                local rocketspeed = 1150

                local localang = self:WorldToLocalAngles(dir:Angle())

                if localang.x < 90 && localang.x > -22.5 && math.abs(localang.y) < 45 then

                    for i = 4,7,3 do
                        local rocket = ents.Create("obj_vj_chopper_missile_z")
                        rocket:SetPos(self:GetAttachment(i).Pos)
                        rocket:SetOwner(self)
                        rocket:Spawn()
                        rocket:GetPhysicsObject():SetVelocity( ( dir ):GetNormalized()*rocketspeed )
                        rocket:SetAngles(dir:Angle())
                        rocket.Target = enemy
                        rocket.Speed = rocketspeed
                    end

                    self.NextRocketTime = CurTime() + math.Rand(self.RocketCoolDown.min,self.RocketCoolDown.max)
                
                end
            
            end
        end

        ---------------------------------------------------------------------------
            -- Bomb Attack:
        ---------------------------------------------------------------------------

        if self.Heli_CanBomb then
            if self.AA_CurrentMovePos && self.NextDropBombTime < CurTime() && self:EnemyInBombDistance() then

                self.NextDropBombTime = CurTime() + self.BombDropDelay

                local bombent = "obj_vj_chopper_bomb_z"
                --if !IsValid(self.ExplosiveRollerMine) && math.random(1,3) == 1 then
                    --bombent = "npc_vj_rollermine_explosive_z"
                --end
            
                self:DropBomb(bombent)

            end
        end

        ---------------------------------------------------------------------------

    elseif !enemyexists then

        if self.ShootPos then self.ShootPos = nil end
        if self.GunCharged then self:UnchargeGun() end

    end


    ---------------------------------------------------------------------------
        -- Pose Parameters:
    ---------------------------------------------------------------------------

    local bullet_source = self:GetAttachment(2).Pos
    local fire_dir = Vector(0,0,0)
    local ideal_poseparam_ang = Angle(0,0,0)

    if self.ShootPos then
        fire_dir = (self.ShootPos - bullet_source):GetNormalized()
        ideal_poseparam_ang = self:WorldToLocalAngles(fire_dir:Angle())
    end

    if self.FlipAimPitchPoseParam then ideal_poseparam_ang.x = -ideal_poseparam_ang.x end
    self.CurrentAimPoseParamAng = LerpAngle(0.33, self.CurrentAimPoseParamAng, ideal_poseparam_ang)

    self:SetPoseParameter( self.AimYawPoseParam ,self.CurrentAimPoseParamAng.y + self.body_horz_noise )
    self:SetPoseParameter( self.AimPitchPoseParam , self.CurrentAimPoseParamAng.x + self.body_vert_noise )

    if self.HeliLights then
        self.Spotlight:SetAngles( self:GetAttachment(12).Ang )
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoSpark(pos,intensity)

    intensity = intensity or 1

	local spark = ents.Create("env_spark")
	spark:SetKeyValue("Magnitude",tostring(intensity))
	spark:SetKeyValue("Spark Trail Length",tostring(intensity))
	spark:SetPos(pos)
	spark:Spawn()
	spark:Fire("StartSpark", "", 0)
	timer.Simple(0.1, function() if IsValid(spark) then spark:Remove() end end)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

    self.HasPainSounds = true -- If set to false, it won't play the pain sounds

    if !dmginfo:IsExplosionDamage() then
        dmginfo:SetDamage(dmginfo:GetDamage() * 0.1)

        if math.random(1, 4) == 1 then
            self:EmitSound("physics/metal/metal_sheet_impact_bullet1.wav", 92, math.random(70, 90))
            self.Spark1 = ents.Create("env_spark")
            self.Spark1:SetPos(dmginfo:GetDamagePosition())
            self.Spark1:Spawn()
            self.Spark1:Fire("StartSpark", "", 0)
            self.Spark1:Fire("StopSpark", "", 0.001)
            self:DeleteOnRemove(self.Spark1)
        end
    
        self.HasPainSounds = false -- If set to false, it won't play the pain sounds
    else

        self.HeavyDamagePoint = dmginfo:GetDamagePosition()
        self:DoSpark(dmginfo:GetDamagePosition(),5)
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()

    self.RotorSoundLoop:Stop()
    self.ShootGunLoop:Stop()

    if self.CrashAlarm && self.CrashSound then
        self.CrashAlarm:Stop()
        self.CrashSound:Stop()
    end

	if self.HeliLights && IsValid(self.Spotlight) then
		self.Spotlight:SetParent()
		self.Spotlight:Fire("lightoff")
		self.Spotlight:Fire("kill",self.Spotlight, 0.5)
	end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------