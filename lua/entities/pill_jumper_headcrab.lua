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
ENT.PrintName = "Headcrab Jumper"
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
    if SERVER then
        --Physics
        self:SetModel("models/headcrabblack.mdl")
        self:PhysicsInit(SOLID_BBOX)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_BBOX)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
        end

        self:ResetSequence(self:LookupSequence("drown"))
    end
end

function ENT:Think()
    if SERVER then
        local tr = util.QuickTrace(self:GetPos(), Vector(0, 0, -15), self)

        if tr.Hit then
            local crab = ents.Create("npc_headcrab_black")
            crab:SetPos(self:GetPos())
            crab:SetAngles(Angle(0, self:GetAngles().y, 0))
            crab:Spawn()
            self:Remove()
        end
    end

    self:NextThink(CurTime())

    return true
end
