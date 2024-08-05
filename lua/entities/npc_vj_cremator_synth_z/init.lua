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

ENT.Model = {"models/vj_cremator_z.mdl"}
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.StartHealth = 290
ENT.BloodColor = "Red"
ENT.TurningSpeed = 10

ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.HasMeleeAttack = false

ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 1 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextFlinchTime = 0 -- How much time until it can flinch again?
ENT.AnimTbl_Flinch = {
    "flich1", -- f l i c h
}

ENT.CremateCorpseFindCooldown = {
    min = 2,
    max = 4,
}

ENT.CrematorGunCooldown = {
    min = 4,
    max = 6,
}

ENT.MaxAttackDist = 3000
ENT.MaxCremateDist = 1500

ENT.BeamBlastRadius = 25
ENT.BeamDamage = 4

ENT.BackAwayFromEnemyDist = 200

ENT.FootStepSoundLevel = 85
ENT.BreathSoundLevel = 80
ENT.DeathSoundLevel = 85

ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.8 -- Next foot step sound when it is walking

ENT.SoundTbl_FootStep = {"npc/cremator/foot1.wav","npc/cremator/foot2.wav","npc/cremator/foot3.wav"}
ENT.SoundTbl_Breath = {"npc/cremator/amb_loop.wav"}
ENT.SoundTbl_Death = {"npc/cremator/crem_die.wav"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(12, 0, 14), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetCollisionBounds(Vector(-15,-15,0), Vector(15,15,90))

    self.NextFindCorpseTime = CurTime()
    self.NextCrematorGunUse = CurTime()
    self.NextBackAwayFromEnemy = CurTime()

    self.BeamMoveNoiseMult1 = math.Rand(0.85, 1.15)
    self.BeamMoveNoiseMult2 = math.Rand(0.85, 1.15)

    self.PlasmaBurnLoop = CreateSound(self,"npc/cremator/plasma_shoot.wav")
    self.PlasmaBurnLoop:SetSoundLevel(95)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

	ply:ChatPrint("MOUSE1 (primary attack key): Fire While Swinging Left And Right")
    ply:ChatPrint("MOUSE2 (secondary attack key): Fire Concentrated Beam")

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopCremateAttack(use_cooldown)
    if !self.Cremating then return end
    self.Cremating = false
    self.DoingGunSwing = false

    if use_cooldown then
        self.NextCrematorGunUse = CurTime() + math.Rand(self.CrematorGunCooldown.min, self.CrematorGunCooldown.max)
    end

    if IsValid(self.Arc_Ent) then
        self.Arc_Ent:Remove()
    end

    if self.GunShouldFire then
        self.PlasmaBurnLoop:Stop()
        self:EmitSound("npc/cremator/plasma_stop.wav",90,math.random(90,110))
        self.GunShouldFire = false
        self.muzzle_light:Remove()
    end

    -- Reset animation to idle.
    self:VJ_ACT_PLAYACTIVITY(ACT_IDLE,true,0.5,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoCremateAttack(swing_gun_anim,is_enemy_attack)
    if self.Cremating or self.Flinching then return end
    self.Cremating = true

    local anim = "fireinout"
    local duration = 5.5

    if swing_gun_anim then
        self.DoingGunSwing = true
        anim = "fireinoutsw"
    end

    timer.Create("VJ_Z_CrematorStartFiringGunTimer" .. self:EntIndex(), 1, 1, function() if IsValid(self) && self.Cremating && !self.GunShouldFire then
        self.GunShouldFire = true
        self.PlasmaBurnLoop:Play()
        self.PlasmaBurnLoop:ChangePitch(math.random(90, 110))

        self.muzzle_light = ents.Create("light_dynamic")
        self.muzzle_light:SetKeyValue("brightness", "3")
        self.muzzle_light:SetKeyValue("distance", "250")
        self.muzzle_light:SetKeyValue("style", "6")
        self.muzzle_light:Fire("Color", "75 255 33")
        self.muzzle_light:SetPos(self:GetAttachment(1).Pos)
        self.muzzle_light:Spawn()
        self.muzzle_light:SetParent(self,1)
        self.muzzle_light:Fire("TurnOn", "", 0)
    end end)

    local face_enemy = is_enemy_attack
    self:VJ_ACT_PLAYACTIVITY(anim,true,duration,face_enemy)
    timer.Create("VJ_Z_CrematorStopFiringGunTimer" .. self:EntIndex(), duration, 1, function() if IsValid(self) && self.Cremating then self:StopCremateAttack(true) end end)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetNearestCorpse()
    local nearest_corpse = nil
    local nearest_corpse_dist = nil

    for _,ent in pairs(ents.FindInSphere(self:GetPos(), self.MaxCremateDist)) do
        --local yaw_diff = math.abs( self:WorldToLocalAngles( (ent:GetPos() - self:GetPos()):Angle() ).y )
        --if yaw_diff > 90 then continue end

        local dist = self:GetPos():Distance(ent:GetPos())

        if ent.IsVJBaseCorpse && (!nearest_corpse_dist or dist < nearest_corpse_dist) && self:Visible(ent) then
            nearest_corpse = ent
            nearest_corpse_dist = dist
        end
    end

    return nearest_corpse
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HasManyVisibleEnemies()
    -- Minimum amount of enemies required in order for us to return true
    local min_enemies = 3
    local enemy_amt = 0
    local max_dist = 350

    for _,npc in pairs(ents.FindInSphere(self:GetPos(), max_dist)) do
        if (npc:IsNPC() or npc:IsPlayer()) && self:Disposition(npc) == D_HT && self:Visible(npc) then

            --local yaw_diff = math.abs( self:WorldToLocalAngles( (npc:GetPos() - self:GetPos()):Angle() ).y )

            --if yaw_diff < 45 then
                enemy_amt = enemy_amt + 1
            --end

        end
    end

    if enemy_amt >= min_enemies then return true end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireGun()
    if !IsValid(self.Arc_Ent) then
        self.Arc_Ent = ents.Create("base_gmodentity")
        self.Arc_Ent:SetModel("models/props_junk/PopCan01a.mdl")
        self.Arc_Ent:Spawn()
        self.Arc_Ent:SetNoDraw(true)
        self:DeleteOnRemove(self.Arc_Ent)
    end

    local source = self:GetAttachment(1).Pos
    local destination = self.IdealShootPos

    local noise1 = 60*math.sin(CurTime()*3.5*self.BeamMoveNoiseMult1)
    local noise2 = 60*math.sin(CurTime()*3.5*self.BeamMoveNoiseMult2)
    local inaccuracy = Vector(noise1,noise2,noise2)
    
    local tr_main = util.TraceLine({
        start = source,
        endpos = source + (destination-source):GetNormalized()*self.MaxAttackDist + inaccuracy,
        mask = MASK_SHOT,
        filter = self,
    })

    util.ParticleTracerEx("vortigaunt_beam_b", source, tr_main.HitPos, false, self:EntIndex(), 1)
    ParticleEffect("vortigaunt_glow_beam_cp1",self:GetAttachment(1).Pos,Angle(0,0,0))

    local hitents = util.VJ_SphereDamage(self,self,tr_main.HitPos,self.BeamBlastRadius,self.BeamDamage,bit.bor(DMG_BURN, DMG_DISSOLVE, DMG_SHOCK, DMG_NEVERGIB),true,true,false,false)
    for _,ent in pairs(hitents) do
        if ent.IsVJBaseCorpse then
            ent:SetName( "ZippyCrematedRagdoll" .. ent:EntIndex() )
            local dissolve = ents.Create("env_entity_dissolver")
            dissolve:SetKeyValue("target", ent:GetName())
            dissolve:SetKeyValue("dissolvetype", 2)
            dissolve:Fire("Dissolve", ent:GetName())
            dissolve:Spawn()
            ent:DeleteOnRemove(dissolve)
        elseif ent:IsSolid() then
            if math.random(1,20) == 1 then
                ent:Ignite(2, 5)
            end
        end
    end

    for i = 1,4 do
        local tr = util.TraceLine({
            start = tr_main.HitPos,
            endpos = tr_main.HitPos + VectorRand(-350,350),
            mask = MASK_SHOT,
            filter = {self,self.Arc_Ent},
        })

        self.Arc_Ent:SetPos(tr_main.HitPos)
        util.ParticleTracerEx("vortigaunt_beam_b", tr_main.HitPos, tr.HitPos, false, self.Arc_Ent:EntIndex(), 0)

        if tr.Hit then
            local effectdata = EffectData()
            effectdata:SetOrigin(tr.HitPos)
            effectdata:SetNormal(tr.HitNormal)
            effectdata:SetRadius( 8 )
            util.Effect( "cball_bounce", effectdata )

            --util.Decal( "Dark", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

            local expLight = ents.Create("light_dynamic")
            expLight:SetKeyValue("brightness", "2")
            expLight:SetKeyValue("distance", "150")
            expLight:Fire("Color", "75 255 33")
            expLight:SetPos(tr.HitPos)
            expLight:Spawn()
            expLight:Fire("TurnOn", "", 0)
            timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)

            effects.BeamRingPoint( tr.HitPos, 0.2, 0, 65, 15, 15, Color(35,125,35) )
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
    local enemy = self:GetEnemy()

    if IsValid(enemy) then

        if self.DoingGunSwing then
            self.IdealShootPos = self:GetAttachment(1).Pos + (self:GetAttachment(1).Ang + Angle(-22,-90,0)):Forward()*self.MaxAttackDist
        elseif self:Visible(enemy) then
            self.IdealShootPos = enemy:GetPos()+enemy:OBBCenter()
        end

        if !self.VJ_IsBeingControlled then
            local enemydist = self:GetPos():Distance(enemy:GetPos())

            if self.NextBackAwayFromEnemy < CurTime() && enemydist < self.BackAwayFromEnemyDist && !self.Cremating then
                self:SetLastPosition( self:GetPos() + (self:GetPos() - enemy:GetPos()):GetNormalized()*self.BackAwayFromEnemyDist )
                self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
                self.NextBackAwayFromEnemy = CurTime()+4
            end

            if self.IdealShootPos && self.NextCrematorGunUse < CurTime() then
                -- Swing gun left and right if there are many visible enemies
                local swing_gun_anim = self:HasManyVisibleEnemies()
        
                if enemydist < self.MaxAttackDist then
                    self:DoCremateAttack(swing_gun_anim,true)
                end
            end
        else

            local controller = self.VJ_TheController

            --if self.NextCrematorGunUse < CurTime() then
                if controller:KeyDown(IN_ATTACK2) then
                    -- Regular attack
                    self:DoCremateAttack(false,true)
                elseif controller:KeyDown(IN_ATTACK) then
                    -- Gun swing attack
                    self:DoCremateAttack(true,true)
                end
            --end

        end

    else

        if !self.VJ_IsBeingControlled then
            if self.NextFindCorpseTime < CurTime() && self.NextCrematorGunUse < CurTime() then
                self.TargetCorpse = self:GetNearestCorpse()
                
                if !self.Cremating && self.TargetCorpse then
                    self:DoCremateAttack(false,false)
                end

                self.NextFindCorpseTime = CurTime() + math.Rand(self.CremateCorpseFindCooldown.min, self.CremateCorpseFindCooldown.max)
            end

            if IsValid(self.TargetCorpse) && self.Cremating then
                self.IdealShootPos = self.TargetCorpse:GetPos() + self.TargetCorpse:OBBCenter()
            else
                self.IdealShootPos = nil
            end
        end
    
    end

    if self.Cremating then
        if self.IdealShootPos then

            if !self.DoingGunSwing or !IsValid(enemy) then
                self:SetIdealYawAndUpdate( (self.IdealShootPos-self:GetPos()):Angle().y )
            end

            if self.GunShouldFire then
                self:FireGun()
            end

        else
            self:StopCremateAttack(false)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

    if comballdamage then
        dmginfo:SetDamage(150)
    elseif !dmginfo:IsExplosionDamage() then
        dmginfo:ScaleDamage(0.5)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
    corpseEnt:SetBodygroup(1,1)
    self:CreateGibEntity("obj_vj_gib","models/cremator_gun.mdl",{BloodType = "", CollideSound = {"SolidMetal.ImpactSoft"}})
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup) -- Return false to disallow the flinch from playing
    if dmginfo:GetDamage() < 80 then
        return false
    end

    if self.Cremating then
        self:StopCremateAttack(true)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
    if self.HasGibDeathParticles == true then -- Taken from black mesa SNPCs I think Xdddddd
        local bloodeffect = EffectData()
        bloodeffect:SetOrigin(self:GetPos() + self:OBBCenter())
        bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
        bloodeffect:SetScale(200)
        util.Effect("VJ_Blood1",bloodeffect)
    end

    self:CreateGibEntity("obj_vj_gib","models/cremator_head.mdl",{Pos = self:LocalToWorld(Vector(0,0,60)),Ang = self:GetAngles() + Angle(0,-90,0)})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/heart_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/lung_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,40))})
    self:CreateGibEntity("obj_vj_gib","models/gibs/humans/liver_gib.mdl",{Pos = self:LocalToWorld(Vector(0,0,35))})
    for i = 1, 2 do
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
    end
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
    self.PlasmaBurnLoop:Stop()
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------