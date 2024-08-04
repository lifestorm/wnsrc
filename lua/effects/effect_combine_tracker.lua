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
	local ent = data:GetEntity()
	local att = data:GetAttachment()

	self.Mat = Material("sprites/bluelaser1")
	self.Mat2 = Material("sprites/light_ignorez")

	self.StartPos = Vector(0, 0, 0)
	self.EndPos = data:GetOrigin()
	self.DecayTime = 0.1
	self.DecayTime2 = 1

	self.Timer1 = CurTime() + self.DecayTime
	self.Timer2 = CurTime() + self.DecayTime2

	if(IsValid(ent) && att > 0) then
		if(ent == LocalPlayer() && ent == LocalPlayer():GetViewEntity()) then
			if(IsValid(LocalPlayer():GetViewModel())) then
				ent = LocalPlayer():GetViewModel()
			end
		elseif(IsValid(ent:GetActiveWeapon())) then
			ent = ent:GetActiveWeapon()
		end

		att = ent:GetAttachment(att)
		if(att) then
			self.StartPos = att.Pos
		end
	end

	self:SetRenderBoundsWS(self.StartPos, self.EndPos)
end

function EFFECT:Render()
	render.SetMaterial(self.Mat)
	render.DrawBeam(self.StartPos, self.EndPos, Lerp((self.Timer1 - CurTime()) / self.DecayTime, 0, 32), 0, 16, Color(255, 0, 0, 255))
	render.SetMaterial(self.Mat2)

	local size = Lerp((self.Timer2 - CurTime()) / self.DecayTime2, 0, 256)
	render.DrawSprite(self.EndPos, size, size, Color(255, 0, 0, 255))
end

function EFFECT:Think()
	if(self.Timer2 <= CurTime()) then
		return false
	end

	return true
end