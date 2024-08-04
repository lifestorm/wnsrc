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
ICON_RENDER_QUEUE = ICON_RENDER_QUEUE or {}

local s100 = SScaleMin(100 / 3)
local s10 = SScaleMin(10 / 3)
local s800 = SScaleMin(800 / 3)

function PANEL:Init()
	self:SetSize(SScaleMin(1000 / 3), SScaleMin(700 / 3))
	self:MakePopup()
	self:Center()
	self:SetTitle("Willard Clothing Creator")
	DFrameFixer(self)

	self:CreateBaseSelector()
end

local function PaintButton(self, w, h, noAlpha)
	surface.SetDrawColor(Color(0, 0, 0, noAlpha and 255 or 100))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(111, 111, 136, noAlpha and 255 or (255 / 100 * 30)))
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:CreateBaseSelector()
	self.baseSelectorPanel = self:Add("DScrollPanel")
	self.baseSelectorPanel:Dock(FILL)

	self.title = self:Add("DLabel")
	self.title:SetFont("LargerTitlesFontNoClamp")
	self.title:SetText("Select Base")
	self.title:SizeToContents()
	self.title:Dock(TOP)
	self.title:SetContentAlignment(5)

	for base, info in pairs(PLUGIN.baseList) do
		local iBaseListKeys = #table.GetKeys(PLUGIN.baseList)
		local dFrameRectH = SScaleMin(25 / 3)
		local dFrameDivider = (dFrameRectH / iBaseListKeys)
		local baseSelector = self.baseSelectorPanel:Add("DButton")
		baseSelector:SetText(base)
		baseSelector:SetFont("TitlesFontNoClamp")
		baseSelector:SetTall((self:GetTall() / iBaseListKeys) - (s10 * 2) - (self.title:GetTall() / iBaseListKeys) - dFrameDivider)
		baseSelector:Dock(TOP)
		baseSelector:DockMargin(0, s10, 0, s10)

		if info.explainer then
			baseSelector:SetHelixTooltip(function(tooltip)
				local infoText = tooltip:AddRow("infoText")
				infoText:SetText(info.explainer)
				infoText:SizeToContents()

				tooltip:SizeToContents()
			end)
		end

		baseSelector.Paint = function(this, w, h)
			PaintButton(this, w, h)
		end

		baseSelector.DoClick = function()
			self:OnBaseSelected(base, info)
		end

		local showItemsWithinBase = baseSelector:Add("DButton")
		showItemsWithinBase:Dock(RIGHT)
		showItemsWithinBase:DockMargin(s10, s10, s10, s10)
		showItemsWithinBase:SetFont("MenuFontNoClamp")
		showItemsWithinBase:SetText("Show items within base")
		showItemsWithinBase:SizeToContents()
		showItemsWithinBase:SetWide(showItemsWithinBase:GetWide() + SScaleMin(10 / 3))

		showItemsWithinBase.DoClick = function()
			self:ShowItemsWithinBase(base, 1)
		end
	end
end

function PANEL:OnBaseSelected(base, info, itemTemplate)
	if !self.baseSelectorPanel or self.baseSelectorPanel and !IsValid(self.baseSelectorPanel) then return end
	self.baseSelectorPanel:SetVisible(false)
	self.title:SetText("Create clothing within the "..base.." base")
	self.title:SizeToContents()

	local desc = self:Add("DLabel")
	desc:SetText(info.explainer)
	desc:SetFont("MenuFont")
	desc:Dock(TOP)
	desc:SetTextColor(Color(200, 200, 200, 255))
	desc:DockMargin(0, 0, 0, s10 * 2)
	desc:SetContentAlignment(5)
	desc:SizeToContents()

	local back = self:Add("DButton")
	back:SetText("Back")
	back:SetFont("TitlesFontNoClamp")
	back:SetTall(SScaleMin(50 / 3))
	back:Dock(BOTTOM)
	back:DockMargin(0, s10, 0, 0)
	back.DoClick = function()

		Derma_Query("Are you sure you wish to return?", "Your item will be lost!",
		"Confirm Operation", function()
			if self.creatorPanel and IsValid(self.creatorPanel) then
				self.creatorPanel:SetVisible(false)
			end

			self.title:SetText("Select Base")
			self.title:SizeToContents()

			self.baseSelectorPanel:SetVisible(true)
			back:Remove()
			desc:Remove()

			self.previewItemTable = nil

		end, "Cancel")
	end

	self.creatorPanel = self:CreateTheCreator(base, info, itemTemplate)
end

function PANEL:GetBodygroupsFromTemplate(template, entity)
	local bodygroups = {}

	for k, value in pairs(template.bodyGroups) do
		local index = entity:FindBodygroupByName(k)

		if (index > -1) then
			bodygroups[index] = value
		end
	end

	return bodygroups
end

