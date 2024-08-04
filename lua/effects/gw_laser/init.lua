--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

EFFECT.Mat = Material("trails/laser")

function EFFECT:Init(data)
	self.Pos = data:GetStart()
	self.Ent = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Start = self:GetTracerShootPos(self.Pos, self.Ent, self.Attachment)
	self.End = data:GetOrigin()

	self.Normal = (self.Start - self.End):Angle():Forward()

	self.Color = Color(150, 100, 255)
	self.Alpha = 150

	self:SetRenderBoundsWS(self.Start, self.End)

	local dynlight = DynamicLight(0)
	dynlight.Pos = self.End + self.Normal * 10
	dynlight.Size = 500
	dynlight.Brightness = 1
	dynlight.Decay = 3000
	dynlight.R = self.Color.r
	dynlight.G = self.Color.g
	dynlight.B = self.Color.b
	dynlight.DieTime = CurTime() + 0.1

	dynlight = DynamicLight(0)
	dynlight.Pos = self.Start
	dynlight.Size = 500
	dynlight.Brightness = 1
	dynlight.Decay = 3000
	dynlight.R = self.Color.r
	dynlight.G = self.Color.g
	dynlight.B = self.Color.b
	dynlight.DieTime = CurTime() + 0.1
end

function EFFECT:Think()
	self.Alpha = self.Alpha - FrameTime() * 2048

	if self.Alpha < 0 then
		return false
	end

	return true
end

function EFFECT:Render()
	if self.Alpha < 1 then
		return
	end

	local length = (self.Start - self.End):Length()
	local texcoord = math.Rand(0, 1)

	render.SetMaterial(self.Mat)
	render.DrawBeam(self.Start, self.End, 32, texcoord, texcoord + length / 128, self.Color)
end