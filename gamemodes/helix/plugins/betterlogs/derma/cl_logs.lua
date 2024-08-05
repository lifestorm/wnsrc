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
local PANEL = {}

local boxPattern = Material("willardnetworks/tabmenu/crafting/box_pattern.png", "noclamp")

-- Shared frame painting function between two VGUI registrations
local function PaintFrames(self, w, h, bCustom)
	local value = 100
	if bCustom then value = 200 end
	if isnumber(bCustom) then value = bCustom end
	local color
	if !isnumber(bCustom) then
		color = Color(0, 0, 0, value)
	else
		color = Color(25, 25, 25, value)
	end

	surface.SetDrawColor(color)
	surface.DrawRect(0, 0, w, h)

	if bCustom then
		surface.SetDrawColor(Color(255, 255, 255, 1))
		surface.SetMaterial(boxPattern)
		surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, w / SScaleMin(414 / 3), h / SScaleMin(677 / 3))
	end

	surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:Init()
	ix.gui.logs = self

	local titlePushDown = SScaleMin(30 / 3)
	local topPushDown = SScaleMin(150 / 3)
	local scale780 = SScaleMin(780 / 3)
	local scale120 = SScaleMin(120 / 3)

	self:SetWide(ScrW() - (topPushDown * 2))

	local sizeXtitle, sizeYtitle = self:GetWide(), scale120
	local sizeXcontent, sizeYcontent = self:GetWide(), scale780

	self.titlePanel = self:Add("Panel")
	self.titlePanel:SetSize(sizeXtitle, sizeYtitle)
	self.titlePanel:SetPos(self:GetWide() * 0.5 - self.titlePanel:GetWide() * 0.5)
	self.titlePanel.noRemove = true

	self:CreateTitleText()

	self.contentFrame = self:Add("Panel")
	self.contentFrame:SetSize(sizeXcontent, sizeYcontent)
	self.contentFrame:SetPos(self:GetWide() * 0.5 - self.contentFrame:GetWide() * 0.5, titlePushDown)
	self.contentFrame.noRemove = true
	self.contentFrame.Paint = function(panel, w, h)
		PaintFrames(panel, w, h, true)
	end

	self:SetTall(scale120 + scale780 + titlePushDown)
	self:Center()
	self.columnWidth = SScaleMin(150 / 3)

	self.requestedLogTypes = {}
	self.requestedLogs = {}

	self.page = 1

	netstream.Start("ixRequestLogTypes")

	self:Rebuild()
end

function PANEL:CreateTitleText()
	local logsTitleIcon = self.titlePanel:Add("DImage")
	logsTitleIcon:SetImage("willardnetworks/tabmenu/charmenu/licenses.png")
	logsTitleIcon:SetSize(SScaleMin(23 / 3), SScaleMin(17 / 3))

	self.logsTitle = self.titlePanel:Add("DLabel")
	self.logsTitle:SetFont("TitlesFontNoClamp")
	self.logsTitle:SetText("Logs")
	self.logsTitle:SizeToContents()
	self.logsTitle:SetPos(SScaleMin(33 / 3), SScaleMin(17 / 3) * 0.5 - self.logsTitle:GetTall() * 0.5)
end

