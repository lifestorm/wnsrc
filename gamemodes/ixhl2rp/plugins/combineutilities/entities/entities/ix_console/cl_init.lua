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

function ENT:Draw()
	self:DrawModel() -- Draw the model

	local ang = self:GetAngles()
	local pos = self:GetPos() + ang:Up() * 48 + ang:Right() * 9.8 + ang:Forward() * -2.38
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis( ang:Forward(), -48 )

	cam.Start3D2D( pos, ang, 0.1 )

	local width, height = 155, 80

	surface.SetDrawColor( Color( 255, 255, 255, 16 ) )
	surface.DrawRect( 0, height / 2 + math.sin( CurTime() * 4 ) * height / 2, width, 1 )

	local alpha = 191 + 64 * math.sin( CurTime() * 4 )

	draw.SimpleText( "Konsola poleceń", "MenuFont", width / 2, 15, Color( 255, 255, 255, alpha ), TEXT_ALIGN_CENTER )
	draw.SimpleText( "Oczekiwanie na użytkownika", "MenuFont", width / 2, height - 25, Color( 255, 255, 180, alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	cam.End3D2D()
end

netstream.Hook("OpenConsoleGUI", function(entity)
	ix.gui.consolePanel = vgui.Create("ConsolePanel")
	ix.gui.consolePanel.entity = entity
end)