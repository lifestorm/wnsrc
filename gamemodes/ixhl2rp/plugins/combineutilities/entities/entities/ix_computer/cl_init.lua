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
local ix = ix

include('shared.lua')

netstream.Hook("OpenComputer", function(activeComputer, activeComputerUsers, activeComputerNotes, groupmessages, hasDiskInserted)
	LocalPlayer().activeComputer = activeComputer
	LocalPlayer().activeComputer.hasDiskInserted = hasDiskInserted
	LocalPlayer().activeComputerUsers = activeComputerUsers
	LocalPlayer().activeComputerNotes = activeComputerNotes

	netstream.Start("SyncStoredNewspapers")

	local base = vgui.Create("CitizenComputer")
	ix.gui.medicalComputer.groupMessages = groupmessages or {}
end)

-- function ENT:Draw()
-- 	self:DrawModel()

-- 	local ang = self:GetAngles()
-- 	local pos = self:GetPos() + ang:Up() * 12 + ang:Right() * 10 + ang:Forward() * 11.75
-- 	ang:RotateAroundAxis(ang:Right(), -85.6)
-- 	ang:RotateAroundAxis(ang:Up(), 90)

-- 	local width, height = 200, 170

-- 	local display = self.Displays[self:GetDisplay()] or self.Displays[6]

-- 	cam.Start3D2D( pos, ang, 0.1 )
-- 		render.PushFilterMin(TEXFILTER.NONE)
-- 		render.PushFilterMag(TEXFILTER.NONE)

-- 		surface.SetDrawColor( Color( 16, 16, 16, 240 ) )
-- 		surface.DrawRect( 0, 0, width, height )

-- 		surface.SetDrawColor( Color( 255, 255, 255, 16 ) )
-- 		surface.DrawRect( 10, height / 2 + math.sin( CurTime() * 4 ) * height / 2.5, width - 22, 1 )

-- 		local alpha = 191 + 64 * math.sin( CurTime() * 4 )
-- 		local color = ColorAlpha(display[2], alpha)

-- 		draw.SimpleText( "Computer", "MenuFont", width / 2, 25, Color( 255, 255, 255, alpha ), TEXT_ALIGN_CENTER )
-- 		draw.SimpleText( display[1], "MenuFont", width / 2, height - 35, Color( 255, 255, 180, alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

-- 		render.PopFilterMin()
-- 		render.PopFilterMag()
-- 	cam.End3D2D()
-- end