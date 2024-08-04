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

ENT.Model = {"models/vortigaunt_synth/VJ_vortigaunt_synth_Z.mdl"}
ENT.StartHealth = 120 -- The starting health of the NPC
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.MaxJumpLegalDistance = VJ_Set(150, 280) -- The max distance the NPC can jump (Usually from one node to another) | ( UP, DOWN )

ENT.AnimTbl_MeleeAttack = {
"meleehigh1",
"meleehigh2",
"meleehigh3",
"meleelow",
}
ENT.TimeUntilMeleeAttackDamage = 0.4 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 15
ENT.SoundTbl_MeleeAttack = {"NPC_FastZombie.AttackHit"}
ENT.SoundTbl_MeleeAttackMiss = {"NPC_Vortigaunt.Swing"}
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 100 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 150 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?

ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackDamage = 20
ENT.AnimTbl_RangeAttack = {"zapattack1"} -- Range Attack Animations
ENT.RangeDistance = 2500 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 150 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = 0.85 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 4 -- How much time until it can use a range attack?
ENT.NextRangeAttackTime_DoRand = 5 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own

ENT.MaxDispellDist = 400
ENT.DispellAttackDamage = 50
ENT.VortDispellCooldown = 5

ENT.HealDistance = 2500
ENT.VortHealCooldown = 6

ENT.SoundTbl_FootStep = {
"npc/stalker/stalker_footstep_left1.wav",
"npc/stalker/stalker_footstep_left2.wav",
"npc/stalker/stalker_footstep_right1.wav",
"npc/stalker/stalker_footstep_right2.wav",
}

ENT.SoundTbl_Idle = {
"npc/vortsynth/kill01.wav",
"npc/vortsynth/kill02.wav",
"npc/vortsynth/kill03.wav",
"npc/vortsynth/kill04.wav",
"npc/vortsynth/kill05.wav",
}

ENT.SoundTbl_CombatIdle = ENT.SoundTbl_Idle

ENT.SoundTbl_Alert = {
"npc/vortsynth/alert01.wav",
"npc/vortsynth/alert02.wav",
"npc/vortsynth/alert03.wav",
}

ENT.SoundTbl_Investigate = ENT.SoundTbl_Alert

ENT.SoundTbl_Death = {
"npc/vortsynth/die01.wav",
"npc/vortsynth/die02.wav",
}

ENT.SoundTbl_Pain = {
"npc/vortsynth/pain01.wav",
"npc/vortsynth/pain02.wav",
"npc/vortsynth/pain03.wav",
"npc/vortsynth/pain04.wav",
"npc/vortsynth/pain05.wav",
}

ENT.FootStepTimeRun = 0.3
ENT.FootStepTimeWalk = 0.5

ENT.FootStepSoundLevel = 80
ENT.IdleSoundLevel = 85
ENT.CombatIdleSoundLevel = 90
ENT.InvestigateSoundLevel = 90
ENT.AlertSoundLevel = 90
ENT.PainSoundLevel = 90
ENT.DeathSoundLevel = 90

ENT.FootStepPitch = VJ_Set(70, 80)

