--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include('shared.lua')

local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")

local color_red = Color(255, 0, 0, 255)

function ENT:Initialize()
	self.buttons = {}
end

function ENT:Draw()
	self:DrawModel()

	local width, height = 260, 135
	local ang = self:GetAngles()
	local pos = self:GetPos() + ang:Up() * 60 - ang:Right() * 4.1 - ang:Forward() * 13
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), -65)
	ang:RotateAroundAxis(ang:Right(), -90)

	local display = self.Displays[self:GetDisplay()] or self.Displays[6]

	cam.Start3D2D(pos, ang, 0.1)
		render.PushFilterMin(TEXFILTER.NONE)
		render.PushFilterMag(TEXFILTER.NONE)

		surface.SetDrawColor(Color(255, 255, 255, 250))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/workshifterminal.png"))
		surface.DrawTexturedRect(0, 0, width, height)

		surface.SetDrawColor(Color(16, 16, 16, 100))
		surface.DrawRect(10, 5, width - 20, height - 10)

		surface.SetDrawColor(Color(72, 255, 243, 10))
		surface.DrawOutlinedRect(10, 5, width - 20, height - 10)

		surface.SetDrawColor(Color(255, 255, 255, 16))
		surface.DrawRect(10, (height - 5) / 1.9 + math.sin(CurTime() * 4) * (height + 8) / 2.3, width - 20, 1)

		local alpha = 191 + 64 * math.sin(CurTime() * 4)
		local color = ColorAlpha(display[2], alpha)

		draw.SimpleText("Terminal Cykli", "MenuFont", width / 2, height * 0.35, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER)
		draw.SimpleText(display[1], "MenuFont", width / 2, height * 0.6, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if (self.buttons) then
			for k, _ in pairs(self.buttons) do
				local closest = self:GetNearestButton()
				local thisText = "Enter CID"
				if (closest == k) then
					cam.Start3D2D(self.buttons[k], ang, 0.1)
						draw.SimpleText(thisText, "MenuFont", 0, -30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
					cam.End3D2D()
				end
			end
		end

		render.PopFilterMin()
		render.PopFilterMag()
	cam.End3D2D()

	render.SetMaterial(glowMaterial)

	if (self.buttons) then
		local position = self:GetPos()
		local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

		self.buttons[1] = position + f*-5.6 + r*5.6 + u*46

		local closest = self:GetNearestButton()

		for k, v in pairs(self.buttons) do
			local thisColor = Color(255, 255, 255, 255)

			if (closest != k) then
				thisColor.a = thisColor == color_red and 100 or 75
			else
				thisColor.a = 230 + (math.sin(RealTime() * 7.5) * 25)
			end

			if (LocalPlayer():KeyDown(IN_USE) and closest == k) then
				thisColor = table.Copy(thisColor)
				thisColor.r = math.min(thisColor.r + 100, 255)
				thisColor.g = math.min(thisColor.g + 100, 255)
				thisColor.b = math.min(thisColor.b + 100, 255)
			end

			render.DrawSprite(v, 4, 4, thisColor)
		end
	end
end