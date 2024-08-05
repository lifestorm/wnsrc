--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function EFFECT:Init(data)

    self.Start = data:GetStart()

    local emitter = ParticleEmitter(self.Start)
    for i = 1,18 do
        local pos = self.Start + VectorRand(-50,50)
        local smoke = emitter:Add("particle/particle_smokegrenade", pos)
        smoke:SetVelocity((pos - self.Start) * math.random(0.5,1))
        smoke:SetDieTime(1)
        smoke:SetStartAlpha(175)
        smoke:SetEndAlpha(0)
        smoke:SetStartSize(25)
        smoke:SetEndSize(85)
        smoke:SetAirResistance(25)
        smoke:SetRollDelta(math.random(0.5,1))
        local rand = math.random(65, 85)
        smoke:SetColor(rand,rand,rand)
    end
    emitter:Finish()

end

function EFFECT:Render() end