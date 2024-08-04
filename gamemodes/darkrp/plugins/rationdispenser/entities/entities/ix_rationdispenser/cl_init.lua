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

surface.CreateFont("ixRationDispenser", {
	font = "Default",
	size = 32,
	antialias = false
})

function ENT:Draw()
	local position, angles = self:GetPos(), self:GetAngles()
	local display = self:GetEnabled() and self.Displays[self:GetDisplay()] or self.Displays[6]

	angles:RotateAroundAxis(angles:Forward(), 90)
	angles:RotateAroundAxis(angles:Right(), 270)

	cam.Start3D2D(position + self:GetForward() * 8.4 + self:GetRight()*  8.5 + self:GetUp() * 3, angles, 0.1)
		render.PushFilterMin(TEXFILTER.NONE)
		render.PushFilterMag(TEXFILTER.NONE)

		surface.SetDrawColor(color_black)
		surface.DrawRect(10, 16, 153, 40)

		surface.SetDrawColor(60, 60, 60)
		surface.DrawOutlinedRect(9, 16, 155, 40)

		local alpha = display[3] and 255 or math.abs(math.cos(RealTime() * 2) * 255)
		local color = ColorAlpha(display[2], alpha)

		draw.SimpleText(display[1], "ixRationDispenser", 86, 36, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		render.PopFilterMin()
		render.PopFilterMag()
	cam.End3D2D()
end

local function ExitCallback()
	netstream.Start("ClosePanelsDispenser", LocalPlayer().activeRationDispenser)
	LocalPlayer().activeRationDispenser = nil
end
local function SelectCallback(idCardID, cid, cidName, ent)
	netstream.Start("SelectIDCardDispenser", idCardID, cidName, ent)
end

netstream.Hook("CIDSelectorDispenser", function(entity)
	LocalPlayer().activeRationDispenser = entity

	local cidSelector = vgui.Create("CIDSelector")
	cidSelector.activeEntity = entity
	cidSelector.ExitCallback = ExitCallback
	cidSelector.SelectCallback = SelectCallback
end)

local function SelectCallbackCoupon(idCardID, cid, cidName, ent)
	netstream.Start("SelectIDCardDispenserCoupon", idCardID, cidName, ent)
end

netstream.Hook("CIDSelectorCoupon", function(entity, amount)
	LocalPlayer().activeRationDispenser = entity

	local cidSelector = vgui.Create("CIDSelector")
	cidSelector.activeEntity = entity
	cidSelector.ExitCallback = ExitCallback
	cidSelector.SelectCallback = SelectCallbackCoupon
end)