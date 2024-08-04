--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

EFFECT = {}

function EFFECT:Init(data)
    self.Position = data:GetOrigin()
    self.Emitter = ParticleEmitter(self.Position)
    self.LifeTime = 2 
    self.EndTime = CurTime() + self.LifeTime

    for i = 1, 50 do
        local particle = self.Emitter:Add("effects/spark", self.Position)
        if particle then
            particle:SetVelocity(VectorRand() * 100)
            particle:SetLifeTime(0)
            particle:SetDieTime(math.Rand(0.5, 1.5))
            particle:SetStartAlpha(255)
            particle:SetEndAlpha(0)
            particle:SetStartSize(25)
            particle:SetEndSize(0)
            particle:SetRoll(math.Rand(0, 360))
            particle:SetRollDelta(math.Rand(-2, 2))
            particle:SetColor(104, 160, 176)
            particle:SetAirResistance(50)
            particle:SetGravity(Vector(0, 0, -100))
        end
    end

    self.Radius = 200
    self.Damage = 5
    self.Owner = data:GetEntity()

    net.Start("ixTeslaDamage")
        net.WriteVector(self.Position)
        net.WriteFloat(self.Radius)
        net.WriteFloat(self.Damage)
        net.WriteEntity(self.Owner)
    net.SendToServer()
end

function EFFECT:Think()
    if CurTime() > self.EndTime then
        self.Emitter:Finish()
        return false
    end

    return true
end

function EFFECT:Render()
    if LocalPlayer():IsAdmin() and LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP then 
        render.SetColorMaterial()
        render.DrawSphere(self.Position, self.Radius, 30, 30, Color(255, 165, 0, 100))
    end 
end

effects.Register(EFFECT, "tesla_effect")
