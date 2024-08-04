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

ENT.Model = "models/Combine_Strider.mdl"
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.StartHealth = 720
--ENT.CustomBlood_Particle = {"blood_impact_synth_01"}
ENT.BloodColor = "White"
ENT.VJ_IsHugeMonster = true

ENT.TurningSpeed = 8 -- How fast it can turn
ENT.SightAngle = 100

ENT.DeathCorpseApplyForce = false

ENT.PoseParameterLooking_Names = {yaw={"minigunYaw"}} -- Custom pose parameters to use, can put as many as needed
ENT.PoseParameterLooking_InvertYaw = true -- Inverts the pitch poseparameters (X)

ENT.InvestigateSoundDistance = 18
ENT.CallForHelpDistance = 10000 -- -- How far away the SNPC's call for help goes | Counted in World Units

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 1000 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 0 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead

ENT.HasMeleeAttack = false
ENT.MeleeAttackDamage = 200
ENT.MeleeAttackDistance = 100 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 115 -- How far does the damage go?

ENT.MovementType = VJ_MOVETYPE_AERIAL
ENT.AA_MinWanderDist = 500 -- Minimum distance that the NPC should go to when wandering
ENT.Aerial_FlyingSpeed_Calm = 160 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking compared to ground SNPCs
ENT.Aerial_FlyingSpeed_Alerted = 210 -- The speed it should fly with, when it's chasing an enemy, moving away quickly, etc. | Basically running compared to ground SNPCs
ENT.Aerial_AnimTbl_Calm = {ACT_WALK} -- Animations it plays when it's wandering around while idle
ENT.Aerial_AnimTbl_Alerted = {ACT_RUN} -- Animations it plays when it's moving while alerted
ENT.AA_GroundLimit = 450 -- If the NPC's distance from itself to the ground is less than this, it will attempt to move up
ENT.AA_MoveAccelerate = 2 -- The NPC will gradually speed up to the max movement speed as it moves towards its destination | Calculation = FrameTime * x
ENT.AA_MoveDecelerate = 2 -- The NPC will slow down as it approaches its destination | Calculation = MaxSpeed / x

ENT.SoundTbl_CombatIdle = {
"npc/strider/dvs_stridervoc_00_35_18.wav",
"npc/strider/strider_hunt1.wav",
"npc/strider/strider_hunt2.wav",
"npc/strider/strider_hunt3.wav",
}
ENT.SoundTbl_Alert = {
"npc/strider/strider_distant1.wav",
"npc/strider/strider_distant2.wav",
"npc/strider/strider_distant3.wav",
}
ENT.SoundTbl_Pain = {
"npc/strider/striderx_alert2.wav",
"npc/strider/striderx_alert4.wav",
"npc/strider/striderx_alert5.wav",
"npc/strider/striderx_alert6.wav",
"npc/strider/striderx_pain2.wav",
"npc/strider/striderx_pain5.wav",
"npc/strider/striderx_pain7.wav",
"npc/strider/striderx_pain8.wav",
}
ENT.SoundTbl_Idle = {"npc/strider/strider_legstretch1.wav","npc/strider/strider_legstretch2.wav","npc/strider/strider_legstretch3.wav"}
ENT.SoundTbl_Death = {"npc/strider/striderx_die1.wav"}

ENT.IdleSoundLevel = 95
ENT.AlertSoundLevel = 115
ENT.PainSoundLevel = 105
ENT.DeathSoundLevel = 105
ENT.CombatIdleSoundLevel = 105

-- Shooting in general
ENT.Fire_TooCloseDist = 0
ENT.FireDistance = 6000
ENT.BulletSpread = 0.03

-- Regular shoot attack
ENT.ShootDamage = 12
ENT.GunAttackFireDelay = 0.15

-- Burst shoot attack
ENT.ConsiderBurstDelay = 4
ENT.DoBurstChance = 3
ENT.BurstFireDelay = 0.1
ENT.BurstFireBulletAmt = 6
ENT.BurstAccuracyMult = 2

