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
ENT.PrintName = "Energy Grenade"

function ENT:Initialize()
    if SERVER then
        --Physics
        self:SetModel("models/items/ar2_grenade.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        util.SpriteTrail(self, 0, Color(255, 0, 255), true, 15, 1, 5, 1 / (15 + 1) * 0.5, "trails/physbeam.vmt")
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
            phys:SetVelocity(self:GetAngles():Forward() * 1200)
        end
    end
end

function ENT:PhysicsCollide(collide, phys)
    self:Remove()
    local explode = ents.Create("env_explosion")
    explode:SetPos(self:GetPos())
    explode:Spawn()
    explode:SetOwner(self:GetOwner())
    explode:SetKeyValue("iMagnitude", "100")
    explode:Fire("Explode", 0, 0)
end
