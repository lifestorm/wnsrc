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


ENT.Model = {"models/Roller.mdl"}
ENT.SightAngle = 180
ENT.VJ_NPC_Class = {"CLASS_COMBINE"}
ENT.StartHealth = 55

ENT.CallForHelpDistance = 10000

ENT.HasMeleeAttack = false
ENT.HasGibOnDeathSounds = false

ENT.HasItemDropsOnDeath = true
ENT.ItemDropsOnDeathChance = 2
ENT.ItemDropsOnDeath_EntityList = {
"item_battery",
}

ENT.MaxMoveSpeed = 675
ENT.CurrentMoveSpeed = 0
ENT.AccelSpeed = 75
ENT.DeaccelSpeed = 150

ENT.MineColor = "0 75 255"
ENT.MineSkin = 0

ENT.SpikeDeployDist = 400

ENT.HasExplosionAttack = false
ENT.ExplodeDist = 0

ENT.HasShockAttack = true
ENT.ShockDamage = 12
ENT.ShockRadius = 125
ENT.ShockDelay = {
    min = 1,
    max = 2,
}

ENT.NextFindNewAllyParentDelay = 8
ENT.MaxFindAllyParentDist = 1750
ENT.AllyParent_MinFollowDist = 200

ENT.SoundTbl_Alert = {"npc/roller/mine/rmine_tossed1.wav"}
ENT.SoundTbl_Idle = {"npc/roller/mine/rmine_chirp_quest1.wav","npc/roller/mine/rmine_blip1.wav"}
ENT.SoundTbl_CombatIdle = {"npc/roller/mine/rmine_taunt1.wav","npc/roller/mine/rmine_taunt2.wav"}
ENT.SoundTbl_Pain = {"npc/roller/mine/rmine_shockvehicle1.wav","npc/roller/mine/rmine_shockvehicle2.wav"}

