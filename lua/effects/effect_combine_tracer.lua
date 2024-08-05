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
	self.Mat2 = Material("effects/strider_muzzle")

	self.StartPos = Vector(0, 0, 0)
	self.EndPos = data:GetOrigin()

	self.Timer1 = 0

	if(!IsValid(ent)) then return end

	if(ent:IsWeapon() && ent:IsCarriedByLocalPlayer()) then
		local ply = ent:GetOwner()

		if(!ply:ShouldDrawLocalPlayer()) then
			local vm = ply:GetViewModel()
			
			if(IsValid(vm)) then
				ent = vm
			end
		end
	end

	self.StartPos = ent:GetAttachment(att).Pos

	self.Speed = 10000
	self.Dir = (self.EndPos - self.StartPos)
	self.Dir:Normalize()

	self.Dist = 0

	self.Len = (self.EndPos - self.StartPos):Length()
	self.X = (self.Len / self.Speed)

	self.Timer1 = CurTime() + self.X

	self:SetRenderBoundsWS(self.StartPos, self.EndPos)
end

function EFFECT:Render()
	local t = (self.Timer1 - CurTime()) / self.X
	local x = Lerp(t, 0, 32)
	local y = LerpVector(t, self.EndPos, self.StartPos)
	render.SetMaterial(self.Mat)
	render.DrawBeam(y, self.EndPos, x, 0, 0, Color(0, 128, 200, 255))

	render.SetMaterial(self.Mat2)
	//render.DrawSprite(self.StartPos, 64, 64)

	//self.Dist = x:DistToSqr(self.StartPos)
end

function EFFECT:Think()
	if(self.Timer1 <= CurTime()) then
		return false
	end

	return true
end