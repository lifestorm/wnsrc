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

ENT.Model = "models/combine_apc.mdl"
ENT.StartHealth = 430

ENT.Immune_Dissolve = false -- Immune to Dissolving | Example: Combine Ball
ENT.Immune_AcidPoisonRadiation = false -- Immune to Acid, Poison and Radiation
ENT.Immune_Bullet = false -- Immune to Bullets
ENT.Immune_Physics = false -- Immune to Physics
ENT.ImmuneDamagesTable = {} -- You can set Specific types of damages for the SNPC to be immune to

ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.InvestigateSoundDistance = 18
ENT.CallForHelpDistance = 10000 -- -- How far away the SNPC's call for help goes | Counted in World Units

-- STOP RANDOMLY TURNING GOD PLEASE
ENT.CallForHelpAnimationFaceEnemy = false -- Should it face the enemy when playing the animation?
ENT.CombatFaceEnemy = false -- If enemy exists and is visible

ENT.SoundTbl_Breath = {"vehicles/apc/apc_idle1.wav"}
ENT.BreathSoundLevel = 90

ENT.DeathCorpseModel = {"models/combine_apc_destroyed_gib01.mdl"}

ENT.Tank_AngleDiffuseNumber = 90 -- Used if the forward direction of the y-axis isn't correct on the model

ENT.APC_RunOverDist = 750
ENT.APC_MinDriveDist = 1250
ENT.APC_AccelSpeed = 15
ENT.APC_DrivingSpeed = 500
ENT.APC_BackPedalSpeed = 200
ENT.APC_TurnSpeedMax = 45

ENT.ShootDist = 3000
ENT.BulletSpread = 0.03
ENT.Shots = {
    min = 10,
    max = 20
}
ENT.ShootCoolDown = {
    min = 2,
    max = 3,
}

