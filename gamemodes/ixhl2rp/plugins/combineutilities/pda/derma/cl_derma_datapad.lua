--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

	--luacheck: ignore 431 432
local PLUGIN = PLUGIN

local color = Color(41, 243, 229, 255)

function PLUGIN:DrawDividerLine(parent, w, h, x, y, dock, bBottomPanel)
	local marginLeft = (dock and bBottomPanel) and SScaleMin(5 / 3) or dock and SScaleMin(9 / 3) or 0
	local marginTop = (dock and bBottomPanel) and SScaleMin((4 / 2) / 3) or dock and SScaleMin((8 / 2) / 3) or 0
	local marginRight = dock and SScaleMin(5 / 3) or 0
	local marginBottom = (dock and bBottomPanel) and SScaleMin((11 / 2) / 3) or dock and SScaleMin((18 / 2) / 3) or 0

	local dividerLine = parent:Add("DShape")
	dividerLine:SetType( "Rect" )
	dividerLine:SetSize(SScaleMin(w / 3), SScaleMin(h / 3))
	dividerLine:SetPos(x, y)
	dividerLine:DockMargin(marginLeft, marginTop, marginRight, marginBottom)
	dividerLine:Dock(dock or NODOCK)
	dividerLine:SetColor(color)

	return dividerLine
end

function PLUGIN:CreateTitle(name, parent, text)
	name:SetSize(parent:GetWide(), SScaleMin(27 / 3))
	name:Dock(TOP)
	name:DockMargin(0, 0, 0, SScaleMin(11 / 3))
	name.Paint = nil

	local title = name:Add("DLabel")
	title:SetFont("TitlesFontNoClamp")
	title:SetTextColor(color)
	title:SetText(string.utf8upper(text))
	title:SetTextInset(0, 0 - SScaleMin(5 / 3))
	title:SizeToContents()

	PLUGIN:DrawDividerLine(name, SScaleMin(name:GetWide() * 3), 4, 0, name:GetTall() - SScaleMin(4 / 3))
end

function PLUGIN:CreateTitleFrameRightTextButton(name, parent, width, text, dock)
	name:SetFont("MenuFontNoClamp")
	name:SetTextColor(color)
	name:SetText(string.utf8upper(text))
	name:Dock(dock)
	name:DockMargin(0, 0, 0 - SScaleMin(3 / 3), SScaleMin(6 / 3))
	name:SizeToContents()
	name.Paint = nil
end

function PLUGIN:CreateUpdates(parent, k, v, datemargin)
	parent:SetSize(parent:GetWide(), SScaleMin(48 / 3))
	parent:Dock(TOP)
	parent.Paint = function(self, w, h)
		if k % 2 == 0 then
			surface.SetDrawColor(0, 0, 0, 75)
			surface.DrawRect(0, 0, w, h)
		else
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)
		end
	end

	local top = parent:Add("EditablePanel")
	top:SetSize(parent:GetWide(), parent:GetTall() * 0.5)
	top:Dock(TOP)
	top.Paint = nil

	local name = top:Add("DLabel")
	name:SetTextColor(Color(154, 169, 175, 255))
	name:SetFont("MenuFontNoClamp")
	name:SetText(v.update_poster)
	name:Dock(LEFT)
	name:DockMargin(SScaleMin(20 / 3), SScaleMin(5 / 3), 0, 0)
	name:SizeToContents()

	local date = top:Add("DLabel")
	date:SetFont("MenuFontNoClamp")
	date:SetTextColor(Color(154, 169, 175, 255))
	date:SetText(v.update_date)
	date:Dock(RIGHT)
	date:DockMargin(0, SScaleMin(5 / 3), SScaleMin( datemargin / 3), 0)
	date:SizeToContents()

	local bottom = parent:Add("EditablePanel")
	bottom:SetSize(parent:GetWide(), parent:GetTall() * 0.4)
	bottom:Dock(TOP)
	bottom.Paint = nil
	bottom:SetName( "bottom" )

	local string = v.update_text
	local a = string.find(string, "[\n]")
	local excerpt = string.utf8sub(string, 1, a)

	local textExcerpt = bottom:Add("HTML")
	textExcerpt:SetSize(SScaleMin(440 / 3), SScaleMin(100 / 3))
	textExcerpt:SetHTML("<body style ='overflow: hidden;'> <p style='font-family: Open Sans; font-size: "..tostring(SScaleMin(13 / 3)).."; color: rgb(41,243,229);'>"..excerpt.."</p>")
	textExcerpt:SetPos(SScaleMin(12 / 3), 0 - SScaleMin(10 / 3))
end

function PLUGIN:CreateButton(name, text, disabled)
	name:SetSize(SScaleMin(480 / 3), SScaleMin(46 / 3))
	name:SetContentAlignment(4)
	name:SetTextInset(SScaleMin(20 / 3), 0)
	name:Dock(TOP)
	name:SetFont("TitlesFontNoClamp")
	name:DockMargin(0, 0, 0, SScaleMin(9 / 3))
	name:SetText(string.utf8upper(text))
	name.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial(disabled and "willardnetworks/datafile/buttonnoarrow-off.png" or "willardnetworks/datafile/button.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

function PLUGIN:CreateEditingButton(name, text)
	name:SetSize(SScaleMin(560 / 3) / 5, SScaleMin(200 / 3) / 6)
	name:SetContentAlignment(5)
	name:Dock(LEFT)
	name:DockMargin(0, 0, SScaleMin(10 / 3), 0)
	name:SetFont("MenuFontBoldNoClamp")
	name:SetText(string.utf8upper(text))
	name.Paint = function(self, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:MakePopup()
	self.Paint = nil
	Schema:AllowMessage(self)

	local mainFrame = self:Add("EditablePanel")
	mainFrame:SetSize(SScaleMin(645 / 3), SScaleMin(850 / 3))
	mainFrame:Center()
	mainFrame.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/mainframe.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	local close = self:Add("DButton")
	close:SetSize(SScaleMin(107 / 3), SScaleMin(105 / 3))
	close:SetPos(ScrW() * 0.5 + mainFrame:GetWide() * 0.5 - close:GetWide() * 0.6, ScrH() * 0.5 - mainFrame:GetTall() * 0.5 - close:GetTall() * 0.4)
	close:SetText("")
	close.Paint = function(self, w, h)
		if close:IsHovered() then
			surface.SetDrawColor(Color(255, 255, 255, 50))
			surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/gadgetlight.png"))
			surface.DrawTexturedRect(0, 0, w, h)
		end
	end
	close.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/close.wav")
		self:Remove()
	end

	local subFrame = mainFrame:Add("EditablePanel")
	subFrame:SetSize(SScaleMin(560 / 3), SScaleMin(782 / 3))
	subFrame:Center()
	subFrame.Paint = nil

	local titleFrame = subFrame:Add("EditablePanel")
	titleFrame:SetSize(subFrame:GetWide(), SScaleMin(50 / 3))
	titleFrame:Dock(TOP)
	titleFrame.Paint = nil

	PLUGIN.mainTitle = titleFrame:Add("DLabel")
	PLUGIN.mainTitle:SetFont("DatapadTitle")
	PLUGIN.mainTitle:SetText(string.utf8upper("datapad"))
	PLUGIN.mainTitle:SetTextInset(SScaleMin(20 / 3), SScaleMin(4 / 3))
	PLUGIN.mainTitle:SizeToContents()

	local contentFrame = subFrame:Add("EditablePanel")
	contentFrame:SetSize(subFrame:GetWide(), subFrame:GetTall() - titleFrame:GetTall())
	contentFrame:Dock(TOP)
	contentFrame.Paint = nil

	local padding = SScaleMin(80 / 3)
	PLUGIN.contentSubframe = contentFrame:Add("EditablePanel")
	PLUGIN.contentSubframe:SetSize(contentFrame:GetWide() - padding, contentFrame:GetTall() - padding)
	PLUGIN.contentSubframe:Center()
	PLUGIN.contentSubframe.Paint = nil

	if (ix.config.Get("datafileNoConnection")) then
		PLUGIN.updates = vgui.Create("ixDatapadNoConnection", PLUGIN.contentSubframe)
	else
		PLUGIN.updates = vgui.Create("ixDatapadUpdates", PLUGIN.contentSubframe)
	end

	PLUGIN.functions = vgui.Create("ixDatapadFunctions", PLUGIN.contentSubframe)
end

vgui.Register("ixDatafilePDA", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), SScaleMin(230 / 3))
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "aktualizacje")

	local updatesTitleSubframe = updatesTitleFrame:Add("EditablePanel")
	updatesTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
	updatesTitleSubframe:Dock(RIGHT)
	updatesTitleSubframe.Paint = nil

	local editUpdates = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(editUpdates, updatesTitleSubframe, 87, "edytuj aktualizacje", RIGHT)

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	local viewLogs = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(viewLogs, updatesTitleSubframe, 68, "wyświetl logi", RIGHT)

	local updatesContentFrame = self:Add("EditablePanel")
	updatesContentFrame:SetSize(self:GetWide(), SScaleMin(192 / 3))
	updatesContentFrame:Dock(TOP)
	updatesContentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	updatesContentFrame.Paint = nil

	for k, v in SortedPairsByMemberValue(PLUGIN.updatelist, "update_id", true) do
		local updateFrame = updatesContentFrame:Add("EditablePanel")
		if (k == #PLUGIN.updatelist or k == #PLUGIN.updatelist - 1 or k == #PLUGIN.updatelist - 2 or k == #PLUGIN.updatelist - 3) then
			PLUGIN:CreateUpdates(updateFrame, k, v, 20)
		end
	end

	editUpdates.DoClick = function()
		local character = LocalPlayer():GetCharacter()
		local getFaction = character:GetFaction()
		local class = character:GetClass()
		if (class == CLASS_OW_SCANNER or getFaction == FACTION_OTA or getFaction == FACTION_MCP or getFaction == FACTION_ADMIN or class == CLASS_CP_RL or class == CLASS_CP_CPT or class == CLASS_CP_CMD) then
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
			if IsValid(PLUGIN.searchProfiles) then
				PLUGIN.searchProfiles:SetVisible(false)
			end

			PLUGIN.updates:SetVisible(false)
			PLUGIN.functions:SetVisible(false)
			PLUGIN.editupdates = vgui.Create("ixDatapadEditUpdates", PLUGIN.contentSubframe)
		else
			LocalPlayer():NotifyLocalized("Nie masz dostępu do tej funkcji!")
		end
	end

	viewLogs.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		if IsValid(PLUGIN.searchProfiles) then
			PLUGIN.searchProfiles:SetVisible(false)
		end
		PLUGIN.updates:SetVisible(false)
		PLUGIN.functions:SetVisible(false)
		PLUGIN.viewLogs = vgui.Create("ixDatapadViewUpdates", PLUGIN.contentSubframe)
	end
end

vgui.Register("ixDatapadUpdates", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), SScaleMin(230 / 3))
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local noConnection = self:Add("DLabel")
	noConnection:SetHeight(SScaleMin(46 / 3))
	noConnection:SetContentAlignment(4)
	noConnection:SetTextInset(SScaleMin(20 / 3), 0)
	noConnection:Dock(TOP)
	noConnection:SetFont("TitlesFontNoClamp")
	noConnection:DockMargin(0, 0, 0, SScaleMin(9 / 3))
	noConnection:SetText(string.utf8upper("NIE USTANOWIONO BEZPIECZNEGO ŁĄCZA UPLINK Z OCIN"))
	noConnection.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 0, 0, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow-off.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "aktualizacje")

	local noConnection2 = self:Add("DLabel")
	noConnection2:SetHeight(SScaleMin(46 / 3))
	noConnection2:SetContentAlignment(4)
	noConnection2:SetTextInset(SScaleMin(20 / 3), 0)
	noConnection2:Dock(TOP)
	noConnection2:SetFont("TitlesFontNoClamp")
	noConnection2:DockMargin(0, 0, 0, SScaleMin(9 / 3))
	noConnection2:SetText(string.utf8upper("BŁĄD: BRAK POŁĄCZENIA"))
	noConnection2.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 0, 0, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow-off.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

