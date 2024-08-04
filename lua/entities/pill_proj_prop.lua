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
ENT.PrintName = "Prop Projectile"

function ENT:Initialize()
    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableGravity(false)
            phys:EnableDrag(false)
            phys:SetDamping(0, 0)
            phys:SetVelocity(self:GetAngles():Forward() * 3000)
        end

        if self.sound then
            self.flySound = CreateSound(self, self.sound)
            self.flySound:Play()
        end

        if self.trail then
            util.SpriteTrail(self, 0, self.tcolor or Color(255, 255, 255), false, 40, 10, 5, 1 / 100, self.trail)
        end

        timer.Simple(10, function()
            if IsValid(self) then
                self:Remove()
            end
        end)
    end
end

function ENT:OnRemove()
    if SERVER and self.flySound then
        self.flySound:Stop()
    end
end