ENT.RocketDistance = 4500
ENT.RocketCoolDown = {
    min = 1.75,
    max = 2.5,
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "APC.Frame", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(0, 0, 50), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("MOUSE1 (primary attack key): Shoot Gun")
    ply:ChatPrint("MOUSE2 (secondary attack key): Launch Rockets")

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CreateWheels()
    local phys = self:GetPhysicsObject()

    self.Wheel_FR = ents.Create("base_gmodentity")
    self.Wheel_FL = ents.Create("base_gmodentity")
    self.Wheel_RR = ents.Create("base_gmodentity")
    self.Wheel_RL = ents.Create("base_gmodentity")

    local wheels = {
        {
            ent = self.Wheel_FR,
            pos = phys:GetPos()+self:GetForward()*45-self:GetRight()*68+self:GetUp()*24,
            ang = phys:GetAngles()+Angle(0,90,90),
        },
        {
            ent = self.Wheel_FL,
            pos = phys:GetPos()-self:GetForward()*45-self:GetRight()*68+self:GetUp()*24,
            ang = phys:GetAngles()+Angle(0,90,-90),
        },
        {
            ent = self.Wheel_RR,
            pos = phys:GetPos()+self:GetForward()*45+self:GetRight()*78+self:GetUp()*24,
            ang = phys:GetAngles()+Angle(0,90,90),
        },
        {
            ent = self.Wheel_RL,
            pos = phys:GetPos()-self:GetForward()*45+self:GetRight()*78+self:GetUp()*24,
            ang = phys:GetAngles()+Angle(0,90,-90),
        },
    }

    for _,wheel_data in pairs(wheels) do
        local wheel = wheel_data.ent

        wheel:SetModel("models/props_phx/wheels/trucktire.mdl")
        wheel:SetPos(wheel_data.pos)
        wheel:SetAngles(wheel_data.ang)
        wheel:Spawn()
        wheel:PhysicsInit(SOLID_VPHYSICS)
        wheel:GetPhysicsObject():SetMass(phys:GetMass()*0.125)
        wheel:SetNoDraw(true)
        wheel:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self:DeleteOnRemove(wheel)

        local axis = constraint.Axis(wheel, self, 0, 0, wheel:OBBCenter(), Vector(0,0,0), 0, 0, 0, 1, Vector(0,0,0))
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize_CustomTank()
    self.NextShootTime = CurTime()
    self.NextRocketTime = CurTime()

    self.bulletprop1 = ents.Create("base_gmodentity")
    self.bulletprop1:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self.bulletprop1:SetPos(self:GetAttachment(7).Pos)
    self.bulletprop1:SetParent(self,7)
    self.bulletprop1:SetSolid(SOLID_NONE)
    self.bulletprop1:AddEFlags(EFL_DONTBLOCKLOS)
    self.bulletprop1:SetNoDraw(true)
    self.bulletprop1:Spawn()

    self.APCAlarm = CreateSound(self,"ambient/alarms/apc_alarm_loop1.wav")
    self.APCAlarm:SetSoundLevel(100)

    timer.Simple(0, function()
        self:CreateWheels()
    end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
    self.APCAlarm:Play()
    self.APCAlarm:ChangePitch(math.random(90,100))
    timer.Simple(6, function() if IsValid(self) then self.APCAlarm:Stop() end end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetNearDeathSparkPositions()
	local randpos = math.random(1,7)
	if randpos == 1 then self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*100 +self:GetUp()*60)
	elseif randpos == 2 then self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*30 +self:GetUp()*60)
	elseif randpos == 5 then self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*10 +self:GetUp()*60 +self:GetRight()*50)
	elseif randpos == 6 then self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*80 +self:GetUp()*60 +self:GetRight()*-50)
	elseif randpos == 7 then self.Spark1:SetLocalPos(self:GetPos() +self:GetForward()*-20 +self:GetUp()*60 +self:GetRight()*-30)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:EnemyInDriveDist()

    local enemy = self:GetEnemy()
    local enemypos = enemy:GetPos()
    local mypos = self:GetPos()
    local yaw_difference = self:WorldToLocalAngles( Angle( 0 , (self:GetPos()-enemy:GetPos()):Angle().y + self.Tank_AngleDiffuseNumber, 0 ) ).y
    local distXY = Vector(enemypos.x,enemypos.y,0):Distance(Vector(mypos.x,mypos.y,0))
    local pos_z_dist = math.abs(enemypos.z-mypos.z)

    if distXY < self.APC_RunOverDist && math.abs(yaw_difference) < 40 && pos_z_dist < 100 then return true end
    if distXY > self.APC_MinDriveDist then return true end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HasObstacle(dir)

    local mult = nil
    if dir == "forward" then
        mult = 150
    elseif dir == "backward" then
        mult = -150
    end
 
    local defaultpos = self:GetPos() - self:GetRight()*mult + self:GetUp()*35
    local collision_positions = {
        defaultpos,
        defaultpos + self:GetForward() * 70,
        defaultpos - self:GetForward() * 70,
    }
    for _,pos in pairs(collision_positions) do

        -- if dir == "backward" then
        --     local prop = ents.Create("prop_dynamic")
        --     prop:SetPos(pos)
        --     prop:SetModel("models/props_junk/PopCan01a.mdl")
        -- end

        if bit.band( util.PointContents(pos) , CONTENTS_SOLID ) == CONTENTS_SOLID then
            --print("has obstacle (" .. dir .. ")!")
            return true
        end

    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HasGroundInFrontOfSelf()
    local trStartPos = self:GetPos()-self:GetRight()*150+self:GetUp()*25

    -- local prop = ents.Create("prop_dynamic")
    -- prop:SetPos(trStartPos)
    -- prop:SetModel("models/props_junk/PopCan01a.mdl")

    local tr = util.TraceLine({
        start = trStartPos,
        endpos = trStartPos - Vector(0,0,50),
        mask = MASK_NPCWORLDSTATIC,
    })

    -- local prop = ents.Create("prop_dynamic")
    -- prop:SetPos(tr.HitPos)
    -- prop:SetModel("models/props_junk/PopCan01a.mdl")
    -- if !tr.Hit then
    --     prop:SetSkin(1,2)
    -- end

    if tr.Hit then return true else /*print("no ground in front!")*/ end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:APC_stop()
    self.CurrentMoveSpeed = 0

    if self.APCDriveSound:IsPlaying() then
        self.APCDriveSound:Stop()
        self:EmitSound("vehicles/apc/apc_shutdown.wav",90,math.random(90, 110))
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--ENT.CanInitBackPedal = true