vgui.Register("ixDatapadNoConnection", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "edytowanie aktualizacji")

	PLUGIN:DrawDividerLine(updatesTitleFrame, updatesTitleFrame:GetWide(), 4, 0, updatesTitleFrame:GetTall() - SScaleMin(4 / 3))

	local updatesTitleSubframe = updatesTitleFrame:Add("EditablePanel")
	updatesTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
	updatesTitleSubframe:Dock(RIGHT)
	updatesTitleSubframe.Paint = nil

	local newUpdate = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(newUpdate, updatesTitleSubframe, 87, "nowa aktualizacja", RIGHT)

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	local back = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, updatesTitleSubframe, 68, "powrót", RIGHT)
	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	newUpdate.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		self:SetVisible(false)
		PLUGIN.newUpdate = vgui.Create("ixDatapadNewUpdate", PLUGIN.contentSubframe)
	end

	local updatesContentFrame = self:Add("EditablePanel")
	updatesContentFrame:SetSize(self:GetWide(), SScaleMin(48 / 3) * 10)
	updatesContentFrame:Dock(TOP)
	updatesContentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	updatesContentFrame.Paint = nil

	for k, v in SortedPairsByMemberValue(PLUGIN.updatelist, "update_id", true) do
		local updateFrame = updatesContentFrame:Add("EditablePanel")
		PLUGIN:CreateUpdates(updateFrame, k, v, 20)

		for _, v2 in ipairs( updateFrame:GetChildren() ) do
			if v2:GetName() == "bottom" then
				for _, v3 in ipairs( v2:GetChildren() ) do
					v3:SetWide(SScaleMin(340 / 3))
				end
				local removeUpdate = v2:Add("DButton")
				removeUpdate:Dock(RIGHT)
				removeUpdate:DockMargin(0, 0, SScaleMin(19 / 3), SScaleMin(5 / 3))
				removeUpdate:SetFont("MenuFontNoClamp")
				removeUpdate:SetTextColor(color)
				removeUpdate:SetText(string.utf8upper("usuń"))
				removeUpdate:SizeToContents()
				removeUpdate.Paint = nil
				removeUpdate.DoClick = function()
					netstream.Start("RemoveUpdate", v.update_id)
				end

				PLUGIN:DrawDividerLine(v2, 2, 13, 0, SScaleMin( 4 / 3), RIGHT, true )

				local editUpdate = v2:Add("DButton")
				editUpdate:Dock(RIGHT)
				editUpdate:DockMargin(0, 0, 0, SScaleMin(5 / 3))
				editUpdate:SetFont("MenuFontNoClamp")
				editUpdate:SetTextColor(color)
				editUpdate:SetText(string.utf8upper("edytuj"))
				editUpdate:SizeToContents()
				editUpdate.Paint = nil
				editUpdate.DoClick = function()
					self:SetVisible(false)
					surface.PlaySound("willardnetworks/datapad/navigate2.wav")
					PLUGIN.editUpdate = vgui.Create("ixDatapadNewUpdate", PLUGIN.contentSubframe)
					PLUGIN.textEntry:SetValue(v.update_text)
					PLUGIN.addUpdate:SetText(string.utf8upper("edytuj aktualizację"))
					PLUGIN.addUpdate.DoClick = function()
						netstream.Start("EditUpdate", v.update_id, PLUGIN.textEntry:GetText())
					end
				end
			end
		end

	end
end

vgui.Register("ixDatapadEditUpdates", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "aktualizacja")

	local updatesTitleSubframe = updatesTitleFrame:Add("EditablePanel")
	updatesTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
	updatesTitleSubframe:Dock(RIGHT)
	updatesTitleSubframe.Paint = nil

	PLUGIN.addUpdate = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(PLUGIN.addUpdate, updatesTitleSubframe, 20, "dodaj aktualizację", RIGHT)

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	local preview = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(preview, updatesTitleSubframe, 20, "podgląd", RIGHT)
	preview:DockMargin(0, 0, 0 - SScaleMin(3 / 3), SScaleMin(6 / 3))
	preview.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		if IsValid(PLUGIN.newUpdate) then
			if PLUGIN.newUpdate:IsVisible() then
				PLUGIN.newUpdate:Dock(NODOCK)
				PLUGIN.newUpdate:SetPos(0, SScaleMin(790 / 3))
			end
		elseif IsValid(PLUGIN.editUpdate) then
			if PLUGIN.editUpdate:IsVisible() then
				PLUGIN.editUpdate:Dock(NODOCK)
				PLUGIN.editUpdate:SetPos(0, SScaleMin(790 / 3))
			end
		end

		vgui.Create("ixDatapadNewUpdatePreview", PLUGIN.contentSubframe)
	end

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	local back = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, updatesTitleSubframe, 68, "powrót", RIGHT)
	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.editupdates:SetVisible(true)
	end

	local updatesContentFrame = self:Add("EditablePanel")
	updatesContentFrame:SetSize(self:GetWide(), self:GetTall() - SScaleMin(126 / 3))
	updatesContentFrame:Dock(TOP)
	updatesContentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	updatesContentFrame.Paint = nil

	PLUGIN.textEntry = vgui.Create("DTextEntry", updatesContentFrame)
	PLUGIN.textEntry:SetSize(self:GetWide(), updatesContentFrame:GetTall())
	PLUGIN.textEntry:SetMultiline(true)
	PLUGIN.textEntry:SetEnterAllowed(true)
	PLUGIN.textEntry:SetVerticalScrollbarEnabled( true )
	PLUGIN.textEntry:RequestFocus()
	PLUGIN.textEntry:SetFont("MenuFontNoClamp")
	PLUGIN.textEntry:SetTextColor( color )
	PLUGIN.textEntry:SetCursorColor( color )
	PLUGIN.textEntry.Paint = function(self, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h)

		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
	end

	local textEntry = PLUGIN.textEntry

	PLUGIN.addUpdate.DoClick = function()
		if #PLUGIN.updatelist == 10 then
			LocalPlayer():NotifyLocalized("Musisz usunąć istniejącą aktualizację przed utworzeniem nowej!")
			surface.PlaySound("willardnetworks/datapad/deny.wav")
			return false
		end
		netstream.Start("AddUpdate", textEntry:GetText())
	end

	local updateHelpFrame = self:Add("EditablePanel")
	updateHelpFrame:SetSize(SScaleMin(560 / 3), SScaleMin(80 / 3))
	updateHelpFrame:Dock(TOP)
	updateHelpFrame:DockMargin(0, SScaleMin(10 / 3), 0, 0)
	updateHelpFrame.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 40))
		surface.DrawRect(0, 0, w, h)
	end

	local topbuttons = updateHelpFrame:Add("DPanel")
	topbuttons:Dock(TOP)
	topbuttons:SetTall(SScaleMin(200 / 3) / 6)
	topbuttons.Paint = nil

	local unorderedlist = topbuttons:Add("DButton")
	PLUGIN:CreateEditingButton(unorderedlist, "lista nieuporządkowana")
	unorderedlist.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		textEntry:SetText(textEntry:GetValue().."<ul style='font-family: Open Sans; color: rgb(41,243,229);'> <li>Coffee</li> <li>Tea</li> <li>Milk</li> </ul>")
	end
	unorderedlist:SetSize(SScaleMin(560 / 3) / 2.39, SScaleMin(200 / 3) / 6)

	local orderedlist = topbuttons:Add("DButton")
	PLUGIN:CreateEditingButton(orderedlist, "lista uporządkowana")
	orderedlist.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		textEntry:SetText(textEntry:GetValue().."<ol style='font-family: Open Sans; color: rgb(41,243,229);'> <li>Coffee</li> <li>Tea</li> <li>Milk</li> </ol>")
	end
	orderedlist:SetSize(SScaleMin(560 / 3) / 2.39, SScaleMin(200 / 3) / 6)

	local bottombuttons = updateHelpFrame:Add("DPanel")
	bottombuttons:Dock(TOP)
	bottombuttons:DockMargin(0, SScaleMin(10 / 3), 0, 0)
	bottombuttons:SetTall(SScaleMin(200 / 3) / 6)
	bottombuttons.Paint = nil

	local underline = bottombuttons:Add("DButton")
	PLUGIN:CreateEditingButton(underline, "podkreślenie")
	underline.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		textEntry:SetText(textEntry:GetValue().."<u style='font-family: Open Sans; color: rgb(41,243,229);'> <u>texthere </u>")
	end

	local colortext = bottombuttons:Add("DButton")
	PLUGIN:CreateEditingButton(colortext, "kolor tekstu")
	colortext.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		textEntry:SetText(textEntry:GetValue().."<colortext style='font-family: Open Sans; color: red;'>text here</colortext>")
	end

	local bold = bottombuttons:Add("DButton")
	PLUGIN:CreateEditingButton(bold, "pogrubienie")
	bold.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		textEntry:SetText(textEntry:GetValue().."<b style='font-family: Open Sans; color: rgb(41,243,229);'> <b>text here</b>")
	end

	local italic = bottombuttons:Add("DButton")
	PLUGIN:CreateEditingButton(italic, "kursywa")
	italic.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		textEntry:SetText(textEntry:GetValue().."<i style='font-family: Open Sans; color: rgb(41,243,229);'>text here</i>")
	end
end

