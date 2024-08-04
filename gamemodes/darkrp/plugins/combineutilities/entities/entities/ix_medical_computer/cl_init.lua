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

netstream.Hook("OpenMedicalComputer", function(activeComputer, activeComputerUsers, activeComputerNotes, groupmessages, hasDiskInserted)
	LocalPlayer().activeComputer = activeComputer
	LocalPlayer().activeComputer.hasDiskInserted = hasDiskInserted
	LocalPlayer().activeComputerUsers = activeComputerUsers
	LocalPlayer().activeComputerNotes = activeComputerNotes

	netstream.Start("SyncStoredNewspapers")

	ix.gui.medicalComputer = vgui.Create("MedicalComputerBase")
	ix.gui.medicalComputer.groupMessages = groupmessages or {}
end)

netstream.Hook("SyncStoredNewspapersClient", function(stored)
	local writingPlugin = ix.plugin.list["writing"]
	writingPlugin.storedNewspapers = stored
end)

netstream.Hook("createMedicalRecords", function(table, resultName, searchname, resultID)
	LocalPlayer().activeComputerRecords = table
	LocalPlayer().activeComputerResultName = resultName
	LocalPlayer().activeComputerSearchName = searchname
	LocalPlayer().activeComputerResultID = resultID
end)

function ENT:Initialize()
	self:StartShittyComputerSound()
end

function ENT:StartShittyComputerSound()
	local uniqueID = "MedicalAmbientSound_"..self:EntIndex()
	local time = 1

	timer.Simple(1, function()
		timer.Adjust(uniqueID, 8)
	end)

	timer.Create(uniqueID, time, 0, function()
		if (IsValid(self)) then
			self:EmitSound( "willardnetworks/datapad/computerloop.wav", 65, 100, 0.15)
		else
			timer.Remove(uniqueID)
		end
	end)
end

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

-- 		draw.SimpleText( "Medical Computer", "MenuFont", width / 2, 25, Color( 255, 255, 255, alpha ), TEXT_ALIGN_CENTER )
-- 		draw.SimpleText( display[1], "MenuFont", width / 2, height - 35, Color( 255, 255, 180, alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

-- 		render.PopFilterMin()
-- 		render.PopFilterMag()
-- 	cam.End3D2D()
-- end