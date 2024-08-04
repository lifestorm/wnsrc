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

ENT.Model = {"models/stalker.mdl"}
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.StartHealth = 100
ENT.BloodColor = "Red"
ENT.TurningSpeed = 15

ENT.HasMeleeAttack = false

ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 500 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 0 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}

ENT.SoundTbl_FootStep = {
"npc/stalker/stalker_footstep_left1.wav",
"npc/stalker/stalker_footstep_left2.wav",
"npc/stalker/stalker_footstep_right1.wav",
"npc/stalker/stalker_footstep_right2.wav",
}

ENT.SoundTbl_Idle = {
"npc/stalker/stalker_ambient01.wav",
}

ENT.SoundTbl_CombatIdle = {
"npc/stalker/stalker_scream1.wav",
"npc/stalker/stalker_scream2.wav",
"npc/stalker/stalker_scream3.wav",
"npc/stalker/stalker_scream4.wav",
}

ENT.SoundTbl_Alert = {
"npc/stalker/stalker_alert1b.wav",
"npc/stalker/stalker_alert2b.wav",
"npc/stalker/stalker_alert3b.wav",
}

ENT.SoundTbl_Investigate = ENT.SoundTbl_Alert

ENT.SoundTbl_Death = {
"npc/stalker/stalker_die1.wav",
"npc/stalker/stalker_die2.wav",
}

ENT.SoundTbl_Pain = {
"npc/stalker/stalker_pain1.wav",
"npc/stalker/stalker_pain2.wav",
"npc/stalker/stalker_pain3.wav",
}

ENT.FootStepTimeRun = 0.85
ENT.FootStepTimeWalk = 0.85

ENT.FootStepSoundLevel = 80
ENT.IdleSoundLevel = 80
ENT.CombatIdleSoundLevel = 85
ENT.InvestigateSoundLevel = 85
ENT.AlertSoundLevel = 85
ENT.PainSoundLevel = 85
ENT.DeathSoundLevel = 85

ENT.BackAwayFromEnemyDist = 350

ENT.LaserReloadTime = 3
ENT.LaserMaxAmmo = 100
ENT.BeamHealChance = 3

ENT.HealDistance = 2000
ENT.AttackDistance = 3000