vgui.Register("ixDatapadNewUpdate", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(SScaleMin(560 / 3), SScaleMin(782 / 3))
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "podgląd")

	local updatesTitleSubframe = updatesTitleFrame:Add("EditablePanel")
	updatesTitleSubframe:SetSize(SScaleMin(50 / 3), 0)
	updatesTitleSubframe:Dock(RIGHT)
	updatesTitleSubframe.Paint = nil

	local back = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, updatesTitleSubframe, 87, "powrót", RIGHT)
	back.DoClick = function()
		self:SetVisible(false)
		surface.PlaySound("willardnetworks/datapad/back.wav")
		if IsValid(PLUGIN.newUpdate) then
			if PLUGIN.newUpdate:IsVisible() then
				PLUGIN.newUpdate:SetPos(0, 0)
			end
		elseif IsValid(PLUGIN.editUpdate) then
			if PLUGIN.editUpdate:IsVisible() then
				PLUGIN.editUpdate:SetPos(0, 0)
			end
		end
	end

	local updatesContentFrame = self:Add("EditablePanel")
	updatesContentFrame:SetSize(self:GetWide(), self:GetParent():GetTall())
	updatesContentFrame:Dock(TOP)
	updatesContentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	updatesContentFrame.Paint = nil

	local updateFrame = updatesContentFrame:Add("HTML")
	updateFrame:SetSize(updatesContentFrame:GetWide(), self:GetParent():GetTall())
	local string = "<p style='font-family: Open Sans; font-size: "..tostring(SScaleMin(13 / 3)).."; color: rgb(41,243,229);'>"..PLUGIN.textEntry:GetText().."</p>"
	local html = string.Replace(string, "\n", "<br>")
	updateFrame:SetHTML(html)
	updateFrame.Paint = function(self, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h)
	end
end

vgui.Register("ixDatapadNewUpdatePreview", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "wyświetl logi")

	local updatesTitleSubframe = updatesTitleFrame:Add("EditablePanel")
	updatesTitleSubframe:SetSize(SScaleMin(50 / 3), 0)
	updatesTitleSubframe:Dock(RIGHT)
	updatesTitleSubframe.Paint = nil

	local back = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, updatesTitleSubframe, 87, "powrót", RIGHT)
	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	local updatesContentFrame = self:Add("EditablePanel")
	updatesContentFrame:SetSize(self:GetWide(), SScaleMin(48 / 3) * 10)
	updatesContentFrame:Dock(TOP)
	updatesContentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	updatesContentFrame.Paint = nil

	for k, v in SortedPairsByMemberValue(PLUGIN.updatelist, "update_id", true) do
		local updateFrame = updatesContentFrame:Add("EditablePanel")
		PLUGIN:CreateUpdates(updateFrame, k, v, 20)
		for _, v2 in ipairs( updateFrame:GetChildren() ) do
			if v2:GetName() == "bottom" then
				for _, v3 in pairs(v2:GetChildren()) do
					v3:SetWide(SScaleMin(360 / 3))
				end
				local viewLog = v2:Add("DButton")
				viewLog:SetTextColor(color)
				viewLog:SetFont("MenuFontNoClamp")
				viewLog:SetText(string.utf8upper("wyświetl log"))
				viewLog:Dock(RIGHT)
				viewLog:DockMargin(0, 0, SScaleMin(19 / 3), SScaleMin(5 / 3))
				viewLog:SizeToContents()
				viewLog.Paint = nil

				viewLog.DoClick = function()
					surface.PlaySound("willardnetworks/datapad/navigate2.wav")
					PLUGIN.viewLogs:SetVisible(false)
					PLUGIN.viewLogID = v
					PLUGIN.viewLog = vgui.Create("ixDatapadViewUpdate", PLUGIN.contentSubframe)
				end
			end
		end
	end
end
vgui.Register("ixDatapadViewUpdates", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	ix.gui.datapadCrimes = self

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "zgłoszenia")

	local updatesTitleSubframe = updatesTitleFrame:Add("EditablePanel")
	updatesTitleSubframe:SetSize(SScaleMin(50 / 3), 0)
	updatesTitleSubframe:Dock(RIGHT)
	updatesTitleSubframe.Paint = nil

	local paginationPanel = self:Add("Panel")
	paginationPanel:Dock(BOTTOM)
	paginationPanel:SetTall(SScaleMin(50 / 3))

	self.decrementCrimes, self.incrementCrimes = paginationPanel:Add("DButton"), paginationPanel:Add("DButton")
	PLUGIN:CreateEditingButton(self.decrementCrimes, "poprzednia strona")
	PLUGIN:CreateEditingButton(self.incrementCrimes, "następna strona")

	self.decrementCrimes:Dock(LEFT)
	self.decrementCrimes:SetWide(self:GetWide() / 2)
	self.incrementCrimes:Dock(FILL)

	self.decrementCrimes:DockMargin(0, 0, SScaleMin(5 / 3), 0)
	self.incrementCrimes:DockMargin(SScaleMin(5 / 3), 0, 0, 0)

	self.curCollect = 0
	self.nextClick = CurTime()

	self.decrementCrimes.DoClick = function()
		if self.nextClick > CurTime() then return end

		self.curCollect = math.max(self.curCollect - 5, 0)

		self:SendTypeOfContent()

		self.nextClick = CurTime() + 1
	end

	self.incrementCrimes.DoClick = function()
		if self.nextClick > CurTime() then return end

		self.curCollect = self.curCollect + 5

		self:SendTypeOfContent()

		self.nextClick = CurTime() + 1
	end

	self.back = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.back, updatesTitleSubframe, 87, "powrót", RIGHT)
	self.back:SizeToContents()
	self.back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	self.showAll = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.showAll, updatesTitleSubframe, 87, "nowe", RIGHT)
	self.showAll:SizeToContents()

	self.showAll.DoClick = function()
		self.curCollect = 0
		surface.PlaySound("helix/ui/press.wav")
		netstream.Start("GetCrimeReports", false, false, self.curCollect)
		self.lastUsedTab = false
	end

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	self.showResolved = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.showResolved, updatesTitleSubframe, 87, "rozwiązane", RIGHT)
	self.showResolved:SizeToContents()

	self.showResolved.DoClick = function()
		self.curCollect = 0
		surface.PlaySound("helix/ui/press.wav")
		netstream.Start("GetCrimeReports", false, true, self.curCollect)
		self.lastUsedTab = "resolved"
	end

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	self.showArchived = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.showArchived, updatesTitleSubframe, 87, "archiwalne", RIGHT)
	self.showArchived:SizeToContents()

	self.showArchived.DoClick = function()
		self.curCollect = 0
		surface.PlaySound("helix/ui/press.wav")
		netstream.Start("GetCrimeReports", true, false, self.curCollect)
		self.lastUsedTab = "archived"
	end

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	self.clearArchieved = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.clearArchieved, updatesTitleSubframe, 127, "clear", RIGHT)
	self.clearArchieved:SizeToContents()

	self.clearArchieved.DoClick = function()
		if (!LocalPlayer():IsCombineRankAbove("i1")) then
			LocalPlayer():NotifyLocalized("Only combine with i1+ rank have access to this.")
			return false
		end

		surface.PlaySound("helix/ui/press.wav")

		Derma_Query(
		"Are you sure that you want to clear all archived crime reports?",
		"THESE CANNOT BE RESTORED",
		"Yes",
		function()
			surface.PlaySound("helix/ui/press.wav")
			netstream.Start("ClearArchivedCrimeReports") 
		end,
		"No",
		function()
			surface.PlaySound("helix/ui/press.wav")
		end)
	end

	updatesTitleSubframe:SetWide(self.back:GetWide() + (SScaleMin(17 / 3) * 3) + self.showAll:GetWide() + self.showResolved:GetWide() + self.showArchived:GetWide() + self.clearArchieved:GetWide())
	self.updatesContentFrame = self:Add("DScrollPanel")
	self.updatesContentFrame:SetSize(self:GetWide(), self:GetTall())
	self.updatesContentFrame:Dock(FILL)
	self.updatesContentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	self.updatesContentFrame.Paint = nil
	self.updatesContentFrame.crimes = {}

	netstream.Start("GetCrimeReports", false, false, self.curCollect)

	self.lastUsedTab = false
end

function PANEL:SendTypeOfContent()
	if self.lastUsedTab == false then
		netstream.Start("GetCrimeReports", false, false, self.curCollect)
	elseif self.lastUsedTab == "resolved" then
		netstream.Start("GetCrimeReports", false, true, self.curCollect)
	else
		netstream.Start("GetCrimeReports", true, false, self.curCollect)
	end
end

