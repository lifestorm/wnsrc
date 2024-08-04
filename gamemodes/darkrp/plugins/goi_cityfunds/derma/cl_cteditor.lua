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

local function CheckItemRates(actualTD)
	if actualTD.highRateProduction < actualTD.averageRateProduction and
	actualTD.highRateProduction < actualTD.lowRateProduction and
	actualTD.averageRateProduction < actualTD.lowRateProduction then
		return true
	end

	return false
end

function PANEL:CreateDivider(parent, dock)
	local divider = parent:Add("Panel")
	divider:Dock(dock)
	divider:SetHeight(SScaleMin(10 / 3))
	divider.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawLine(0, h * 0.5, w, h * 0.5)
	end
end

function PANEL:Init()
	if (ix.gui.ctEditor and ix.gui.ctEditor != self) then
		ix.gui.ctEditor:Remove()
	end

	ix.gui.ctEditor = self

	self:SetSize(ScrW(), ScrH())

	self.typeData = {}
	self.typeList = {}

	self.innerContent = self:Add("Panel")
	self.innerContent:SetSize(SScaleMin(900 / 3), SScaleMin(640 / 3))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	self.innerContent.Paint = function(s, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.topbar = self.innerContent:Add("Panel")
	self.topbar:SetHeight(SScaleMin(40 / 3))
	self.topbar:Dock(TOP)
	self.topbar.Paint = function(s, width, height)
		surface.SetDrawColor(8, 8, 8, 130)
		surface.DrawRect(0, 0, width, height)

		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawLine(0, height * 0.95, width, height * 0.95)
	end

	local exit = self.topbar:Add("DImageButton")
	exit:SetMaterial(Material("willardnetworks/tabmenu/navicons/exit.png", "smooth"))
	exit:SetSize(SScaleMin(25 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local titleText = self.topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("City Type Editor")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()
end

function PANEL:AddTypeToList(typeID, parent, typeData)
	local pnl = parent:Add("DButton")
	pnl:Dock(LEFT)
	pnl:DockMargin(SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3), 0)
	pnl:SetFont("TitlesFontNoClamp")
	pnl:SetText(typeID)
	pnl:SetWide(SScaleMin(128 / 3))
	pnl.typeData = typeData
	pnl.DoClick = function(s)
		self:BuildEditor(s.typeData)
		surface.PlaySound("willardnetworks/charactercreation/boop" .. math.random(1, 3) .. ".wav")
	end
	pnl.DoRightClick = function(s)
		local menu = DermaMenu()
		menu:AddOption( "Remove", function()
			Derma_Query("Are you sure you want to remove this type?", "REMOVING TYPE",
			"Yes", function()
				net.Start("ix.city.RemoveType")
					net.WriteString(s.typeData.name)
				net.SendToServer()
				self.typeData[s.typeData.name] = nil
				if (self.actualTD and self.actualTD.name == s.typeData.name and self.innerScroller) then
					self.innerScroller:Remove()
				end
				s:Remove()
				surface.PlaySound("willardnetworks/datapad/close.wav")
			end,
			"No", nil)
		end)
		menu:Open()
	end
	parent:AddPanel( pnl )

	self.typeList[#self.typeList + 1] = pnl
	return pnl
end

function PANEL:CreateItemButton(itemID, parent, category)
	if (self.itemsPanel.items[itemID]) then
		return LocalPlayer():NotifyLocalized("Item already exists or its invalid.")
	end
	self.itemsPanel.items[itemID] = category
	if category == "high" then
		self.actualTD.itemsHighRate[itemID] = true
	elseif category == "average" then
		self.actualTD.itemsAverageRate[itemID] = true
	elseif category == "low" then
		self.actualTD.itemsLowRate[itemID] = true
	end

	local button = parent:Add("DButton")
	button:SetContentAlignment(5)
	button:SetFont("LargerTitlesFontNoClamp")
	button:SetText(ix.item.list[itemID].name)
	button:Dock(TOP)
	button:SetHeight(SScaleMin(64 / 3))
	button:DockMargin(SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3), 0)
	button.DoClick = function(s)
		local menu = DermaMenu()
		menu:AddOption( "Remove", function()
			Derma_Query("Are you sure you want to remove this item?", "REMOVING ITEM",
			"Yes", function()
				self.itemsPanel.items[itemID] = nil
				if category == "high" then
					self.actualTD.itemsHighRate[itemID] = nil
				elseif category == "average" then
					self.actualTD.itemsAverageRate[itemID] = nil
				elseif category == "low" then
					self.actualTD.itemsLowRate[itemID] = nil
				end
				surface.PlaySound("willardnetworks/datapad/close.wav")
				s:Remove()
			end,
			"No", nil)
		end)
		menu:Open()
	end

	local icon = button:Add("SpawnIcon")
	icon:SetModel(ix.item.list[itemID].model)
	icon:Dock(LEFT)
end

function PANEL:Populate()
	if ix.gui.fundManager and IsValid(ix.gui.fundManager) then
		ix.gui.fundManager:Remove()
	end

	self.returnButton = self.innerContent:Add("DButton")
	self.returnButton:SetContentAlignment(5)
	self.returnButton:SetFont("LargerTitlesFontNoClamp")
	self.returnButton:SetText("RETURN")
	self.returnButton:Dock(TOP)
	self.returnButton:SetHeight(SScaleMin(32 / 3))
	self.returnButton:DockMargin(SScaleMin(6 / 3), 0, SScaleMin(6 / 3), 0)
	self.returnButton.DoClick = function(s)
		self:Remove()
		vgui.Create("ixFundManager")
	end

	self.createType = self.innerContent:Add("DButton")
	self.createType:SetContentAlignment(5)
	self.createType:SetFont("LargerTitlesFontNoClamp")
	self.createType:SetText("CREATE TYPE")
	self.createType:Dock(TOP)
	self.createType:SetHeight(SScaleMin(32 / 3))
	self.createType:DockMargin(SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3), 0)
	self.createType.DoClick = function(s)
		Derma_StringRequest("Type name", "Insert type name here.", "", function(text)
			if self.typeData[text] then
				return LocalPlayer():NotifyLocalized("Type with this name already exists.")
			end

			net.Start("ix.city.CreateType")
				net.WriteString(text)
			net.SendToServer()

			net.Start("ix.city.RequestUpdateTypes")
			net.SendToServer()
		end)
	end

	self:CreateDivider(self.innerContent, TOP)

	self.typePanel = self.innerContent:Add("DHorizontalScroller")
	self.typePanel:Dock(TOP)
	self.typePanel:DockMargin(SScaleMin(6 / 3), 0, SScaleMin(12 / 3), 0)
	self.typePanel:SetHeight(SScaleMin(48 / 3))
	self.typePanel:SetOverlap(-64)

	for typeID, type in pairs(self.typeData) do
		self:AddTypeToList(typeID, self.typePanel, type)
	end

	self:CreateDivider(self.innerContent, TOP)
end

function PANEL:CreateOptionWang(parent, text, dock, font)
	local pnl = parent:Add("Panel")
	pnl:Dock(dock)
	pnl:DockMargin(SScaleMin(3 / 3), SScaleMin(3 / 3), SScaleMin(3 / 3), SScaleMin(3 / 3))
	pnl:SetWide(SScaleMin( (480 / 3) / 3))

	local label = pnl:Add("DLabel")
	label:SetFont(font or "SubtitleFont")
	label:Dock(TOP)
	label:SetText(text)
	label:SetContentAlignment(5)
	label:SizeToContents()

	local numWang = pnl:Add("DNumberWang")
	numWang:Dock(BOTTOM)
	numWang:DockMargin(SScaleMin(48 / 3), 0, SScaleMin(48 / 3), 0)
	numWang:SetMax(9999)
	numWang.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 1)

		draw.SimpleText(s:GetValue(), "SubtitleFont", w * 0.25, h * 0.15)
	end

	return numWang
