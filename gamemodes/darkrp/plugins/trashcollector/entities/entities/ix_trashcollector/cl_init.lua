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

function ENT:Draw()
	self:DrawModel() -- Draw the model

	local ang = self:GetAngles()
	local pos = self:GetPos() + ang:Up() * 65 + ang:Right() * -15.5 + ang:Forward() * -45
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), -90)

	cam.Start3D2D( pos, ang, 0.1 )

	local width, height = 285, 400

	surface.SetDrawColor( Color( 16, 16, 16 ) )
	surface.DrawRect( 0, 0, width, height )

	surface.SetDrawColor( Color( 255, 255, 255, 16 ) )
	surface.DrawRect( 0, height / 2 + math.sin( CurTime() * 4 ) * height / 2, width, 1 )

	local alpha = 191 + 64 * math.sin( CurTime() * 4 )
	local color = ColorAlpha(self.Displays[self:GetDisplay()][2], alpha)
	
	draw.SimpleText( "TRASH COLLECTOR", "TitlesFontFixed", width / 2, height * 0.5 - 16, Color( 255, 255, 255, alpha ), TEXT_ALIGN_CENTER )
	draw.SimpleText( self.Displays[self:GetDisplay()][1], "TitlesFontFixed", width / 2, height * 0.5 + 16, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	if (self.buttons) then
		if !self:GetUsed() then
			for k, _ in pairs(self.buttons) do
				local closest = self:GetNearestButton()
				local thisText = "Place Trash"
				if k == 2 then thisText = "Start Machine" end
				if (closest == k) then
					cam.Start3D2D( self.buttons[k], ang, 0.1 )
						draw.SimpleText( thisText, "MenuFont", 0, ((k == 2 or k == 3) and 30 or -30), Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
					cam.End3D2D()
				end
			end
		end
	end

	cam.End3D2D()

	render.SetMaterial(glowMaterial)

	if (self.buttons) then
		local position = self:GetPos()
		local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

		self.buttons[1] = position + f*-45.5 + r*20 + u*45
		self.buttons[2] = position + f*-45.5 + r*20 + u*38
		local closest = self:GetNearestButton()

		for k, v in pairs(self.buttons) do
			local thisColor = self:GetUsed() and Color(255, 0, 0, 255) or k == 1 and Color(0, 255, 0, 255) or k == 2 and Color(150, 150, 0, 255)

			if (closest != k) then
				thisColor.a = 75
			else
				thisColor.a = 230 + (math.sin(RealTime() * 7.5) * 25)
			end

			if (LocalPlayer():KeyDown(IN_USE) and closest == k) then
				thisColor = table.Copy(thisColor)
				thisColor.r = math.min(thisColor.r + 100, 255)
				thisColor.g = math.min(thisColor.g + 100, 255)
				thisColor.b = math.min(thisColor.b + 100, 255)
			end

			render.DrawSprite(v, 10, 10, thisColor)
		end
	end
end

netstream.Hook("ixTrashCollectorSelector", function(entIndex, junkAmount)
	local selector = vgui.Create("ixTrashCollectorSelector")
	selector.entIndex = entIndex
	selector.junkAmount = junkAmount
end)