function PANEL:CreateCrimes(tCrimes)
	if #tCrimes == 0 then
		self.curCollect = math.max(self.curCollect - 5, 0)
		return
	end

	self.updatesContentFrame:Clear()

	local counter = 0
	for _, data in pairs(tCrimes) do
		counter = counter + 1
		local crime = self.updatesContentFrame:Add("EditablePanel")
		PLUGIN:CreateRow(crime, "IMIĘ | CID | EXTRACT", (istable(data["message_poster"]) and data["message_poster"].poster or data["message_poster"]).." | "..data["message_cid"].." | "..string.Left(data["message_text"], 15).."...", false, true)
		self:CreateBottomOrTopTextOrButton(crime:GetChildren()[1], "DATA: "..data["message_date"], true)

		if counter % 2 == 0 then
			crime.Paint = function(this, w, h)
				surface.SetDrawColor(40, 88, 115, 75)
				surface.DrawRect(0, 0, w, h)
			end
		else
			crime.Paint = function(this, w, h)
				surface.SetDrawColor(0, 0, 0, 75)
				surface.DrawRect(0, 0, w, h)
			end
		end

		if istable(data["message_poster"]) then
			if data["message_poster"].resolved then
				local resolveText = self:CreateBottomOrTopTextOrButton(crime:GetChildren()[1], "ROZWIĄZANE", true)
				resolveText:SetTextColor(Color(180, 255, 180, 255))

				crime.Paint = function(this, w, h)
					surface.SetDrawColor(0, 255, 0, 5)
					surface.DrawRect(0, 0, w, h)
				end
			end
		end

		if istable(data["message_poster"]) then
			if data["message_poster"].archived then
				local delete = self:CreateBottomOrTopTextOrButton(crime:GetChildren()[2], "USUŃ", false, true)
				delete.DoClick = function()
					surface.PlaySound("helix/ui/press.wav")
					crime:Remove()
					netstream.Start("DeleteCrimeReport", data["message_id"], true, self.lastUsedTab, self.curCollect)
				end
			end
		end

		local view = self:CreateBottomOrTopTextOrButton(crime:GetChildren()[2], "WYŚWIETL", false, true)
		view.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate2.wav")
			for _, v in pairs(self.updatesContentFrame.crimes) do
				if v == crime then continue end
				v:Remove()
			end

			crime:Clear()
			crime:SetTall(self.updatesContentFrame:GetTall())
			crime.Paint = nil

			local resolveArchivePanel = crime:Add("Panel")
			resolveArchivePanel:Dock(TOP)
			resolveArchivePanel:SetTall(SScaleMin(46 / 3))

			local resolved = resolveArchivePanel:Add("DButton")
			PLUGIN:CreateButton(resolved, istable(data["message_poster"]) and data["message_poster"].resolved and "cofnij rozwiązanie" or "uznaj za rozwiązane")
			resolved:Dock(LEFT)
			resolved:SetWide(crime:GetWide() * 0.5 - SScaleMin(5 / 3))

			local archive = resolveArchivePanel:Add("DButton")
			PLUGIN:CreateButton(archive, istable(data["message_poster"]) and data["message_poster"].archived and "odarchiwizuj" or "archiwizuj")
			archive:Dock(RIGHT)
			archive:SetWide(crime:GetWide() * 0.5 - SScaleMin(5 / 3))

			resolved.Paint = function(this, w, h)
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow.png"))
				surface.DrawTexturedRect(0, 0, w, h)
			end

			archive.Paint = function(this, w, h)
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow.png"))
				surface.DrawTexturedRect(0, 0, w, h)
			end

			resolved.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")
				netstream.Start("ResolveCrimeReport", data["message_id"], data["message_poster"], istable(data["message_poster"]) and data["message_poster"].resolved and true or false, self.lastUsedTab, self.curCollect)
			end

			archive.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")
				netstream.Start("ArchiveCrimeReport", data["message_id"], data["message_poster"], istable(data["message_poster"]) and data["message_poster"].archived and true or false, self.lastUsedTab, self.curCollect)
			end

			local entry = crime:Add("DTextEntry")
			entry:Dock(FILL)
			entry:SetMultiline(true)
			entry:SetValue(data["message_text"] or "")
			entry:SetVerticalScrollbarEnabled( true )
			entry:SetEnterAllowed(true)
			entry:SetEditable(false)
			entry:SetFont("MenuFontNoClamp")
			entry:SetTextColor( Color(41, 243, 229, 255) )
			entry:SetCursorColor( Color(41, 243, 229, 255) )
			entry.Paint = function(this, w, h)
				surface.SetDrawColor(40, 88, 115, 75)
				surface.DrawRect(0, 0, w, h)

				this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
			end

			self.back.DoClick = function()
				surface.PlaySound("willardnetworks/datapad/back.wav")
				netstream.Start("GetCrimeReports")

				self.back.DoClick = function()
					surface.PlaySound("willardnetworks/datapad/back.wav")
					self:SetVisible(false)
					PLUGIN.updates:SetVisible(true)
					PLUGIN.functions:SetVisible(true)
				end
			end
		end

		self.updatesContentFrame.crimes[#self.updatesContentFrame.crimes + 1] = crime
	end
end

function PANEL:CreateBottomOrTopTextOrButton(parent, text, bTop, bButton)
	local labelText = parent:Add(bButton and "DButton" or "DLabel")
	labelText:SetTextColor(bTop and Color(154, 169, 175, 255) or color)
	labelText:SetFont("MenuFontNoClamp")
	labelText:SetText(text)
	labelText:Dock(RIGHT)
	labelText:DockMargin(0, 0, SScaleMin(20 / 3), 0)
	labelText:SizeToContents()
	labelText.Paint = nil

	return labelText
end

vgui.Register("ixDatapadViewCrimeReports", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	ix.gui.datapadPersonalNotes = self

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "notatki osobiste")

	local updatesTitleSubframe = updatesTitleFrame:Add("EditablePanel")
	updatesTitleSubframe:Dock(RIGHT)
	updatesTitleSubframe.Paint = nil

	self.back = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.back, updatesTitleSubframe, 87, "powrót", RIGHT)
	self.back:SizeToContents()
	self.back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	PLUGIN:DrawDividerLine(updatesTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	self.save = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.save, updatesTitleSubframe, 87, "zapisz", RIGHT)
	self.save:SizeToContents()

	updatesTitleSubframe:SetSize(self.back:GetWide() + self.save:GetWide() + SScaleMin(17 / 3), 0)

	self.notesContent = self:Add("DTextEntry")
	self.notesContent:SetSize(self:GetWide(), self:GetTall())
	self.notesContent:Dock(FILL)
	self.notesContent:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	self.notesContent:SetMultiline(true)
	self.notesContent:SetVerticalScrollbarEnabled( true )
	self.notesContent:SetEnterAllowed(true)
	self.notesContent:SetFont("MenuFontNoClamp")
	self.notesContent:SetTextColor( color )
	self.notesContent:SetCursorColor( color )
	self.notesContent.Paint = function(this, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h)

		this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
	end

	self.save.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then
			LocalPlayer():Notify("Błąd: brak połączenia. Notatki zostały zapisane tylko lokalnie.")
			surface.PlaySound("hl1/fvox/buzz.wav")
		end
		netstream.Start("SavePersonalNotesDatapad", self.notesContent:GetValue())
	end

	netstream.Start("GetPersonalNotesDatapad")
end

function PANEL:CreatePersonalNotes(notes)
	self.notesContent:SetText(notes)
end

vgui.Register("ixDatapadViewPersonalNotes", PANEL, "EditablePanel")

netstream.Hook("ReplyPersonalNotesDatapad", function(notes)
	if ix.gui.datapadPersonalNotes and IsValid(ix.gui.datapadPersonalNotes) then
		ix.gui.datapadPersonalNotes:CreatePersonalNotes(notes)
	end
end)

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local updatesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(updatesTitleFrame, self, "wyświetl log")

	local updatesTitleSubframe = updatesTitleFrame:Add("EditablePanel")
	updatesTitleSubframe:SetSize(SScaleMin(50 / 3), 0)
	updatesTitleSubframe:Dock(RIGHT)
	updatesTitleSubframe.Paint = nil

	local back = updatesTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, updatesTitleSubframe, 87, "powrót", RIGHT)
	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.viewLogs:SetVisible(true)
	end

	local updatesContentFrame = self:Add("EditablePanel")
	updatesContentFrame:SetSize(self:GetWide(), self:GetParent():GetTall())
	updatesContentFrame:Dock(TOP)
	updatesContentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	updatesContentFrame.Paint = nil

	local updateFrame = updatesContentFrame:Add("EditablePanel")
	PLUGIN:CreateUpdates(updateFrame, 1, PLUGIN.viewLogID, 20)
	updateFrame:SetSize(updatesContentFrame:GetWide(), self:GetParent():GetTall())
	for _, v in pairs(updateFrame:GetChildren()) do
		if v:GetName() == "bottom" then
			v:Dock(TOP)
			v:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall() - SScaleMin(50 / 3))
			for _, v2 in pairs(v:GetChildren()) do
				local string = "<p style='font-family: Open Sans; font-size: "..tostring(SScaleMin(13 / 3)).."; color: rgb(41,243,229);'>"..PLUGIN.viewLogID.update_text.."</p>"
				local html = string.Replace(string, "\n", "<br>")
				v2:SetHTML(html)
				v2:SetSize(self:GetParent():GetWide() - SScaleMin(16 / 3), self:GetParent():GetTall() - SScaleMin(20 / 3))
			end
		end
	end
end
vgui.Register("ixDatapadViewUpdate", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetWide(self:GetParent():GetWide())
	self:Dock(FILL)
	self.Paint = nil

	local function errorNoConnection()
		LocalPlayer():NotifyLocalized("Błąd: brak połączenia!")
		surface.PlaySound("hl1/fvox/buzz.wav")
	end

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "funkcje")

	local functionsTitleSubframe = titleFrame:Add("EditablePanel")
	functionsTitleSubframe:Dock(RIGHT)
	functionsTitleSubframe.Paint = nil

	local crimeReports = functionsTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(crimeReports, functionsTitleSubframe, false, "zgłoszenia wykroczeń", RIGHT)

	PLUGIN:DrawDividerLine(functionsTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	local personalNotes = functionsTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(personalNotes, functionsTitleSubframe, false, "notatki osobiste", RIGHT)

	functionsTitleSubframe:SetWide(crimeReports:GetWide() + personalNotes:GetWide() + SScaleMin(17 / 3))

	crimeReports.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then errorNoConnection() return end

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		if IsValid(PLUGIN.searchProfiles) then
			PLUGIN.searchProfiles:SetVisible(false)
		end

		PLUGIN.updates:SetVisible(false)
		PLUGIN.functions:SetVisible(false)
		PLUGIN.viewCrimeReports = vgui.Create("ixDatapadViewCrimeReports", PLUGIN.contentSubframe)
	end

	personalNotes.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		if IsValid(PLUGIN.searchProfiles) then
			PLUGIN.searchProfiles:SetVisible(false)
		end

		PLUGIN.updates:SetVisible(false)
		PLUGIN.functions:SetVisible(false)
		PLUGIN.viewPersonalNutes = vgui.Create("ixDatapadViewPersonalNotes", PLUGIN.contentSubframe)
	end

	local searchProfiles = self:Add("DButton")
	PLUGIN:CreateButton(searchProfiles, "wyszukaj profile danych obywateli")
	searchProfiles:DockMargin(0, 0 - SScaleMin(2 / 3), 0, SScaleMin(9 / 3))
	searchProfiles.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		PLUGIN.functions:SetVisible(false)
		PLUGIN.searchProfiles = vgui.Create("ixDatapadSearchProfiles", PLUGIN.contentSubframe)
	end

	local viewMyData = self:Add("DButton")
	PLUGIN:CreateButton(viewMyData, "wyświetl swój profil danych", ix.config.Get("datafileNoConnection"))
	viewMyData.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then errorNoConnection() return end

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		PLUGIN.updates:SetVisible(false)
		PLUGIN.functions:SetVisible(false)
		netstream.Start("OpenDatafile", nil, true)
	end

	local protectionTeams = self:Add("DButton")
	PLUGIN:CreateButton(protectionTeams, "protection teams", ix.config.Get("datafileNoConnection"))
	protectionTeams.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then errorNoConnection() return end

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		PLUGIN.updates:SetVisible(false)
		PLUGIN.functions:SetVisible(false)
		PLUGIN.clProtectionTeams = vgui.Create("ixDatapadProtectionTeams", PLUGIN.contentSubframe)
	end

	local characterFaction = LocalPlayer():GetCharacter():GetFaction()
	local activePermits = self:Add("DButton")
	PLUGIN:CreateButton(activePermits, "aktualne zezwolenia", ix.config.Get("datafileNoConnection"))
	activePermits.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then errorNoConnection() return end

		if (characterFaction != FACTION_WORKERS and characterFaction != FACTION_ADMIN and characterFaction != FACTION_SERVERADMIN and characterFaction != FACTION_OVERWATCH and !LocalPlayer():IsCombineRankAbove("i1")) then
			LocalPlayer():NotifyLocalized("Tylko CWU, CA i i1+ mają dostęp do tej funkcji.")
			return false
		end

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		PLUGIN.updates:SetVisible(false)
		PLUGIN.functions:SetVisible(false)
		PLUGIN.activePermits = vgui.Create("ixDatapadActivePermits", PLUGIN.contentSubframe)
	end

	local activeWages = self:Add("DButton")
	PLUGIN:CreateButton(activeWages, "aktualne płace/lojaliści", ix.config.Get("datafileNoConnection"))
	activeWages.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then errorNoConnection() return end

		if (characterFaction != FACTION_WORKERS and characterFaction != FACTION_ADMIN and characterFaction != FACTION_SERVERADMIN and characterFaction != FACTION_OVERWATCH and !LocalPlayer():IsCombineRankAbove("i1")) then
			LocalPlayer():NotifyLocalized("Tylko CWU, CA i i1+ mają dostęp do tej funkcji.")
			return false
		end

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		PLUGIN.updates:SetVisible(false)
		PLUGIN.functions:SetVisible(false)
		PLUGIN.activeWages = vgui.Create("ixDatapadActiveWages", PLUGIN.contentSubframe)
	end

	local apartments = self:Add("DButton")
	PLUGIN:CreateButton(apartments, "mieszkania/sklepy", ix.config.Get("datafileNoConnection"))
	apartments.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then errorNoConnection() return end

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		PLUGIN.updates:SetVisible(false)
		PLUGIN.functions:SetVisible(false)
		PLUGIN.apartments = vgui.Create("ixDatapadApartments", PLUGIN.contentSubframe)
	end
end

vgui.Register("ixDatapadFunctions", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	if (IsValid(ix.gui.protectionTeams)) then
		ix.gui.protectionTeams:Remove()
	end

	ix.gui.protectionTeams = self

	self.teams = {}
	self.teamSubpanels = {}

	self:SetSize(self:GetParent():GetSize())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local teamsTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(teamsTitleFrame, self, "protection teams")

	local teamsTitleSubframe = teamsTitleFrame:Add("EditablePanel")
	teamsTitleSubframe:SetSize(SScaleMin(108 / 3), 0)
	teamsTitleSubframe:Dock(RIGHT)
	teamsTitleSubframe.Paint = nil

	local back = teamsTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, teamsTitleSubframe, 87, "powrót", RIGHT)
	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	self.teamsPanel = self:Add("ixHelpMenuCategories")
	self.teamsPanel:Dock(LEFT)
	self.teamsPanel.Paint = nil
	self.teamsPanel:DockPadding(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), SScaleMin(10 / 3))
	self.teamsPanel.Paint = function(_, w, h)
		surface.SetDrawColor(Color(150, 150, 150, 20))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/tabmenu/crafting/box_pattern.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	local divider = self:Add("DShape")
	divider:SetType( "Rect" )
	divider:SetWide( 1 )
	divider:Dock(LEFT)
	divider:SetColor(color)
	divider:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))

	self.membersPanel = self:Add("Panel")
	self.membersPanel:Dock(FILL)
	self.membersPanel:DockPadding(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), SScaleMin(10 / 3))

	local title = self.teamsPanel:Add("DLabel")
	title:SetFont("TitlesFontNoClamp")
	title:SetText(string.utf8upper("Teamy"))
	title:SetContentAlignment(5)
	title:SizeToContents()
	title:SetTextColor(color)
	title:DockMargin(0, 0, 0, SScaleMin(10 / 3))
	title:Dock(TOP)

	local title2 = self.membersPanel:Add("DLabel")
	title2:SetFont("TitlesFontNoClamp")
	title2:SetText(string.utf8upper("Członkowe Teamów"))
	title2:SetContentAlignment(5)
	title2:SizeToContents()
	title2:SetTextColor(color)
	title2:DockMargin(0, 0, 0, SScaleMin(10 / 3))
	title2:Dock(TOP)

	self.memberScroll = self.membersPanel:Add("DScrollPanel")
	self.memberScroll:Dock(FILL)

	self.teamScroll = self.teamsPanel:Add("DScrollPanel")
	self.teamScroll:Dock(FILL)

	self:CreateButtons()
