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
ENT.PrintName = "Barnacle Tongue"

function ENT:Initialize()
    if SERVER then
        --Physics
        self:SetModel("models/props_junk/PopCan01a.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
            phys:SetMass(100)
        end
    end
end

function ENT:StartTouch(ent)
    if IsValid(self.connected) or ent:IsWorld() then return end

    if util.IsValidRagdoll(ent:GetModel()) and not ent:IsRagdoll() and not ent:IsPlayer() then
        local doll = ents.Create("prop_ragdoll")
        doll:SetModel(ent:GetModel())
        doll:SetPos(ent:GetPos())
        doll:SetAngles(ent:GetAngles())
        doll:Spawn()
        ent:Remove()
        ent = doll
        self:SetPos(ent:GetPhysicsObject(0):GetPos())
    end

    constraint.Weld(self, ent, 0, 0, 0, true, false)
    self.connected = ent
    self:EmitSound("npc/barnacle/neck_snap1.wav")
end

function ENT:Draw()
end
