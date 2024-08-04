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
	self.Entity = data:GetEntity()
	self.Attach = data:GetAttachment()
	self.EndPos = data:GetOrigin()
	self.Normal = data:GetNormal()
	self.Scale = data:GetScale()

	self.Color = Color(150, 100, 255)
	self.Alpha = 150

	local dynlight = DynamicLight(0)
	dynlight.Pos = self.EndPos + self.Normal * 10
	dynlight.Size = 350
	dynlight.Brightness = 1
	dynlight.Decay = 3000
	dynlight.R = self.Color.r
	dynlight.G = self.Color.g
	dynlight.B = self.Color.b
	dynlight.DieTime = CurTime() + 0.1

	if not IsValid(self.Entity) then
		return
	end

	dynlight = DynamicLight(0)
	dynlight.Pos = self.Entity:GetAttachment(self.Attach).Pos
	dynlight.Size = 350
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
	if not IsValid(self.Entity) then
		return
	end

	if self.Alpha < 1 then
		return
	end

	local start = self.Entity:GetAttachment(self.Attach).Pos

	local length = (start - self.EndPos):Length()
	local texcoord = math.Rand(0, 1)
	local col = Color(150, 100, 255)

	self:SetRenderBoundsWS(start, self.EndPos)

	render.SetMaterial(self.Mat)
	render.DrawBeam(start, self.EndPos, self.Scale, texcoord, texcoord + length / 128, col)
end