end

function PANEL:CreateButtons()
	if !self then self = ix.gui.protectionTeams end
	local teams = {}
	if (PLUGIN.teams and !table.IsEmpty(PLUGIN.teams)) then
		for k, v in pairs(PLUGIN.teams) do
			teams[k] = function(container)
				local memberList = {}

				for k2, v2 in pairs(v["members"]) do
					if (!IsValid(v2)) then table.remove(v["members"], k2) continue end

					if (v2:GetNetVar("ProtectionTeamOwner")) then
						memberList[#memberList + 1] = {
							client = v2,
							owner = 1
						}
					else
						memberList[#memberList + 1] = {
							client = v2,
							owner = 99
						}
					end
				end

				for _, v2 in SortedPairsByMemberValue(memberList, "owner", false) do
					local member = self.memberScroll:Add("ixMenuButton")
					member:SetFont("MenuFontBoldNoClamp")
					member:SetText(v2.client:Name() or "Nieznany")
					member:SizeToContents()
					member:Dock(TOP)
					member.Paint = function(this, width, height)
						derma.SkinFunc("DrawImportantBackground", 0, 0, width, height, ColorAlpha(this.backgroundColor, this.currentBackgroundAlpha))
					end

					member.DoRightClick = function(this)
						if ((!LocalPlayer():IsDispatch()) and (!LocalPlayer():GetNetVar("ProtectionTeamOwner") or LocalPlayer():GetNetVar("ProtectionTeam") != k)) then return end

						local interactMenu = DermaMenu(this)
						local member1 = interactMenu:AddOption(v2.client:Name())
						member1:SetContentAlignment(5)
						member1.Paint = function(_, width, height) end

						local spacer = interactMenu:AddSpacer()
						spacer.Paint = function(_, width, height)
							surface.SetDrawColor( Color( 255, 255, 255, 100 ) )
							surface.DrawRect( 0, 0, width, height )
						end

						interactMenu:AddOption(L("TeamTransferOwner"), function()
							ix.command.Send("PTLead", v2.client:Name())
						end):SetIcon( "icon16/award_star_gold_1.png" )

						interactMenu:AddOption(L("TeamKickMember"), function()
							ix.command.Send("PTKick", v2.client:Name())
						end):SetIcon( "icon16/cross.png" )

						interactMenu:Open()
						this.Menu = interactMenu
						for _, v3 in pairs(interactMenu:GetChildren()[1]:GetChildren()) do
							if v3:GetClassName() == "Label" then
								v3:SetFont("MenuFontNoClamp")
							end
						end
					end

					if (v2.client:GetNetVar("ProtectionTeamOwner")) then
						member.backgroundColor = Color(50,150,100)
					end
				end
			end
		end
	end

	for k, v in pairs(teams) do
		self:AddTeam(k)
		self.teams[k] = v
	end

	self.createButton = self.teamsPanel:Add("ixMenuButton")
	self.createButton:SetText("tabCreateTeam")
	self.createButton:SizeToContents()
	self.createButton:SetZPos(-99)
	self.createButton:Dock(BOTTOM)
	self.createButton.DoClick = function()
		ix.command.Send("PTCreate")
	end

	self.teamsPanel:SetWide(self:GetWide() * 0.5)

	if (LocalPlayer():GetNetVar("ProtectionTeam")) then
		if (IsValid(self.createButton)) then
			self.createButton:Remove()
		end

		self.leaveButton = self.membersPanel:Add("ixMenuButton")
		self.leaveButton:SetText("tabLeaveTeam")
		self.leaveButton:SizeToContents()
		self.leaveButton:Dock(BOTTOM)
		self.leaveButton.DoClick = function()
			ix.command.Send("PTLeave")
		end
	end

	if (self.teams[ix.gui.lastTeamMenuTab] or LocalPlayer():GetNetVar("ProtectionTeam")) then
		local lastTab = self.teams[ix.gui.lastTeamMenuTab] and ix.gui.lastTeamMenuTab or LocalPlayer():GetNetVar("ProtectionTeam")
		self:OnCategorySelected(lastTab)
	end
end


function PANEL:AddTeam(name)
	local button = self.teamScroll:Add("ixMenuButton")
	button:SetText(L("TeamName", name))
	button:SetBackgroundColor(ix.config.Get("color"))
	button.backgroundAlpha = 255
	button:SizeToContents()
	button:Dock(TOP)
	button.DoClick = function(this)
		self:OnCategorySelected(name)
		PLUGIN:UpdateTeamMenu()
	end
	button.DoRightClick = function(this)
		if ((LocalPlayer():GetNetVar("ProtectionTeam") != name or !LocalPlayer():GetNetVar("ProtectionTeamOwner")) and !LocalPlayer():IsDispatch()) then return end

		local reassignMenu = DermaMenu(this)

		reassignMenu:AddOption(L("TeamReassign"), function()
			Derma_StringRequest(L("cmdPTReassign"), L("cmdReassignPTDesc"), name, function(text) ix.command.Send("PTReassign", text, name) end)
		end)

		reassignMenu:Open()
		this.Menu = reassignMenu
	end

	local panel = self.teamScroll:Add("DScrollPanel")
	panel:SetVisible(false)
	panel:Dock(FILL)

	-- reverts functionality back to a standard panel in the case that a category will manage its own scrolling
	panel.DisableScrolling = function()
		panel:GetCanvas():SetVisible(false)
		panel:GetVBar():SetVisible(false)
		panel.OnChildAdded = function() end
	end

	button.Paint = function(this, width, height)
		local alpha = panel:IsVisible() and this.backgroundAlpha or this.currentBackgroundAlpha
		surface.SetDrawColor(ColorAlpha(ix.config.Get("color"), alpha))
		surface.DrawRect(0, 0, width, height)
	end

	self.teamSubpanels[name] = panel

	return button
end

function PANEL:OnCategorySelected(name)
	local panel = self.teamSubpanels[name]

	if (!IsValid(panel)) then
		return
	end

	if (!panel.bPopulated) then
		self.teams[name](panel)
		panel.bPopulated = true
	end

	if (IsValid(self.activeTeam)) then
		self.activeTeam:SetVisible(false)
	end

	panel:SetVisible(true)

	self.activeTeam = panel
	ix.gui.lastTeamMenuTab = name

	self:OnTeamSelected(name)
end

function PANEL:OnTeamSelected(index)
	if (LocalPlayer():GetNetVar("ProtectionTeam") != index and !LocalPlayer():GetNetVar("ProtectionTeam")) then
		if (IsValid(self.joinButton)) then
			self.joinButton:Remove()
		end

		self.joinButton = self.membersPanel:Add("ixMenuButton")
		self.joinButton:SetText("tabJoinTeam")
		self.joinButton:SizeToContents()
		self.joinButton:Dock(BOTTOM)
		self.joinButton.DoClick = function(this)
			ix.command.Send("PTJoin", index)
		end
	end
end

