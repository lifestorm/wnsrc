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

ENT.Model = "models/VJ_ministrider_Z.mdl"
ENT.StartHealth = 235
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}

ENT.ShootDistance = 3000
ENT.MinShootDist = 100
ENT.BulletSpread = 0.03

--ENT.BloodColor = "White"

ENT.RangeAttackCooldown = {
    min = 1.5,
    max = 3,
}
ENT.RangeAttackDuration = {
    min = 1.5,
    max = 3,
}

ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.AnimTbl_MeleeAttack = {"meleeleft"}
ENT.MeleeAttackDamage = 20
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 200 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 300 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackBleedEnemy = true -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 1 -- Chance that the enemy bleeds | 1 = always
ENT.MeleeAttackBleedEnemyTime = 0.33 -- How much time until the next repetition?
ENT.MeleeAttackBleedEnemyReps = 10 -- How many repetitions?

ENT.InvestigateSoundDistance = 36
ENT.CallForHelpDistance = 10000 -- -- How far away the SNPC's call for help goes | Counted in World Units

ENT.GeneralSoundPitch1 = 190
ENT.GeneralSoundPitch2 = 200

ENT.SoundTbl_FootStep = {
"^npc/strider/strider_step1.wav",
"^npc/strider/strider_step2.wav",
"^npc/strider/strider_step3.wav",
"^npc/strider/strider_step4.wav",
"^npc/strider/strider_step5.wav",
}
ENT.SoundTbl_Alert = {
"npc/strider/striderx_alert2.wav",
"npc/strider/striderx_alert4.wav",
"npc/strider/striderx_alert5.wav",
}
ENT.SoundTbl_CombatIdle = ENT.SoundTbl_Alert
ENT.SoundTbl_Investigate = ENT.SoundTbl_Alert

ENT.SoundTbl_Idle = {"npc/strider/strider_hunt1.wav","npc/strider/strider_hunt2.wav","npc/strider/strider_hunt3.wav"}
ENT.SoundTbl_Pain = {"npc/strider/striderx_pain5.wav","npc/strider/striderx_pain7.wav"}
ENT.SoundTbl_Death = {"npc/strider/striderx_die1.wav"}


local huntervoicevolume = 90
ENT.AlertSoundLevel = huntervoicevolume
ENT.PainSoundLevel = huntervoicevolume
ENT.DeathSoundLevel = 85
ENT.CombatIdleSoundLevel = huntervoicevolume
ENT.InvestigateSoundLevel = huntervoicevolume

ENT.FootStepSoundLevel = 90
ENT.FootStepPitch = VJ_Set(130, 150)