function PANEL:Rebuild()
	self.contentFrame:Clear()
	  self.buttonsList = {}

	self.leftSide = self.contentFrame:Add("Panel")
	self.leftSide:Dock(LEFT)
	self.leftSide:SetWide(self.contentFrame:GetWide() * 0.20)

	self.rightSide = self.contentFrame:Add("Panel")
	self.rightSide:Dock(RIGHT)
	self.rightSide:SetWide(self.contentFrame:GetWide() * 0.80)
	self.rightSide.Paint = function() end

	self.logs = self.rightSide:Add("DListView")
	self.logs:Dock(FILL)
	self.logs:DockMargin(4, 4, 4, 4)
	self.logs:AddColumn("ID")
	self.logs:AddColumn("Time")
	self.logs:AddColumn("Steam ID")
	self.logs:AddColumn("Text")
	self.logs:SetHeaderHeight(SScaleMin(16 / 3))
	self.logs:SetDataHeight(SScaleMin(17 / 3))

	self.logs.Paint = function() end

	for _, v in pairs(self.logs:GetChildren()) do
		if v:GetName() != "DListView_Column" then continue end
		for _, v2 in pairs(v:GetChildren()) do
			if v2:GetName() != "DButton" then continue end
			local text = v2:GetText()
			if (text == "Steam ID" or text == "Time" or text == "ID") then
				v:SetFixedWidth(self.columnWidth)
			end
		end
	end

	self.logs.OnRowRightClick = function(list, lineId, line)
		local dmenu = DermaMenu()
		dmenu:MakePopup()
		dmenu:SetPos(input.GetCursorPos())

		local record = line.record

		if (record) then
			dmenu:AddOption("Copy to clipboard", function()
				SetClipboardText("["..os.date("%Y-%m-%d %X", record.datetime).."] "..record.text)
			end)

			if (record.steamid) then
				dmenu:AddOption("Copy SteamID to clipboard", function()
					SetClipboardText(util.SteamIDFrom64(record.steamid))
				end)

				dmenu:AddOption("Copy SteamID64 to clipboard", function()
					SetClipboardText(record.steamid)
				end)
			end

			if (record.pos_x) then
				local pos = Vector(record.pos_x, record.pos_y, record.pos_z)

				if (CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Tp", nil)) then
					dmenu:AddOption("Teleport", function()
						netstream.Start("ixLogTeleport", pos)
					end)
				end

				dmenu:AddOption("Mark", function()
					PLUGIN:LogMark(pos, record)
				end)
			end
		end

		for _, v in pairs(dmenu:GetChildren()[1]:GetChildren()) do
			v:SetFont("MenuFontNoClamp")
		end
	end

  self:FillLogs()

	self:CreatePagination()
  self:CreateLeftSideButtons()
end

function PANEL:FillLogs(bPage)
  self.logs:Clear()

	local logsData = self:GetCache(self.page) or self.requestedLogs

	if (logsData) then
		if (istable(logsData)and !table.IsEmpty(logsData)) then
			for _, v in pairs(logsData) do
				local e = "UNKNOWN"
				v.id, v.datetime, v.steamid, v.text = v.id or e, v.datetime or e, v.steamid or e, v.text or e

				local line = self.logs:AddLine(v.id, os.date("%Y-%m-%d %X", v.datetime), util.SteamIDFrom64(v.steamid), v.text)
				line.record = v
				line.type = v.log_type
			end

			self:SetCache(self.page, table.Copy(logsData))
		elseif (isnumber(logsData)) then
			self.logs:AddLine("You have to wait "..logsData.." second(s) before next search.")
		end
	else
		self.logs:AddLine("Logs not found!")
	end

	if (bPage) then
		self:UpdatePage(true)
	end

	for k, v2 in pairs(self.logs:GetLines()) do
		for k2, v3 in pairs(v2:GetChildren()) do
			v3:SetFont("MenuFontNoClamp")
		end
	end

	for k3, v4 in pairs(self.logs.Columns) do
		for k4, v5 in pairs(v4:GetChildren()) do
			v5:SetFont("MenuFontNoClamp")
		end
	end

	for _, v in ipairs(self.logs.Lines) do
		v.Paint = function(panel, width, height)
			if (panel:IsSelected()) then
				SKIN.tex.Input.ListBox.Hovered(0, 0, width, height)
			elseif (panel.Hovered) then
				surface.SetDrawColor(34, 58, 112)
				surface.DrawRect(0, 0, width, height)
			elseif (panel.m_bAlt) then
				SKIN.tex.Input.ListBox.EvenLine(0, 0, width, height)
			end

			if self.highlightDeathsKnockouts:GetChecked() then
				if v.type and v.type != "chat" and v:GetColumnText( 4 ):find("knocked") then
					surface.SetDrawColor(255, 218, 185, 10)
					surface.DrawRect(0, 0, width, height)
				end

				if v:GetColumnText( 4 ):find("died") or v:GetColumnText( 4 ):find("death") or v:GetColumnText( 4 ):find("killed") then
					surface.SetDrawColor(255, 0, 0, 10)
					surface.DrawRect(0, 0, width, height)
				end
			end
		end

		for _, v2 in ipairs(v.Columns) do
			v2:SetTextColor(Color(255, 255, 255))
		end
	end
end

-- Helper paint function for outlined rectangles
local function PaintStandard(self, w, h, alpha)
	surface.SetDrawColor(Color(0, 0, 0, alpha))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:CreateLeftSideButtons()
	local function search(pnl)
		local curTime = CurTime()

		if (pnl.nextClick and pnl.nextClick >= curTime) then
			LocalPlayer():Notify("Please wait before searching again!")
			return
		end

		self:SetCache()

		surface.PlaySound("helix/ui/press.wav")

		self:RequestLogs()

		pnl.nextClick = curTime + 3
	end
  self.afterTextEntry = self.leftSide:Add("DTextEntry")
  self:CreateTextEntry(self.afterTextEntry, true, 32, false, false, false, "Time after")
  self.afterTextEntry:SetTooltip("Events after x long ago. Time example: 5y2d7w = 5 years, 2 days, and 7 weeks")
  self.afterTextEntry:SetEnterAllowed(true)
  self.afterTextEntry.OnEnter = search

	self.afterTextEntry:SetValue(ix.option.Get("logDefaultTime"))

  self.beforeTextEntry = self.leftSide:Add("DTextEntry")
  self:CreateTextEntry(self.beforeTextEntry, true, 32, false, false, false, "Time before")
  self.beforeTextEntry:SetTooltip("Events before x long ago. Time example: 5y2d7w = 5 years, 2 days, and 7 weeks")
  self.beforeTextEntry:SetEnterAllowed(true)
  self.beforeTextEntry.OnEnter = search

	self.descCheckBox = self.leftSide:Add("DCheckBoxLabel")
	self.descCheckBox:SetText("Reversed time order")
	self.descCheckBox:Dock(TOP)
	self.descCheckBox:SetFont("MenuFontNoClamp")
	self.descCheckBox:SetChecked(true)
	self.descCheckBox:DockMargin(2, 2, 2, 2)

	self.descCheckBox.PerformLayout = function(panel)
		local x = panel.m_iIndent or 0

		panel.Button:SetSize(SScaleMin(15 / 3), SScaleMin(15 / 3))
		panel.Button:SetPos(x, math.floor((panel:GetTall() - panel.Button:GetTall()) / 2))

		panel.Label:SizeToContents()
		panel.Label:SetPos(x + panel.Button:GetWide() + SScaleMin(9 / 3), 0)
	end

	self.highlightDeathsKnockouts = self.leftSide:Add("DCheckBoxLabel")
	self.highlightDeathsKnockouts:SetText("Highlight deaths/knockouts")
	self.highlightDeathsKnockouts:Dock(TOP)
	self.highlightDeathsKnockouts:SetFont("MenuFontNoClamp")
	self.highlightDeathsKnockouts:SetChecked(true)
	self.highlightDeathsKnockouts:DockMargin(2, 2, 2, 2)

	self.highlightDeathsKnockouts.PerformLayout = function(panel)
		local x = panel.m_iIndent or 0

		panel.Button:SetSize(SScaleMin(15 / 3), SScaleMin(15 / 3))
		panel.Button:SetPos(x, math.floor((panel:GetTall() - panel.Button:GetTall()) / 2))

		panel.Label:SizeToContents()
		panel.Label:SetPos(x + panel.Button:GetWide() + SScaleMin(9 / 3), 0)
	end

  self.steamidTextEntry = self.leftSide:Add("DTextEntry")
  self:CreateTextEntry(self.steamidTextEntry, true, 32, false, false, false, "SteamID")
  self.steamidTextEntry:SetTooltip("Events commited by the player with this SteamID")
  self.steamidTextEntry:SetEnterAllowed(true)
  self.steamidTextEntry.OnEnter = search

  self.distanceTextEntry = self.leftSide:Add("DTextEntry")
  self:CreateTextEntry(self.distanceTextEntry, true, 32, false, false, false, "Distance")
  self.distanceTextEntry:SetTooltip("Events on the x distance from your current position. Leave empty for global")
  self.distanceTextEntry:SetEnterAllowed(true)
  self.distanceTextEntry.OnEnter = search

  self.textTextEntry = self.leftSide:Add("DTextEntry")
  self:CreateTextEntry(self.textTextEntry, true, 32, false, false, false, "Text")
  self.textTextEntry:SetTooltip("Part of the log text")
  self.textTextEntry:SetEnterAllowed(true)
  self.textTextEntry.OnEnter = search

  self.mapTextEntry = self.leftSide:Add("DTextEntry")
  self:CreateTextEntry(self.mapTextEntry, true, 32, false, false, false, "Map")
  self.mapTextEntry:SetTooltip("Event on the specific map. Leave empty for current")
  self.mapTextEntry:SetEnterAllowed(true)
  self.mapTextEntry.OnEnter = search

  if (!table.IsEmpty(self.requestedLogTypes)) then
	self.logTypeCombo = self.leftSide:Add("DComboBox")
	self.logTypeCombo:SetValue("Log type")
	self.logTypeCombo:SetTall(SScaleMin(32 / 3))
	self.logTypeCombo:Dock(TOP)
	self.logTypeCombo:SetFont("MenuFontNoClamp")

	self.logTypeCombo.Think = function(comboBox)
		if (comboBox:IsMenuOpen()) then
			comboBox.Menu:SetMaxHeight(ScrH() * 0.4)
		end
	end

	local logTypes = self.requestedLogTypes

	self.logTypeCombo:AddChoice("raw")
	for _, v in pairs(logTypes) do
		self.logTypeCombo:AddChoice(v)
	end
  end

  local searchButton = self.leftSide:Add("DButton")
  searchButton:Dock(BOTTOM)
	searchButton:SetText("Search")
	searchButton:SetFont("MenuFontNoClamp")
	searchButton:SetTall(SScaleMin(32 / 3))
	searchButton:DockMargin(4, 4, 4, 4)
	searchButton:SetContentAlignment(5)

  searchButton.Paint = function(panel, w, h)
		PaintStandard(panel, w, h, 100)
  end

  searchButton.DoClick = search
end

function PANEL:RequestLogs()
	local data = {
		before = ix.util.GetStringTime(self.beforeTextEntry:GetValue()),
		after = ix.util.GetStringTime(self.afterTextEntry:GetValue()),
		steamid = self.steamidTextEntry:GetValue(),
		distance = tonumber(self.distanceTextEntry:GetValue()),
		text = self.textTextEntry:GetValue(),
		logType = self.logTypeCombo:GetSelected(),
		map = self.mapTextEntry:GetValue(),
		logsPerPage = 25,
		currentPage = self.page,
		desc = self.descCheckBox:GetChecked()
	}

	netstream.Start("ixRequestLogs", data)
end

function PANEL:CreatePagination()
	local paginationBg = self.rightSide:Add("DPanel")
	paginationBg:Dock(BOTTOM)
	paginationBg:DockMargin(4, 4, 4, 4)
	paginationBg:SetTall(SScaleMin(32 / 3))

	self.firstPage = paginationBg:Add("DButton")
	self.firstPage:Dock(LEFT)
	self.firstPage:SetText("RETURN TO FIRST PAGE")
	self.firstPage:SetTextColor(color_white)
	self.firstPage:SetFont("MenuFontNoClamp")
	self.firstPage:SizeToContents()
	self.firstPage:SetWide(self.firstPage:GetWide() + SScaleMin(20 / 3))
	self.firstPage:DockMargin(4, 4, 4, 4)
	self.firstPage.DoClick = function(btn)
		local curTime = CurTime()

		if (btn.nextClick and btn.nextClick >= curTime) then return end
		surface.PlaySound("helix/ui/press.wav")

		self.page = 1

		self:UpdatePage()

		btn.nextClick = curTime + 1
	end

	self.pagePrev = paginationBg:Add("DButton")
	self.pagePrev:Dock(LEFT)
	self.pagePrev:SetText("<")
	self.pagePrev:SetTextColor(color_white)
	self.pagePrev:SetFont("MenuFontNoClamp")
	self.pagePrev:DockMargin(4, 4, 4, 4)
	self.pagePrev.DoClick = function(btn)
		local curTime = CurTime()

		if (btn.nextClick and btn.nextClick >= curTime) then return end
		surface.PlaySound("helix/ui/press.wav")

		self.page = self.page - 1

		self:UpdatePage()

		btn.nextClick = curTime + 1
	end

	self.pageLabel = paginationBg:Add("DLabel")
	self.pageLabel:SetText("Page #"..self.page)
	self.pageLabel:SetFont("MenuFontNoClamp")
	self.pageLabel:SetContentAlignment(5)
	self.pageLabel:Dock(FILL)

	self.pageNext = paginationBg:Add("DButton")
	self.pageNext:Dock(RIGHT)
	self.pageNext:SetText(">")
	self.pageNext:SetFont("MenuFontNoClamp")
	self.pageNext:SetTextColor(color_white)
	self.pageNext:DockMargin(4, 4, 4, 4)
	self.pageNext.DoClick = function(btn)
		local curTime = CurTime()

		if (btn.nextClick and btn.nextClick >= curTime) then return end
		surface.PlaySound("helix/ui/press.wav")

		self.page = self.page + 1

		self:UpdatePage()

		btn.nextClick = curTime + 1
	end

	self:UpdatePage(true)

	-- Page field
	self.pageTextEntry = paginationBg:Add("DTextEntry")
	self.pageTextEntry:Dock(RIGHT)
	self.pageTextEntry:SetFont("MenuFontNoClamp")
	self.pageTextEntry:SetNumeric(true)
	self.pageTextEntry:SetTall(SScaleMin(32 / 3))
	self.pageTextEntry:DockMargin(4, 4, 4, 4)
	self.pageTextEntry:SetWide(SScaleMin(100 / 3))

	-- Goto page x button
	local gotoPage = paginationBg:Add("DButton")
	gotoPage:Dock(RIGHT)
	gotoPage:SetText("GOTO PAGE")
	gotoPage:SetFont("MenuFontNoClamp")
	gotoPage:SetTextColor(color_white)
	gotoPage:DockMargin(4, 4, 4, 4)
	gotoPage:SetWide(SScaleMin(100 / 3))
	gotoPage.DoClick = function(btn)
		local curTime = CurTime()

		if (btn.nextClick and btn.nextClick >= curTime) then return end
		surface.PlaySound("helix/ui/press.wav")

		local page = tonumber(self.pageTextEntry:GetValue())

		if (page and page > 0) then
			self.page = page

			self:UpdatePage()
		end

		btn.nextClick = curTime + 1
	end
end

function PANEL:UpdatePage(bNoRequest)
	self.pagePrev:SetDisabled(self.page == 1)
	self.pageNext:SetDisabled(table.Count(self.logs:GetLines()) < 25)
	self.pageLabel:SetText("Page #"..self.page)

	if (!bNoRequest) then
		if (self:GetCache(self.page)) then
			self:FillLogs(true)
		else
			self:RequestLogs()
		end
	end
end

function PANEL:CreateTextEntry(parent, bDockTop, height, bMultiline, bScrollbar, bEnter, placeholderText)
  parent:SetPlaceholderText(placeholderText)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(height / 3))
	parent:SetMultiline(bMultiline)
	parent:SetVerticalScrollbarEnabled(bScrollbar)
	parent:SetEnterAllowed(bEnter)
	parent:SetTextColor(Color(200, 200, 200, 255))
	parent:SetCursorColor(Color(200, 200, 200, 255))
	parent:SetFont("MenuFontNoClamp")
	parent:SetPlaceholderColor(Color(200, 200, 200, 200))

	if bDockTop then
		parent:DockMargin(2, 2, 2, 2)
	end

	parent.Paint = function(panel, w, h)
		if bMultiline then
			surface.SetDrawColor(Color(25, 25, 25, 255))
		else
			surface.SetDrawColor(Color(0, 0, 0, 100))
		end

		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
		surface.DrawOutlinedRect(0, 0, w, h)

		if (panel.GetPlaceholderText and panel.GetPlaceholderColor and panel:GetPlaceholderText() and panel:GetPlaceholderText():Trim() != "" and panel:GetPlaceholderColor() and (!panel:GetText() or panel:GetText() == "")) then
			local oldText = panel:GetText()
			local str = panel:GetPlaceholderText()
			if (str:StartWith("#")) then str = str:utf8sub(2) end
			str = language.GetPhrase(str)

			panel:SetText(str)
			panel:DrawTextEntryText(panel:GetPlaceholderColor(), panel:GetHighlightColor(), panel:GetCursorColor())
			panel:SetText(oldText)

			return
		end

		panel:DrawTextEntryText(panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor())
	end
end

function PANEL:GetCache(page)
	local client = LocalPlayer()
	client.logCache = client.logCache or {}
	return client.logCache[page]
end

function PANEL:SetCache(page, cache)
	local client = LocalPlayer()
	client.logCache = client.logCache or {}

	if (page) then
		client.logCache[page] = cache
	else
		client.logCache = {}
	end
end

vgui.Register("ixLogs", PANEL, "EditablePanel")