vgui.Register("ixDatapadProtectionTeams", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), SScaleMin(247 / 3))
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(32 / 3))
	self.Paint = nil

	local searchProfilesTitleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(searchProfilesTitleFrame, self, "wyszukiwanie profili")

	local searchTitleSubframe = searchProfilesTitleFrame:Add("EditablePanel")
	searchTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
	searchTitleSubframe:Dock(RIGHT)
	searchTitleSubframe.Paint = nil

	self.search = searchTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.search, searchTitleSubframe, 87, "szukaj", RIGHT)

	self.topDivider = PLUGIN:DrawDividerLine(searchTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	self.back = searchTitleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.back, searchTitleSubframe, 87, "powrót", RIGHT)
	self.back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.functions:SetVisible(true)
	end

	local noConnection2 = self:Add("DLabel")
	self.noConnection2 = noConnection2
	noConnection2:SetHeight(SScaleMin(46 / 3))
	noConnection2:SetContentAlignment(4)
	noConnection2:SetTextInset(SScaleMin(20 / 3), 0)
	noConnection2:Dock(TOP)
	noConnection2:SetFont("TitlesFontNoClamp")
	noConnection2:DockMargin(0, 0, 0, SScaleMin(9 / 3))
	noConnection2:SetText(string.utf8upper("BŁĄD: BRAK POŁĄCZENIA"))
	noConnection2.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 0, 0, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow-off.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end
	noConnection2:SetVisible(false)

	local contentFrame = self:Add("EditablePanel")
	contentFrame:SetSize(self:GetWide(), self:GetParent():GetTall())
	contentFrame:Dock(TOP)
	contentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	contentFrame.Paint = function(self, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h)
	end

	local nameText = contentFrame:Add("DLabel")
	nameText:SetFont("MenuFontNoClamp")
	nameText:SetTextColor(color)
	nameText:SetText(string.utf8upper("Imię lub CID:"))
	nameText:Dock(TOP)
	nameText:SetZPos(1)
	nameText:DockMargin(SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3))

	self.name = contentFrame:Add("DTextEntry")
	self.name:Dock(TOP)
	self.name:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
	self.name:SetMultiline(false)
	self.name:RequestFocus()
	self.name:SetEnterAllowed(true)
	self.name:SetFont("MenuFontNoClamp")
	self.name:SetTall(SScaleMin(20 / 3))
	self.name:SetVerticalScrollbarEnabled( false )
	self.name:SetTextColor( color )
	self.name:SetZPos(2)
	self.name:SetCursorColor( color )
	self.name.Paint = function(self, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h)

		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
	end

	self.name.OnEnter = function()
		if (ix.config.Get("datafileNoConnection")) then
			LocalPlayer():NotifyLocalized("Błąd: brak połączenia!")
			surface.PlaySound("hl1/fvox/buzz.wav")
			noConnection2:SetVisible(true)
			return
		end

		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		netstream.Start("OpenDatafile", self.name:GetText(), false)
	end

	self.search.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then
			LocalPlayer():NotifyLocalized("Błąd: brak połączenia!")
			surface.PlaySound("hl1/fvox/buzz.wav")
			noConnection2:SetVisible(true)
			return
		end

		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		netstream.Start("OpenDatafile", self.name:GetText(), false)
	end

	PLUGIN.searchEntry = self.name
	PLUGIN.searchButton = self.search
end

vgui.Register("ixDatapadSearchProfiles", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	ix.gui.activePermitsDatapad = self

	self:Dock(FILL)
	self.Paint = nil

	local activePermitsFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(activePermitsFrame, self, "aktualne zezwolenia")

	local activePermitsSubframe = activePermitsFrame:Add("EditablePanel")
	activePermitsSubframe:SetSize(SScaleMin(108 / 3), 0)
	activePermitsSubframe:Dock(RIGHT)
	activePermitsSubframe.Paint = nil

	local back = activePermitsSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, activePermitsSubframe, 87, "powrót", RIGHT)
	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	self.content = self:Add("DScrollPanel")
	self.content:Dock(FILL)

	self:GetUpdates()
end

function PANEL:CreateActivePermits(activePermitsList)
	for _, v in pairs(activePermitsList) do
		local dropdown = self.content:Add("DCollapsibleCategory")
		dropdown:SetLabel("")
		dropdown:SetExpanded( false )
		dropdown:Dock(TOP)
		dropdown:GetChildren()[1]:SetHeight(SScaleMin(30 / 3))
		dropdown.Paint = function(this, w, h)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)

			if dropdown:GetExpanded() then
				surface.SetDrawColor(color_white)
				surface.SetMaterial( ix.util.GetMaterial("willardnetworks/tabmenu/crafting/minus.png"))
				surface.DrawTexturedRect(SScaleMin(480 / 3) - SScaleMin(15 / 3) - (self.content:GetVBar():IsVisible() and SScaleMin(10 / 3) * 2 or SScaleMin(10 / 3)), SScaleMin(30 / 3) * 0.5 - SScaleMin(15 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(15 / 3))
			else
				surface.SetDrawColor(color_white)
				surface.SetMaterial( ix.util.GetMaterial("willardnetworks/tabmenu/crafting/plus.png"))
				surface.DrawTexturedRect(SScaleMin(480 / 3) - SScaleMin(15 / 3) - (self.content:GetVBar():IsVisible() and SScaleMin(10 / 3) * 2 or SScaleMin(10 / 3)), SScaleMin(30 / 3) * 0.5 - SScaleMin(15 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(15 / 3))
			end
		end

		local coverPanel = vgui.Create("DShape", dropdown)
		coverPanel:SetSize(SScaleMin(480 / 3), SScaleMin(30 / 3))
		coverPanel:SetColor(Color(100, 100, 100, 10))
		coverPanel:SetType("Rect")

		local categoryTitle = vgui.Create("DLabel", dropdown)
		categoryTitle:SetText(v.name.. " | #"..v.cid)
		categoryTitle:SetFont("MenuFontLargerBoldNoFix")
		categoryTitle:SetColor(color)
		categoryTitle:SizeToContents()
		categoryTitle:SetPos(SScaleMin(10 / 3), (SScaleMin(30 / 3) * 0.5) - (categoryTitle:GetTall() * 0.5))

		local categoryList = vgui.Create("Panel", dropdown)
		categoryList:Dock(FILL)
		dropdown:SetContents(categoryList)
		categoryList.Paint = function(self, w, h)
			surface.SetDrawColor(color)
			surface.DrawLine(0, 0, w, 0)
		end

		for k2, v2 in pairs(v.permits) do
			if !isbool(v2) and v2 <= os.time() then
				continue
			end

			local permitPanel = categoryList:Add("Panel")
			permitPanel:Dock(TOP)
			permitPanel:SetTall(SScaleMin(30 / 3))

			categoryList:DockMargin(0, 0, 0, 0 - SScaleMin(30 / 3))

			local permitName = permitPanel:Add("DLabel")
			permitName:Dock(LEFT)
			permitName:SetText(Schema:FirstToUpper(k2))
			permitName:SetFont("MenuFontBoldNoClamp")
			permitName:SetColor(color)
			permitName:SizeToContents()
			permitName:DockMargin(SScaleMin(10 / 3), 0, 0, 0)

			local disable = permitPanel:Add("DButton")
			disable:Dock(RIGHT)
			disable:SetWide(SScaleMin(100 / 3))
			disable:SetText("WYŁĄCZ")
			disable:SetFont("MenuFontBoldNoClamp")
			disable.Paint = function(self, w, h)
				surface.SetDrawColor(color_white)
				surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/licensedisabled2.png"))
				surface.DrawTexturedRect(0, 0, w, h)
			end

			disable.DoClick = function()
				permitPanel:Remove()

				local genericdata = v
				genericdata.permits[k2] = nil
				netstream.Start("RemovePermitDatapad", genericdata, "permit")
				surface.PlaySound("willardnetworks/datapad/navigate.wav")

				if #categoryList:GetChildren() == 1 then
					dropdown:Remove()
				end
			end

			local endDate = permitPanel:Add("DLabel")
			endDate:Dock(RIGHT)
			if isbool(v2) then
				endDate:SetText("DATA WYGAŚNIĘCIA: BRAK")
			else
				endDate:SetText("DATA WYGAŚNIĘCIA: "..os.date( "%d/%m/%Y" , v2 ))
			end

			endDate:SetFont("MenuFontBoldNoClamp")
			endDate:SetColor(Color(51, 243, 36, 255))
			endDate:SizeToContents()
			endDate:DockMargin(0, 0, SScaleMin(10 / 3), 0)
		end
	end
end

function PANEL:GetUpdates()
	netstream.Start("GetActivePermitsDatapad")
end

vgui.Register("ixDatapadActivePermits", PANEL, "EditablePanel")

netstream.Hook("CreateActivePermitsDatapad", function(permits)
	if !IsValid(ix.gui.activePermitsDatapad) then
		return
	end

	ix.gui.activePermitsDatapad:CreateActivePermits(permits)
end)

netstream.Hook("CreateActiveShopPermitsDatapad", function(permits)
	if !IsValid(ix.gui.shopPermits) then
		return
	end
	ix.gui.shopPermits:CreateActivePermits(permits)
end)

PANEL = {}

function PANEL:Init()
	ix.gui.activeWagesDatapad = self

	self:Dock(FILL)
	self.Paint = nil

	local activeWagesFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(activeWagesFrame, self, "płace")

	local activeWagesSubframe = activeWagesFrame:Add("EditablePanel")
	activeWagesSubframe:SetSize(SScaleMin(108 / 3), 0)
	activeWagesSubframe:Dock(RIGHT)
	activeWagesSubframe.Paint = nil

	self.decrementWages, self.incrementWages = activeWagesFrame:Add("DButton"), activeWagesFrame:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.incrementWages, activeWagesSubframe, 87, "nast. strona", RIGHT)
	self.incrementWages:SetZPos(1)
	PLUGIN:CreateTitleFrameRightTextButton(self.decrementWages, activeWagesSubframe, 87, "poprz. strona", RIGHT)
	self.decrementWages:SetZPos(2)
	self.incrementWages:DockMargin(SScaleMin(20 / 3), 0, 0 - SScaleMin(3 / 3), SScaleMin(6 / 3))

	self.curCollect = 0
	self.nextClick = CurTime()

	self.decrementWages.DoClick = function()
		if self.nextClick > CurTime() then return end

		self.wagesContent:Clear()
		self.loyalistsContent:Clear()
		self.curCollect = math.max(self.curCollect - 5, 0)
		self:GetUpdates(self.curCollect)

		self.nextClick = CurTime() + 1
	end

	self.incrementWages.DoClick = function()
		if self.nextClick > CurTime() then return end

		self.wagesContent:Clear()
		self.loyalistsContent:Clear()
		self.curCollect = self.curCollect + 5
		self:GetUpdates(self.curCollect)

		self.nextClick = CurTime() + 1
	end

	local back = activeWagesSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, activeWagesSubframe, 87, "powrót", RIGHT)
	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	self.wagesContent = self:Add("DScrollPanel")
	self.wagesContent:Dock(TOP)
	self.wagesContent:SetTall(self:GetParent():GetTall() * 0.5 - activeWagesFrame:GetTall())
	self.wagesContent:DockMargin(0, 0, 0, SScaleMin(10 / 3))

	local activeLoyalistsFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(activeLoyalistsFrame, self, "lojaliści")

	local activeLoyalistsSubframe = activeLoyalistsFrame:Add("EditablePanel")
	activeLoyalistsSubframe:SetSize(SScaleMin(108 / 3), 0)
	activeLoyalistsSubframe:Dock(RIGHT)
	activeLoyalistsSubframe.Paint = nil

	self.loyalistsContent = self:Add("DScrollPanel")
	self.loyalistsContent:Dock(FILL)

	self.decrementLoyalists, self.incrementLoyalists = activeLoyalistsFrame:Add("DButton"), activeLoyalistsFrame:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.incrementLoyalists, activeLoyalistsSubframe, 87, "nast. strona", RIGHT)
	self.incrementLoyalists:SetZPos(1)
	PLUGIN:CreateTitleFrameRightTextButton(self.decrementLoyalists, activeLoyalistsSubframe, 87, "poprz. strona", RIGHT)
	self.decrementLoyalists:SetZPos(2)
	self.incrementLoyalists:DockMargin(SScaleMin(20 / 3), 0, 0 - SScaleMin(3 / 3), SScaleMin(6 / 3))

	self.decrementLoyalists.DoClick = self.decrementWages.DoClick
	self.incrementLoyalists.DoClick = self.incrementWages.DoClick

	self:GetUpdates(self.curCollect)
