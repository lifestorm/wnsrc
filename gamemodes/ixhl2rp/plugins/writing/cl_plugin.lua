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
	for fontName, fontFileName in pairs(self.validHandwriting) do
		surface.CreateFont( fontName, {
			font = fontFileName,
			extended = false,
			size = SScaleMin(30 / 3),
			weight = 550,
			antialias = true
		} )
	end

	surface.CreateFont( "GeorgiaBold", {
		font = "Georgia",
		extended = false,
		size = SScaleMin(16 / 3),
		weight = 1000,
		antialias = true
	} )

	surface.CreateFont( "FjallaOneRegularLarge", {
		font = "Fjalla One",
		extended = false,
		size = SScaleMin(124 / 3),
		weight = 550,
		antialias = true
	} )

	surface.CreateFont( "FjallaOneRegularSmall", {
		font = "Fjalla One",
		extended = false,
		size = SScaleMin(40 / 3),
		weight = 550,
		antialias = true
	} )

	surface.CreateFont( "ArialBold", {
		font = "Arial",
		extended = false,
		size = SScaleMin(14 / 3),
		weight = 1000,
		antialias = true
	} )

	surface.CreateFont( "AdobeCaslonProBold", {
		font = "Caslon-Bold",
		extended = false,
		size = SScaleMin(40 / 3),
		weight = 1000,
		antialias = true
	} )

	surface.CreateFont( "AdobeCaslonProBoldSmaller", {
		font = "Caslon-Bold",
		extended = false,
		size = SScaleMin(24 / 3),
		weight = 1000,
		antialias = true
	} )

	surface.CreateFont( "MinionProBold", {
		font = "MinionPro-Bold",
		extended = false,
		size = SScaleMin(18 / 3),
		weight = 1000,
		antialias = true
	} )

	surface.CreateFont( "MinionProBoldAd", {
		font = "MinionPro-Bold",
		extended = false,
		size = SScaleMin(80 / 3),
		weight = 1000,
		antialias = true
	} )

	surface.CreateFont( "MinionProRegular", {
		font = "MinionPro-Regular",
		extended = false,
		size = SScaleMin(18 / 3),
		weight = 550,
		antialias = true
	} )

	surface.CreateFont( "MinionProItalic", {
		font = "MinionPro-It",
		extended = false,
		size = SScaleMin(60 / 3),
		weight = 550,
		antialias = true
	} )

	surface.CreateFont( "AbrilTitlingRegular", {
		font = "AbrilTitlingW01-Regular",
		extended = false,
		size = SScaleMin(16 / 3),
		weight = 550,
		antialias = true
	} )

	surface.CreateFont("UnifrakturTitle", {
		font = "UnifrakturMaguntia",
		size = SScaleMin(59 / 3),
		extended = true,
		weight = 500
	})

	surface.CreateFont( "LusitanaTitle", {
		font = "Lusitana",
		extended = true,
		size = SScaleMin(34 / 3),
		weight = 550,
		antialias = true
	} )

	surface.CreateFont( "LusitanaItalic", {
		font = "Lusitana",
		extended = true,
		size = SScaleMin(34 / 3),
		weight = 550,
		antialias = true,
		italic = true
	} )

	surface.CreateFont( "LusitanaSmall", {
		font = "Lusitana",
		extended = true,
		size = SScaleMin(24 / 3),
		weight = 550,
		antialias = true
	} )

	surface.CreateFont( "TNRTitle", {
		font = "Times New Roman",
		extended = false,
		size = SScaleMin(36 / 3),
		weight = 550,
		antialias = true
	} )

	-- Sorry for the hardcode, but its' size needed to be adjusted.
	surface.CreateFont( "BookTimes", {
		font = "Times New Roman",
		extended = false,
		size = SScaleMin(9),
		weight = 550,
		antialias = true
	} )

	-- Sorry for the hardcode, but its' size needed to be adjusted.
	surface.CreateFont( "BookTypewriter", {
		font = "Traveling _Typewriter",
		extended = false,
		size = SScaleMin(8.9),
		weight = 550,
		antialias = true
	} )
end

function PLUGIN:OpenViewerEditor(itemID, identifier, data, tNewspaper, contents)
	local viewerEditor = vgui.Create("ixWriting"..Schema:FirstToUpper(identifier))
	viewerEditor.itemID = itemID
	viewerEditor.nData = data
	viewerEditor.tNewspaper = tNewspaper
	viewerEditor.identifier = identifier

	if tNewspaper and viewerEditor.BuildContents then
		viewerEditor:BuildContents(contents or "The Informed Citizen")
	end

	if (data or (!data and tNewspaper)) then
		viewerEditor:Populate(itemID, identifier, data, tNewspaper)
	end
end

function PLUGIN:OpenHandWritingSelector()
	vgui.Create("ixWritingHandwritingSelector")
end

netstream.Hook("ixWritingOpenViewerEditor", function(itemID, identifier, data, tNewspaper)
	PLUGIN:OpenViewerEditor(itemID, identifier, data, tNewspaper, data and data.template)
end)

netstream.Hook("ixWritingOpenHandWritingSelector", function()
	PLUGIN:OpenHandWritingSelector()
end)

netstream.Hook("ixWritingReplyUnionNewspapers", function(newspapers, bTerminal)
	if bTerminal then
		if ix.gui.terminalPanel and IsValid(ix.gui.terminalPanel) then
			if !ix.gui.terminalPanel.newspaperPanel or ix.gui.terminalPanel.newspaperPanel and !IsValid(ix.gui.terminalPanel.newspaperPanel) then return end

			ix.gui.terminalPanel:CreateStoredNewspapers(newspapers)
		end

		return
	end
	
	if ix.gui.medicalComputer.newspaper and IsValid(ix.gui.medicalComputer.newspaper) then
		ix.gui.medicalComputer.newspaper:CreateStoredNewspapers(newspapers)
	end
end)