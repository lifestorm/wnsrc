--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN
include('shared.lua')

netstream.Hook("OpenPickupDispenser", function(boughtItems, entity)
	LocalPlayer().activePickupDispenser = entity
	LocalPlayer().boughtItems = boughtItems
	vgui.Create("PickupDispenser")
end)

netstream.Hook("OpenCIDSelector", function(entity)
	LocalPlayer().activePickupDispenser = entity
	local cidSelector = vgui.Create("CIDSelector")
	cidSelector.activeEntity = entity

	cidSelector.ExitCallback = function()
		netstream.Start("ClosePanels", LocalPlayer().activePickupDispenser)
		LocalPlayer().activePickupDispenser = nil
		LocalPlayer().boughtItems = nil
	end

	cidSelector.SelectCallback = function(idCardID, cid, cidName, entity2)
		netstream.Start("SelectCID", idCardID, cid, cidName, entity2)
	end
end)

function ENT:Draw()
	local position, angles = self:GetPos(), self:GetAngles()
	local display = self.Displays[self:GetDisplay()] or self.Displays[6]

	angles:RotateAroundAxis(angles:Forward(), 90)
	angles:RotateAroundAxis(angles:Right(), 270)

	cam.Start3D2D(position + self:GetForward() * 8.4 + self:GetRight()*  8.5 + self:GetUp() * 3, angles, 0.1)
		render.PushFilterMin(TEXFILTER.NONE)
		render.PushFilterMag(TEXFILTER.NONE)

		surface.SetDrawColor(color_black)
		surface.DrawRect(10, 16, 153, 40)

		surface.SetDrawColor(60, 60, 60)
		surface.DrawOutlinedRect(9, 16, 155, 40)

		surface.SetDrawColor( Color( 255, 255, 255, 3 ) )
		surface.DrawRect( 11, 36 + math.sin( CurTime() * 4 ) * 38 / 2, 151, 1 )

		local alpha = 191 + 64 * math.sin( CurTime() * 4 )
		local color = ColorAlpha(display[2], alpha)

		draw.SimpleText(display[1], "MenuFont", 86, 36, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		render.PopFilterMin()
		render.PopFilterMag()
	cam.End3D2D()
end