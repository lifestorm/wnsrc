--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PANEL = {}
local PLUGIN = PLUGIN

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self.Paint = function(self, w, h)
		surface.SetDrawColor(Color(58, 115, 71, 80))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( self, 1 )

		surface.SetDrawColor(ColorAlpha(color_white, 5))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/vortessence.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	self.main = self:Add("EditablePanel")
	self.main:SetSize(SScaleMin(700 / 3), SScaleMin(600 / 3))
	self.main:Center()
	self.main:MakePopup()
	Schema:AllowMessage(self.main)
	self.main.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self:CreateTopTitle(self.main)
	self:CreateButtons(self.main)
end

function PANEL:CreateTopTitle(parent)
	local topbar = parent:Add("Panel")
	topbar:SetSize(parent:GetWide(), SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function( self, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("The Vortessence")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(SScaleMin(-200 / 3), SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end
end

local function GreenOutlineButton(self, w, h)
	surface.SetDrawColor(Color(0, 0, 0, 100))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(112, 135, 111, (255 / 100 * 30)))
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:CreateButtons(parent)
	local buttonPanel = parent:Add("Panel")
	buttonPanel:Dock(LEFT)
	buttonPanel:SetWide(parent:GetWide() / 3.5)
	buttonPanel.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 50)
		surface.DrawRect(0, 0, w, h)
	end

	local searchBar = buttonPanel:Add("DTextEntry")
	searchBar:Dock(TOP)
	searchBar:SetFont("MenuFontNoClamp")
	searchBar:SetSize(SScaleMin(200 / 3), SScaleMin(30 / 3))
	searchBar:DockMargin(0, 0, 0, SScaleMin(10 / 3))
	searchBar:SetPlaceholderText("Search note title...")
	searchBar:SetTextColor(Color(200, 200, 200, 255))
	searchBar:SetCursorColor(Color(200, 200, 200, 255))
	searchBar:SetFont("MenuFontNoClamp")
	searchBar:SetText(value or "")
	searchBar.Paint = function(panel, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		if ( panel.GetPlaceholderText and panel.GetPlaceholderColor and panel:GetPlaceholderText() and
			panel:GetPlaceholderText():Trim() != "" and panel:GetPlaceholderColor() and ( !panel:GetText() or panel:GetText() == "" ) ) then

			local oldText = panel:GetText()

			local str = panel:GetPlaceholderText()
			if ( str:StartWith( "#" ) ) then str = str:sub( 2 ) end
			str = language.GetPhrase( str )

			panel:SetText( str )
			panel:DrawTextEntryText( panel:GetPlaceholderColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
			panel:SetText( oldText )

			return
		end

		panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
	end

	searchBar.OnChange = function(searchSelf)
		local text = searchSelf:GetValue()

		if self.content and text != nil then
			-- Clear existing rows
			self.content:Clear()

			local category = self.content.category -- Get the selected category from the content panel

			for _, v in SortedPairs(PLUGIN.vortnotes, true) do
				if v.note_category and tonumber(v.note_category) == category then
					if string.find(string.lower(v.note_title), string.lower(text), 1, true) then
						self:CreateRow(self.content, v, category)
					end
				end
			end

			self:CreateAdd(self.content, category)
		end
	end

	self.buttonList = {}

	for i = 1, 3 do
		local charInfoButton = i == 1
		local eventButton = i == 2
		local charOrEvent = (charInfoButton or eventButton)

		local info = buttonPanel:Add("DButton")
		info:SetTall(SScaleMin(50 / 3))
		info:SetFont("TitlesFontNoClamp")
		info:Dock(TOP)
		info:DockMargin(0, 0, 0, -1)
		info:SetText(charInfoButton and "Character Notes" or eventButton and "Event Notes" or "General Notes")
		info.Paint = function(self, w, h)
			GreenOutlineButton(self, w, h)
		end

		info.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			if self.content then
				self.content:Remove()
			end

			searchBar:SetText("")
			self:CreateContent(self.main, i)
		end

		table.insert(self.buttonList, info)
	end
end

function PANEL:CreateContent(parent, info)
	self.content = parent:Add("DScrollPanel")
	self.content:Dock(FILL)
	self.content.name = info == 1 and "Character Notes" or info == 2 and "Event Notes" or "General Notes"
	self.content.category = info

	self:CreateTitleLabel(self.content)

	for _, v in SortedPairs(PLUGIN.vortnotes, true) do
		if v.note_category and tonumber(v.note_category) == info then
			self:CreateRow(self.content, v, info)
		end
	end

	self:CreateAdd(self.content, info)
end

function PANEL:CreateTitleLabel(parent, text)
	self.titleLabel = parent:Add("DLabel")
	self.titleLabel:Dock(TOP)
	self.titleLabel:SetText(text or parent.name or "")
	self.titleLabel:DockMargin(0, SScaleMin(15 / 3), 0, SScaleMin(14 / 3))
	self.titleLabel:SetFont("TitlesFontNoClamp")
	self.titleLabel:SetContentAlignment(5)
end

function PANEL:CreateDivider(parent)
	local divider = parent:Add("DShape")
	divider:SetType("Rect")
	divider:Dock(RIGHT)
	divider:SetWide(1)
	divider:DockMargin(0, SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
	divider:SetColor(Color(112, 135, 111, (255 / 100 * 30)))

end

function PANEL:CreateRow(parent, rowInfo, category)
	local row = parent:Add("DButton")
	row:Dock(TOP)
	row:SetTall(SScaleMin(50 / 3))
	row:SetText(rowInfo["note_title"] or "")
	row:SetContentAlignment(4)
	row:SetFont("TitlesFontNoClamp")
	row:SetTextInset(SScaleMin(10 / 3), 0)
	row:DockMargin(0, 0, 0, -1)
	row.Paint = function(self, w, h)
		GreenOutlineButton(self, w, h)
	end

	if CAMI.PlayerHasAccess(client, "Helix - Manage Vortessence Menu") then
		local delete = row:Add("DImageButton")
		delete:SetImage("willardnetworks/tabmenu/navicons/exit.png")
		delete:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
		delete:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
		delete:Dock(RIGHT)
		delete.DoClick = function()
			netstream.Start("RemoveNoteVortessence", rowInfo["note_id"], category)
			surface.PlaySound("helix/ui/press.wav")
		end

		self:CreateDivider(row)
	end

	local date = row:Add("DLabel")
	date:Dock(RIGHT)
	date:SetFont("TitlesFontNoClamp")
	date:SetText(rowInfo["note_date"] or "")
	date:SetContentAlignment(6)
	date:SizeToContents()
	date:DockMargin(0, 0, SScaleMin(10 / 3), 0)

	self:CreateDivider(row)

	local name = row:Add("DLabel")
	name:Dock(RIGHT)
	name:SetFont("TitlesFontNoClamp")
	name:SetText(rowInfo["note_poster"] or "")
	name:SetContentAlignment(6)
	name:SizeToContents()
	name:DockMargin(0, 0, SScaleMin(10 / 3), 0)

	row.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		parent:Clear()
		self:CreateTitleLabel(parent, rowInfo["note_title"])
		self:CreateNoteText(parent, rowInfo)
	end
end

function PANEL:CreateNoteText(parent, rowInfo)
	local wrappedText = parent:Add("DLabel")
	wrappedText:SetFont("MenuFontNoClamp")
	wrappedText:SetText(rowInfo["note_text"] or "")
	wrappedText:SetWrap(true)
	wrappedText:Dock(TOP)
	wrappedText:SetAutoStretchVertical(true)
	wrappedText:DockMargin(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), 0)
end

function PANEL:CreateAdd(parent, category)
	local add = parent:Add("DButton")
	add:Dock(TOP)
	add:SetTall(SScaleMin(50 / 3))
	add:SetText("Add Note")
	add:SetFont("TitlesFontNoClamp")
	add.Paint = function(self, w, h)
		surface.SetDrawColor(Color(112, 135, 111, (255 / 100 * 10)))
		surface.DrawRect(0, 0, w, h)

		GreenOutlineButton(self, w, h)
	end

	add.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		Derma_StringRequest(
			"Add Note | "..parent.name,
			"Set the title of your note:",
			"",
			function(title)
				if string.len(title) <= 0 then
					LocalPlayer():NotifyLocalized("You cannot input an empty title!")
					return false
				end

				surface.PlaySound("helix/ui/press.wav")

				Derma_StringRequest(
					"Add Note | "..parent.name,
					"Set the text of your note:",
					"",
					function(text)
						netstream.Start("AddNoteVortessence", title, text, category)
					end
				)
			end
		)
	end
end

vgui.Register("VortessenceMenu", PANEL, "EditablePanel")