function PANEL:CreateTheCreator(base, info, itemTemplate)
	local creatorPanel = self:Add("Panel")
	creatorPanel:Dock(FILL)

	local previewPanel = creatorPanel:Add("Panel")
	previewPanel:Dock(LEFT)

	local previewTitle = previewPanel:Add("DLabel")
	previewTitle:SetFont("LargerTitlesFontNoClamp")
	previewTitle:SetText("Item Preview")
	previewTitle:SizeToContents()
	previewTitle:Dock(TOP)
	previewTitle:DockMargin(s10, s10, s10, s10)
	previewTitle:SetContentAlignment(5)

	local previewTitleW = previewTitle:GetWide()
	local previewPanelW = previewTitleW + (s10 * 2) + SScaleMin(100 / 3)
	previewPanel:SetWide(previewPanelW)

	creatorPanel.Paint = function(this, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 50))
		surface.DrawRect(0, 0, previewPanelW, h)
	end

	self.previewItemTable = itemTemplate or self:GetItemTemplate(base)

	if info.parent then
		self.previewItemTable = self:GetItemTemplate(info.parent, self.previewItemTable)
		info.vars = self:MergeVars(info.vars, PLUGIN.baseList[info.parent].vars)
	end

	self.previewItemTable.model = itemTemplate and itemTemplate.model or "models/props_junk/watermelon01.mdl"

	self.preview = self:CreateItemShowcase(false, self.previewItemTable)
	self.preview:SetParent(previewPanel)
	self.preview:Dock(TOP)

	local previewM = previewPanelW * 0.5 - self.preview:GetWide() * 0.5
	self.preview:DockMargin(previewM, 0, previewM, 0)

	if self.previewItemTable.OnInventoryDraw then
		local entity = self.preview:GetEntity()
		self.previewItemTable:OnInventoryDraw(entity, self.previewItemTable.proxy or false)
	end

	if self.previewItemTable.PaintOver then
		self.preview.PaintOver = function(this, w, h)
			self.previewItemTable.PaintOver(this, self.previewItemTable, w, h)
		end
	end

	local optionPanel = creatorPanel:Add("DScrollPanel")
	optionPanel:Dock(FILL)
	optionPanel:DockMargin(s10 * 2, 0, 0, 0)

	self.previewModel = self:CreatePlayermodelPreview(previewPanel, PLUGIN:GetModelsByBase(base), function()
		local entity = self.previewModel and self.previewModel.Entity

		if self.previewModel and IsValid(self.previewModel) then
			for key, value in pairs(self.curBodygroups) do
				entity:SetBodygroup(key, value)
			end
		end
	end)

	self.curBodygroups = itemTemplate and itemTemplate.bodyGroups and
	self:GetBodygroupsFromTemplate(itemTemplate, self.previewModel.Entity) or {}

	for index, value in pairs(self.curBodygroups) do
		self.previewModel.Entity:SetBodygroup(index, value)
	end

	local getCode = previewPanel:Add("DButton")
	getCode:SetFont("TitlesFontNoClamp")
	getCode:SetTall(SScaleMin(50 / 3))
	getCode:Dock(BOTTOM)
	getCode:SetText("View Code")
	getCode:DockMargin(0, s10, 0, 0)

	getCode.Paint = function(this, w, h)
		PaintButton(this, w, h)
	end

	getCode.DoClick = function()
		local frame = vgui.Create("DFrame")
		frame:SetSize(SScaleMin(1000 / 3), SScaleMin(700 / 3))
		frame:MakePopup()
		frame:Center()
		frame:SetTitle("View Code")
		DFrameFixer(frame)

		local textEntry = frame:Add("DTextEntry")
		textEntry:Dock(FILL)
		textEntry:SetMultiline( true )
		textEntry:SetVerticalScrollbarEnabled( true )
		textEntry:SetEnterAllowed( true )
		textEntry:SetTextColor(Color(200, 200, 200, 255))
		textEntry:SetCursorColor(Color(200, 200, 200, 255))
		textEntry:SetFont("MenuFontNoClamp")
		textEntry.Paint = function(this, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawOutlinedRect(0, 0, w, h)

			this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
		end

		local str = self:FillOutString(base)

		textEntry:SetText(str)

		local copy = frame:Add("DButton")
		copy:SetFont("MenuFontNoClamp")
		copy:SetTall(SScaleMin(50 / 3))
		copy:SetText("Copy")
		copy:Dock(BOTTOM)
		copy:DockMargin(0, s10, 0, 0)

		copy.Paint = function(this, w, h)
			PaintButton(this, w, h)
		end

		copy.DoClick = function()
			SetClipboardText(str)
		end
	end

	self:CreateOptions(optionPanel, base)

	local curProxy = self.previewItemTable and self.previewItemTable.proxy or {}
	self:UpdateProxyValues(curProxy)

	return creatorPanel
end

-- want to sort strings -> numbers -> bool first
function PANEL:FillOutString(base)
	local newString = ""

	local toAvoid = {"name", "description", "category", "model"}

	for _, key in pairs(toAvoid) do
		newString = newString..'ITEM.'..key..' = "'..self.previewItemTable[key]..'"\n'
	end

	--string
	for key, value in pairs(self.previewItemTable) do
		if !PLUGIN.baseList[base].vars[key] then continue end
		if table.HasValue(toAvoid, key) then continue end

		if !isstring(value) then continue end
		if value == "" then continue end

		newString = newString..'ITEM.'..key..' = "'..value..'"\n'
	end

	--number
	for key, value in pairs(self.previewItemTable) do
		if !PLUGIN.baseList[base].vars[key] then continue end

		if !isnumber(value) then continue end
		if value == 0 then continue end

		newString = newString..'ITEM.'..key.." = "..tostring(value)..'\n'
	end

	--bool
	for key, value in pairs(self.previewItemTable) do
		if !PLUGIN.baseList[base].vars[key] then continue end

		if !isbool(value) then continue end
		if value == false then continue end

		newString = newString..'ITEM.'..key.." = "..tostring(value)..'\n'
	end

	--tables
	for key, value in pairs(self.previewItemTable) do
		if !PLUGIN.baseList[base].vars[key] then continue end

		if key:find("Color") then
			if istable(value) and value.r then
				local color = "Color("..value.r..", "..value.g.. ", "..value.b..")"
				newString = newString..'ITEM.'..key.." = "..color..'\n'
				continue
			end
		end

		if key:find("proxy") then
			local addonString = 'ITEM.'..key.." = {"

			for proxy, color in pairs(value) do
				local isTable = istable(color)
				if !isTable or isTable and !color.r then continue end

				if (color.r == 255 and color.g == 255 and color.b == 255) then continue end

				local vectorColor = "Vector("..color.r.." / 255, "..color.g.. " / 255, "..color.b.." / 255)"
				addonString = addonString..'\n'..proxy.." = "..vectorColor..','
			end

			if addonString != 'ITEM.'..key.." = {" then
				addonString = addonString.."\n}\n"

				newString = newString..addonString
			end
		end

		if istable(value) and !key:find("proxy") then
			for key2, v in pairs(value) do
				if v == 0 or v == "" then
					value[key2] = nil
				end
			end

			if table.IsEmpty(value) then continue end

			local tableString = table.ToString( value, 'ITEM.'..key, true )
			newString = newString..tableString..'\n'
		end
	end

	return newString
end

function PANEL:GetContentType(type, var)
	return (isstring(type) and "ixSettingsRowString" or isnumber(type) and "ixSettingsRowNumber"
	or var:find("Color") and "ixSettingsRowColor" or istable(type) and "DButton" or isbool(type) and "ixSettingsRowBool")
end

function PANEL:GetContentZPos(type, var)
	if var == "name" then return 1 end
	if var == "description" then return 2 end
	if var == "model" then return 3 end
	if var == "category" then return 4 end

	return (isstring(type) and 5 or isnumber(type) and 6
	or isbool(type) and 7 or var:find("Color") and 8 or istable(type) and 9)
end

function PANEL:UpdateProxyValues(newValue)
	if !newValue then return end

	if self.previewModel and IsValid(self.previewModel) then
		self.previewModel.overrideProxyColors = newValue
	end
end

function PANEL:CreateOptions(parent, base)
	local baseTable = PLUGIN.baseList[base]
	if !PLUGIN.baseList or PLUGIN.baseList and !baseTable then return end

	self.options = {}

	for var, contentTable in pairs(baseTable.vars) do
		local type = contentTable.type
		local contentType = self:GetContentType(type, var)
		local zPos = self:GetContentZPos(type, var)

		if !contentType then return end

		local option = parent:Add(contentType)
		option:Dock(TOP)
		option:SetText(Schema:FirstToUpper(var or ""))
		option:SetZPos(zPos)

		if contentType == "ixSettingsRowString" then
			option.setting.OnTextChanged = function()
				self:UpdateItemShowcase(var, option:GetValue())
			end

			if self.previewItemTable[var] then
				option:SetValue(self.previewItemTable[var])
			end
		end

		if var == "width" or var == "height" then option:SetVisible(false) end -- this is always 1

		if contentType == "ixSettingsRowNumber" then
			option:SetMin(contentTable.min or 0)
			option:SetMax(contentTable.max or 0)

			if contentTable.decimals then
				option:SetDecimals(1)
			end

			option:SetValue(self.previewItemTable[var] or contentTable.min or 0)

			option.OnValueChanged = function()
				local newValue = option:GetValue()

				self:UpdateItemShowcase(var, newValue)
			end
		end

		if contentType == "ixSettingsRowColor" then
			option.OnValueChanged = function()
				local newValue = option:GetValue()

				self:UpdateItemShowcase(var, newValue)
			end

			if self.previewItemTable[var] then
				option:SetValue(self.previewItemTable[var])
			end
		end

		if contentType == "ixSettingsRowBool" then
			option.OnValueChanged = function()
				local newValue = option:GetValue()

				self:UpdateItemShowcase(var, newValue)
			end

			if self.previewItemTable[var] then
				option:SetValue(self.previewItemTable[var])
			end
		end

		if contentType == "DButton" then
			option:SetFont("MenuFontNoClamp")
			option:SetTall(SScaleMin(50 / 3))
			option:Dock(TOP)
			option:DockMargin(0, s10, 0, 0)

			option.Paint = function(this, w, h)
				PaintButton(this, w, h)
			end

			option.DoClick = function()
				if contentTable.altChoices then return contentTable.altChoices() end
				if contentTable.altMenu then return contentTable.altMenu() end
			end
		end

		if contentTable.description then
			option:SetHelixTooltip(function(tooltip)
				local notif1 = tooltip:AddRow("description")
				notif1:SetText(contentTable.description or "")
				notif1:SizeToContents()
			end)
		end

		if (contentTable.altChoices or contentTable.altMenu) and contentType != "DButton" then
			local helper = option:Add("DButton")
			helper:Dock(RIGHT)
			helper:SetFont("MenuFontNoClamp")
			helper:SetText("Helper")
			helper:SetTall(SScaleMin(50 / 3))
			helper:DockMargin(0, 0, s10, 0)
			helper:SizeToContents()
			local sizeW, sizeH = helper:GetSize()
			helper:SetSize(sizeW + (s10 * 2), sizeH)

			helper.DoClick = function()
				self.curHelper = var
				if contentTable.altChoices then
					local altChoicesSelector = vgui.Create("DFrame")
					altChoicesSelector:SetSize(SScaleMin(300 / 3), SScaleMin(400 / 3))
					altChoicesSelector:MakePopup()
					altChoicesSelector:Center()
					altChoicesSelector:SetTitle("Possible choices in base")
					DFrameFixer(altChoicesSelector)

					local scroll = altChoicesSelector:Add("DScrollPanel")
					scroll:Dock(FILL)

					local choices = contentTable.altChoices()
					if choices and istable(choices) then
						for _, choice in pairs(choices) do
							local choiceButton = scroll:Add("DButton")
							choiceButton:SetText(Schema:FirstToUpper(choice or ""))
							choiceButton:SetFont("MenuFontNoClamp")
							choiceButton:SetTall(SScaleMin(50 / 3))
							choiceButton:Dock(TOP)
							choiceButton:DockMargin(0, 0, 0, s10)

							choiceButton.DoClick = function()
								option:SetValue(choice)
								self:UpdateItemShowcase(var, choice)

								altChoicesSelector:Remove()
							end
						end
					end
				end
				if contentTable.altMenu then return contentTable.altMenu() end
			end
		end

		self.options[var] = option
	end
end

function PANEL:OpenProxyChooser()
	local frame = vgui.Create("DFrame")
	frame:SetSize(SScaleMin(600 / 3), SScaleMin(400 / 3))
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Multiple Choice Selector")
	DFrameFixer(frame, false, true, true)

	frame.Paint = function(this, w, h)
		surface.SetDrawColor(Color(40, 40, 40, 255))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.DrawRect(0, 0, w, this.lblTitle:GetTall() + SScaleMin(5 / 3))

		return true
	end

	local curProxy = self.previewItemTable and self.previewItemTable.proxy or {}

	for _, proxy in pairs(PLUGIN:GetProxyList()) do
		local color = curProxy and curProxy[proxy] or false

		local colorChooser = frame:Add("ixSettingsRowColor")
		colorChooser:Dock(TOP)
		colorChooser:SetText(proxy or "")
		colorChooser:SetValue(color or color_white)

		colorChooser.OnValueChanged = function()
			local newColor = colorChooser:GetValue()

			curProxy[proxy] = newColor

			self:UpdateItemShowcase("proxy", curProxy)
			self:UpdateProxyValues(curProxy)
		end
	end
end

function PANEL:MergeVars(curVars, newVars)
	for k, v in pairs(newVars) do
		if (curVars[k] == nil) then
			curVars[k] = v
		end
	end

	local mergeTable = table.Copy(newVars)
	curVars = table.Merge(mergeTable, curVars)

	return curVars
end

function PANEL:GetItemTemplate(base, itemTable)
	local template = itemTable or {}
	local baseTable = ix.item.base[base]

	for k, v in pairs(baseTable) do
		if (template[k] == nil) then
			template[k] = v
		end

		template.baseTable = baseTable
	end

	local mergeTable = table.Copy(baseTable)
	template = table.Merge(mergeTable, template)

	return template
end

function PANEL:UpdateItemShowcase(var, value)
	local itemTable = self.previewItemTable
	if !itemTable then return end
	if !self.preview or self.preview and !IsValid(self.preview) then return end

	itemTable[var] = value

	if var == "model" then
		self.preview:SetModel(value, itemTable:GetSkin(), itemTable:GetModelBodygroups())
	end

	self.preview:SetHelixTooltip(function(tooltip)
		ix.hud.PopulateItemTooltip(tooltip, itemTable, true)
	end)


	if itemTable.PaintOver and var == "outlineColor" then
		self.preview.PaintOver = function(this, w, h)
			itemTable.PaintOver(this, itemTable, w, h)
		end
	end

	if itemTable.OnInventoryDraw then
		local entity = self.preview:GetEntity()
		itemTable:OnInventoryDraw(entity, self.previewItemTable.proxy or false)
	end

	if var == "iconCam" then
        local camData = {
            cam_pos = value.pos,
            cam_ang = value.ang,
            cam_fov = value.fov
        }

		if !itemTable.OnInventoryDraw then
			self.preview.Icon:RebuildSpawnIconEx(camData)
		else
			self.preview:SetCamPos(itemTable.iconCam.pos)
			self.preview:SetFOV(itemTable.iconCam.fov)
			self.preview:SetLookAng(itemTable.iconCam.ang)

			local entity = self.preview:GetEntity()
			itemTable:OnInventoryDraw(entity, self.previewItemTable.proxy or false)
		end
	end
end

function PANEL:CreateItemShowcase(grid, itemTable)
	local panelType = itemTable.OnInventoryDraw and "ixItemIconAdvanced" or "ixItemIcon"
	local itemIcon = vgui.Create(panelType)
	itemIcon:SetModel(itemTable:GetModel(), itemTable:GetSkin(), itemTable:GetModelBodygroups())
	itemIcon:SetSize(s100, s100)

	if itemTable.OnInventoryDraw then
		local entity = itemIcon:GetEntity()

		itemTable:OnInventoryDraw(entity, itemTable.proxy or self.previewItemTable and self.previewItemTable.proxy or false)

		itemIcon.LayoutEntity = function()
		end

		if (itemTable.iconCam) then
			itemIcon:SetCamPos(itemTable.iconCam.pos)
			itemIcon:SetFOV(itemTable.iconCam.fov)
			itemIcon:SetLookAng(itemTable.iconCam.ang)
		else
			local pos = entity:GetPos()
			local camData = PositionSpawnIcon(entity, pos)

			if (camData) then
				itemIcon:SetCamPos(camData.origin)
				itemIcon:SetFOV(camData.fov)
				itemIcon:SetLookAng(camData.angles)
			end
		end
	end

	itemIcon:SetHelixTooltip(function(tooltip)
		ix.hud.PopulateItemTooltip(tooltip, itemTable, true)
	end)

	if (grid) then
		grid:AddItem( itemIcon )
		self.items[#self.items + 1] = itemIcon
	end

	return itemIcon
end

function PANEL:SearchBarPaint(this, w, h)
	PaintButton(this, w, h)

	if ( !this:GetText() or this:GetText() == "" ) then

		local oldText = this:GetText()

		local str = this:GetPlaceholderText()
		if ( str:StartWith( "#" ) ) then str = str:utf8sub( 2 ) end
		str = language.GetPhrase( str )

		this:SetText( str )
		this:DrawTextEntryText( this:GetPlaceholderColor(), this:GetHighlightColor(), this:GetCursorColor() )
		this:SetText( oldText )

		return
	end

	this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
end

function PANEL:ShowItemsWithinBase(base, page)
	local defaultW, defaultH = SScaleMin(500 / 3), SScaleMin(550 / 3)

	self.baseItemsPanel = vgui.Create("DFrame")
	self.baseItemsPanel:SetSize(SScaleMin(500 / 3), SScaleMin(550 / 3))
	self.baseItemsPanel:MakePopup()
	self.baseItemsPanel:Center()
	self.baseItemsPanel:SetTitle("Items within "..base)
	DFrameFixer(self.baseItemsPanel)

	local tableView = self.baseItemsPanel:Add("DButton")
	tableView:SetText("Table View")
	tableView:SetFont("MenuFontNoClamp")
	tableView:SetTall(SScaleMin(50 / 3))
	tableView:Dock(TOP)
	tableView:DockMargin(0, 0, 0, s10)

	tableView.Paint = function(this, w, h)
		PaintButton(this, w, h)
	end

	local gridView = self.baseItemsPanel:Add("DButton")
	gridView:SetText("Grid View")
	gridView:SetFont("MenuFontNoClamp")
	gridView:SetTall(SScaleMin(50 / 3))
	gridView:Dock(TOP)
	gridView:DockMargin(0, 0, 0, s10)

	gridView.Paint = function(this, w, h)
		PaintButton(this, w, h)
	end

	gridView:SetVisible(false)

	local itemGrid = self.baseItemsPanel:Add("DGrid")
	itemGrid:Dock(FILL)
	itemGrid:SetCols(5)
	itemGrid:SetColWide(s100)
	itemGrid:SetRowHeight(s100)

	self.items = {}
	self.currentPage = math.Clamp(page, 1, 9999)

	for _, itemTable in pairs(self:GetItemsByPage(base, self.currentPage)) do
		local itemIcon = self:CreateItemShowcase(itemGrid, itemTable)
		itemIcon.OnMousePressed = function(this, code)
			if (code == MOUSE_LEFT) then
				Derma_Query("Use as item base?", "Item Template",
				"Confirm Operation", function()
					self.baseItemsPanel:Remove()
					self:OnBaseSelected(base, PLUGIN.baseList[base], self:GetItemTemplate(base, itemTable))
				end, "Cancel")
			end
		end
	end

	local backForwardPanel = self.baseItemsPanel:Add("Panel")
	backForwardPanel:Dock(BOTTOM)
	backForwardPanel:SetTall(SScaleMin(50 / 3))

	local back = backForwardPanel:Add("DButton")
	back:Dock(LEFT)
	back:SetWide(self.baseItemsPanel:GetWide() / 2)
	back:SetText("")
	self:CreateArrow(back, "back_arrow")
	back.Paint = function(this, w ,h) PaintButton(this, w, h) end

	back.DoClick = function()
		self:ChangePage(itemGrid, base)
	end

	local next = backForwardPanel:Add("DButton")
	next:Dock(FILL)
	next:SetText("")
	self:CreateArrow(next, "right-arrow")
	next.Paint = function(this, w ,h) PaintButton(this, w, h) end

	next.DoClick = function()
		self:ChangePage(itemGrid, base, true)
	end

	tableView.DoClick = function()
		self.baseItemsPanel:SetSize(s800, s800)
		self.baseItemsPanel:Center()
		itemGrid:SetVisible(false)
		gridView:SetVisible(true)
		tableView:SetVisible(false)
		backForwardPanel:SetVisible(false)

		self.searchBar = self.baseItemsPanel:Add("DTextEntry")
		self.searchBar:Dock(TOP)
		self.searchBar:DockMargin(0, 0, 0, s10)
		self.searchBar:SetTall(SScaleMin(50 / 3))
		self.searchBar:SetTextColor(Color(200, 200, 200, 255))
		self.searchBar:SetCursorColor(Color(200, 200, 200, 255))
		self.searchBar:SetFont("MenuFontNoClamp")
		self.searchBar:SetUpdateOnType(true)
		self.searchBar:SetPlaceholderText("Search...")
		self.searchBar:SetPlaceholderColor(Color(200, 200, 200, 255))
		self.searchBar.OnValueChange = function(this, value)
			self:ReloadItemList(value, base)
		end

		self.searchBar.Paint = function(this, w, h)
			PANEL:SearchBarPaint(this, w, h)
		end

		if self.itemListView and IsValid(self.itemListView) then self.itemListView:Remove() end

		self.itemListView = self.baseItemsPanel:Add("DListView")
		self.itemListView:Dock( FILL )
		self.itemListView:AddColumn( "Name" )
		self.itemListView:AddColumn( "Description" )
		self.itemListView:AddColumn( "uniqueID" )

		for key, itemTable in SortedPairsByMemberValue(ix.item.list, "name") do
			if !itemTable.base or !PLUGIN.baseList[itemTable.base] then continue end
			if itemTable.base != base then continue end

			local line = self.itemListView:AddLine( itemTable.name or "", itemTable.description or "", key )
			line:SetHelixTooltip(function(tooltip)
				ix.hud.PopulateItemTooltip(tooltip, itemTable, true)
			end)

			line.OnSelect = function()
				Derma_Query("Use as item base?", "Item Template",
				"Confirm Operation", function()
					self:OnBaseSelected(base, PLUGIN.baseList[base], self:GetItemTemplate(base, itemTable))
					self.baseItemsPanel:Remove()
				end, "Cancel")
			end
		end

		self:DListViewDarkMode(self.itemListView)
	end

	gridView.DoClick = function()
		self.baseItemsPanel:SetSize(defaultW, defaultH)
		self.baseItemsPanel:Center()

		if self.itemListView and IsValid(self.itemListView) then self.itemListView:Remove() end
		if self.searchBar and IsValid(self.searchBar) then self.searchBar:Remove() end

		itemGrid:SetVisible(true)
		gridView:SetVisible(false)
		tableView:SetVisible(true)
		backForwardPanel:SetVisible(true)
	end
end

function PANEL:ReloadItemList(filter, base)
	if !self.itemListView or self.itemListView and !IsValid(self.itemListView) then return end
	self.itemListView:Clear()

	for key, itemTable in SortedPairsByMemberValue(ix.item.list, "name") do
		if !itemTable.base or !PLUGIN.baseList[itemTable.base] then continue end
		if itemTable.base != base then continue end

		local v = ix.item.list[key]
		local itemName = v.GetName and v:GetName() or L(v.name)

		if (filter and !itemName:lower():find(filter:lower(), 1, false)) then
			continue
		end

		local line = self.itemListView:AddLine( itemTable.name or "", itemTable.description or "", key )
		line:SetHelixTooltip(function(tooltip)
			ix.hud.PopulateItemTooltip(tooltip, itemTable, true)
		end)

		line.OnSelect = function()
			Derma_Query("Use as item base?", "Item Template",
			"Confirm Operation", function()
				self:OnBaseSelected(base, PLUGIN.baseList[base], self:GetItemTemplate(base, itemTable))
				self.baseItemsPanel:Remove()
			end, "Cancel")
		end
	end

	self:DListViewDarkMode(self.itemListView)
end

function PANEL:DListViewDarkMode(dListView)
	dListView:DockMargin(4, 4, 4, 4)
	dListView:SetHeaderHeight(SScaleMin(20 / 3))
	dListView:SetDataHeight(SScaleMin(20 / 3))

	dListView.Paint = function() end

	for _, v4 in pairs(dListView.Columns) do
		for _, v5 in pairs(v4:GetChildren()) do
			v5:SetFont("MenuFontNoClamp")
		end

		v4.Paint = function(this, w, h)
			PaintButton(this, w, h, true)
		end
	end

	for _, v in ipairs(dListView.Lines) do
		for _, v3 in pairs(v:GetChildren()) do
			v3:SetFont("MenuFontNoClamp")
		end

		v.Paint = function(panel, width, height)
			if (panel:IsSelected()) then
				--luacheck: ignore 1
				SKIN.tex.Input.ListBox.Hovered(0, 0, width, height)
			elseif (panel.Hovered) then
				surface.SetDrawColor(34, 58, 112)
				surface.DrawRect(0, 0, width, height)
			elseif (panel.m_bAlt) then
				SKIN.tex.Input.ListBox.EvenLine(0, 0, width, height)
			end
		end

		for _, v2 in ipairs(v.Columns) do
			v2:SetTextColor(Color(200, 200, 200))
		end
	end
end

function PANEL:ChangePage(itemGrid, base, bForward)
	local newPage = math.Clamp(self.currentPage + (bForward and 1 or -1), 1, 9999)
	local newItems = self:GetItemsByPage(base, newPage)
	if #table.GetKeys(newItems) <= 0 then return end

	self.currentPage = newPage
	self:ClearItems(itemGrid)
	for _, itemTable in pairs(self:GetItemsByPage(base, self.currentPage)) do
		local itemIcon = self:CreateItemShowcase(itemGrid, itemTable)
		itemIcon.OnMousePressed = function(this, code)
			if (code == MOUSE_LEFT) then
				Derma_Query("Use as item base?", "Item Template",
				"Confirm Operation", function()
					self.baseItemsPanel:Remove()
					self:OnBaseSelected(base, PLUGIN.baseList[base], self:GetItemTemplate(base, itemTable))
				end, "Cancel")
			end
		end
	end
end

function PANEL:ClearItems(grid)
	if self.items then
		for _, v in pairs(self.items) do
			if IsValid(v) then
				grid:RemoveItem(v)
			end
		end

		self.items = {}
	end
end

function PANEL:CreateArrow(parent, path)
	local s5 = SScaleMin(5 / 3)
	local s40 = SScaleMin(40 / 3)
	local imgbgWD2 = self.baseItemsPanel:GetWide() / 2
	local lrMargin = (imgbgWD2 - s40) * 0.5

	local arrow = parent:Add("DImage")
	arrow:Dock(FILL)
	arrow:DockMargin(lrMargin, s5, lrMargin, s5)
	arrow:SetImage("willardnetworks/mainmenu/"..path..".png")
end

function PANEL:Think()
	if self.baseItemsPanel and IsValid(self.baseItemsPanel) then
		self.baseItemsPanel:MoveToFront()
	end
end

function PANEL:GetItemsByPage(base, page)
	local itemList = {}
	for key, itemTable in pairs(ix.item.list) do
		if !itemTable.base or !PLUGIN.baseList[itemTable.base] then continue end
		if itemTable.base != base then continue end

		itemList[key] = itemTable
	end

	local itemListKeys = table.GetKeys(itemList)

	local items = {}

	local endInt = 20 * (page == 1 and 1 or page)
	local startInt = page == 1 and 1 or endInt - 19

	for i = startInt, endInt do
		if i > #itemListKeys then break end

		local key = itemListKeys[i]
		items[key] = ix.item.list[key]
	end

	return items
end

function PANEL:GetChoicesInBaseFromVar(base, var)
	local choices = {}
	for _, itemTable in pairs(ix.item.list) do
		if !itemTable.base or !PLUGIN.baseList[itemTable.base] then continue end
		if itemTable.base != base then continue end

		if !itemTable[var] then continue end
		if choices[var] then continue end

		choices[var] = itemTable[var]
	end

	return choices
end

function PANEL:GetChoicesInBaseFromVarTable(base, var)
	local choices = {}

	for _, itemTable in pairs(ix.item.list) do
		if !itemTable.base or !PLUGIN.baseList[itemTable.base] then continue end
		if itemTable.base != base then continue end

		if !itemTable[var] then continue end

		for _, choice in pairs(itemTable[var]) do
			if table.HasValue(choices, choice) then continue end

			choices[#choices + 1] = choice
		end
	end

	return choices
end

function PANEL:OpenColorAppendixMenu()
	local frame = vgui.Create("DFrame")
	frame:SetSize(SScaleMin(1000 / 3), SScaleMin(700 / 3))
	frame:MakePopup()
	frame:Center()
	frame:SetTitle("Color Appendix Creator")
	DFrameFixer(frame)

	local colorAppendixList = ix.hud.appendixColors or {}
	local curItemTable = self.previewItemTable
	local curColors = curItemTable and curItemTable.colorAppendix and table.GetKeys(curItemTable.colorAppendix) or false

	local selectorPanel = frame:Add("Panel")
	selectorPanel:Dock(TOP)
	selectorPanel:SetTall(SScaleMin(50 / 3))
	selectorPanel:DockMargin(0, 0, 0, s10 * 2)

	local colorSelector = selectorPanel:Add("DComboBox")
	colorSelector:SetFont("MenuFontNoClamp")
	colorSelector:Dock(LEFT)
	colorSelector:SetWide(SScaleMin(150 / 3))
	colorSelector:DockMargin(0, 0, s10 * 2, 0)
	colorSelector:SetValue( curColors and istable(curColors) and Schema:FirstToUpper(curColors[1] or "") or "Select Color" )
	colorSelector:AddChoice( "None" )
	colorSelector:SetSortItems( false )

	for colorKey, _ in pairs(colorAppendixList) do
		colorSelector:AddChoice( Schema:FirstToUpper(colorKey) )
	end

	colorSelector.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawRect(0, 0, w, h)
	end

	local textEntry = selectorPanel:Add("DTextEntry")
	textEntry:Dock(FILL)
	textEntry:SetTextColor(Color(200, 200, 200, 255))
	textEntry:SetCursorColor(Color(200, 200, 200, 255))
	textEntry:SetFont("MenuFontNoClamp")
	textEntry:SetPlaceholderText("Add text here...")
	textEntry:SetPlaceholderColor(Color(200, 200, 200, 255))
	textEntry:SetText(curColors and curItemTable.colorAppendix[curColors[1]] or "")

	textEntry.Paint = function(this, w, h)
		PANEL:SearchBarPaint(this, w, h)
	end

	for key, color in pairs(colorAppendixList) do
		local colorShowcase = frame:Add("DLabel")
		colorShowcase:Dock(TOP)
		colorShowcase:SetText((Schema:FirstToUpper(key or "") or "N/A")..": Lorem ipsum dolor sit amet")
		colorShowcase:SetTextColor(color or color_white)
		colorShowcase:DockMargin(0, s10 * 2, 0, 0)
		colorShowcase:SetContentAlignment(5)
		colorShowcase:SetFont("ixSmallFont")
		colorShowcase:SizeToContents()
	end

	local save = frame:Add("DButton")
	save:SetText("Save")
	save:SetFont("TitlesFontNoClamp")
	save:SetTall(SScaleMin(50 / 3))
	save:Dock(BOTTOM)

	save.Paint = function(this, w, h)
		PaintButton(this, w, h)
	end

	save.DoClick = function()
		local colorAppendix = {}

		local color = colorSelector:GetValue()
		if color and color != "None" and color != "Select Color" and color != "" then
			colorAppendix[string.lower(color)] = textEntry:GetText() or ""
		end

		self:UpdateItemShowcase("colorAppendix", colorAppendix)

		frame:Remove()
	end
end

function PANEL:CreatePlayermodelPreview(parent, models, buttonCallback)
	local model = parent:Add("ixModelPanel")
	model:Dock(FILL)
	model:SetFOV(60)
	model:SetModel(models.male)

	local genderPanel = parent:Add("Panel")
	genderPanel:Dock(BOTTOM)
	genderPanel:SetTall(SScaleMin(50 / 3))
	genderPanel:SetZPos(999)

	local male = genderPanel:Add("DButton")
	male:Dock(LEFT)
	male:SetWide(parent:GetWide() / 2)
	male:SetText("Male")
	male:SetFont("TitlesFontNoClamp")
	male:DockMargin(0, 0, SScaleMin(5 / 3), 0)
	male.Paint = function(this, w, h)
		PaintButton(this, w, h)
	end

	local female = genderPanel:Add("DButton")
	female:Dock(FILL)
	female:SetText("Female")
	female:DockMargin(SScaleMin(5 / 3), 0, 0, 0)
	female:SetFont("TitlesFontNoClamp")
	female.Paint = function(this, w, h)
		PaintButton(this, w, h)
	end

	male.DoClick = function()
		model:SetModel(models.male)

		buttonCallback()
	end

	female.DoClick = function()
		model:SetModel(models.female)

		buttonCallback()
	end

	return model
end

function PANEL:OpenBodygroupChooser(models)
	local frame = vgui.Create("DFrame")
	frame:SetSize(SScaleMin(1000 / 3), SScaleMin(700 / 3))
	frame:MakePopup()
	frame:Center()
	frame:SetTitle("Item Bodygroup Chooser")
	DFrameFixer(frame)

	local leftColumn = frame:Add("Panel")
	leftColumn:SetWide(frame:GetWide() * 0.5)
	leftColumn:Dock(LEFT)
	leftColumn:DockMargin(0, 0, s10 * 2, 0)

	local rightColumn = frame:Add("DScrollPanel")
	rightColumn:Dock(FILL)

	local function UpdateBodyGroups( type, val )
		if PANEL.model and IsValid(PANEL.model) then
			PANEL.model.Entity:SetBodygroup( type, math.Round( val ) )
			PANEL.model:SetCorrectHair()
		end
	end

	PANEL.model = self:CreatePlayermodelPreview(leftColumn, models, function()
		for _, v in pairs(PANEL.sliderPanels) do
			UpdateBodyGroups(v.bg, v:GetValue())
		end
	end)

	if self.previewItemTable and self.previewItemTable.OnInventoryDraw then
		self.previewItemTable:OnInventoryDraw(PANEL.model.Entity, self.previewItemTable.proxy or false)
	end

	PANEL.sliderPanels = {}

	for k = 0, PANEL.model.Entity:GetNumBodyGroups() - 1 do
		if ( PANEL.model.Entity:GetBodygroupCount( k ) <= 1 ) then continue end

		local bgName = PANEL.model.Entity:GetBodygroupName( k )
		if (bgName == "hair" or bgName == "beard") then continue end

		local bgTransfer = self.curBodygroups
		local sliderPanel = rightColumn:Add("ixNumSlider")
		sliderPanel:Dock(TOP)
		sliderPanel:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))
		sliderPanel:SetTall(SScaleMin(50 / 3))
		sliderPanel:SetMax(PANEL.model.Entity:GetBodygroupCount( k ) - 1)
		sliderPanel:SetValue(bgTransfer and bgTransfer[k] or 0)

		if bgTransfer then
			UpdateBodyGroups(k, sliderPanel:GetValue())
		end

		sliderPanel:SetDecimals( 0 )
		sliderPanel.label:SetText(bgTransfer and bgTransfer[k] or "0")
		sliderPanel.bg = k
		sliderPanel.slider.OnValueChanged = function(panel)
			UpdateBodyGroups(k, sliderPanel:GetValue())
			sliderPanel.label:SetText(sliderPanel:GetValue())
		end

		local label = sliderPanel:Add("DLabel")
		label:SetFont("TitlesFontNoClamp")
		label:SetText(Schema:FirstToUpper(bgName))
		label:Dock(FILL)
		label:SetContentAlignment(5)

		sliderPanel.slider.OnValueUpdated = function(panel)
			UpdateBodyGroups(k, sliderPanel:GetValue())
			sliderPanel.label:SetText(sliderPanel:GetValue())
		end

		PANEL.sliderPanels[#PANEL.sliderPanels + 1] = sliderPanel
	end

	local save = leftColumn:Add("DButton")
	save:Dock(BOTTOM)
	save:SetZPos(998)
	save:SetText("Save")
	save:SetTall(SScaleMin(50 / 3))
	save:DockMargin(0, s10 * 2, 0, 0)
	save:SetFont("TitlesFontNoClamp")
	save.Paint = function(this, w, h)
		PaintButton(this, w, h)
	end

	save.DoClick = function()
		if self.previewModel and IsValid(self.previewModel) then
			local bodyGroups = {}
			for _, v in pairs(PANEL.sliderPanels) do
				self.previewModel.Entity:SetBodygroup(v.bg, v:GetValue())
				self.curBodygroups[v.bg] = v:GetValue()
				bodyGroups[self.previewModel.Entity:GetBodygroupName(v.bg)] = v:GetValue()

				self.previewModel:SetCorrectHair()
			end

			self.previewItemTable["bodyGroups"] = bodyGroups
		end

		frame:Remove()
	end
end

function PANEL:OpenItemModelChoices()
	PANEL.spawnMenu = vgui.Create("DFrame")
	PANEL.spawnMenu:SetSize(SScaleMin(1000 / 3), SScaleMin(700 / 3))
	PANEL.spawnMenu:MakePopup()
	PANEL.spawnMenu:Center()
	PANEL.spawnMenu:SetTitle("Model Selector")
	DFrameFixer(PANEL.spawnMenu)

	local content = PANEL.spawnMenu:Add("SpawnmenuContentPanel")
	content.OldSpawnlists = content.ContentNavBar.Tree:AddNode( "#spawnmenu.category.browse", "icon16/cog.png" )
	content:Dock(FILL)

	content:EnableModify()
	hook.Call( "PopulatePropMenu", GAMEMODE )
	content:CallPopulateHook( "PopulateContent" )

	content.OldSpawnlists:MoveToFront()
	content.OldSpawnlists:SetExpanded( true )
end

function PANEL:OpenItemPicker()
	PANEL.itemMenu = vgui.Create("DFrame")
	PANEL.itemMenu:SetSize(SScaleMin(1000 / 3), SScaleMin(700 / 3))
	PANEL.itemMenu:MakePopup()
	PANEL.itemMenu:Center()
	PANEL.itemMenu:SetTitle("Item Selector")
	DFrameFixer(PANEL.itemMenu)

	local itemListPlugin = ix.plugin.list["itemlist"]
	if itemListPlugin then
		if itemListPlugin.CreateItemsPanel then
			local base = itemListPlugin:CreateItemsPanel()
			base:SetParent(PANEL.itemMenu)
			base:Dock(FILL)
			base:EnableModify()

			local p1 = base.ContentNavBar and IsValid(base.ContentNavBar) and base.ContentNavBar:GetChildren()
			local p2 = p1[4] and IsValid(p1[4]) and p1[4]:GetChildren()
			local defSearchEntry = p2[1] or false
			if defSearchEntry and IsValid(defSearchEntry) then
				defSearchEntry:Remove()
			end
		end
	end
end

-- called in cl_whitelistedspawnmenu.lua, whitelistedprops plugin, edited it to support this due to it overriding spawnmenu.
function PANEL:SaveSpawnMenuChoice(model, bodygroups, skin)
	if PANEL.spawnMenu and IsValid(PANEL.spawnMenu) then
		PANEL.spawnMenu:Remove()
	end

	if self.options["model"] and IsValid(self.options["model"]) then
		self.options["model"]:SetValue(model)
	end

	self:UpdateItemShowcase("model", model)
end

-- called in sh_plugin.lua, itemlist plugin, edited it to support this.
function PANEL:SaveItemMenuChoice(uniqueID)
	if PANEL.itemMenu and IsValid(PANEL.itemMenu) then
		PANEL.itemMenu:Remove()
	end

	local option = self.curHelper
	if !option then return end

	if self.options[self.curHelper] and IsValid(self.options[self.curHelper]) then
		self.options[self.curHelper]:SetValue(uniqueID)
	end

	self:UpdateItemShowcase(self.curHelper, uniqueID)
end

function PANEL:OpenMultipleChoice(list, var)
	local frame = vgui.Create("DFrame")
	frame:SetSize(SScaleMin(300 / 3), SScaleMin(400 / 3))
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("Multiple Choice Selector")
	DFrameFixer(frame)

	frame.checkboxes = {}

	local checkBoxPanel = frame:Add("DScrollPanel")
	checkBoxPanel:Dock(FILL)

	if !istable(list) then return end
	for _, value in SortedPairs(list) do
        local checkbox = checkBoxPanel:Add( "DCheckBoxLabel" )
        checkbox:Dock(TOP)
        checkbox:SetText(value or "")
        checkbox:SetValue( self.previewItemTable[var] and
		table.HasValue(self.previewItemTable[var], value) and true or false )
		checkbox:SetFont("MenuFontNoClamp")
        checkbox:SizeToContents()

		checkbox.PerformLayout = function(panel)
			local x = panel.m_iIndent or 0

			panel.Button:SetSize(SScaleMin(15 / 3), SScaleMin(15 / 3))
			panel.Button:SetPos(x, math.floor((panel:GetTall() - panel.Button:GetTall()) / 2))

			panel.Label:SizeToContents()
			panel.Label:SetPos(x + panel.Button:GetWide() + SScaleMin(9 / 3), 0)
		end

		frame.checkboxes[#frame.checkboxes + 1] = checkbox
	end

	local save = frame:Add("DButton")
	save:SetText("Save")
	save:SetFont("TitlesFontNoClamp")
	save:SetTall(SScaleMin(50 / 3))
	save:Dock(BOTTOM)

	save.Paint = function(this, w, h)
		PaintButton(this, w, h)
	end

	save.DoClick = function()
		frame:Remove()
		local checked = {}

		for _, panel in pairs(frame.checkboxes) do
			if panel:GetChecked() then
				checked[#checked + 1] = panel:GetText()
			end
		end

		self:UpdateItemShowcase(var, checked)
	end
end

function PANEL:OpenIconEditor()
	local data = self.previewItemTable

	ix.gui.iconEditor = vgui.Create('ixIconEditor')
	local iconEditor = ix.gui.iconEditor
	DFrameFixer(iconEditor)

	if iconEditor.model and IsValid(iconEditor.model) then
		if data.model then
			iconEditor.model:SetModel(data.model)
			if data.OnInventoryDraw then
				data:OnInventoryDraw(iconEditor.model.Entity, self.previewItemTable.proxy or false)
			end
		end
	end

	if iconEditor.width and IsValid(iconEditor.width) then
		if data.width then
			iconEditor.width:SetMinMax(1, data.width)
		end
	end

	if iconEditor.height and IsValid(iconEditor.height) then
		if data.height then
			iconEditor.height:SetMinMax(1, data.height)
		end
	end

	if iconEditor.modelPath and IsValid(iconEditor.modelPath) then
		iconEditor.modelPath:Remove()
	end

	if iconEditor.copy and IsValid(iconEditor.copy) then
		iconEditor.copy:SetText("Save")
		iconEditor.copy.DoClick = function()
			local camPos = iconEditor.model:GetCamPos()
			local camAng = iconEditor.model:GetLookAng()

			local iconCam = {
				pos = Vector(math.Round(-camPos.x, 2), math.Round(-camPos.y, 2), math.Round(camPos.z, 2)),
				ang = Angle(math.Round(camAng.p, 2), math.Round(camAng.y + 180, 2), math.Round(camAng.r, 2)),
				fov = math.Round(iconEditor.model:GetFOV(), 2)
			}

			if data.OnInventoryDraw then
				iconCam.pos = Vector(math.Round(camPos.x, 2), math.Round(camPos.y, 2), math.Round(camPos.z, 2))
				iconCam.ang = Angle(math.Round(camAng.p, 2), math.Round(camAng.y, 2), math.Round(camAng.r, 2))
			end

			self:UpdateItemShowcase("iconCam", iconCam)
		end
	end

	local advanced = data.OnInventoryDraw
	if advanced then
		iconEditor.item:SetVisible(false)

		iconEditor.itemAdvanced = vgui.Create("ixItemIconAdvanced", iconEditor.itemPanel)
		iconEditor.itemAdvanced:SetModel(data:GetModel(), data:GetSkin(), data:GetModelBodygroups())
		iconEditor.itemAdvanced:SetSize(s100, s100)

		local entity = iconEditor.itemAdvanced:GetEntity()

		iconEditor.itemAdvanced.LayoutEntity = function()
		end

		local pos = entity:GetPos()
		local camData = PositionSpawnIcon(entity, pos)

		if (camData) then
			iconEditor.itemAdvanced:SetCamPos(camData.origin)
			iconEditor.itemAdvanced:SetFOV(camData.fov)
			iconEditor.itemAdvanced:SetLookAng(camData.angles)
		end

		iconEditor.item.Rebuild = function(pnl, forceRebuild)
			iconEditor.itemAdvanced:SetFOV(iconEditor.model:GetFOV())
			iconEditor.itemAdvanced:SetCamPos(iconEditor.model:GetCamPos())
			iconEditor.itemAdvanced:SetLookAng(iconEditor.model:GetLookAng())
		end

		data:OnInventoryDraw(entity, self.previewItemTable.proxy or false)
	end

	if data and data.iconCam then
		local curPos = data.iconCam.pos
		local curAng = data.iconCam.ang

		local pos = Vector((!advanced and -curPos.x or curPos.x), (!advanced and -curPos.y or curPos.y), curPos.z)
		local ang = Angle(curAng.p, curAng.y + (!advanced and 180 or 0), curAng.r)

		iconEditor.model:SetCamPos(pos)
		iconEditor.model:SetFOV(data.iconCam.fov)
		iconEditor.model:SetLookAng(ang)
	end

	timer.Simple(0.5, function()
		iconEditor.item:Rebuild(true)
	end)
end

vgui.Register("ixClothingCreator", PANEL, "DFrame")