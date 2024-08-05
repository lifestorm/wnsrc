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

local color_green = Color(0, 255, 0, 255)
local color_red = Color(255, 0, 0, 255)
local color_orange = Color(255, 125, 0, 255)

function ENT:Draw()
	self:DrawModel()

	local position = self:GetPos()
	local angles = self:GetAngles()
	angles:RotateAroundAxis(angles:Up(), 90)
	angles:RotateAroundAxis(angles:Forward(), 90)

	local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
	
	local spacing = 0
	local labels = self:GetNetVar("labels")
	local prices = self:GetNetVar("prices")

	if (!labels or !prices) then return end

	cam.Start3D2D(position + f * 17.6 + r * -18 + u * 4.6, angles, 0.06)
		for i = 1, 8 do
			if (labels[i] != "" and labels[i] != " ") then
				draw.SimpleText("(" .. prices[i] .. ")" .. labels[i], "DebugFixedSmall", 90, spacing, color_white, TEXT_ALIGN_RIGHT)
			end

			spacing = spacing + 34
		end
	cam.End3D2D()

	render.SetMaterial(glowMaterial)

	if (self.buttons) then
		local closest = self:GetNearestButton()
		local stocks = self:GetNetVar("stocks")
		local buttons = self:GetNetVar("buttons")

		for k, v in pairs(self.buttons) do
			if (labels[k] == "" or labels[k] == " ") then
				continue
			end

			local color = color_green

			if (stocks and !stocks[k]) then
				color = color_red
				color.a = 200
			end

			if (buttons and !buttons[k]) then
				color = color_orange
				color.a = 200
			end

			if (closest != k) then
				color.a = color == color_red and 100 or 75
			else
				color.a = 230 + (math.sin(RealTime() * 7.5) * 25)
			end

			if (LocalPlayer():KeyDown(IN_USE) and closest == k) then
				color = table.Copy(color)
				color.r = math.min(color.r + 100, 255)
				color.g = math.min(color.g + 100, 255)
				color.b = math.min(color.b + 100, 255)
			end

			render.DrawSprite(v, 4, 4, color)
		end

		if (!self:GetLocked()) then
			render.DrawSprite(position + f * 18.5 + r * -21 + u * 13, 7, 7, Color(50, 100, 255, 255))
		end
	end
end
