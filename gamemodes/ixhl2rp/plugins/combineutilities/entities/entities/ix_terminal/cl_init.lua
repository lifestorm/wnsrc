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

netstream.Hook("OpenTerminal", function(idCardId, genericData, activeCID, credits, entity, messages)
	LocalPlayer().idCardId = idCardId
	LocalPlayer().idCardCredits = credits
	LocalPlayer().activeTerminal = entity
	LocalPlayer().genericData = genericData
	LocalPlayer().activeCID = activeCID

	if istable(messages) then
		LocalPlayer().messageList = messages
	else
		messages = {}
		LocalPlayer().messageList = messages
	end

	vgui.Create("ixTerminal")
end)

netstream.Hook("OpenCIDSelectorTerminal", function(entity)
	LocalPlayer().activeTerminal = entity
	local cidSelector = vgui.Create("CIDSelector")
	cidSelector.activeEntity = entity

	cidSelector.ExitCallback = function()
		netstream.Start("ClosePanelsTerminal", LocalPlayer().activeTerminal)
		LocalPlayer().activeTerminal = nil
		LocalPlayer().genericData = nil
		LocalPlayer().activeCID = nil
		LocalPlayer().messageList = nil
	end

	cidSelector.SelectCallback = function(idCardID, cid, cidName, entity)
		netstream.Start("SelectCIDTerminal", idCardID, cid, cidName, entity)
	end
end)

function ENT:Draw()
	self:DrawModel()

	local width, height = 200, 120
	local ang = self:GetAngles()
	local pos = self:GetPos() + ang:Up() * 31.2 + ang:Right() * 13 + ang:Forward() * 3.1
	ang:RotateAroundAxis(ang:Right(), 94)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 180)

	local display = self.Displays[self:GetDisplay()] or self.Displays[6]

	cam.Start3D2D( pos, ang, 0.1 )
		render.PushFilterMin(TEXFILTER.NONE)
		render.PushFilterMag(TEXFILTER.NONE)

		surface.SetDrawColor( Color( 16, 16, 16, 140 ) )
		surface.DrawRect( 0, 0, width, height )

		surface.SetDrawColor( Color( 255, 255, 255, 16 ) )
		surface.DrawRect( 0, height / 2 + math.sin( CurTime() * 4 ) * height / 2, width, 1 )

		local alpha = 191 + 64 * math.sin( CurTime() * 4 )
		local color = ColorAlpha(display[2], alpha)

		draw.SimpleText( "Terminal Obywatelski", "MenuFont", width / 2, 25, Color( 255, 255, 255, alpha ), TEXT_ALIGN_CENTER )
		draw.SimpleText(display[1], "MenuFont", width / 2, height * 0.5, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		render.PopFilterMin()
		render.PopFilterMag()
	cam.End3D2D()
end