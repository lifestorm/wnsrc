--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Init(data)

    self.Start = data:GetStart()

    local emitter = ParticleEmitter(self.Start)
    for i = 1,14 do
        local pos = self.Start + VectorRand(-250,250)
        local spark = emitter:Add("Effects/bluespark", pos)
        spark:SetVelocity((self.Start - pos) * 1.25)
        spark:SetDieTime(0.15)
        spark:SetStartAlpha(0)
        spark:SetEndAlpha(175)
        spark:SetStartSize(math.random(10,18))
        spark:SetEndSize(0)
        spark:SetStartLength(0)
        spark:SetEndLength(math.random(125,150))
    end
    emitter:Finish()

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think() end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Render() end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------