end

function PANEL:GetUpdates(curCollect)
	netstream.Start("GetActiveWagesDatapad", curCollect)
end

function PANEL:CreateActiveWages(wages, loyalists)
	self:CreateActivePanels(wages, self.wagesContent)
	self:CreateActivePanels(loyalists, self.loyalistsContent)
end

function PANEL:CreateActivePanels(table, parent)
	local counter = 0
	for _, data in SortedPairsByMemberValue(table, "socialCredits", true) do
		data.socialCredits = !data.combine and math.Clamp(tonumber(data.socialCredits), 0, 200) or tonumber(data.socialCredits)
		counter = counter + 1
		local wagesPanel = parent:Add("Panel")
		wagesPanel:Dock(TOP)
		wagesPanel:SetTall(SScaleMin(30 / 3))
		if counter % 2 == 0 then
			wagesPanel.Paint = function(self, w, h)
				surface.SetDrawColor(40, 88, 115, 75)
				surface.DrawRect(0, 0, w, h)
			end
		else
			wagesPanel.Paint = function(self, w, h)
				surface.SetDrawColor(0, 0, 0, 75)
				surface.DrawRect(0, 0, w, h)
			end
		end

		local wagesContent = "PŁACE: "..data.wages
		local loyalistContent = "SK: "..data.socialCredits.." | "..data.loyaltyStatus
		local wagesName = wagesPanel:Add("DLabel")
		wagesName:Dock(LEFT)
		wagesName:SetText(data.name.." | #"..data.cid.." | "..(parent == self.wagesContent and wagesContent or loyalistContent))
		wagesName:SetFont("MenuFontBoldNoClamp")
		wagesName:SetColor(color)
		wagesName:SizeToContents()
		wagesName:DockMargin(SScaleMin(10 / 3), 0, 0, 0)

		if parent == self.loyalistsContent and data.loyaltyStatus == "BRAK" then continue end

		local disable = wagesPanel:Add("DButton")
		disable:Dock(RIGHT)
		disable:SetWide(SScaleMin(135 / 3))
		disable:SetText(parent == self.wagesContent and "USUŃ PŁACĘ" or "USUŃ STATUS")
		disable:SetFont("MenuFontBoldNoClamp")
		disable.Paint = function(self, w, h)
			surface.SetDrawColor(color_white)
			surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/licensedisabled2.png"))
			surface.DrawTexturedRect(0, 0, w, h)
		end

		disable.DoClick = function()
			local genericdata = data
			if parent == self.loyalistsContent then
				if genericdata.loyaltyStatus != "BRAK" and genericdata.socialCredits < 200 then
					wagesPanel:Remove()
				end

				if genericdata.loyaltyStatus != "BRAK" and genericdata.socialCredits >= 200 then
					disable:Remove()
				end
			end

			if parent == self.wagesContent then
				genericdata.wages = 0
			else
				genericdata.loyaltyStatus = "BRAK"
			end

			if wagesName and IsValid(wagesName) and parent == self.loyalistsContent then
				wagesName:SetText(data.name.." | #"..data.cid.." | SK: "..data.socialCredits.." | "..data.loyaltyStatus)
			end

			netstream.Start("RemovePermitDatapad", genericdata, parent == self.wagesContent)
			if self.wagesContent and IsValid(self.wagesContent) then
				self.wagesContent:Clear()
			end

			if self.loyalistsContent and IsValid(self.loyalistsContent) then
				self.loyalistsContent:Clear()
			end
			self:GetUpdates(self.curCollect)

			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end
	end
end

vgui.Register("ixDatapadActiveWages", PANEL, "EditablePanel")

net.Receive("CreateActiveWagesDatapad", function()
	local wages = net.ReadTable()
	local loyalists = net.ReadTable()

	if !ix.gui.activeWagesDatapad then return end
	if !IsValid(ix.gui.activeWagesDatapad) then return end

	ix.gui.activeWagesDatapad:CreateActiveWages(wages, loyalists)
end)

PANEL = {}

function PANEL:Init()
	ix.gui.apartments = self

	self:Dock(FILL)
	self.Paint = nil

	self.apartmentsFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(self.apartmentsFrame, self, "mieszkania")

	local apartmentsSubframe = self.apartmentsFrame:Add("EditablePanel")
	apartmentsSubframe:SetSize(SScaleMin(108 / 3), 0)
	apartmentsSubframe:Dock(FILL)
	apartmentsSubframe.Paint = nil

	self.back = apartmentsSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.back, apartmentsSubframe, 87, "powrót", RIGHT)
	self.back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end
	self.back:SetZPos(1)

	self.content = self:Add("DScrollPanel")
	self.content:Dock(FILL)

	self.apartmentButtons = {}

	self.decrementApartments, self.incrementApartments = apartmentsSubframe:Add("DButton"), apartmentsSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.incrementApartments, apartmentsSubframe, 87, "nast. strona", RIGHT)
	self.incrementApartments:SetZPos(2)
	PLUGIN:CreateTitleFrameRightTextButton(self.decrementApartments, apartmentsSubframe, 87, "poprz. strona", RIGHT)
	self.decrementApartments:SetZPos(3)
	self.incrementApartments:DockMargin(SScaleMin(20 / 3), 0, 0 - SScaleMin(3 / 3) + SScaleMin(20 / 3), SScaleMin(6 / 3))

	self.curCollect = 5
	self.nextClick = CurTime()

	self.decrementApartments.DoClick = function()
		if self.nextClick > CurTime() then return end

		self.curCollect = math.max(self.curCollect - 5, 5)
		self:GetApartments(self.curCollect)

		self.nextClick = CurTime() + 1
	end

	self.incrementApartments.DoClick = function()
		if self.nextClick > CurTime() then return end

		self.curCollect = self.curCollect + 5
		self:GetApartments(self.curCollect)

		self.nextClick = CurTime() + 1
	end

	self:GetApartments(self.curCollect)
end

function PANEL:RevertBackToNormal()
	self.back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	self.apartmentsFrame:GetChildren()[1]:SetText("MIESZKANIA")
	self.apartmentsFrame:GetChildren()[1]:SizeToContents()
end

function PANEL:GetApartments()
	netstream.Start("RequestApartmentNamesDatapad", self.curCollect)
end

function PANEL:CreateDividerPart(parent, text, bDockRight, bShouldRightSpace)
	local panel = parent:Add("Panel")
	panel:Dock(bDockRight and RIGHT or LEFT)
	panel.Think = function()
		panel:DockMargin(0, 0, bShouldRightSpace and ((self.viewWidth or 0) + SScaleMin(20 / 3)) or 0, 0)
	end

	panel.Paint = function(_, w, h)
		surface.SetDrawColor(color)
		surface.DrawLine(w - 1, SScaleMin(5 / 3), w - 1, h - SScaleMin(5 / 3))
	end

	local label = panel:Add("DLabel")
	label:SetText(text and string.upper(text) or "")
	label:SetFont("MenuFontBoldNoClamp")
	label:SetContentAlignment(5)
	label:SizeToContents()
	label:Dock(FILL)

	panel:SetSize(label:GetWide() + SScaleMin(20 / 3), parent:GetTall())

	return panel
end

function PANEL:ClearContent()
	self.content:Clear()

	if IsValid(self.content2) and IsValid(self.shopsFrame) then
		self.shopsFrame:Remove()
		self.content2:Remove()
	end
end

function PANEL:CreateApartments(apartments, callback, bShops)
	local dividerPanel = vgui.Create("Panel", !bShops and self.content or (IsValid(self.content2) and self.content2 or self.content))
	dividerPanel:Dock(TOP)
	dividerPanel:SetTall(SScaleMin(30 / 3))
	dividerPanel.Paint = function(self, w, h)
		surface.SetDrawColor(40, 88, 115, 150)
		surface.DrawRect(0, 0, w, h)
	end

	local name = self:CreateDividerPart(dividerPanel, "nazwa")
	local tenantAmount = self:CreateDividerPart(dividerPanel, "najemcy", true, true)
	local rentDue = self:CreateDividerPart(dividerPanel, "należny czynsz", true)
	local rent = self:CreateDividerPart(dividerPanel, "czynsz", true)

	local osDateWidth = 0

	local counter = 0
	for appID, tApartment in SortedPairsByMemberValue(apartments, "name") do
		counter = counter + 1
		local apartmentsPanel = vgui.Create("EditablePanel", !bShops and self.content or (IsValid(self.content2) and self.content2 or self.content))
		apartmentsPanel:Dock(TOP)
		apartmentsPanel:SetTall(SScaleMin(30 / 3))
		if counter % 2 == 0 then
			apartmentsPanel.Paint = function(self, w, h)
				surface.SetDrawColor(40, 88, 115, 75)
				surface.DrawRect(0, 0, w, h)
			end
		else
			apartmentsPanel.Paint = function(self, w, h)
				surface.SetDrawColor(0, 0, 0, 75)
				surface.DrawRect(0, 0, w, h)
			end
		end

		local view = apartmentsPanel:Add("DButton")
		view:Dock(RIGHT)
		view:SetText("WYŚWIETL")
		view:SetFont("MenuFontBoldNoClamp")
		view:SizeToContents()
		view:DockMargin(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), 0)
		view.Paint = nil
		view.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
			self:ViewSingleApartment(appID, tApartment, apartments)
			if self.decrementApartments and IsValid(self.decrementApartments) then
				self.decrementApartments:SetVisible(false)
			end

			if self.incrementApartments and IsValid(self.incrementApartments) then
				self.incrementApartments:SetVisible(false)
			end
		end

		local actualName = self:CreateDividerPart(apartmentsPanel, string.len(tApartment.name) < 18 and tApartment.name or string.Left(tApartment.name, 18).."...")
		actualName:Dock(FILL)

		local actualTenantAmount = self:CreateDividerPart(apartmentsPanel, table.Count(tApartment.tenants), true)
		actualTenantAmount:SetWide(tenantAmount:GetWide())
		actualTenantAmount:GetChildren()[1]:Center()

		local actualRentDue = self:CreateDividerPart(apartmentsPanel, os.date("%d/%m/%Y", tApartment.rentDue), true)
		osDateWidth = actualRentDue:GetWide()

		local actualRent = self:CreateDividerPart(apartmentsPanel, tApartment.rent, true)
		actualRent:SetWide(rent:GetWide())
		actualRent:GetChildren()[1]:Center()

		self.viewWidth = view:GetWide()
		self.apartmentButtons[appID] = view
	end

	rentDue:SetWide(osDateWidth)

	name:GetChildren()[1]:Center()
	name:Dock(FILL)

	if (callback) then
		callback(!bShops and self.content or (IsValid(self.content2) and self.content2 or self.content), PLUGIN)
	end
end