-- Strider cannon:
ENT.ConsiderCannonDelay = 6
ENT.DoCannonChance = 2
ENT.StriderCannonDamage = 150

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

	ply:ChatPrint("NOTE: Controlling is not really supported for this SNPC!!")

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GiveBullseyes()
    self.bullseye_front = ents.Create("obj_vj_Bullseye")
    self.bullseye_behind = ents.Create("obj_vj_Bullseye")
    self.bullseye_left = ents.Create("obj_vj_Bullseye")
    self.bullseye_right = ents.Create("obj_vj_Bullseye")
    self.bullseye_over = ents.Create("obj_vj_Bullseye")
    self.bullseye_under = ents.Create("obj_vj_Bullseye")

    local center = self:GetPos()+self:OBBCenter()
    local bullseye_dist = 65

    self.bullseyes = {
        {
            ent = self.bullseye_front,
            pos = center+self:GetForward()*bullseye_dist,
        },
        {
            ent = self.bullseye_behind,
            pos = center-self:GetForward()*bullseye_dist,
        },
        {
            ent = self.bullseye_left,
            pos = center-self:GetRight()*bullseye_dist,
        },
        {
            ent = self.bullseye_right,
            pos = center+self:GetRight()*bullseye_dist,
        },
        {
            ent = self.bullseye_over,
            pos = center+self:GetUp()*bullseye_dist,
        },
        {
            ent = self.bullseye_under,
            pos = center-self:GetUp()*bullseye_dist,
        },
    }

    for _,bullseye_data in pairs(self.bullseyes) do
        local bullseye = bullseye_data.ent
        bullseye:SetModel("models/hunter/blocks/cube05x05x05.mdl")
        bullseye:SetPos(bullseye_data.pos)
        bullseye:SetParent(self,12)
        bullseye:SetAngles(self:GetAngles())
        bullseye:Spawn()
        bullseye:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        bullseye:AddEFlags(EFL_DONTBLOCKLOS)
        bullseye:DrawShadow(true)
        bullseye:SetNoDraw(true)
        bullseye:SetSolid(SOLID_NONE)
        bullseye.VJ_NPC_Class = self.VJ_NPC_Class
        self:DeleteOnRemove(bullseye)
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local strider_mins, strider_maxs = Vector(-65, -65, -65), Vector(65, 65, 65)

function ENT:CustomOnInitialize()
    self:SetCollisionBounds(strider_mins, strider_maxs)
    
    timer.Simple(0.03, function() if IsValid(self) then self:SetPos(self:GetPos()+Vector(0,0,self.AA_GroundLimit)) end end)

    self.bulletprop1 = ents.Create("base_gmodentity")
    self.bulletprop1:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self.bulletprop1:SetPos(self:GetAttachment(10).Pos)
    self.bulletprop1:SetParent(self,10)
    self.bulletprop1:SetSolid(SOLID_NONE)
    self.bulletprop1:AddEFlags(EFL_DONTBLOCKLOS)
    self.bulletprop1:SetNoDraw(true)
    self.bulletprop1:Spawn()

    self.NextStriderFootStepSound = CurTime()

    self.Strider_Current_Height_Mode = "high"

    self.CurrentHeightPoseParam = 500

    self:GiveBullseyes()

    self.NextRegularShoot = CurTime()
    self.NextConsiderBurst = CurTime()
    self.NextConsiderCannon = CurTime()
    self.BurstRepsLeft = 0

    self.NextTogggleRandomCrouch = CurTime()
    self.RandomCrouch = math.random(1, 2) == 1

    self.BurstAttackShootTimerName = "VJ_Z_StriderBurstShoot" .. self:EntIndex()
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.CurAimPitch = 0

