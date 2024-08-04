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

ENT.Model = {"models/zippy/assassin.mdl"}
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.TurningSpeed = 30

ENT.StartHealth = 140
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.DeathCorpseSkin = 1

ENT.CallForHelpDistance = 10000
ENT.InvestigateSoundDistance = 18

ENT.MeleeAttackDamage = 15
ENT.AnimTbl_MeleeAttack = {"stab"} -- Melee Attack Animations
ENT.SoundTbl_MeleeAttack = {"NPC_FastZombie.AttackHit"}
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 150 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 175 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackBleedEnemy = true -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 1 -- Chance that the enemy bleeds | 1 = always
ENT.MeleeAttackBleedEnemyTime = 0.33 -- How much time until the next repetition?
ENT.MeleeAttackBleedEnemyReps = 15 -- How many repetitions?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {"stab"}
ENT.RangeAttackEntityToSpawn = "obj_vj_knife_z" -- The entity that is spawned when range attacking

ENT.RangeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the range attack animation?
ENT.RangeDistance = 4000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 75 -- How close does it have to be until it uses melee?
ENT.RangeAttackAngleRadius = 180 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.TimeUntilRangeAttackProjectileRelease = 0.5 -- How much time until the projectile code is ran?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own
ENT.NextRangeAttackTime = 2 -- How much time until it can use a range attack?
ENT.NextRangeAttackTime_DoRand = 3 -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 600 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = 300 -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead

ENT.GeneralSoundPitch1 = 120
ENT.GeneralSoundPitch2 = 130

ENT.SoundTbl_FootStep = {
"npc/fast_zombie/foot1.wav",
"npc/fast_zombie/foot2.wav",
"npc/fast_zombie/foot3.wav",
"npc/fast_zombie/foot4.wav",
}
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

ENT.FootStepTimeRun = 0.2
ENT.FootStepTimeWalk = 0.5

ENT.FootStepSoundLevel = 80
ENT.PainSoundLevel = 75
ENT.DeathSoundLevel = 75

