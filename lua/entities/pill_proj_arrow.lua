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
ENT.PrintName = "Rocket"

function ENT:Initialize()
    if SERVER and self.particle then
        ParticleEffectAttach(self.particle, PATTACH_ABSORIGIN_FOLLOW, self, 0)
    end
end

if SERVER then
    function ENT:Think()
        if self.stuck then return end
        local tr = util.QuickTrace(self:GetPos(), self:GetAngles():Forward() * (self.speed or 3000) * FrameTime(), {self, self:GetOwner()})

        if tr.HitWorld then
            self:StopParticles()
            self.stuck = true

            timer.Simple(10, function()
                if IsValid(self) then
                    self:Remove()
                end
            end)
        elseif tr.Hit then
            tr.Entity:TakeDamage(self.damage, self:GetOwner(), self)
            self:Remove()
        end

        self:SetPos(tr.HitPos)
        self:SetAngles(self:GetAngles() + Angle(12, 0, 0) * FrameTime())
        self:NextThink(CurTime())

        return true
    end
end