function PANEL:ViewSingleApartment(appID, tApartment, apartments)
	self:ClearContent()
	if IsValid(self.apartmentsFrame) then
		self.apartmentsFrame:GetChildren()[1]:SetText(string.upper((string.len(tApartment.name) > 30 and string.Left(tApartment.name, 27).."..." or tApartment.name).." | "..(tApartment.type or "")))
		self.apartmentsFrame:GetChildren()[1]:SizeToContents()
	end

	self.content:Dock(FILL)
	self.content:DockMargin(0, 0, 0, 0)

	if IsValid(self.back) then
		self.back.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/back.wav")
			self:GetApartments(self.curCollect)
			self:RevertBackToNormal()

			if self.incrementApartments and IsValid(self.incrementApartments) then
				self.incrementApartments:SetVisible(true)
			end

			if self.decrementApartments and IsValid(self.decrementApartments) then
				self.decrementApartments:SetVisible(true)
			end
		end
	end

	local rent = self.content:Add("EditablePanel")
	PLUGIN:CreateRow(rent, "czynsz", tApartment.rent, false, true)
	local edit = self:CreateBottomOrTopTextOrButton(rent.bottom, "EDYTUJ", false, true)
	edit.DoClick = function()
		Derma_StringRequest("Zmień czynsz", "Zmienia wymagany czynsz za mieszkanie.", tApartment.rent, function(text)
			netstream.Start("ApartmentUpdateRent", appID, tonumber(text))
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end)

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
	end

	local individualRent = self.content:Add("EditablePanel")
	PLUGIN:CreateRow(individualRent, "czynsz indywidualny", table.Count(tApartment.tenants) == 0 and "0" or (math.ceil(tApartment.rent / table.Count(tApartment.tenants))))

	local housing = ix.plugin.list["housing"]
	if housing and housing.GetRemainingRent then
		local rentRemaining = self.content:Add("EditablePanel")
		PLUGIN:CreateRow(rentRemaining, "pozostały czynsz", housing:GetRemainingRent(tApartment), false, true)
	end

	local rentDue = self.content:Add("EditablePanel")
	PLUGIN:CreateRow(rentDue, "czynsz należny do", os.date("%H:%M:%S - %d/%m/%Y", tApartment.rentDue), false, IsValid(housing) and true or false)

	local extendRent = self:CreateBottomOrTopTextOrButton(rentDue.bottom, "PRZEDŁUŻ", false, true)
	extendRent.DoClick = function()
		Derma_StringRequest("Przedłuż terminu płatności czynszu", "O ile dni?", 0, function(text)
			netstream.Start("ApartmentExtendRentDueDateByDays", appID, tonumber(text))
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end)

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
	end

	local tenantsTitle = self.content:Add("EditablePanel")
	PLUGIN:CreateTitle(tenantsTitle, self.content, "najemcy".." | ".."NIEPRZYPISYWANIE: "..((tApartment.noAssign == true and "TAK" or "NIE") or ""))
	tenantsTitle:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))

	local addTenant = self:CreateBottomOrTopTextOrButton(tenantsTitle, "DODAJ NAJEMCĘ", false, true)
	addTenant:DockMargin(0, 0, -SScaleMin(3 / 3), SScaleMin(10 / 3))
	addTenant.DoClick = function()
		Derma_StringRequest("Wprowadź CID", "Wprowadź CID osoby którą chcesz dodać do mieszkania.", "", function(text)
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
			netstream.Start("AddTenant", appID, tonumber(text))
		end)

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
	end

	local tenantsFrame = self.content:Add("DScrollPanel")
	tenantsFrame:Dock(TOP)
	tenantsFrame:SetTall(rentDue:GetTall() * 3)

	local counter = 0
	for cid, tTenant in pairs(tApartment.tenants) do
		if istable(cid) then cid = tonumber(cid) end
		counter = counter + 1

		local cidLabel = tenantsFrame:Add("EditablePanel")
		PLUGIN:CreateRow(cidLabel, "cid | id klucza | autopłatność", (!cid and "N/A" or cid).." | "..(tTenant.key == true and "OCZEKUJĄCE ID KLUCZA" or tTenant.key or "N/A").." | "..((tTenant.autoPay and tTenant.autoPay == true and "PRAWDA" or "FAŁSZ") or ""), false, counter % 2 == 0 and true or false)

		local remove = self:CreateBottomOrTopTextOrButton(cidLabel.bottom, "USUŃ", false, true)
		remove.DoClick = function()
			if !cid then return end
			cidLabel:Remove()
			netstream.Start("RemoveTenant", cid, appID)
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end

		if !cid then return end
		if (tTenant.key != true) then
			local renewKey = self:CreateBottomOrTopTextOrButton(cidLabel.bottom, "ODNÓW KLUCZ |", false, true)
			renewKey:DockMargin(0, 0, 0, 0)
			renewKey.DoClick = function()
				netstream.Start("RenewKey", cid, appID)
				surface.PlaySound("willardnetworks/datapad/navigate.wav")
			end
		end
	end

	if tApartment.type == "shop" then
		local employeesTitle = self.content:Add("EditablePanel")
		PLUGIN:CreateTitle(employeesTitle, self.content, "pracownicy")
		employeesTitle:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))

		local addEmployee = self:CreateBottomOrTopTextOrButton(employeesTitle, "DODAJ PRACOWNIKA", false, true)
		addEmployee:DockMargin(0, 0, -SScaleMin(3 / 3), SScaleMin(10 / 3))
		addEmployee.DoClick = function()
			Derma_StringRequest("Wprowadź CID", "Wprowadź CID osoby którą chcesz dodać do sklepu.", "", function(text)
				surface.PlaySound("willardnetworks/datapad/navigate.wav")
				netstream.Start("AddEmployee", appID, tonumber(text))
			end)

			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end

		local employeeFrame = self.content:Add("DScrollPanel")
		employeeFrame:Dock(TOP)
		employeeFrame:SetTall(rentDue:GetTall() * 3)

		local eCounter = 0
		for cid, tEmployee in pairs(tApartment.employees) do
			if istable(cid) then cid = tonumber(cid) end
			eCounter = eCounter + 1

			local cidLabel = employeeFrame:Add("EditablePanel")
			PLUGIN:CreateRow(cidLabel, "cid | id klucza ", (!cid and "N/A" or cid).." | "..(tEmployee.key == true and "OCZEKUJĄCY ID KLUCZA" or tEmployee.key or "N/A") , false, eCounter % 2 == 0 and true or false)

			local remove = self:CreateBottomOrTopTextOrButton(cidLabel.bottom, "REMOVE", false, true)
			remove.DoClick = function()
				if !cid then return end
				cidLabel:Remove()
				netstream.Start("RemoveEmployee", cid, appID)
				surface.PlaySound("willardnetworks/datapad/navigate.wav")
			end

			if !cid then return end
			if (tEmployee.key != true) then
				local renewKey = self:CreateBottomOrTopTextOrButton(cidLabel.bottom, "ODNÓW KLUCZ |", false, true)
				renewKey:DockMargin(0, 0, 0, 0)
				renewKey.DoClick = function()
					netstream.Start("RenewKey", cid, appID, true)
					surface.PlaySound("willardnetworks/datapad/navigate.wav")
				end
			end
		end
	end

	local paymentsTitle = self.content:Add("EditablePanel")
	PLUGIN:CreateTitle(paymentsTitle, self.content, "płatności")
	paymentsTitle:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))

	local paymentsFrame = self.content:Add("DScrollPanel")
	paymentsFrame:Dock(TOP)
	paymentsFrame:SetTall(SScaleMin(160 / 3))

	eCounter = 0
	for cid, tPayment in pairs(tApartment.payments) do
		eCounter = eCounter + 1

		local cidLabelPayment = paymentsFrame:Add("EditablePanel")
		PLUGIN:CreateRow(cidLabelPayment, "cid | kwota", cid.." | "..tPayment.amount, false, eCounter % 2 == 0 and true or false)

		self:CreateBottomOrTopTextOrButton(cidLabelPayment:GetChildren()[1], "DATA:", true)
		self:CreateBottomOrTopTextOrButton(cidLabelPayment.bottom, os.date( "%d/%m/%Y", tPayment.date), false)
	end

	if tApartment.type == "shop" then
		local permitsTitle = self.content:Add("EditablePanel")
		PLUGIN:CreateTitle(permitsTitle, self.content, "aktualne zezwolenia")
		permitsTitle:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))

		local activeShopPermitsFrame = self.content:Add("EditablePanel")
		ix.gui.shopPermits = activeShopPermitsFrame
		activeShopPermitsFrame.GetUpdates = function()
			netstream.Start("GetActiveShopPermitsDatapad", appID)
		end
		activeShopPermitsFrame.CreateActivePermits = function(s, permitData)
			for k2, v2 in pairs(permitData) do
				if !isbool(v2) then
					continue
				end

				local permitPanel = self.content:Add("Panel")
				permitPanel:Dock(TOP)
				permitPanel:SetTall(SScaleMin(30 / 3))

				local permitName = permitPanel:Add("DLabel")
				permitName:Dock(LEFT)
				permitName:SetText(Schema:FirstToUpper(k2))
				permitName:SetFont("MenuFontBoldNoClamp")
				permitName:SetColor(color)
				permitName:SizeToContents()
				permitName:DockMargin(SScaleMin(10 / 3), 0, 0, 0)

				local toggleButton = permitPanel:Add("DButton")
				toggleButton:Dock(RIGHT)
				toggleButton:SetWide(SScaleMin(100 / 3))
				toggleButton:SetText(string.upper(tostring(v2)))
				toggleButton:SetFont("MenuFontBoldNoClamp")
				toggleButton.material = (v2 and "willardnetworks/datafile/licenseenabled.png") or (!v2 and "willardnetworks/datafile/licensedisabled2.png")

				toggleButton.Paint = function(s, w, h)
					surface.SetDrawColor(color_white)
					surface.SetMaterial(ix.util.GetMaterial(s.material))
					surface.DrawTexturedRect(0, 0, w, h)
				end

				toggleButton.DoClick = function(this)
					local bPermit = permitData[k2]
					if !bPermit then
						bPermit = true
						this.material = "willardnetworks/datafile/licenseenabled.png"
					else
						bPermit = false
						this.material = "willardnetworks/datafile/licensedisabled2.png"
					end
					permitData[k2] = bPermit

					this:SetText(string.upper(tostring(bPermit)))

					netstream.Start("ToggleShopPermitDatapad", k2, bPermit, appID)
					surface.PlaySound("willardnetworks/datapad/navigate.wav")

				end
			end
		end
		activeShopPermitsFrame:GetUpdates()
	end
end

function PANEL:CreateBottomOrTopTextOrButton(parent, text, bTop, bButton)
	local labelText = parent:Add(bButton and "DButton" or "DLabel")
	labelText:SetTextColor(bTop and Color(154, 169, 175, 255) or color)
	labelText:SetFont("MenuFontNoClamp")
	labelText:SetText(text)
	labelText:Dock(RIGHT)
	labelText:DockMargin(0, 0, SScaleMin(20 / 3), 0)
	labelText:SizeToContents()
	labelText.Paint = nil

	return labelText
end

vgui.Register("ixDatapadApartments", PANEL, "EditablePanel")