local hurtgests = {
    "flinch_01",
    "flinch_02",
    "flinch_03",
}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(5, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("SPACE (jump key): Dispell")
    ply:ChatPrint("ALT (walk key): Heal Orbs")

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

    self.VortChargeTimerName = "VJ_VortSynth_Z_ChargeTimer" .. self:EntIndex()
    self.VortHealOrbsTimerName = "VJ_VortSynth_Z_HealOrbTimer" .. self:EntIndex()
    self.NextDispell = CurTime()
    self.NextHeal = CurTime()
    self.NextFindHurtAllyT = CurTime()

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:VortCharge(effectreps)

    if !IsValid(self.ChargeLight1) then
        self.ChargeLight1 = ents.Create("light_dynamic")
        self.ChargeLight1:SetKeyValue("brightness", "2")
        self.ChargeLight1:SetKeyValue("distance", "150")
        self.ChargeLight1:Fire("Color", "0 75 255")
        self.ChargeLight1:SetPos(self:GetAttachment(3).Pos)
        self.ChargeLight1:SetParent(self,3)
        self.ChargeLight1:Spawn()
        self.ChargeLight1:Fire("TurnOn", "", 0)
        self:DeleteOnRemove(self.ChargeLight1)
    end

    if !IsValid(self.ChargeLight2) then
        self.ChargeLight2 = ents.Create("light_dynamic")
        self.ChargeLight2:SetKeyValue("brightness", "2")
        self.ChargeLight2:SetKeyValue("distance", "150")
        self.ChargeLight2:Fire("Color", "0 75 255")
        self.ChargeLight2:SetPos(self:GetAttachment(4).Pos)
        self.ChargeLight2:SetParent(self,4)
        self.ChargeLight2:Spawn()
        self.ChargeLight2:Fire("TurnOn", "", 0)
        self:DeleteOnRemove(self.ChargeLight2)
    end

    timer.Create(self.VortChargeTimerName, 0.3, effectreps, function()
        ParticleEffectAttach("st_elmos_fire_cp0", PATTACH_POINT_FOLLOW, self, 4)
        ParticleEffectAttach("st_elmos_fire_cp0", PATTACH_POINT_FOLLOW, self, 3)
        if timer.RepsLeft(self.VortChargeTimerName) == 0 then
            self.ChargeLight1:Remove()
            self.ChargeLight2:Remove()
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer(seed)

    self:VortCharge(3)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()

    self:EmitSound("npc/vortsynth/vort_attack_shoot" .. math.random(3, 4) .. ".wav",100,math.random(90, 110))

    if self.RangeAttackPos then
        for i = 3,4 do

            local source = self:GetAttachment(i).Pos

            local tr = util.TraceLine({
                start = source,
                endpos = source + (self.RangeAttackPos - (source+VectorRand(-20,20))):GetNormalized()*10000,
                mask = MASK_SHOT,
                filter = self,
            })
            util.ParticleTracerEx("Weapon_Combine_Ion_Cannon_Black",self:GetPos()+self:OBBCenter(),tr.HitPos,false,self:EntIndex(),i)
            util.VJ_SphereDamage(self,self,tr.HitPos,75,self.RangeAttackDamage*0.5,bit.bor(DMG_DISSOLVE,DMG_SHOCK),true,true,false,false)

        end
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DispellAttack()
    if self.DispellAttacking then return end
    self.DispellAttacking = true

    self:EmitSound("npc/vortsynth/vort_Dispell.wav",100,math.random(90, 110))
    self:VortCharge(4)

    local duration = self:SequenceDuration(self:LookupSequence("Dispel"))
    local impacttime = duration-0.33
    self:VJ_ACT_PLAYACTIVITY("Dispel",true,duration,false)

    timer.Simple(impacttime, function() if IsValid(self) then
        local Dispellpos = self:GetPos()+self:GetUp()*4

        util.VJ_SphereDamage(self,self,Dispellpos,self.MaxDispellDist*1.25,self.DispellAttackDamage,bit.bor(DMG_DISSOLVE,DMG_SHOCK,DMG_BLAST),true,true,false,false)

        util.ScreenShake(Dispellpos, 16, 200, 1, self.MaxDispellDist*4)
        self:EmitSound("weapons/physcannon/energy_sing_explosion2.wav",100,math.random(70, 80))

        local effectdata = EffectData()
        effectdata:SetOrigin(Dispellpos)
        effectdata:SetNormal(self:GetUp())
        effectdata:SetRadius( self.MaxDispellDist*0.25 )
        effectdata:SetScale( 150 )
        util.Effect( "cball_bounce", effectdata )
        util.Effect( "ThumperDust", effectdata )

        local expLight = ents.Create("light_dynamic")
        expLight:SetKeyValue("brightness", "4")
        expLight:SetKeyValue("distance", tostring(self.MaxDispellDist*2))
        expLight:Fire("Color", "0 75 255")
        expLight:SetPos(Dispellpos)
        expLight:Spawn()
        expLight:Fire("TurnOn", "", 0)
		timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
		self:DeleteOnRemove(expLight)

        effects.BeamRingPoint( Dispellpos, 0.35, 0, self.MaxDispellDist*2, 50, 5, Color(0,75,255) )

    end end)

    timer.Simple(duration, function() if IsValid(self) then
        self.DispellAttacking = false
        self.NextDispell = CurTime() + self.VortDispellCooldown
    end end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:VortHeal(agressive,target)
    if self.DoingHeal then return end
    self.DoingHeal = true

    self:VortCharge(5)

    if !agressive then
        self.VortHeal_CurrentAlly = target
    end

    local healduration = 2
    self:AddGesture(self:GetSequenceActivity(self:LookupSequence("gest_heal")))

    -- if agressive then
    --     self:VJ_ACT_PLAYACTIVITY("actionidle",true,healduration,true)
    -- else
    --     self:VJ_ACT_PLAYACTIVITY("idle02",true,healduration,false)
    -- end

    self:EmitSound("npc/vort/health_charge.wav",90,math.random(140, 150))

    timer.Simple(1.25, function() if IsValid(self) then

        timer.Create(self.VortHealOrbsTimerName, 0.16, 6, function()
            local speed = 650
            local orb = ents.Create("obj_vj_combvort_orb_z")
            orb:SetPos(self:GetAttachment(4).Pos)
            orb:SetAngles(self:GetForward():Angle())
            orb:SetOwner(self)
            orb.VJ_NPC_Class = self.VJ_NPC_Class
            orb.Target = target
            orb.Speed = speed
            if agressive then
                orb.TrackRatio = 0.19
            else
                orb.TrackRatio = 0.75
            end
            orb:Spawn()
            local dir = self:GetForward()
            if self.RangeAttackPos then
                dir = ( self.RangeAttackPos-self:GetPos() ):GetNormalized()
            end
            orb:GetPhysicsObject():SetVelocity( dir*speed )
        end)

    end end)

    timer.Simple(healduration, function() if IsValid(self) then
        self.VortHeal_CurrentAlly = nil
        self.DoingHeal = false
        self.NextHeal = CurTime()+self.VortHealCooldown
    end end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Attacking()
    if self.RangeAttacking or self.MeleeAttacking or self.DispellAttacking or self.DoingHeal then return true end
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

            local isAlly = false
            for _,npcclass in pairs(ent.VJ_NPC_Class) do
                for _,mynpcclass in pairs(self.VJ_NPC_Class) do
                    if npcclass == mynpcclass then
                        isAlly = true
                        break
                    end
                end
            end

            if !isAlly then continue end

            local healthratio = ent:Health()/ent:GetMaxHealth()
            local priority = tostring(1-healthratio)
            if healthratio < 1 && !ent.VJ_IsHugeMonster then hurt_allies[priority] = ent end

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

    self.NextFindHurtAllyT = CurTime() + 3
    return ally_to_heal

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
    if self.IsBeingDroppedByDropship then return end

    if !self.VJ_IsBeingControlled then
        if !self:Attacking() && self.NextFindHurtAllyT < CurTime() && self.NextHeal < CurTime() then
            local hurt_ally = self:FindHurtAlly()

            if hurt_ally then
                self:VortHeal(false,hurt_ally)
            end
        end

        if self.VortHeal_CurrentAlly && IsValid(self.VortHeal_CurrentAlly) then
            self:SetIdealYawAndUpdate( (self.VortHeal_CurrentAlly:GetPos() - self:GetPos()):Angle().y )
        end
    end


    local enemy = self:GetEnemy()
    if IsValid(enemy) then

        if self:Visible(enemy) then
            self.RangeAttackPos = enemy:GetPos()+enemy:OBBCenter()
        end

        if !self.VJ_IsBeingControlled then
            if self:Visible(enemy) then

                local enemydist = enemy:GetPos():Distance(self:GetPos())

                if !self:Attacking() && self.NextDispell < CurTime() && enemydist < self.MaxDispellDist then
                    self:DispellAttack()
                end

                if !self:Attacking() && self.NextHeal < CurTime() && enemydist < self.HealDistance && enemydist > self.RangeToMeleeDistance then
                    local tr = util.TraceLine({
                        start = self:GetPos()+self:OBBCenter(),
                        endpos = enemy:GetPos()+enemy:OBBCenter(),
                        mask = MASK_NPCWORLDSTATIC
                    })
                    if !tr.Hit then
                        self:VortHeal(true,enemy) -- HURT enemy, not heal.
                    end
                end

            end
        else
            local controller = self.VJ_TheController

            if !self:Attacking() && self.NextDispell < CurTime() && controller:KeyDown(IN_JUMP) then
                self:DispellAttack()
            end

            if !self:Attacking() && self.NextHeal < CurTime() && controller:KeyDown(IN_WALK) then
                self:VortHeal(true,enemy)
            end
        end

    else
        self.RangeAttackPos = nil
    end

    if self.DoingHeal then
        self.HasRangeAttack = false
        self.HasMeleeAttack = false 
    else
        self.HasRangeAttack = true
        self.HasMeleeAttack = true
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
    if timer.Exists(self.VortChargeTimerName) then
        timer.Remove(self.VortChargeTimerName)
    end
    if timer.Exists(self.VortHealOrbsTimerName) then
        timer.Remove(self.VortHealOrbsTimerName)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo)

    if math.random(1, 4) == 1 then
        self:AddGesture( self:GetSequenceActivity(self:LookupSequence(table.Random(hurtgests))) )
    end

    if !dmginfo:IsExplosionDamage() then
        dmginfo:ScaleDamage(0.5)
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
    if self.HasGibDeathParticles == true then -- Taken from black mesa SNPCs I think Xdddddd
        local bloodeffect = EffectData()
        bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
        bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
        bloodeffect:SetScale(120)
        util.Effect("VJ_Blood1",bloodeffect)
    end

    self:CreateGibEntity("obj_vj_gib","UseAlien_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Small",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,35))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
    self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos = self:LocalToWorld(Vector(0,0,30))})
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------