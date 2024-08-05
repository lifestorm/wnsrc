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

	self.Mat2 = Material("effects/strider_muzzle")

	self.StartPos = Vector(0, 0, 0)

	self.Timer2 = 0
	self.Decay = 1

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

	self.Ent = ent
	self.Att = att

	self.Decay = 0.16
	self.Timer2 = CurTime() + self.Decay
	self.StartPos = self.Ent:GetAttachment(self.Att).Pos

	self:SetRenderBoundsWS(self.StartPos + Vector() * 64, self.StartPos - Vector() * 64)
end

function EFFECT:Render()
	local size = Lerp((self.Timer2 - CurTime()) / self.Decay, 0, 64)

	if(!IsValid(self.Ent)) then return end
	self.StartPos = self.Ent:GetAttachment(self.Att).Pos

	render.SetMaterial(self.Mat2)
	render.DrawSprite(self.StartPos, size, size)
end

function EFFECT:Think()
	if(self.Timer2 <= CurTime()) then
		return false
	end

	return true
end