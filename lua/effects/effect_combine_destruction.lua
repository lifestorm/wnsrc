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
	self.Pos = data:GetOrigin()
	self.Normal = data:GetNormal()
	self.Mat = Material("effects/strider_bulge_dudv")

	self:SetRenderBoundsWS(self.Pos - Vector(128, 128, 128) * 2, self.Pos + Vector(128, 128, 128) * 2)

	self.Timer1 = CurTime() + 1.5
end

function EFFECT:Render()
	local x = (self.Timer1 - CurTime()) / 1.5
	local size = Lerp(x, 0, 256)

	self.Mat:SetFloat("$refractamount", 0.1 * math.sin(x * math.pi * 5 + 1))
	render.UpdateRefractTexture()
	render.SetMaterial(self.Mat)
	render.DrawSprite(self.Pos, size, size, Color(0, 0, 255, 150))
end

function EFFECT:Think()
	if(CurTime() >= self.Timer1) then return false end

	return true
end