ENT.BackAwayFromEnemyDist = 500
ENT.KnifeSpeed = 3000

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("SPACE (jump key): Toggle Invisibility (you cannot attack while you're invisible)")

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetRenderMode(RENDERMODE_TRANSCOLOR)
    self:SetCollisionBounds(Vector(-16,-16,0), Vector(16,16,90))
    self.CurrentCloak = "uncloaked"

    self.Eye1 = ents.Create( "env_sprite" )
    self.Eye2 = ents.Create( "env_sprite" )
    local eyes = {
        {
            ent = self.Eye1,
            attachment = 2,
        },
        {
            ent = self.Eye2,
            attachment = 3,
        },
    }

	for _,eye_data in pairs(eyes) do
        local eye = eye_data.ent
        eye:SetKeyValue( "model","sprites/blueflare1.spr" )
        eye:SetKeyValue( "rendercolor","0 0 0" )
        eye:SetPos( self:GetAttachment(eye_data.attachment).Pos )
        eye:SetParent( self, eye_data.attachment )
        eye:SetKeyValue( "scale","0.12" )
        eye:SetKeyValue( "rendermode","7" )
        eye:Spawn()
        self:DeleteOnRemove(eye)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleRangeAttacks()
    if math.random(1, 2) == 1 then
        local mypos = self:GetPos()+self:OBBCenter()
        local tr = util.TraceEntity( { start = mypos, endpos = mypos+Vector(0,0,100), mask = MASK_NPCWORLDSTATIC }, self )
        if !tr.HitWorld then
            self.AnimTbl_RangeAttack = {"jumpbackt"}
        end
    else
        self.AnimTbl_RangeAttack = {"stab"}
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
    local source = self:GetAttachment(1).Pos
    local shootdir = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter() - (source + VectorRand(-20,20))

    local knife = ents.Create("obj_vj_knife_z")
    knife:SetOwner(self)
    knife:SetPos(source)
    knife:SetAngles(shootdir:Angle())
    knife:Spawn()
    knife:GetPhysicsObject():SetVelocity(shootdir:GetNormalized() * self.KnifeSpeed)
    knife.Target = self:GetEnemy()
    knife.VJ_NPC_Class = self.VJ_NPC_Class

    if math.random(1, 3) == 1 then
        self.ShouldFullCloak = true
        timer.Create("AssassinStopCloakTimer_Z_" .. self:EntIndex(), math.Rand(2,4), 1,  function() if IsValid(self) then self.ShouldFullCloak = false end end)
    end

    -- if math.random(1, 2) == 1 then
    --     local enemydist = self:GetPos():Distance(self:GetEnemy():GetPos())

    --     if enemydist > self.BackAwayFromEnemyDist && enemydist < self.NoChaseAfterCertainRange_FarDistance then
    --         local movedir = self:GetRight()*500
    --         if math.random(1, 2) == 1 then movedir = -movedir end

    --         local tr = util.TraceLine({
    --             start = self:GetPos()+self:OBBCenter(),
    --             endpos = self:GetPos()+self:OBBCenter() + movedir,
    --             mask = MASK_NPCWORLDSTATIC,
    --         })

    --         self:SetLastPosition( tr.HitPos )
    --         self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
    --     end
    -- end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChangeCloak(cloak_mode,doAnim)
    if cloak_mode == self.CurrentCloak or self.ChangingCloak then return end
    self.ChangingCloak = true
    if doAnim == nil then doAnim = true end

    local time_until_cloak = 0.5

    local last_cloak_mode = self.CurrentCloak
    timer.Simple(time_until_cloak, function() if IsValid(self) then
        if cloak_mode == "uncloaked" then
            self:SetColor(Color(255,255,255,255))
        elseif cloak_mode == "halfcloaked" then
            self:SetColor(Color(255,255,255,66))
        elseif cloak_mode == "fullcloaked" then
            self:SetColor(Color(255,255,255,0))
        end

        if cloak_mode == "halfcloaked" then
            self.Eye1:SetKeyValue( "rendercolor","35 155 35" )
            self.Eye2:SetKeyValue( "rendercolor","35 155 35" )
            self.Eye1_Trail = util.SpriteTrail(self.Eye1, 0, Color(35,255,0), true, 7, 0, 0.35, 0.008, "trails/laser")
            self.Eye2_Trail = util.SpriteTrail(self.Eye2, 0, Color(35,255,0), true, 7, 0, 0.35, 0.008, "trails/laser")
        elseif last_cloak_mode == "halfcloaked" then
            self.Eye1:SetKeyValue( "rendercolor","0 0 0" )
            self.Eye2:SetKeyValue( "rendercolor","0 0 0" )
            self.Eye1_Trail:Remove()
            self.Eye2_Trail:Remove()
        end

        if cloak_mode == "fullcloaked" then
            self.Behavior = VJ_BEHAVIOR_PASSIVE
            self:AddFlags(FL_NOTARGET)
        elseif last_cloak_mode == "fullcloaked" then
            self.Behavior = VJ_BEHAVIOR_AGRESSIVE
            self:RemoveFlags(FL_NOTARGET)
        end

        if last_cloak_mode == "fullcloaked" or cloak_mode == "fullcloaked" then
            local effectdata = EffectData()
            effectdata:SetStart(self:GetPos()+self:OBBCenter())
            util.Effect("assassin_cloak_z",effectdata)
        end

        self.ChangingCloak = false
    end end)

    self.CurrentCloak = cloak_mode
    if doAnim then
        self:VJ_ACT_PLAYACTIVITY("smoke", true, time_until_cloak, true)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
    if self.IsBeingDroppedByDropship then return end

    local enemy = self:GetEnemy()

    if self.Behavior == VJ_BEHAVIOR_AGRESSIVE && IsValid(enemy) && !self.VJ_IsBeingControlled then
        local enemydist = self:GetPos():Distance(enemy:GetPos())

        if self:Visible(enemy) && !self:IsBusy() && enemydist < self.BackAwayFromEnemyDist && enemydist > self.NoChaseAfterCertainRange_CloseDistance then
            local tr = util.TraceLine({
                start = self:GetPos()+self:OBBCenter(),
                endpos = self:GetPos()+self:OBBCenter() + (self:GetPos() - enemy:GetPos()):GetNormalized()*self.BackAwayFromEnemyDist,
                mask = MASK_NPCWORLDSTATIC,
            })
            self:SetLastPosition( tr.HitPos )
            self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
        end
    end

    if self.VJ_IsBeingControlled then
        if self.CurrentCloak != "fullcloaked" then
            self:ChangeCloak("halfcloaked")
        end

        if self.VJ_TheController:KeyDown(IN_JUMP) then
            if self.CurrentCloak != "fullcloaked" then
                self:ChangeCloak("fullcloaked")
            else
                self:ChangeCloak("halfcloaked")
            end
        end
    else
        if IsValid(enemy) then
            if self.ShouldFullCloak then
                self:ChangeCloak("fullcloaked")
            else
                self:ChangeCloak("halfcloaked")
            end
        else
            self:ChangeCloak("uncloaked")
        end
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