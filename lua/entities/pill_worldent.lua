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
ENT.PrintName = "Pill World Entity"

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "PillForm")
end

function ENT:Initialize()
    if SERVER then
        --Physics
        self:SetModel("models/Items/combine_rifle_ammo01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
        end

        self:SetUseType(SIMPLE_USE)

        if self.DarkRPItem then
            self:SetPillForm(self.DarkRPItem.pill)
        end
    else
        self.mat = Material("pills/" .. self:GetPillForm() .. ".png")
        self.randoff = math.Rand(0, 10)
    end
end

if SERVER then
    function ENT:Use(ply)
        if pk_pills.convars.preserve:GetBool() then
            local ent = pk_pills.getMappedEnt(ply)
            if IsValid(ent) then return end
        end

        ply:EmitSound("weapons/bugbait/bugbait_squeeze1.wav")
        pk_pills.apply(ply, self:GetPillForm())
        self:Remove()
    end

    function ENT:Think()
        if self:WaterLevel() > 0 then
            self:EmitSound("weapons/underwater_explode3.wav")
            self:Remove()
        end
    end
end

function ENT:Draw()
    self:DrawModel()
    local ang = LocalPlayer():EyeAngles()
    ang.p = 0
    cam.Start3D2D(self:GetPos(), ang + Angle(-0, -90, 90), 1)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(self.mat)
    surface.DrawTexturedRect(-10, TimedSin(1, 0, 3, self.randoff) - 30, 20, 20)
    cam.End3D2D()
end
