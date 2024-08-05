--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

include("shared.lua")

local glowMaterial = Material("sprites/glow04_noz")
local color_green = Color(0, 255, 0)
local color_blue = Color(0, 255, 255)

function ENT:Draw()
	self:DrawModel()

	if (!IsValid(self.CSModel)) then return end

	local position = self:GetPos() + self:GetUp() * 0.5 + self:GetForward() * 6 + self:GetRight() * -14

	if (!self:GetBreached() and (CurTime() % 1.5) < 0.75) then
		render.SetMaterial(glowMaterial)
		render.DrawSprite(position, 3, 3, color_green)
	end

	local propPosition = self.CSModel:GetPos()
	if (!self:GetBreached() and self:GetProgress() > 0) then
		local glow = Lerp(self:GetProgress() / 255, 3, 16)
		render.SetMaterial(glowMaterial)
		render.DrawSprite(propPosition, glow, glow, color_blue)
	end
end

function ENT:CreateClientsideModel()
	self.CSModel = ClientsideModel("models/transmissions_element120/rotato_small.mdl")
	if (IsValid(self.CSModel)) then
		self.CSModel:SetParent(self)
		local pos = Vector(4.6, 13.4, 6.4)
		self.CSModel:SetLocalPos(pos)
		self.CSModel:SetSkin(1)
		self.CSModel:SetNoDraw(true)
	end
end

function ENT:Initialize()
	self:CreateClientsideModel()

	self.lock = self:GetParent()
end

function ENT:OnRemove()
	if (IsValid(self.CSModel)) then self.CSModel:Remove() end
end

function ENT:Think()
	self.Rotation = math.Approach(self.Rotation or 0, 400, self:GetProgress() / 5)
	if self.Rotation > 360 then
		self.Rotation = self.Rotation - 360
	end

	if (IsValid(self.CSModel)) then
		self.CSModel:SetAngles(Angle(0, self.Rotation, 0))

		if (self:GetBreached() and self.CSModel:GetSkin() != 2) then
			self.CSModel:SetSkin(2)
		end
	else
		self:CreateClientsideModel()
	end

	self:SetNextClientThink(CurTime())
	return true
end
