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

netstream.Hook("SetNewspaperContent", function(randomID, savedText)
	ix.data.Set("newspaper_"..randomID, savedText, false, true)
end)

netstream.Hook("SetNewspaperContentWithIDCL", function(id, content)
	ix.data.Set(id, content, false, true)
end)

netstream.Hook("OpenNewspaperEditor", function(canEdit, activeNewspaper, entity, bCracked)
	local editor = vgui.Create("NewspaperEditor")
	editor:CreateFunctionsPanel(canEdit, entity, bCracked)
	editor:CreateInnerContent(entity, activeNewspaper, bCracked)
end)

function ENT:Draw()
	self:DrawModel()

	local ang = self:GetAngles()
	local pos = self:GetPos() + ang:Up() * 41.7 + ang:Right() * 9.56 + ang:Forward() * 8.6
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)

	local width, height = 176, 66

	local display = self.Displays[self:GetDisplay()] or self.Displays[6]

	cam.Start3D2D( pos, ang, 0.1 )
		render.PushFilterMin(TEXFILTER.NONE)
		render.PushFilterMag(TEXFILTER.NONE)

		surface.SetDrawColor( Color( 16, 16, 16, 240 ) )
		surface.DrawRect( 0, 0, width, height )

		surface.SetDrawColor( Color( 255, 255, 255, 16 ) )
		surface.DrawRect( 10, height / 2 + math.sin( CurTime() * 4 ) * height / 2.5, width - 22, 1 )

		local alpha = 191 + 64 * math.sin( CurTime() * 4 )
		local color = ColorAlpha(display[2], alpha)

		draw.SimpleText( "NEWSPAPER PRINTER", "MenuFont", width / 2, 10, Color( 255, 255, 255, alpha ), TEXT_ALIGN_CENTER )
		draw.SimpleText( display[1], "MenuFont", width / 2, height - 16, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		render.PopFilterMin()
		render.PopFilterMag()
	cam.End3D2D()

	local paper = self:GetPaper() or 0
	local ink = self:GetInk() or 0

	pos = pos + ang:Up() * -1.95
	cam.Start3D2D( pos, ang, 0.1 )
		render.PushFilterMin(TEXFILTER.NONE)
		render.PushFilterMag(TEXFILTER.NONE)

		surface.SetDrawColor( Color(255, 255, 255, 255) )
		surface.DrawRect( -6, 97, 35 / 2, 12 )

		draw.SimpleText( paper, "MenuFont", 3, 93, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER )

		surface.SetDrawColor( Color(0, 0, 0, 255) )
		surface.DrawRect( -6 + (35 / 2), 97, 35 / 2, 12 )

		draw.SimpleText( ink, "MenuFont", 20, 93, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )

		render.PopFilterMin()
		render.PopFilterMag()
	cam.End3D2D()
end