function ENT:CustomOn_PoseParameterLookingCode(pitch, yaw, roll)
    local ideal_pitch = pitch

    if IsValid(self:GetEnemy()) then
        ideal_pitch = pitch-45
    end

    self.CurAimPitch = Lerp(0.8, self.CurAimPitch, ideal_pitch)
    self:SetPoseParameter("minigunPitch",self.CurAimPitch)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Strider_ChangeHeight(mode)
    if self.Strider_Adjusting_Hight then return end

    local adjust_time = nil
    local new_strider_height = nil
    local new_strider_poseparam = nil

    if mode == "high" && self.Strider_Current_Height_Mode != "high" then

        adjust_time = 4
        new_strider_poseparam = 500

        self:VJ_ACT_PLAYACTIVITY("stand",true,adjust_time,true)
        self.Strider_Current_Height_Mode = "high"

    elseif mode == "low" && self.Strider_Current_Height_Mode != "low" then

        adjust_time = 4
        new_strider_poseparam = 0

        self:VJ_ACT_PLAYACTIVITY("crouch",true,adjust_time,true)
        self.Strider_Current_Height_Mode = "low"

    end

    if new_strider_poseparam then

        self.Strider_Adjusting_Hight = true
        timer.Simple(1, function() if IsValid(self) then self.CurrentHeightPoseParam = new_strider_poseparam end end)
        timer.Simple(adjust_time, function() if IsValid(self) then self.Strider_Adjusting_Hight = false end end)

    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
    local mypos = self:GetPos()

    -- Decide if we should move or not:
    local should_move = GetConVar("ai_disabled"):GetInt() == 0 && self.Strider_Current_Height_Mode != "low" && !self.PathObstructed && !self.InMidAir && !self.EnemyInNoChaseDist && !self.EnemyPosUnreachable && !self.IsBeingDroppedByDropship

    if self.MovementType == VJ_MOVETYPE_AERIAL && !should_move then
        self:AA_StopMoving()
        self.MovementType = VJ_MOVETYPE_STATIONARY
        --print("stopping...")
    elseif self.MovementType == VJ_MOVETYPE_STATIONARY && should_move then
        self.MovementType = VJ_MOVETYPE_AERIAL
        --print("moving!")
    end

    -- Update collision bounds to match head position if it's crouching:
    if self.Strider_Current_Height_Mode == "low" or self.Strider_Adjusting_Hight then
        self:SetCollisionBoundsWS(strider_mins+self:GetBonePosition(0), strider_maxs+self:GetBonePosition(0))
        self.DefaultCollisionBoundsSet = false
    elseif !self.DefaultCollisionBoundsSet then
        self:SetCollisionBounds(strider_mins, strider_maxs)
        self.DefaultCollisionBoundsSet = true
    end

    -- Update bullseye's npc classes:
    for _,bullseye in pairs(self.bullseyes) do
        bullseye.VJ_NPC_Class = self.VJ_NPC_Class
    end

    -- Update pose parameters:
    self:SetPoseParameter("body_height",self.CurrentHeightPoseParam)

    -- If stationary, then ease in velocity.
    if self.MovementType == VJ_MOVETYPE_STATIONARY then
        local ease_in_vel = -self:GetVelocity()
        self:SetLocalVelocity( Vector(ease_in_vel.x,ease_in_vel.y,0) )
    end

    -- Cannon charge effect:
    if self.StriderCannonCharging then
        local effectdata = EffectData()
        effectdata:SetStart(self:GetAttachment(9).Pos)
        util.Effect("cguard_suck", effectdata)
    end

    -- Footstep sounds:
    local seq = self:GetSequenceName(self:GetSequence())
    if self.NextStriderFootStepSound < CurTime() && (seq == "walk_all" or seq == "fastwalk_all") then
        self:EmitSound("^npc/strider/strider_step"..math.random(1, 6)..".wav", 110, math.random(65, 75))

        if seq == "walk_all" then
            self.NextStriderFootStepSound = CurTime()+0.9
        elseif seq == "fastwalk_all" then
            self.NextStriderFootStepSound = CurTime()+0.6
        end
    end

    ---------------------------------------------------------------------------------------------------------------------------------------------------
        -- Simulate gravity based on body height, and make sure height is correct:
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    local tr = util.TraceLine({
        start = mypos,
        endpos = mypos - Vector(0,0,10000),
        mask = MASK_NPCWORLDSTATIC,
    })
    local ground_dist = math.abs(mypos.z - tr.HitPos.z)

    -- local testprop = ents.Create("prop_dynamic")
    -- testprop:SetModel("models/props_c17/FurnitureChair001a.mdl")
    -- testprop:SetPos(mypos)

    local fallspeed = 50
    local repel_ground_speed = 50
    local extra_height_tolerance = 25
    local vec = Vector(0,0,0)

    self.InMidAir = false
    if ground_dist > self.AA_GroundLimit+100 then
        self.InMidAir = true
    end

    if ground_dist > self.AA_GroundLimit+extra_height_tolerance then
        vec = Vector(0,0,-fallspeed)
    elseif ground_dist < self.AA_GroundLimit-extra_height_tolerance then
        vec = Vector(0,0,repel_ground_speed)
        --print("going up")
    else
        -- If its head is at an acceptable height, then ease in velocity.
        vec = Vector(0,0,-self:GetVelocity().z*0.5)
        --print("good height")
    end

    if self.MovementType == VJ_MOVETYPE_AERIAL then
        self:SetVelocity(vec)
    elseif self.MovementType == VJ_MOVETYPE_STATIONARY then
        self:SetLocalVelocity(vec*10)
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
    if self.IsBeingDroppedByDropship then return end

    local enemy = self:GetEnemy()
    local enemyexists = IsValid(enemy)

    local enemydist = nil
    if enemyexists then
        enemydist = enemy:GetPos():Distance(self:GetPos())
    end

    ---------------------------------------------------------------------------------------------------------------------------------------------------
        -- Custom enemy visibility check:
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    local enemy_visible = false
    if enemyexists then
        enemy_visible = self:Visible(enemy)

        if !enemy_visible then
            -- Double check enemy visibility with a traceline
            local tr_visibility = util.TraceLine({
                start = self:GetAttachment(10).Pos, -- Muzzle
                endpos = enemy:GetPos()+enemy:OBBCenter(),
                filter = {self,enemy},
                mask = MASK_BLOCKLOS,
            })
            enemy_visible = !tr_visibility.Hit

            if enemy_visible then
                -- This sadly doesn't seem to work.
                self:VJ_DoSetEnemy(enemy, false, true)
            end
        end
    end

    ---------------------------------------------------------------------------------------------------------------------------------------------------
        -- Crouch:
    ---------------------------------------------------------------------------------------------------------------------------------------------------

    local enemy_under_self = false
    local tr_crouch1
    local tr_crouch2


    if self.NextTogggleRandomCrouch < CurTime() then
        self.RandomCrouch = !self.RandomCrouch
        self.NextTogggleRandomCrouch = CurTime() + math.Rand(8, 15)
        print(self.RandomCrouch)
    end
    

    if enemyexists then
        enemy_under_self = enemy:GetPos().z - self:GetPos().z < 0

        -- Check if the strider can't reach its enemy in a standing position:
        tr_crouch1 = util.TraceLine({
            start = self:GetPos(), -- Normal head position, when it's not crouching.
            endpos = enemy:GetPos()+enemy:OBBCenter(),
            filter = {self,enemy},
            mask = MASK_NPCWORLDSTATIC,
        })

        -- Check if the strider can reach the enemy when crouched:
        tr_crouch2 = util.TraceLine({
            start = self:GetPos()-Vector(0,0,310),
            endpos = enemy:GetPos()+enemy:OBBCenter(),
            filter = {self,enemy},
            mask = MASK_SHOT,
        })
    end

    local should_crouch = enemyexists && !tr_crouch2.Hit && ((tr_crouch1.Hit && enemy_under_self) or self.RandomCrouch) && enemydist < self.FireDistance

    local new_strider_height = nil
    if self.Strider_Current_Height_Mode == "high" then
        -- Consider crouching:
        if should_crouch then
            new_strider_height = "low"

            if !self.NextHeightModeSwitch then
                self.NextHeightModeSwitch = CurTime()+2.5
            end

            -- If the enemy has been occluded for a certain time, crouch:
            if self.NextHeightModeSwitch && self.NextHeightModeSwitch < CurTime() then
                self:Strider_ChangeHeight(new_strider_height)
                self.NextHeightModeSwitch = nil
                --print("crouching!")
            end
        elseif !should_crouch then
            -- Reset Timer:
            self.NextHeightModeSwitch = nil 
        end
    elseif self.Strider_Current_Height_Mode == "low" then
        -- Consider uncrouching:
        if !should_crouch then
            new_strider_height = "high"

            if !self.NextHeightModeSwitch then
                self.NextHeightModeSwitch = CurTime()+6
            end

            -- If the enemy has been visible for a certain time, stand up again:
            if self.NextHeightModeSwitch && self.NextHeightModeSwitch < CurTime() then
                self:Strider_ChangeHeight(new_strider_height)
                self.NextHeightModeSwitch = nil
                --print("standing!")
            end
        elseif should_crouch then
            -- Reset Timer:
            self.NextHeightModeSwitch = nil 
        end
    end

    -- if self.NextHeightModeSwitch then
    --     print("time until switch to " .. new_strider_height .. ": " .. self.NextHeightModeSwitch-CurTime())
    -- end

    ---------------------------------------------------------------------------------------------------------------------------------------------------
        -- Movement stuff:
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    local tr_path_obstructed = util.TraceHull({
        start = self:GetPos(),
        endpos = self:GetPos()+self:GetForward()*250,
        mins = strider_mins*0.33 - Vector(0,0,175),
        maxs = strider_maxs*0.33,
        mask = MASK_NPCWORLDSTATIC,
    })

    if tr_path_obstructed.Hit then
        self.PathObstructed = true
    else
        self.PathObstructed = false
    end

    if enemyexists && enemy_visible && enemydist < self.NoChaseAfterCertainRange_FarDistance && enemydist > self.NoChaseAfterCertainRange_CloseDistance then
        --print("no chase dist")
        self.EnemyInNoChaseDist = true
    else
        self.EnemyInNoChaseDist = false
    end

    -- Stop moving if enemy is too far up or down from us.
    if enemyexists then
        local move_ang_pitch = self:WorldToLocalAngles( (enemy:GetPos()+enemy:OBBCenter()-self:GetPos()):Angle() ).x

        if enemyexists && math.abs(move_ang_pitch) > 30 && enemydist > self.NoChaseAfterCertainRange_CloseDistance then
            self.EnemyPosUnreachable = true
        else
            self.EnemyPosUnreachable = false
        end
    else
        self.EnemyPosUnreachable = false
    end

    ---------------------------------------------------------------------------------------------------------------------------------------------------
        -- Attacks:
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    if enemyexists then
        if enemy:GetPos():Distance(self:GetAttachment(1).Pos) < self.MeleeAttackDistance then
            self:Strider_MeleeAttack()
        end

        if enemy_visible then
            self.ShootPos = enemy:GetPos()+enemy:OBBCenter()
        end

        -- Consider doing strider cannon attack every now and then:
        if self.NextConsiderCannon < CurTime() then
            if !self.ShouldDoStriderCannon && math.random(1, self.DoCannonChance) == 1 then
                self.ShouldDoStriderCannon = true
            end

            self.NextConsiderCannon = CurTime()+self.ConsiderCannonDelay
        end

        -- Consider doing burst attack every now and then:
        if self.NextConsiderBurst < CurTime() then
            if self.BurstRepsLeft < 1 && math.random(1, self.DoBurstChance) == 1 then
                self.BurstRepsLeft = 3
            end

            self.NextConsiderBurst = CurTime()+self.ConsiderBurstDelay
        end

        -- If we are close to a position to shoot at, do any available range attack.
        if self.ShootPos then
            local dist = self.ShootPos:Distance(self:GetPos())

            if dist > self.Fire_TooCloseDist && dist < self.FireDistance then
                if self.ShouldDoStriderCannon then
                    -- If we should do the strider cannon attack, do it first.
                    self:StriderCannon()
                elseif self.BurstRepsLeft > 0 then
                    -- If we have burst attacks to do, do them before regular gun attack.
                    self:GunBurstAttack()
                else
                    -- Otherwise use regular gun attack.
                    self:GunAttack()
                end
            end
        end
    else
        self:StopBurstAttack()
        self.BurstRepsLeft = 0
        self.ShootPos = nil
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Strider_MeleeAttack()
    if self.Strider_MeleeAttacking then return end
    self.Strider_MeleeAttacking = true

    local anim = "bighitl"
    local time_total = 2.5
    local time_until_damage = 1.5
    
    self:VJ_ACT_PLAYACTIVITY(anim,true,time_total,true)

    timer.Simple(time_until_damage, function() if IsValid(self) then
        local hitents = util.VJ_SphereDamage(self,self, self:GetAttachment(1).Pos + Vector(0,0,35) ,self.MeleeAttackDamageDistance,self.MeleeAttackDamage,bit.bor(DMG_CRUSH, DMG_SLASH),true,false,false,false)

        for _,ent in pairs(hitents) do
            if ent:IsSolid() then
                self:EmitSound("npc/strider/strider_skewer1.wav",95,math.random(85, 100))
                break
            end
        end
    end end)

    timer.Simple(time_total, function() if IsValid(self) then
        self.Strider_MeleeAttacking = false
    end end)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Shoot(damage,soundpitch,accuracy_mult,tracer)
    local source = self:GetAttachment(10).Pos
    local pos = self.ShootPos or self:GetPos()+self:OBBCenter()+self:GetForward()*100
    local shootdir = pos - self.bulletprop1:GetPos()

    accuracy_mult = accuracy_mult or 1
    tracer = tracer or "AirboatGunHeavyTracer"

    ParticleEffectAttach("vj_rifle_full_blue",PATTACH_POINT_FOLLOW,self,10)
    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "5")
    expLight:SetKeyValue("distance", "250")
    expLight:Fire("Color", "0 75 255")
    expLight:SetPos(source)
    expLight:Spawn()
    expLight:SetParent(self,10)
    expLight:Fire("TurnOn", "", 0)
    timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
    self:DeleteOnRemove(expLight)

    self.bulletprop1:FireBullets({
        Src = self.bulletprop1:GetPos(),
        Dir = shootdir:GetNormalized(),
        Damage = damage*0.5,
        Force = 25,
        TracerName = tracer,
        Spread = Vector( self.BulletSpread/accuracy_mult,self.BulletSpread/accuracy_mult,self.BulletSpread/accuracy_mult ),
        Num = 1,
        Tracer = 1,
        Attacker = self,
        Inflictor = self,
        Filter = self,
		Callback = function(attacker, tracer)
            if math.random(1, 2) == 1 then
                local effectdata = EffectData()
                effectdata:SetOrigin(tracer.HitPos)
                effectdata:SetNormal(tracer.HitNormal)
                effectdata:SetRadius( 10 )
                util.Effect( "cball_bounce", effectdata )
            end
            effects.BeamRingPoint( tracer.HitPos, 0.2, 0, 70, 12, 12, Color(255,255,175) )
			util.VJ_SphereDamage(self,self,tracer.HitPos,20,damage*0.5,DMG_SONIC,true,false,false,false)
		end,
    })

    local randpitch = math.random(soundpitch-10, soundpitch+10)
    self:EmitSound("^npc/strider/strider_minigun.wav",140,randpitch,1,CHAN_STATIC)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GunAttack()
    if self.NextRegularShoot > CurTime() then return end
    self.NextRegularShoot = CurTime() + self.GunAttackFireDelay
    self:Shoot(self.ShootDamage,80)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopBurstAttack()
    timer.Remove(self.BurstAttackShootTimerName)
    self.BurstAttacking = false
    self.BurstRepsLeft = self.BurstRepsLeft - 1
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GunBurstAttack()
    if self.BurstAttacking then return end
    self.BurstAttacking = true

    local time_until_burst = 0.75
    local burst_cool_off_time = 0.33

    self:EmitSound("npc/attack_helicopter/aheli_charge_up.wav", 100,  math.random(120, 140))
    self:EmitSound("weapons/cguard/charging.wav", 100, math.random(90, 100) , 0.33)

    timer.Simple(time_until_burst, function() if IsValid(self) then

        timer.Create(self.BurstAttackShootTimerName, self.BurstFireDelay, self.BurstFireBulletAmt, function()
            self:Shoot(self.ShootDamage,110,self.BurstAccuracyMult,"AirboatGunTracer")
            
            if timer.RepsLeft(self.BurstAttackShootTimerName) == 0 then
                timer.Simple(burst_cool_off_time, function() if IsValid(self) then
                    self:StopBurstAttack()
                end end)
            end
        end)

    end end)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StriderCannon()
    if self.DoingStriderCannon then return end
    self.DoingStriderCannon = true

    local pos = self.ShootPos
    local time_until_fire = 1.1

    -- Charge cannon
    self.StriderCannonCharging = true
    self:SetNWBool("StriderChargingCannon", true)

    self:SetNWVector("StriderCannonBeamPos",pos)

    self:EmitSound("npc/strider/charging.wav",120,math.random(80, 90),0.75)
    self:EmitSound("npc/attack_helicopter/aheli_charge_up.wav", 120,  math.random(110, 120))
    self:EmitSound("weapons/cguard/charging.wav", 120, math.random(70, 80) , 0.33)

    local effectdata = EffectData()
    effectdata:SetStart(pos)
    effectdata:SetMagnitude(time_until_fire)
    effectdata:SetEntity(self)
    effectdata:SetAttachment(9)
    effectdata:SetScale(0.66)
    util.Effect("cguard_warp", effectdata)

    self.BlackHoleLight = ents.Create("light_dynamic")
    self.BlackHoleLight:SetKeyValue("brightness", "3")
    self.BlackHoleLight:SetKeyValue("distance", "250")
    self.BlackHoleLight:Fire("Color", "0 75 255")
    self.BlackHoleLight:SetPos(self:GetAttachment(9).Pos)
    self.BlackHoleLight:SetParent(self,9)
    self.BlackHoleLight:Spawn()
    self.BlackHoleLight:Fire("TurnOn", "", 0)
    self:DeleteOnRemove(self.BlackHoleLight)

    -- Fire cannon
    timer.Simple(time_until_fire, function() if IsValid(self) then
        self.StriderCannonCharging = false
        self:SetNWBool("StriderChargingCannon", false)

        self.BlackHoleLight:Remove()

        if self.ShootPos then
            local tr = util.TraceLine({
                start = self:GetAttachment(9).Pos,
                endpos = self:GetAttachment(9).Pos + (pos-self:GetAttachment(9).Pos):GetNormalized()*10000,
                mask = MASK_SHOT,
                filter = self,
            })

            local expLight2 = ents.Create("light_dynamic")
            expLight2:SetKeyValue("brightness", "9")
            expLight2:SetKeyValue("distance", "600")
            expLight2:Fire("Color", "0 75 255")
            expLight2:SetPos(tr.HitPos)
            expLight2:Spawn()
            expLight2:Fire("TurnOn", "", 0)
            timer.Simple(0.1,function() if IsValid(expLight2) then expLight2:Remove() end end)
            self:DeleteOnRemove(expLight2)

            local effectdata2 = EffectData()
            effectdata2:SetOrigin(tr.HitPos)
            effectdata2:SetNormal(tr.HitNormal)
            effectdata2:SetRadius( 300 )
            effectdata2:SetScale( 100 )
            if tr.HitWorld then
                util.Effect( "cball_bounce", effectdata2 )
                util.Effect( "AR2Explosion", effectdata2 )
            end
            util.Effect( "ThumperDust", effectdata2 )
            util.Effect( "ThumperDust", effectdata2 )
            --ParticleEffect( "striderbuster_explode_dummy_core", tr.HitPos, Angle(0,0,00) )

            util.ScreenShake(tr.HitPos, 16, 200, 2, 4000)
            util.Decal( "Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

            effects.BeamRingPoint( tr.HitPos, 0.3, 0, 600, 25, 25, Color(255,255,175) )

            util.VJ_SphereDamage(self,self,tr.HitPos,225,self.StriderCannonDamage,bit.bor(DMG_DISSOLVE,DMG_SHOCK,DMG_BLAST),true,true,false,false)

            self:EmitSound("npc/strider/fire.wav",140,math.random(70, 80),1)
            self:EmitSound("npc/vj_combine_guard_z/cguard_fire.wav", 140, math.random(70, 80))

            sound.Play( "Weapon_Mortar.Impact", tr.HitPos, 120, 100, 1 )
        end
    end end)

    timer.Simple(2, function() if IsValid(self) then
        self.DoingStriderCannon = false
        self.ShouldDoStriderCannon = false
    end end)
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

    if !dmginfo:IsExplosionDamage() && !comballdamage then
        
        if dmginfo:IsBulletDamage() then
            dmginfo:SetDamage(dmginfo:GetDamage() * 0.05) -- Since bullet damage delivered to its head hitgroup is doubled.
        else
            dmginfo:SetDamage(dmginfo:GetDamage() * 0.1)
        end

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
    
        self.HasPainSounds = false -- If set to false, it won't play the pain sounds
    else
        self.Bleeds = true

        if comballdamage then
            dmginfo:SetDamage(150)
        end

        if dmginfo:GetDamage() >= 30 then
            self:AddGesture(self:GetSequenceActivity( self:LookupSequence("flinch_gesture") ))
        else
            self.HasPainSounds = false -- If set to false, it won't play the pain sounds
        end
        self:DoSpark(dmginfo:GetDamagePosition(),5)
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)

    self.HasDeathSounds = false

    local headpos = self:GetBonePosition(0)

	self:EmitSound("NPC_CombineGunship.Explode", 120, 100)
	local effectdata = EffectData()
	effectdata:SetOrigin(headpos)
	effectdata:SetScale( 500 )
	util.Effect( "Explosion", effectdata )
	self:EmitSound( "Explo.ww2bomb", 130, 100)
	ParticleEffect("vj_explosion1", headpos, Angle(0,0,0), nil)
    ParticleEffect( "striderbuster_explode_goop", headpos, self:GetAngles() )

	self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib1.mdl",{Pos = headpos, BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib2.mdl",{Pos = headpos, BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib3.mdl",{Pos = headpos, BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib4.mdl",{Pos = headpos, BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib5.mdl",{Pos = headpos, BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib6.mdl",{Pos = headpos, BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/strider_gib7.mdl",{Pos = headpos, BloodType = "",Vel = self:GetVelocity()+VectorRand()*600, CollideSound = {"SolidMetal.ImpactSoft"}})

	self:CreateGibEntity("prop_ragdoll","models/gibs/strider_head.mdl",{Pos = headpos-Vector(0,0,500), BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*500, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("prop_ragdoll","models/gibs/strider_weapon.mdl",{Pos = headpos-Vector(0,0,500), BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*500, CollideSound = {"SolidMetal.ImpactSoft"}})
	
    self:CreateGibEntity("prop_ragdoll","models/gibs/strider_back_leg.mdl",{Pos = self:GetPos()-Vector(0,0,500), BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*500, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("prop_ragdoll","models/gibs/strider_left_leg.mdl",{Pos = self:GetPos()-Vector(0,0,500), BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*500, CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("prop_ragdoll","models/gibs/strider_right_leg.mdl",{Pos = self:GetPos()-Vector(0,0,500), BloodType = "", Ang = self:GetAngles(), Vel = self:GetVelocity(), AngVel = VectorRand()*500, CollideSound = {"SolidMetal.ImpactSoft"}})
    return true

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
    timer.Remove(self.BurstAttackShootTimerName)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------