ENT.VJC_Data = {
	CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "polymsh2", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RollerInit() end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()

    self:RollerInit()
    self:SetSkin(self.MineSkin)

    self:SetCollisionBounds(Vector(-12.5,-12.5,-12.5), Vector(12.5,12.5,12.5))

    self.MoveAutoStopTimerName = "VJRollerMineAutoStopTimer" .. self:EntIndex()
    self:RollTo(self:GetPos())

    self.SpikeModel = ents.Create("prop_dynamic")
    self.SpikeModel:SetModel("models/roller_spikes.mdl")
    self.SpikeModel:SetPos(self:GetPos())
    self.SpikeModel:Spawn()
    self.SpikeModel:SetParent(self)
    self.SpikeModel:SetNoDraw(true)
    self.SpikeModel:SetSkin(self:GetSkin())

    self.NextShockTime = CurTime()

    self.AllyParent = NULL
    self.NextFindNewAllyParentTime = CurTime()

    --self:SetBloodColor(BLOOD_COLOR_MECH)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MovementThink()

    self.Rolling = true
    if self:GetPos():Distance(self.CurrentDestination) < 60 then
        self.Rolling = false
        self.BeingForcedToMove = false
    end

    if self.Rolling then
        self.CurrentMoveSpeed = math.Clamp(self.CurrentMoveSpeed + self.AccelSpeed, 0, self.MaxMoveSpeed)
    else
        self.CurrentMoveSpeed = math.Clamp(self.CurrentMoveSpeed - self.DeaccelSpeed, 0, self.MaxMoveSpeed)
    end

    if self.CurrentMoveSpeed > 0 then

        local cur_angs = self:GetAngles()
        self:SetAngles(Angle( cur_angs.x + self.CurrentMoveSpeed * 0.1, cur_angs.y , cur_angs.z ))

        local destination = self.CurrentDestination
        if !self.Rolling then
            destination = self:GetForward() * 100
        end

        local movedir = (destination - self:GetPos()):GetNormalized()
        if self:IsOnGround() then
            self:SetVelocity(Vector( movedir.x*self.CurrentMoveSpeed , movedir.y*self.CurrentMoveSpeed , math.Rand(0, 100) ))
        else
            self:SetVelocity(Vector( movedir.x*50 , movedir.y*50 , 0 ))
        end

        self:SetIdealYawAndUpdate( ( self.CurrentDestination - self:GetPos() ):Angle().y )

    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RollTo(pos,autostoptime,force)

    if self.BeingForcedToMove then return end

    if force then
        self.BeingForcedToMove = true
    end

    autostoptime = autostoptime or 4

    self.CurrentDestination = pos

    timer.Create(self.MoveAutoStopTimerName, autostoptime, 1, function() if IsValid(self) then

        self:RollTo(self:GetPos())
        self.BeingForcedToMove = false
        --print("holding position..")

    end end)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()

    self:MovementThink()

    if self:WaterLevel() > 1 then
        self:TakeDamage(10000000, self, self)
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
function ENT:DeploySpikes()
    if self.SpikesDeployed then return end
    self.SpikesDeployed = true

    self.SpikeModel:SetNoDraw(false)
    self:SetNoDraw(true)

    self.DeployedLight = ents.Create("light_dynamic")
    self.DeployedLight:SetKeyValue("brightness", "1")
    self.DeployedLight:SetKeyValue("distance", "150")
    self.DeployedLight:Fire("Color", self.MineColor)
    self.DeployedLight:SetPos(self:GetPos())
    self.DeployedLight:SetParent(self)
    self.DeployedLight:Spawn()
    self.DeployedLight:Fire("TurnOn", "", 0)

    self:DoSpark(self:GetPos())

    self:SetVelocity(Vector(0,0,75))

    self:EmitSound("npc/roller/blade_out.wav", 80, math.random(90, 110))

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RetractSpikes()
    if !self.SpikesDeployed then return end
    self.SpikesDeployed = false

    self.SpikeModel:SetNoDraw(true)
    self:SetNoDraw(false)

    self.DeployedLight:Remove()

    self:EmitSound("npc/roller/blade_cut.wav", 80, math.random(90, 110))

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Shock()

    if self.NextShockTime > CurTime() then return end

    local realisticRadius = true
    local shocked_ents = util.VJ_SphereDamage(self, self, self:GetPos(), self.ShockRadius, self.ShockDamage, bit.bor(DMG_DISSOLVE,DMG_SHOCK,DMG_NEVERGIB), true, realisticRadius)
    local shock_successful = nil

    for _,ent in pairs(shocked_ents) do
        if ent:IsSolid() then
            shock_successful = true
        end
    end
    
    if !shock_successful then return end


    local HasDoneSelfPushback = false
    local max_effects = 3
    local effects_used = 0

    for _,ent in pairs(shocked_ents) do
        if ent:IsSolid() then

            local hitpos = ent:GetPos() + ent:OBBCenter()

            if effects_used < max_effects then
                util.ParticleTracerEx( "st_elmos_fire", self:GetPos(), hitpos , false, self:EntIndex() , 0)
                effects_used = effects_used + 1
            end

            local attack_dir = (hitpos - self:GetPos()):GetNormalized()

            if !HasDoneSelfPushback then
                self:SetVelocity(-attack_dir * 300 + Vector(0,0,200))
                HasDoneSelfPushback = true
            end

            if ent:IsNPC() or ent:IsPlayer() then
                ent:SetVelocity(Vector( attack_dir.x , attack_dir.y , 0 ) * 300)
                self:DoSpark(hitpos)
            end

            if ent:GetMoveType() == MOVETYPE_VPHYSICS then

                local physobj = ent:GetPhysicsObject()

                if IsValid(physobj) then
                    physobj:SetVelocity(attack_dir * 200)
                end
            
            end

        end
    end

    self:EmitSound("npc/roller/mine/rmine_explode_shock1.wav", 95, math.random(90, 110))

    self.NextShockTime = CurTime() + math.Rand( self.ShockDelay.min , self.ShockDelay.max )

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnResetEnemy()

    self:RollTo(self:GetPos())

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FindNewAllyParent()

    local closest_ally = nil
    local closest_ally_dist = nil

    for _,ent in pairs( ents.FindInSphere(self:GetPos(), self.MaxFindAllyParentDist) ) do

        if !ent:IsOnGround() or ent:GetClass() == "npc_vj_rollermine_z" or ent:GetClass() == "npc_vj_rollermine_explosive_z" or ent:GetClass() == "npc_vj_combine_apc_z" or !self:IsAlly(ent) then continue end

        local dist = ent:GetPos():Distance(self:GetPos())

        if !closest_ally_dist or dist < closest_ally_dist then
            closest_ally = ent
            closest_ally_dist = dist
        end

    end

    if closest_ally then self.AllyParent = closest_ally end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TryFollowAllyParent()

    if !IsValid(self.AllyParent) then return end

    ally_parent_distace = self:GetPos():Distance(self.AllyParent:GetPos())

    if self:Visible(self.AllyParent) && ally_parent_distace > self.AllyParent_MinFollowDist then
        self:RollTo(self.AllyParent:GetPos())
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("Hold W (forward key): Move")
    ply:ChatPrint("Hold MOUSE1 (primary attack key): Spikes")
    ply:ChatPrint("Please don't use thirdperson, it's kinda broken.")

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()

    if self.IsExploding then
        sound.EmitHint(SOUND_DANGER, self:GetPos(), 300, 0.5, self)
        return
    end


    local enemy = self:GetEnemy()

    if IsValid(enemy) then

        local enemydist = self:GetPos():Distance(enemy:GetPos())

        if self.VJ_IsBeingControlled then

            local controller = self.VJ_TheController

            if controller:KeyDown(IN_FORWARD) then
                local pos = enemy:GetPos()
                pos = Vector(pos.x,pos.y,0)
                self:RollTo(pos,0.5)
            end

            if controller:KeyDown(IN_ATTACK) then
                self:DeploySpikes()
            else
                self:RetractSpikes()
            end

        else

            if self:Visible(enemy) then
                self:RollTo(enemy:GetPos())
            else
                self:TryFollowAllyParent()
            end

            if enemydist < self.SpikeDeployDist then
                self:DeploySpikes()
            else
                self:RetractSpikes()
            end

        end

        if self.HasExplosionAttack then

            if self.VJ_IsBeingControlled then
                if self.VJ_TheController:KeyDown(IN_ATTACK2) then
                    self.IsExploding = true
                    self:SetVelocity(Vector(0,0,290))
                    self:EmitSound("npc/roller/mine/rmine_predetonate.wav", 90, math.random(90, 110))
                    timer.Simple(0.75, function() if IsValid(self) then self:TakeDamage(10000000, self, self) end end)
                end
            else
                if enemydist < self.ExplodeDist then
                    self.IsExploding = true
                    self:SetVelocity(Vector(0,0,290))
                    self:EmitSound("npc/roller/mine/rmine_predetonate.wav", 90, math.random(90, 110))
                    timer.Simple(0.75, function() if IsValid(self) then self:TakeDamage(10000000, self, self) end end)
                end
            end

        end
    
    else

        self:RetractSpikes()

        if self.NextFindNewAllyParentTime < CurTime() then
            self:FindNewAllyParent()
            self.NextFindNewAllyParentTime = CurTime() + self.NextFindNewAllyParentDelay
        end

        self:TryFollowAllyParent()

    end

    if self.HasShockAttack && self.SpikesDeployed then
        self:Shock()
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)

    if !dmginfo:IsExplosionDamage() then
        dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)

        if math.random(1, 3) == 1 then
			self:EmitSound("weapons/fx/rics/ric1.wav", 82, math.random(85, 115))
			
			local spark = ents.Create("env_spark")
			spark:SetPos(dmginfo:GetDamagePosition())
			spark:Spawn()
			spark:Fire("StartSpark", "", 0)
			spark:Fire("StopSpark", "", 0.001)
			self:DeleteOnRemove(spark)
		end
    end

    if !self.IsExploding then
        self:SetVelocity(VectorRand()*125)
    end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)

    self:EmitSound("physics/metal/metal_box_break" .. math.random(1, 2) .. ".wav", 90, math.random(90, 110), 0.75)
    self:EmitSound("npc/roller/mine/rmine_explode_shock1.wav", 90, math.random(130, 150))

    ParticleEffect("explosion_turret_break",self:GetPos(),self:GetAngles())

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)

    self:CreateGibEntity("obj_vj_gib","models/gibs/manhack_gib01.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/manhack_gib04.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/combine_turrets/floor_turret_gib2.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})
    self:CreateGibEntity("obj_vj_gib","models/gibs/scanner_gib02.mdl",{BloodType = "",Pos = self:LocalToWorld(Vector(0,0,0)), CollideSound = {"SolidMetal.ImpactSoft"}})

    return true

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)

	corpseEnt:GetPhysicsObject():SetVelocity(  self:GetVelocity() * 0.38 + Vector(0,0,125) )
    corpseEnt:SetAngles(self:GetAngles())

    ParticleEffectAttach("electrical_arc_01_system", PATTACH_ABSORIGIN_FOLLOW, corpseEnt,0)

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------