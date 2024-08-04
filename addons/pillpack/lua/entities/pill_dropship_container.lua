--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Dropship Container"
ENT.Category = "Pill Pack Entities"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
    if SERVER then
        --Physics
        self:SetModel("models/Combine_Dropship_Container.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
        end

        self.mode = 1
        self.full = true
    end

    self:SetPlaybackRate(1)
end

function ENT:Think()
    self:NextThink(CurTime())

    return true
end

function ENT:Deploy()
    local dropship = self:GetParent()

    if not self.full then
        dropship:PillSound("alert_empty")

        return
    end

    self.full = false
    self:SetSequence(self:LookupSequence("open"))
    dropship:PillLoopSound("deploy")

    local doClose = function()
        if not IsValid(self) then return end
        self:SetSequence(self:LookupSequence("close"))

        if IsValid(dropship) and self:GetParent() == dropship then
            dropship:PillLoopStop("deploy")
        end
    end

    if self.mode ~= 6 then
        local mode = self.mode
        timer.Simple(12, doClose)

        local doDeploy = function()
            if not IsValid(self) then return end
            local m = mode == 5 and math.random(1, 4) or mode
            local startAngPos = self:GetAttachment(self:LookupAttachment("deploy_landpoint"))
            local combine = ents.Create("pill_jumper_combine")
            combine:SetPos(startAngPos.Pos)
            combine:SetAngles(self:GetAngles())
            combine.myNpc = m == 4 and "npc_metropolice" or "npc_combine_s"
            combine.myWeapon = m == 2 and "weapon_shotgun" or m == 4 and "weapon_smg1" or "weapon_ar2"

            if m == 1 or m == 2 then
                combine:SetModel("models/combine_soldier.mdl")
            elseif m == 3 then
                combine:SetModel("models/Combine_Super_Soldier.mdl")
            elseif m == 4 then
                combine:SetModel("models/police.mdl")
            end

            if m == 2 then
                combine:SetSkin(1)
            end

            combine:SetParent(self)
            combine:Spawn()
        end

        for i = 1, 5 do
            timer.Simple(i * 2, doDeploy)
        end
    else
        timer.Simple(5.5, doClose)

        local doDeploy = function()
            if not IsValid(self) then return end
            local mine = ents.Create("npc_rollermine")
            mine:SetPos(self:LocalToWorld(Vector(100, 0, 0)))
            mine:Spawn()
            mine:GetPhysicsObject():SetVelocity(self:GetAngles():Forward() * 500)
        end

        for i = 1, 10 do
            timer.Simple(i / 2, doDeploy)
        end
    end

    return true
end

function ENT:Use(ply)
    if self.mode >= 6 then
        self.mode = 1
    else
        self.mode = self.mode + 1
    end

    if self.mode == 1 then
        ply:ChatPrint("Mode 1: 5 Soldiers")
    elseif self.mode == 2 then
        ply:ChatPrint("Mode 2: 5 Shotgunners")
    elseif self.mode == 3 then
        ply:ChatPrint("Mode 3: 5 Elites")
    elseif self.mode == 4 then
        ply:ChatPrint("Mode 4: 5 Metrocops")
    elseif self.mode == 5 then
        ply:ChatPrint("Mode 5: 5 Random Combine")
    elseif self.mode == 6 then
        ply:ChatPrint("Mode 6: 10 Rollermines")
    end
end

function ENT:SpawnFunction(ply, tr, ClassName)
    if (not tr.Hit) then return end
    local SpawnPos = tr.HitPos + tr.HitNormal * 100
    local ent = ents.Create(ClassName)
    ent:SetPos(SpawnPos)
    ent:Spawn()
    ent:Activate()

    return ent
end