function ENT:BackPedal()
    --if !self.CanInitBackPedal or self.ShouldBackpedal then return end
    if self.ShouldBackpedal then return end
    self:APC_stop()
    self.ShouldBackpedal = true
    --self.CanInitBackPedal = false

    --print("doing backpedal..")

    local backpedaltime = 3
    timer.Simple(backpedaltime, function() if IsValid(self) then
        self:APC_stop()
        self.ShouldBackpedal = false
        --print("backpedal done!")
    end end)
    --local nextbackpedal = 4
    --timer.Simple(nextbackpedal, function() if IsValid(self) then self.CanInitBackPedal = true print("backpedal cooldown finished!") end end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:APCOnGround()
    local tr_ent = util.TraceEntity({
        start = self:GetPos() + self:GetUp()*10,
        endpos = self:GetPos() + self:GetUp()*-25,
        mask = MASK_NPCWORLDSTATIC
    },self)

    if tr_ent.Hit then return true end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Brake(activate)

    if !self.BrakeActive && activate == true then

        self.BrakeActive = true

        local wheels = {
            self.Wheel_FL,
            self.Wheel_FR,
            self.Wheel_RL,
            self.Wheel_RR,
        }
        for _,wheel in pairs(wheels) do
            local weld = constraint.Weld(wheel, self, 0, 0, 0, false, false)
        end


    elseif self.BrakeActive && activate == false then

        self.BrakeActive = false
        constraint.RemoveConstraints(self, "Weld")

    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
    if self.ShouldDrive then
        self:Brake(false)
    else
        self:Brake(true)
    end

    if !self.APCDriveSound then
        self.APCDriveSound = CreateSound(self,"vehicles/apc/apc_firstgear_loop1.wav")
        self.APCDriveSound:SetSoundLevel(95)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.CurrentMoveSpeed = 0
ENT.CurrentTurnSpeed = 0

function ENT:DriveThink()

    local phys = self:GetPhysicsObject()
    local enemy = self:GetEnemy()
    

    ----------------------------------------------------------------------------------------------------------------------
        -- Decide if we should drive/backpedal:
    ----------------------------------------------------------------------------------------------------------------------

    if !self.VJ_IsBeingControlled then

        if IsValid(enemy) then

            local localang = self:WorldToLocalAngles((self:GetPos()-enemy:GetPos()):Angle() + Angle(0,-90,0))
            local enemy_outside_of_rocket_ang = math.abs(localang.y) < 135
            local no_ground_in_front = !self:HasGroundInFrontOfSelf()
            --local NoChaseFlyingEnemyDist = 1000
            --local flying_enemy_unreachable = self:GetPos():Distance(enemy:GetPos()) > NoChaseFlyingEnemyDist && !enemy:IsOnGround()

            --print("flying_enemy_unreachable = " .. tostring(flying_enemy_unreachable))

            if self:Visible(enemy) && (self:EnemyInDriveDist() or enemy_outside_of_rocket_ang) /*&& !flying_enemy_unreachable*/ then
                self.ShouldDrive = true

                if !self:HasObstacle("backward") && (self:HasObstacle("forward") or no_ground_in_front or enemy_outside_of_rocket_ang) then
                    self:BackPedal()
                end
            else
                self.ShouldDrive = false
            end

        else
            self.ShouldDrive = false
        end

    elseif self.VJ_IsBeingControlled then

        local controller = self.VJ_TheController

        if controller:KeyDown(IN_FORWARD) or controller:KeyDown(IN_BACK) then
            self.ShouldDrive = true
    
            if !self.ShouldBackpedal && controller:KeyDown(IN_BACK) then
                self:APC_stop()
                self.ShouldBackpedal = true
            elseif self.ShouldBackpedal && !controller:KeyDown(IN_BACK) then
                self:APC_stop()
                self.ShouldBackpedal = false
            end
        else
            self.ShouldDrive = false
            self.ShouldBackpedal = false
        end

    end

    ----------------------------------------------------------------------------------------------------------------------
        -- Move/Turn:
    ----------------------------------------------------------------------------------------------------------------------

    if self.ShouldDrive && self:APCOnGround() then
        if !self.APCDriveSound:IsPlaying() then
            self.APCDriveSound:Play()
            self.APCDriveSound:ChangePitch(math.random(95, 105))
        end

        local yaw_difference = self:WorldToLocalAngles( Angle( 0 , (self:GetPos()-enemy:GetPos()):Angle().y + self.Tank_AngleDiffuseNumber, 0 ) ).y


        -- Turning for both controller and ai
        if !self.VJ_IsBeingControlled then

            if math.abs(yaw_difference) > 20 then
                self.CurrentTurnSpeed = math.Clamp(yaw_difference*0.5,-self.APC_TurnSpeedMax,self.APC_TurnSpeedMax)
                phys:AddAngleVelocity(Vector(0,0, self.CurrentTurnSpeed ))
            else
                self.CurrentTurnSpeed = 0
            end

        else

            local controller = self.VJ_TheController

            if controller:KeyDown(IN_MOVERIGHT) then

                self.CurrentTurnSpeed = -self.APC_TurnSpeedMax
                if self.ShouldBackpedal then self.CurrentTurnSpeed = -self.CurrentTurnSpeed end
                phys:AddAngleVelocity(Vector(0,0, self.CurrentTurnSpeed ))

            elseif controller:KeyDown(IN_MOVELEFT) then

                self.CurrentTurnSpeed = self.APC_TurnSpeedMax
                if self.ShouldBackpedal then self.CurrentTurnSpeed = -self.CurrentTurnSpeed end
                phys:AddAngleVelocity(Vector(0,0, self.CurrentTurnSpeed ))

            else
                self.CurrentTurnSpeed = 0
            end

        end


        if self.ShouldBackpedal && !self:HasObstacle("backward") then
            self.CurrentMoveSpeed = math.Clamp( self.CurrentMoveSpeed-self.APC_AccelSpeed, -self.APC_BackPedalSpeed, self.APC_DrivingSpeed )
        else
            self.CurrentMoveSpeed = math.Clamp( self.CurrentMoveSpeed+self.APC_AccelSpeed, -self.APC_BackPedalSpeed, self.APC_DrivingSpeed )
        end
        phys:SetVelocity( ( self:GetForward():Angle()+Angle(0,self.Tank_AngleDiffuseNumber,0) ):Forward()*self.CurrentMoveSpeed )

    elseif !self:APCOnGround() then
        --print("not on ground!")
        phys:AddAngleVelocity(Vector(0,-self:GetAngles().x*1.5,0))
    end

    if !(self.ShouldDrive && self:APCOnGround()) then
        self:APC_stop()
    end

    ----------------------------------------------------------------------------------------------------------------------
        -- Poseparameters:
    ----------------------------------------------------------------------------------------------------------------------
    if self.ShouldDrive then
        local turnposeparam = -phys:GetAngleVelocity().z*0.005
        if self.ShouldBackpedal then
            turnposeparam = -turnposeparam
        end
        self:SetPoseParameter("vehicle_steer", turnposeparam)
    else
        self:SetPoseParameter("vehicle_steer", 0)
    end

    local wheels = {
        fl = self.Wheel_FL,
        fr = self.Wheel_FR,
        rl = self.Wheel_RL,
        rr = self.Wheel_RR,
    }

    for k,ent_wheel in pairs(wheels) do

        local poseparam_name = "vehicle_wheel_" .. k .. "_spin"
        local poseparam_add = ent_wheel:GetPhysicsObject():GetAngleVelocity().z*0.06
        if k == "fr" or k == "rr" then
            poseparam_add = -poseparam_add
        end

        self:SetPoseParameter(poseparam_name, self:GetPoseParameter(poseparam_name) + poseparam_add)

    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AimGun()

    local enemy = self:GetEnemy()

    local pos = self.ShootPos or self:GetAttachment(7).Pos+self:GetRight()*-100
    local bullet_source = self:GetAttachment(7).Pos
    local fire_dir = (pos - bullet_source):GetNormalized()
    local ideal_poseparam_ang = self:WorldToLocalAngles(fire_dir:Angle()) - Angle(0,90,0)

    if !self.CurrentAimPoseParamAng then self.CurrentAimPoseParamAng = Angle(0,0,0) end
    self.CurrentAimPoseParamAng = LerpAngle(0.5, self.CurrentAimPoseParamAng, ideal_poseparam_ang)

    local weapon_yaw = self.CurrentAimPoseParamAng.y

    self:SetPoseParameter( "vehicle_weapon_yaw",  weapon_yaw )
    self:SetPoseParameter( "vehicle_weapon_pitch", self.CurrentAimPoseParamAng.x )

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ShootBullet()
    local bullet_source = self:GetAttachment(7).Pos
    local fire_dir = (self.ShootPos - self.bulletprop1:GetPos()):GetNormalized()

    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "5")
    expLight:SetKeyValue("distance", "250")
    expLight:Fire("Color", "0 75 255")
    expLight:SetPos(bullet_source)
    expLight:Spawn()
    expLight:SetParent(self,7)
    expLight:Fire("TurnOn", "", 0)
    timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
    self:DeleteOnRemove(expLight)
    ParticleEffectAttach("vj_rifle_full_blue",PATTACH_POINT_FOLLOW,self,7)

    self.bulletprop1:FireBullets({
        Src = self.bulletprop1:GetPos(),
        Dir = fire_dir,
        Damage = 10,
        Force = 25,
        TracerName = "AirboatGunTracer",
        Spread = Vector( self.BulletSpread,self.BulletSpread,self.BulletSpread ),
        Num = 1,
        Attacker = self,
        Inflictor = self,
        Filter = self,
		Callback = function(attacker, tracer)
			-- local effectdata = EffectData()
			-- effectdata:SetOrigin(tracer.HitPos)
			-- effectdata:SetNormal(tracer.HitNormal)
			-- effectdata:SetRadius( 5 )
			-- util.Effect( "cball_bounce", effectdata )
		end,
    })

    self:EmitSound("^weapons/ar1/ar1_dist1.wav",130,math.random(80, 90),1,CHAN_WEAPON)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireGun(times)
    if self.Shooting then return end
    self.Shooting = true

    local timername = "VJ_APC_Z_ShootTimer" .. self:EntIndex()
    timer.Create(timername, 0.11, times, function()

        if !IsValid(self) or !self.ShootPos or self.Dead then
            timer.Remove(timername)
            if IsValid(self) then
                self.Shooting = false
                self.NextShootTime = CurTime() + math.Rand(self.ShootCoolDown.min, self.ShootCoolDown.max)
            end
            return
        end

        self:ShootBullet()

        if timer.RepsLeft(timername) == 0 then
            self.Shooting = false
            self.NextShootTime = CurTime() + math.Rand(self.ShootCoolDown.min, self.ShootCoolDown.max)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireRocket()

    local enemy = self:GetEnemy()
    local rocketspeed = 1150
    local dir = enemy:GetPos()+enemy:OBBCenter() - self:GetPos()

    local rocket = ents.Create("obj_vj_chopper_missile_z")
    rocket:SetPos(self:GetAttachment(8).Pos)
    rocket:SetOwner(self)
    rocket:Spawn()
    rocket:GetPhysicsObject():SetVelocity( ( dir ):GetNormalized()*rocketspeed )
    rocket:SetAngles( (dir):Angle() )
    rocket.Target = enemy
    rocket.Speed = rocketspeed

    self.NextRocketTime = CurTime() + math.Rand(self.RocketCoolDown.min,self.RocketCoolDown.max)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
    if self.Dead then return end

    self:DriveThink()
    self:AimGun() -- Forward or at shootpos

    local enemy = self:GetEnemy()

    if IsValid(enemy) then

        local enemydist = self:GetPos():Distance(enemy:GetPos())

        if self:Visible(enemy) then
            self.ShootPos = enemy:GetPos()+enemy:OBBCenter()
        end


        if !self.VJ_IsBeingControlled then

            if self.ShootPos && self.NextShootTime < CurTime() && enemydist < self.ShootDist then
                self:FireGun( math.Rand(self.Shots.min,self.Shots.max) )
            end
            if self:Visible(enemy) && self.NextRocketTime < CurTime() && enemydist < self.RocketDistance then

                local fire_dir = ( enemy:GetPos() - self:GetAttachment(7).Pos ):GetNormalized()
                local localang = self:WorldToLocalAngles(fire_dir:Angle() + Angle(0,-90,0))
                if math.abs(localang.x) < 90 && math.abs(localang.y) < 90 then
                    self:FireRocket()
                end
    
            end

        else

            local controller = self.VJ_TheController
            if controller:KeyDown(IN_ATTACK) then
                self:ShootBullet()
            end
            if self:Visible(enemy) && self.NextRocketTime < CurTime() && controller:KeyDown(IN_ATTACK2) then
                self:FireRocket()
            end

        end


    else
        self.ShootPos = nil
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)

    self:EmitSound( "Explo.ww2bomb", 130, 100)

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )

	ParticleEffect("vj_explosion1", self:GetPos(), Angle(0,0,0), nil)
    ParticleEffect( "striderbuster_explode_dummy_core", self:GetPos(), self:GetAngles() )

    corpseEnt:GetPhysicsObject():SetVelocity(VectorRand()*150+Vector(0,0,150))

    self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib02.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib03.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib04.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/combine_apc_destroyed_gib05.mdl",{BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

        self:DoSpark(dmginfo:GetDamagePosition(),5)
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
    if self.APCDriveSound then
        self.APCDriveSound:Stop()
    end
    self.APCAlarm:Stop()
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------