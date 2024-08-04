--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.factoryPanels = ix.factoryPanels or {}
ix.factoryPanels.list = ix.factoryPanels.list or {}

function ix.factoryPanels:CreatePanel(panel, ent)
	local pnl = vgui.Create(panel)
	pnl:SetTerminalEntity(ent)
	ent.terminalPanel = pnl
	ix.factoryPanels.list[#ix.factoryPanels.list + 1] = pnl
	return pnl
end

function ix.factoryPanels:PurgeEntityPanels(ent)
	for index, panel in pairs(self.list) do
		if panel:GetTerminalEntity() == ent then
			panel:Destroy()
			table.remove(self.list, index)
		end
	end
end

-- fonts

surface.CreateFont( "WNTerminalSmallText", {
	font = "Open Sans",
	extended = false,
	size = 32,
	weight = 550,
	scanlines = 2,
	antialias = true,
	outline = true
} )

surface.CreateFont( "WNTerminalMediumSmallerText", {
	font = "Open Sans",
	extended = false,
	size = 38,
	weight = 550,
	scanlines = 2,
	antialias = true,
	outline = true
} )

surface.CreateFont( "WNTerminalMediumText", {
	font = "Open Sans",
	extended = false,
	size = 48,
	weight = 550,
	scanlines = 2,
	antialias = true,
	outline = true
} )

surface.CreateFont( "WNTerminalLargeText", {
	font = "Open Sans",
	extended = false,
	size = 96,
	weight = 550,
	scanlines = 2,
	antialias = true,
	outline = true
} )

surface.CreateFont( "WNTerminalMoreLargerText", {
	font = "Open Sans",
	extended = false,
	size = 114,
	weight = 550,
	scanlines = 2,
	antialias = true,
	outline = true
} )

surface.CreateFont( "WNTerminalVeryLargeText", {
	font = "Open Sans",
	extended = false,
	size = 600,
	weight = 550,
	scanlines = 2,
	antialias = true,
	outline = true
} )

surface.CreateFont("ButtonLabel", {
	font = "Roboto",
	size = 70,
	antialias = true,
	extended = true
})