ENT.shoot_attachment = 1

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "MiniStrider.body_joint", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(30, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

    self:SetCollisionBounds(Vector(-16,-16,0), Vector(16,16,90))

    self.NextMainRangeAttackTime = CurTime()

    --self:SetBloodColor(BLOOD_COLOR_MECH)

    self.bulletprop1 = ents.Create("base_gmodentity")
    self.bulletprop1:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self.bulletprop1:SetPos(self:GetAttachment(1).Pos + self:GetForward()*6)
    self.bulletprop1:SetParent(self,1)
    self.bulletprop1:SetSolid(SOLID_NONE)
    self.bulletprop1:AddEFlags(EFL_DONTBLOCKLOS)
    self.bulletprop1:SetNoDraw(true)
    self.bulletprop1:Spawn()

    self.bulletprop2 = ents.Create("base_gmodentity")
    self.bulletprop2:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self.bulletprop2:SetPos(self:GetAttachment(2).Pos + self:GetForward()*6)
    self.bulletprop2:SetParent(self,2)
    self.bulletprop2:SetSolid(SOLID_NONE)
    self.bulletprop2:AddEFlags(EFL_DONTBLOCKLOS)
    self.bulletprop2:SetNoDraw(true)
    self.bulletprop2:Spawn()

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events

function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)

    if ev == 2050 or ev == 2050 then
        self:FootStepSoundCode()
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Shoot()

    local shootents = {self.bulletprop1,self.bulletprop2}
    local source = self:GetAttachment(self.shoot_attachment).Pos
    local pos = self.ShootPos or self:GetPos()+self:OBBCenter()+self:GetForward()*100
    local shootdir = pos - shootents[self.shoot_attachment]:GetPos()

    ParticleEffectAttach("vj_rifle_full_blue",PATTACH_POINT_FOLLOW,self,self.shoot_attachment)
    local expLight = ents.Create("light_dynamic")
    expLight:SetKeyValue("brightness", "2")
    expLight:SetKeyValue("distance", "175")
    expLight:Fire("Color", "0 75 255")
    expLight:SetPos(source)
    expLight:Spawn()
    expLight:SetParent(self,self.shoot_attachment)
    expLight:Fire("TurnOn", "", 0)
    timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
    self:DeleteOnRemove(expLight)

    shootents[self.shoot_attachment]:FireBullets({
        Src = shootents[self.shoot_attachment]:GetPos(),
        Dir = shootdir:GetNormalized(),
        Damage = 6,
        Force = 25,
        TracerName = "AirboatGunTracer",
        Spread = Vector( self.BulletSpread,self.BulletSpread,self.BulletSpread ),
        Num = 1,
        Tracer = 1,
        Attacker = self,
        Inflictor = self,
        Filter = self,
        -- Callback = function(attacker, tracer)
        --     local effectdata = EffectData()
        --     effectdata:SetOrigin(tracer.HitPos)
        --     effectdata:SetNormal(tracer.HitNormal)
        --     effectdata:SetRadius( 5 )
        --     util.Effect( "cball_bounce", effectdata )
        -- end,
    })

    self:EmitSound("^npc/strider/strider_minigun.wav",130,math.random(90, 110),0.66,CHAN_WEAPON)

    if math.abs( self:WorldToLocalAngles(shootdir:Angle()).y ) > 22.5 then
        self:SetIdealYawAndUpdate( shootdir:Angle().y )
    end

    if self.shoot_attachment == 1 then
        self.shoot_attachment = 2
    elseif self.shoot_attachment == 2 then
        self.shoot_attachment = 1
    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartMainRangeAttack()
    if self.DoingMainRangeAttack then return end
    self.DoingMainRangeAttack = true

    local deploytime = self:SequenceDuration(self:LookupSequence("plant"))
    self:VJ_ACT_PLAYACTIVITY("plant",true,deploytime,true)

    timer.Simple(deploytime, function() if IsValid(self) then
        local duration = math.Rand(self.RangeAttackDuration.min, self.RangeAttackDuration.max)

        self:VJ_ACT_PLAYACTIVITY(ACT_RANGE_ATTACK1,true,duration,false)

        timer.Simple(duration, function() if IsValid(self) && self.DoingMainRangeAttack then

            self.NextMainRangeAttackTime = CurTime() + math.Rand(self.RangeAttackCooldown.min, self.RangeAttackCooldown.max)
            self.DoingMainRangeAttack = false

        end end)

    end end)

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp) -- return true to disable the attack and move onto the next entity!

    if IsValid(hitEnt) && !isProp then self:EmitSound("npc/strider/strider_skewer1.wav",80,math.random(140, 150)) end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("MOUSE2 (secondary attack key): Shoot")

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()

    local enemy = self:GetEnemy()


    if IsValid(enemy) then

        if self.Charging then self:ChargeThink() end

        if self:Visible(enemy) then
            self.ShootPos = enemy:GetPos() + enemy:OBBCenter()
        end

        local enemydist = self:GetPos():Distance(enemy:GetPos())


        if self.VJ_IsBeingControlled then

            local controller = self.VJ_TheController

            if controller:KeyDown(IN_ATTACK2) then
                self:StartMainRangeAttack()
            end

        else

            if self.NextMainRangeAttackTime < CurTime() then
                if self.ShootPos && enemydist < self.ShootDistance && enemydist > self.MinShootDist then
                    self:StartMainRangeAttack()
                end
            end

        end

        if self:GetSequenceName(self:GetSequence()) == "shoot" then
            self:Shoot()
        end

    else

        if self.DoingMainRangeAttack then
            self:VJ_ACT_PLAYACTIVITY("unplant",true,1,true)
            self.DoingMainRangeAttack = false
        end

        self.ShootPos = nil

    end

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

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
        dmginfo:SetDamage(dmginfo:GetDamage()*0.2)

        if math.random(1, 4) == 1 then self:EmitSound("weapons/fx/rics/ric1.wav", 82, math.random(85, 115)) end
        
        local spark = ents.Create("env_spark")
        spark:SetPos(dmginfo:GetDamagePosition())
        spark:Spawn()
        spark:Fire("StartSpark", "", 0)
        spark:Fire("StopSpark", "", 0.001)
        self:DeleteOnRemove(spark)
    end

    if comballdamage then
        dmginfo:SetDamage(150)
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------