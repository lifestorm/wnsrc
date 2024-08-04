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
    self:SetPos(effectdata:GetOrigin())
    self.color = HSVToColor(math.Rand(0, 360), .8, 1)
    self.vel = VectorRand()
    self.i = 0
end

function EFFECT:Think()
    --[[self:SetPos(self.ent:GetAttachment(self.ent:LookupAttachment("zipline")).Pos)
	self:SetRenderBoundsWS(self:GetPos(),self.endPoint)]]
    self:SetPos(self:GetPos() + self.vel)
    self.i = self.i + 1
    if self.i > 100 then return false end

    return true
end

local wow = Material("pillsprites/wow.png")

function EFFECT:Render()
    --[[cam.Start3D2D(self:GetPos(),LocalPlayer():EyeAngles()+Angle(90,0,0),1)
 		/*surface.SetFont("CloseCaption_Bold")
 		surface.SetTextColor(HSVToColor(math.Rand(0,360),1,.5))
		surface.SetTextPos(100,100)
		surface.GetTextSize(32)
		surface.DrawText("wow")
		draw.SimpleText("Oh No!", "CloseCaption_Bold", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.DrawText("TEXT", "CloseCaption_Bold", 1, 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	cam.End3D2D()]]
    cam.Start3D(EyePos(), EyeAngles())
    render.SetMaterial(wow)
    render.DrawSprite(self:GetPos(), 20, 10, self.color)
    cam.End3D()
end
