--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local mat = Material("effects/strider_muzzle")

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Init(data)

    self.Ent = data:GetEntity()
    self.RandSinMult = math.Rand(0.8, 1.2)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think()
    if !IsValid(self.Ent) then
        return false
    end

    self.Start = self.Ent:GetPos()
    self:SetRenderBoundsWS(self.Start - Vector(15,15,15), self.Start + Vector(15,15,15))
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Render()
    if !IsValid(self.Ent) then return end

    self.brightnessMult = ( 2+math.sin(CurTime()*10)*self.RandSinMult )*0.5
    render.SetMaterial(mat)
    render.DrawSprite(self.Ent:GetPos(),30,30,Color(0,115*self.brightnessMult,155*self.brightnessMult))

    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------