end

local btnColor = Color(111, 111, 136, 255)

function PANEL:UpdateTypes(newTbl)
	self.typeData = newTbl

	for _, pnl in pairs(self.typeList) do
		pnl:Remove()
	end

	if (self.innerScroller) then
		self.innerScroller:Remove()
	end

	for typeID, type in pairs(self.typeData) do
		self:AddTypeToList(typeID, self.typePanel, type)
	end
end

function PANEL:BuildEditor(typeData)
	if (self.innerScroller) then
		self.innerScroller:Remove()
	end

	self.actualTD = typeData

	self.innerScroller = self.innerContent:Add("DScrollPanel")
	self.innerScroller:Dock(FILL)

	local itemsText = self.innerScroller:Add("DLabel")
	itemsText:SetFont("CharCreationBoldTitleNoClamp")
	itemsText:Dock(TOP)
	itemsText:SetText("ITEM PRODUCTION TABLES")
	itemsText:DockMargin(0, SScaleMin(12 / 3), 0, 0)
	itemsText:SetContentAlignment(5)
	itemsText:SizeToContents()

	self.itemsPanel = self.innerScroller:Add("Panel")
	self.itemsPanel:Dock(TOP)
	self.itemsPanel:SetHeight(SScaleMin(348 / 3))
	self.itemsPanel:DockMargin(SScaleMin(8 / 3), SScaleMin(4 / 3), 0, 0)
	self.itemsPanel.items = {}

	self.itemsHPScroller = self.itemsPanel:Add("DScrollPanel")
	self.itemsHPScroller:Dock(LEFT)
	self.itemsHPScroller:DockMargin(SScaleMin(12 / 3), 0, 0, 0)
	self.itemsHPScroller:SetWide(self.innerContent:GetWide() * 0.31)
	self.itemsHPScroller.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 2)
	end

	local hpText = self.itemsHPScroller:Add("DLabel")
	hpText:SetFont("TitlesFontNoBoldNoClamp")
	hpText:Dock(TOP)
	hpText:SetText("HIGH PRODUCTION")
	hpText:DockMargin(0, SScaleMin(4 / 3), 0, 0)
	hpText:SetContentAlignment(5)
	hpText:SizeToContents()

	local addHPButton = self.itemsHPScroller:Add("DButton")
	addHPButton:SetFont("MenuFontNoClamp")
	addHPButton:Dock(TOP)
	addHPButton:SetText("Add item")
	addHPButton:DockMargin(SScaleMin(36 / 3), SScaleMin(6 / 3), SScaleMin(36 / 3), 0)
	addHPButton:SetContentAlignment(5)
	addHPButton:SizeToContents()
	addHPButton.Paint = function(s, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(btnColor)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	addHPButton.DoClick = function(s)
		surface.PlaySound("helix/ui/press.wav")
		Derma_StringRequest("Item ID", "Insert item's ID you want to add here.", "", function(text)
			if !ix.item.list[text] then
				return LocalPlayer():NotifyLocalized("Wrong item ID.")
			end
			self:CreateItemButton(text, self.itemsHPScroller, "high")
		end)
	end

	self:CreateDivider(self.itemsHPScroller, TOP)

	self.itemsAPScroller = self.itemsPanel:Add("DScrollPanel")
	self.itemsAPScroller:Dock(LEFT)
	self.itemsAPScroller:DockMargin(SScaleMin(12 / 3), 0, 0, 0)
	self.itemsAPScroller:SetWide(self.innerContent:GetWide() * 0.31)
	self.itemsAPScroller.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 2)
	end

	local apText = self.itemsAPScroller:Add("DLabel")
	apText:SetFont("TitlesFontNoBoldNoClamp")
	apText:Dock(TOP)
	apText:SetText("AVERAGE PRODUCTION")
	apText:DockMargin(0, SScaleMin(4 / 3), 0, 0)
	apText:SetContentAlignment(5)
	apText:SizeToContents()

	local addAPButton = self.itemsAPScroller:Add("DButton")
	addAPButton:SetFont("MenuFontNoClamp")
	addAPButton:Dock(TOP)
	addAPButton:SetText("Add item")
	addAPButton:DockMargin(SScaleMin(36 / 3), SScaleMin(6 / 3), SScaleMin(36 / 3), 0)
	addAPButton:SetContentAlignment(5)
	addAPButton:SizeToContents()
	addAPButton.Paint = function(s, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(btnColor)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	addAPButton.DoClick = function(s)
		surface.PlaySound("helix/ui/press.wav")
		Derma_StringRequest("Item ID", "Insert item's ID you want to add here.", "", function(text)
			if !ix.item.list[text] then
				return LocalPlayer():NotifyLocalized("Wrong item ID.")
			end
			self:CreateItemButton(text, self.itemsAPScroller, "average")
		end)
	end

	self:CreateDivider(self.itemsAPScroller, TOP)

	self.itemsLPScroller = self.itemsPanel:Add("DScrollPanel")
	self.itemsLPScroller:Dock(LEFT)
	self.itemsLPScroller:DockMargin(SScaleMin(12 / 3), 0, 0, 0)
	self.itemsLPScroller:SetWide(self.innerContent:GetWide() * 0.31)
	self.itemsLPScroller.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 2)
	end

	local lpText = self.itemsLPScroller:Add("DLabel")
	lpText:SetFont("TitlesFontNoBoldNoClamp")
	lpText:Dock(TOP)
	lpText:SetText("LOW PRODUCTION")
	lpText:DockMargin(0, SScaleMin(4 / 3), 0, 0)
	lpText:SetContentAlignment(5)
	lpText:SizeToContents()

	local addLPButton = self.itemsLPScroller:Add("DButton")
	addLPButton:SetFont("MenuFontNoClamp")
	addLPButton:Dock(TOP)
	addLPButton:SetText("Add item")
	addLPButton:DockMargin(SScaleMin(36 / 3), SScaleMin(6 / 3), SScaleMin(36 / 3), 0)
	addLPButton:SetContentAlignment(5)
	addLPButton:SizeToContents()
	addLPButton.Paint = function(s, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(btnColor)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	addLPButton.DoClick = function(s)
		surface.PlaySound("helix/ui/press.wav")
		Derma_StringRequest("Item ID", "Insert item's ID you want to add here.", "", function(text)
			if !ix.item.list[text] then
				return LocalPlayer():NotifyLocalized("Wrong item ID.")
			end
			self:CreateItemButton(text, self.itemsLPScroller, "low")
		end)
	end

	self:CreateDivider(self.itemsLPScroller, TOP)

	for itemID, _ in pairs(self.actualTD.itemsHighRate) do
		self:CreateItemButton(itemID, self.itemsHPScroller, "high")
	end
	for itemID, _ in pairs(self.actualTD.itemsAverageRate) do
		self:CreateItemButton(itemID, self.itemsAPScroller, "average")
	end
	for itemID, _ in pairs(self.actualTD.itemsLowRate) do
		self:CreateItemButton(itemID, self.itemsLPScroller, "low")
	end

	local productionPanel = self.innerScroller:Add("Panel")
	productionPanel:Dock(TOP)
	productionPanel:SetHeight(SScaleMin(96 / 3))
	productionPanel:DockMargin(SScaleMin(196 / 3), SScaleMin(4 / 3), SScaleMin(196 / 3), 0)
	local high = self:CreateOptionWang(productionPanel, "HIGH PRODUCTION RATE", LEFT)
	high:SetValue(self.actualTD.highRateProduction)
	high:GetParent():SetHelixTooltip(function(tooltip)
		local name = tooltip:AddRow("name")
		name:SetImportant()
		name:SetText("High production rate")
		name:SizeToContents()

		local info = tooltip:AddRow("info")
		info:SetText("Defines the rate of production in hours. If you'll leave this row with value of 1, the items from high production category will produce every hour.")
		info:SizeToContents()

		tooltip:SizeToContents()
	end)
	high.OnValueChanged = function(s, value)
		self.actualTD.highRateProduction = value
	end

	local avrg = self:CreateOptionWang(productionPanel, "AVERAGE PRODUCTION RATE", LEFT)
	avrg:SetValue(self.actualTD.averageRateProduction)
	avrg:GetParent():SetHelixTooltip(function(tooltip)
		local name = tooltip:AddRow("name")
		name:SetImportant()
		name:SetText("Average production rate")
		name:SizeToContents()

		local info = tooltip:AddRow("info")
		info:SetText("Defines the rate of production in hours. If you'll leave this row with value of 1, the items from high production category will produce every hour.")
		info:SizeToContents()

		tooltip:SizeToContents()
	end)
	avrg.OnValueChanged = function(s, value)
		self.actualTD.averageRateProduction = value
	end

	local low = self:CreateOptionWang(productionPanel, "LOW PRODUCTION RATE", LEFT)
	low:SetValue(self.actualTD.lowRateProduction)
	low:GetParent():SetHelixTooltip(function(tooltip)
		local name = tooltip:AddRow("name")
		name:SetImportant()
		name:SetText("Low production rate")
		name:SizeToContents()

		local info = tooltip:AddRow("info")
		info:SetText("Defines the rate of production in hours. If you'll leave this row with value of 1, the items from high production category will produce every hour.")
		info:SizeToContents()

		tooltip:SizeToContents()
	end)
	low.OnValueChanged = function(s, value)
		self.actualTD.lowRateProduction = value
	end

	self:CreateDivider(self.innerScroller, TOP)

	local incomeText = self.innerScroller:Add("DLabel")
	incomeText:SetFont("CharCreationBoldTitleNoClamp")
	incomeText:Dock(TOP)
	incomeText:SetText("CREDIT INCOME")
	incomeText:DockMargin(0, SScaleMin(12 / 3), 0, 0)
	incomeText:SetContentAlignment(5)
	incomeText:SizeToContents()

	local incomePanel = self.innerScroller:Add("Panel")
	incomePanel:Dock(TOP)
	incomePanel:SetHeight(SScaleMin(96 / 3))

	local passiveIncome = incomePanel:Add("Panel")
	passiveIncome:Dock(LEFT)
	passiveIncome:SetWide(SScaleMin(225 / 3))
	passiveIncome:DockMargin(SScaleMin(64 / 3), 1, 0, 0)

	local incomeWang = self:CreateOptionWang(passiveIncome, "Passive income in credits", FILL, "TitlesFontNoBoldNoClamp")
	incomeWang:SetValue(self.actualTD.passiveIncome)
	incomeWang.OnValueChanged = function(s, value)
		self.actualTD.passiveIncome = value
	end
	local passiveIncomeRate = incomePanel:Add("Panel")
	passiveIncomeRate:SetWide(SScaleMin(225 / 3))
	passiveIncomeRate:DockMargin(0, 1, SScaleMin(64 / 3), 0)
	passiveIncomeRate:Dock(RIGHT)

	local rateWang = self:CreateOptionWang(passiveIncomeRate, "Passive income in hours", FILL, "TitlesFontNoBoldNoClamp")
	rateWang:SetValue(self.actualTD.passiveIncomeRate)
	rateWang.OnValueChanged = function(s, value)
		self.actualTD.passiveIncomeRate = value
	end

	self:CreateDivider(self.innerScroller, TOP)

	local saveChanges = self.innerScroller:Add("DButton")
	saveChanges:SetFont("MenuFontNoClamp")
	saveChanges:Dock(TOP)
	saveChanges:SetText("SAVE CHANGES")
	saveChanges:DockMargin(SScaleMin(96 / 3), SScaleMin(6 / 3), SScaleMin(96 / 3), SScaleMin(6 / 3))
	saveChanges:SetContentAlignment(5)
	saveChanges:SizeToContents()
	saveChanges.Paint = function(s, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(btnColor)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	saveChanges.DoClick = function(s)
		if !CheckItemRates(self.actualTD) then
			return LocalPlayer():NotifyLocalized("You've settuped item production variables in a wrong way. High rate must be not more than average, and low rate must be the biggest value.")
		end
		Derma_Query("Are you sure you want to save the changes you've made?", "SAVING CHANGES",
		"Yes", function()
			net.Start("ix.city.UpdateType")
				net.WriteString(util.TableToJSON(self.actualTD))
			net.SendToServer()
		end,
		"No", nil)
	end

	self:CreateDivider(self.innerScroller, TOP)
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(63, 58, 115, 220)
	surface.DrawRect(0, 0, w, h)

	Derma_DrawBackgroundBlur(self, 1)
end

vgui.Register("ixCtEditor", PANEL, "Panel")