local beams = {
    repair_beam = {
        damage = 0,
        accuracy = 50, 
        damagetype = DMG_GENERIC,
        ammo_consumption = 1,
        spark_power = 1,
        color = "255 0 0",
        sound = {
            level = 80,
            pitch = 70,
            volume = 0.33,
        }
    },
    medium_beam = {
        damage = 2,
        accuracy = 275,
        damagetype = bit.bor(DMG_SHOCK, DMG_NEVERGIB),
        ammo_consumption = 2,
        spark_power = 2,
        color = "255 70 0",
        sound = {
            level = 90,
            pitch = 100,
            volume = 0.66,
        }
    },
    strong_beam = {
        damage = 4,
        accuracy = 275,
        damagetype = bit.bor(DMG_SHOCK, DMG_BURN, DMG_DISSOLVE),
        ammo_consumption = 4,
        spark_power = 5,
        color = "255 175 0",
        sound = {
            level = 100,
            pitch = 130,
            volume = 1,
        }
    },
}

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self.RandomSinMult1 = math.Rand(0.8, 1.2)
    self.RandomSinMult2 = math.Rand(0.8, 1.2)
    self.LaserAmmo = self.LaserMaxAmmo
    self.CurrentAttackBeamType = "medium_beam"
    self.Target = NULL

	self.LaserLight = ents.Create( "env_sprite" )
	self.LaserLight:SetKeyValue( "model","sprites/blueflare1.spr" )
	self.LaserLight:SetKeyValue( "rendercolor","0 0 0" )
	self.LaserLight:SetPos( self:GetAttachment(1).Pos )
	self.LaserLight:SetParent( self, 1 )
	self.LaserLight:SetKeyValue( "scale","0.5" )
	self.LaserLight:SetKeyValue( "rendermode","7" )
	self.LaserLight:Spawn()
	self:DeleteOnRemove(self.LaserLight)

    self.BeamSound = CreateSound(self,"npc/stalker/laser_burn.wav")
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoLaser(type,targetpos)
    if self.LaserAmmo < 1 or self.ReloadingLaser then return end

    local beam = beams[type]
    self:SetNWString("StalkerBeamType", type)

    self.StalkerFiringLaser = true
    self:SetNWBool("StalkerFiringLaser", true)

    if !self.BeamSound:IsPlaying() then
        self.BeamSound:SetSoundLevel(beam.sound.level)
        self.BeamSound:Play()
        self.BeamSound:ChangeVolume(beam.sound.volume)
        self.BeamSound:ChangePitch(math.random(beam.sound.pitch-10, beam.sound.pitch+10))
    end

    if !IsValid(self.muzzle_light) then
        self.muzzle_light = ents.Create("light_dynamic")
        self.muzzle_light:SetKeyValue("brightness", "2")
        self.muzzle_light:SetKeyValue("distance", "200")
        self.muzzle_light:SetKeyValue("style", "6")
        self.muzzle_light:Fire("Color", beam.color)
        self.muzzle_light:SetPos(self:GetAttachment(1).Pos)
        self.muzzle_light:Spawn()
        self.muzzle_light:SetParent(self,1)
        self.muzzle_light:Fire("TurnOn", "", 0)
    end
    self.LaserLight:SetKeyValue( "rendercolor", beam.color )

    local noise1 = beam.accuracy*math.sin(CurTime()*2.5*self.RandomSinMult1)
    local noise2 = beam.accuracy*math.sin(CurTime()*2.5*self.RandomSinMult2)
    local inaccuracy = Vector(noise1,noise2,noise2)

    local tr = util.TraceLine({
        start = self:GetAttachment(1).Pos,
        endpos = self:GetAttachment(1).Pos + (targetpos - self:GetAttachment(1).Pos):GetNormalized()*10000 + inaccuracy,
        mask = MASK_SHOT,
        filter = self,
    })

    local hitents = {}
    if beam.damage > 0 then
        hitents = util.VJ_SphereDamage(self,self,tr.HitPos,20,beam.damage,beam.damagetype,true,false,false,false)
    else
        hitents = ents.FindInSphere(tr.HitPos, 20)
    end

    for _,ent in pairs(hitents) do
        if type == "strong_beam" then
            if math.random(1,10) == 1 && ent:IsSolid() then
                ent:Ignite(1.5, 5)
            end
        elseif math.random(1,self.BeamHealChance) == 1 && type == "repair_beam" && ent == self.Target then
            ent:SetHealth( math.Clamp(ent:Health()+1, 0, ent:GetMaxHealth()) )
        end

        if ent:GetClass() == "func_breakable_surf" then
            ent:Fire("Shatter")
        end
    end

    if math.random(1, 2) == 1 then
        local spark = ents.Create("env_spark")
        spark:SetPos(tr.HitPos)
        spark:SetKeyValue("Magnitude",tostring(beam.spark_power))
        spark:SetKeyValue("Spark Trail Length",tostring(beam.spark_power))
        spark:Spawn()
        spark:Fire("StartSpark", "", 0)
        spark:Fire("StopSpark", "", 0.001)
        self:DeleteOnRemove(spark)

        local expLight = ents.Create("light_dynamic")
        expLight:SetKeyValue("brightness", "2")
        expLight:SetKeyValue("distance", "150")
        expLight:Fire("Color", beam.color)
        expLight:SetPos(tr.HitPos)
        expLight:Spawn()
        expLight:Fire("TurnOn", "", 0)
        timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
    end

    self:SetNWVector("StalkerLaserPos", tr.HitPos)
    self.StalkerLaserPos = tr.HitPos

    self.LaserAmmo = self.LaserAmmo - beam.ammo_consumption
    timer.Create("VJ_Z_StalkerCeaseFireLaser" .. self:EntIndex(), 0.15, 1, function() if IsValid(self) then
        self:SetNWBool("StalkerFiringLaser", false)
        self.StalkerFiringLaser = false
        self.StalkerLaserPos = nil
        self.LaserLight:SetKeyValue( "rendercolor","0 0 0" )
        self.muzzle_light:Remove()
        self.BeamSound:Stop()
    end end)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ReloadLaser()
    if self.ReloadingLaser then return end
    self.ReloadingLaser = true

    self.Target = NULL

    self.CurrentAttackBeamType = "medium_beam"
    if math.random(1, 3) == 1 then
        self.CurrentAttackBeamType = "strong_beam"
    end

    self:EmitSound("weapons/slam/mine_mode.wav",85,math.random(80, 90))

    timer.Simple(self.LaserReloadTime, function() if IsValid(self) then
        self.LaserAmmo = self.LaserMaxAmmo
        self.ReloadingLaser = false
    end end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsAlly(ent)
    if !ent.VJ_NPC_Class then return end

    for _,npcclass in pairs(ent.VJ_NPC_Class) do
        for _,mynpcclass in pairs(self.VJ_NPC_Class) do
            if npcclass == mynpcclass then
                return true
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FindHurtAlly()
    local hurt_allies = {}

    for _,ent in pairs(ents.FindInSphere(self:GetPos(), self.HealDistance)) do
        if ent:GetClass() != self:GetClass() && ent:IsNPC() && self:Visible(ent) && ent.VJ_NPC_Class then
            local tr = util.TraceLine({
                start = self:GetPos()+self:OBBCenter(),
                endpos = ent:GetPos()+ent:OBBCenter(),
                mask = MASK_NPCWORLDSTATIC
            })
            if tr.Hit then continue end

            if !self:IsAlly(ent) then continue end

            local healthratio = ent:Health()/ent:GetMaxHealth()
            local priority = tostring(1-healthratio)
            if healthratio < 1 then hurt_allies[priority] = ent end
        end
    end

    local highestPriority = 0
    local ally_to_heal = nil

    for priority,ally in pairs(hurt_allies) do
        if tonumber(priority) > highestPriority then
            ally_to_heal = ally
            highestPriority = tonumber(priority)
        end
    end

    return ally_to_heal
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("MOUSE1 (primary attack key): Regular Laser")
    ply:ChatPrint("MOUSE2 (secondary attack key): Strong Laser")
    ply:ChatPrint("R (reload key): Repair Laser")

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
    local enemy = self:GetEnemy()

    -- Back away from enemy:
    if IsValid(enemy) && !self.VJ_IsBeingControlled then
        local enemydist = self:GetPos():Distance(enemy:GetPos())

        if self:Visible(enemy) && !self:IsBusy() && enemydist < self.BackAwayFromEnemyDist then
            local tr = util.TraceLine({
                start = self:GetPos()+self:OBBCenter(),
                endpos = self:GetPos()+self:OBBCenter() + (self:GetPos() - enemy:GetPos()):GetNormalized()*self.BackAwayFromEnemyDist,
                mask = MASK_NPCWORLDSTATIC,
            })
            self:SetLastPosition( tr.HitPos )
            self:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH")
        end
    end

    -- Beam stuff:
    if !self.VJ_IsBeingControlled then
        ---------------------------------------------------------------------------
            -- Beam AI:
        ---------------------------------------------------------------------------

        if !IsValid(self.Target) then
            if math.random(1, 2) == 1 && IsValid(enemy) then
                self.Target = enemy
            else
                self.Target = self:FindHurtAlly() or NULL
            end
        end

        if IsValid(self.Target) then
            local target_reachable = self:Visible(self.Target) && self:GetPos():Distance(self.Target:GetPos()) < self.AttackDistance
            local target_is_ally = self:IsAlly(self.Target)

            local beamtype = self.CurrentAttackBeamType
            if target_is_ally then
                beamtype = "repair_beam"
            end

            if target_reachable then
                
                if target_is_ally then
                    -- Remove potential enemy supression point, if target is not an enemy.
                    self.ShootPos = nil
                else
                    -- Make potential enemy supression point, if target is an enemy.
                    self.ShootPos = self.Target:GetPos()+self.Target:OBBCenter()
                end
                -- Shoot straight at target.
                self:DoLaser(beamtype,self.Target:GetPos()+self.Target:OBBCenter())
            elseif self.ShootPos && !target_is_ally then
                -- Shoot at suppression point, where the target was last seen.
                self:DoLaser(self.CurrentAttackBeamType,self.ShootPos)
            end

            if (!target_reachable && !self.ShootPos) or ( target_is_ally && self.Target:Health() == self.Target:GetMaxHealth() ) or (enemy && enemy:IsPlayer() && !enemy:Alive()) then
                self.Target = NULL
            end
        else
            -- Remove potential enemy supression point, if there is no target.
            self.ShootPos = nil
        end
    else
        ---------------------------------------------------------------------------
            -- Beam when used by controller:
        ---------------------------------------------------------------------------

        local controller = self.VJ_TheController

        if IsValid(enemy) then
            if controller:KeyDown(IN_ATTACK) then
                self:DoLaser("medium_beam",enemy:GetPos())
            elseif controller:KeyDown(IN_ATTACK2) then
                self:DoLaser("strong_beam",enemy:GetPos())
            elseif controller:KeyDown(IN_RELOAD) then
                self:DoLaser("repair_beam",enemy:GetPos())
            end
        end
    end

    -- Don't forget to reload doctor freeman:
    if self.LaserAmmo < 1 then
        self:ReloadLaser()
    end

    -- Look at the position we are firing the beam at:
    if self.StalkerLaserPos then
        self:FaceCertainPosition(self.StalkerLaserPos, 0.2)
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
    if self.HasGibDeathParticles == true then -- Taken from black mesa SNPCs I think Xdddddd
        local bloodeffect = EffectData()
        bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
        bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
        bloodeffect:SetScale(120)
        util.Effect("VJ_Blood1",bloodeffect)
    end

    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/brain_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,60)),Ang = self:GetAngles() + Angle(0,-90,0)})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/heart_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseHuman_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
    return true
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
    self.BeamSound:Stop()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------