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

function PLUGIN:LoadFonts(font, genericFont)
	surface.CreateFont( "DatapadTitle", {
		font = "Open Sans Bold", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = true,
		size = SScaleMin(32 / 3),
		weight = 550,
		antialias = true,
	} )
end

netstream.Hook("OpenPDA", function(table, text)
	if IsValid(PLUGIN.ixDatapad) then
		PLUGIN.ixDatapad:Remove()
	end

	PLUGIN.updatelist = table
	PLUGIN.ixDatapad = vgui.Create("ixDatafilePDA")
	surface.PlaySound("willardnetworks/datapad/open.wav")
	if (text != nil) then
		PLUGIN.functions:SetVisible(false)
		PLUGIN.searchProfiles = vgui.Create("ixDatapadSearchProfiles", PLUGIN.contentSubframe)
		PLUGIN.searchEntry:SetValue(text)
		PLUGIN.searchButton:DoClick()
	end
end)