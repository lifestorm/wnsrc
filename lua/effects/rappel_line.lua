--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

function EFFECT:Init(effectdata)
    self.endPoint = effectdata:GetOrigin()
    local ent = effectdata:GetEntity()
    self.ent = ent:GetPuppet()
    self.ply = ent:GetPillUser()
end

function EFFECT:Think()
    if not IsValid(self.ent) then return false end
    self:SetPos(self.ent:GetAttachment(self.ent:LookupAttachment("zipline")).Pos)
    self:SetRenderBoundsWS(self:GetPos(), self.endPoint)

    return not self.ply:OnGround()
end

local ropeMat = Material("cable/cable2")

function EFFECT:Render()
    --print("p")
    local color = Color(10, 10, 10)
    render.SetMaterial(ropeMat)
    render.DrawBeam(self:GetPos(), self.endPoint, 2, 0, 0, color)
end
