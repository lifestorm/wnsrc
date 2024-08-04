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

function PANEL:AddCityToList(cityID, parent, cityData)
	local pnl = parent:Add("DButton")
	pnl:Dock(TOP)
	pnl:DockMargin(SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3), 0)
	pnl:SetFont("TitlesFontNoClamp")
	pnl:SetText(cityID != "1" and "CITY-" .. cityID or "CITY-" .. ix.config.Get("mainCityNumber", 24))
	pnl:SetHeight(SScaleMin(32 / 3))
	pnl.cityData = cityData
	pnl.DoClick = function(s)
		self:BuildEditor(cityID == "1", s.cityData)

		surface.PlaySound("willardnetworks/charactercreation/boop" .. math.random(1, 3) .. ".wav")
	end
	pnl.DoRightClick = function(s)
		if s.cityData.id == "1" then
			return
		end

		local menu = DermaMenu()
		menu:AddOption( "Remove", function()
			Derma_Query("Are you sure you want to remove this city?", "REMOVING CITY",
			"Yes", function()
				net.Start("ix.city.RemoveCity")
					net.WriteString(s.cityData.id)
				net.SendToServer()
				self.cities[s.cityData.id] = nil
				if (self.cityData.id == s.cityData.id and self.editorPanel) then
					self.cityData.id:Remove()
				end
				s:Remove()
				surface.PlaySound("willardnetworks/datapad/close.wav")
			end,
			"No", nil)
		end)
		menu:Open()
	end

	self.cityList[#self.cityList + 1] = pnl
	return pnl
end

function PANEL:CreateButton(parent, text, color, callback)
	parent:Dock(TOP)
	parent:SetText(text)
	parent:SetHeight(SScaleMin(36 / 3))
	parent:DockMargin(SScaleMin(8 / 3), SScaleMin(6 / 3), 0, 0)
	parent:SetFont("MenuFontNoClamp")
	parent.Paint = function(s, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(color)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	parent.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		callback()
	end
end

function PANEL:RequestPopulate()
	net.Start("ix.city.PopulateFunds")
	net.SendToServer()
end

function PANEL:Populate(data)
	self.cities = data
	for index, city in pairs(self.cities) do
		self:AddCityToList(city.id, self.cityListFrame, city)
	end
end

function PANEL:CreateLabeledNumWang(parent, text, dock, icon)
	local pnl = parent:Add("Panel")
	pnl:Dock(dock)
	pnl:DockMargin(SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3))
	pnl:SetWide(parent:GetWide() * 0.84)

	local label = pnl:Add("DLabel")
	label:SetFont("SubtitleFont")
	label:Dock(TOP)
	label:SetText(text)
	label:SetContentAlignment(5)
	label:SizeToContents()

	local iconP = pnl:Add("Panel")
	iconP:Dock(TOP)
	iconP:SetHeight(SScaleMin(16 / 3))
	iconP:DockMargin(0, SScaleMin(6 / 3), 0, 0)
	iconP.Paint = function(s, w, h)
		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(icon)
		surface.DrawTexturedRect(w * .35, 0, 16, 16)
	end

	local numWang = pnl:Add("DNumberWang")
	numWang:Dock(BOTTOM)
	numWang:SetMax(9999)
	numWang.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 1)

		draw.SimpleText(s:GetValue(), "SubtitleFont", w * 0.25, h * 0.15)
	end

	return numWang
end

local priceMat = Material("willardnetworks/tabmenu/charmenu/chips.png", "smooth")
local amountMat = Material("willardnetworks/tabmenu/navicons/inventory.png", "smooth")
local mulTDMat = Material("willardnetworks/tabmenu/crafting/plus.png", "smooth")
local redTDMat = Material("willardnetworks/tabmenu/crafting/minus.png", "smooth")

function PANEL:CreateItemButton(itemID, parent, data, isMain)
	if (!self.cityData.items[itemID] or parent.items[itemID]) then
		return LocalPlayer():NotifyLocalized("Item already exists or its invalid.")
	end

	parent.items[itemID] = true

	local button = parent:Add("DButton")
	button:SetContentAlignment(5)
	button:SetFont("LargerTitlesFontNoClamp")
	button:SetText(ix.item.list[itemID].name)
	button:Dock(TOP)
	button:SetHeight(SScaleMin(64 / 3))
	button:DockMargin(SScaleMin(6 / 3), SScaleMin(6 / 3), SScaleMin(6 / 3), 0)

	local icon = button:Add("SpawnIcon")
	icon:SetModel(ix.item.list[itemID].model)
	icon:Dock(LEFT)

	local adjustment = parent:Add("Panel")
	adjustment:Dock(TOP)
	adjustment:DockMargin(SScaleMin(6 / 3), 0, SScaleMin(6 / 3), 0)
	adjustment:SetHeight(SScaleMin(112 / 3))
	adjustment.Paint = function(s, w, h)
		surface.SetDrawColor(8, 8, 8, 130)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local amount = self:CreateLabeledNumWang(adjustment, "Amount", LEFT, amountMat)
	amount:GetParent():SetHelixTooltip(function(tooltip)
		local name = tooltip:AddRow("name")
		name:SetImportant()
		name:SetText("Amount")
		name:SizeToContents()

		local info = tooltip:AddRow("info")
		info:SetText("Current accessable amount of this item.")
		info:SizeToContents()

		tooltip:SizeToContents()
	end)
	amount.OnValueChanged = function(s, value)
		self.cityData.items[itemID].amount = value
	end
	amount:SetValue(data and data.amount or 0)
	self.cityData.items[itemID].amount = amount:GetValue()

	if (!isMain) then
		local price = self:CreateLabeledNumWang(adjustment, "Price", LEFT, priceMat)
		price:GetParent():SetHelixTooltip(function(tooltip)
			local name = tooltip:AddRow("name")
			name:SetImportant()
			name:SetText("Price")
			name:SizeToContents()

			local info = tooltip:AddRow("info")
			info:SetText("This is default price of an item not affected by abundance and lack thresholds.")
			info:SizeToContents()

			tooltip:SizeToContents()
		end)
		price.OnValueChanged = function(s, value)
			self.cityData.items[itemID].price = value
		end
		price:SetValue(data and data.price or 0)
		self.cityData.items[itemID].price = price:GetValue()

		local mulTD = self:CreateLabeledNumWang(adjustment, "Mul.TD", LEFT, mulTDMat)
		mulTD:GetParent():SetHelixTooltip(function(tooltip)
			local name = tooltip:AddRow("name")
			name:SetImportant()
			name:SetText("Lack threshold")
			name:SizeToContents()

			local info = tooltip:AddRow("info")
			info:SetText("How many of this items must be in stock to consider them 'lacking'. If item amount is lower than this value - then its price multiplicates by P.Mul value.")
			info:SizeToContents()

			tooltip:SizeToContents()
		end)
		mulTD:SetValue(data and data.priceMulptiplicationTD or 10)
		self.cityData.items[itemID].priceMulptiplicationTD = mulTD:GetValue()
		mulTD.OnValueChanged = function(s, value)
			self.cityData.items[itemID].priceMulptiplicationTD = value
		end
		local redTD = self:CreateLabeledNumWang(adjustment, "Red.TD", LEFT, redTDMat)
		redTD:GetParent():SetHelixTooltip(function(tooltip)
			local name = tooltip:AddRow("name")
			name:SetImportant()
			name:SetText("Abundance threshold")
			name:SizeToContents()

			local info = tooltip:AddRow("info")
			info:SetText("How many of this items must be in stock to consider them 'abundant'. If item amount is more than this value - then its price divides by P.Div value.")
			info:SizeToContents()

			tooltip:SizeToContents()
		end)
		redTD:SetValue(data and data.priceReductionTD or 90)
		self.cityData.items[itemID].priceReductionTD = redTD:GetValue()
		redTD.OnValueChanged = function(s, value)
			self.cityData.items[itemID].priceReductionTD = value
		end
		local pMul = self:CreateLabeledNumWang(adjustment, "P.Mul", LEFT, mulTDMat)
		pMul:SetValue(data and data.priceMul or 2)
		self.cityData.items[itemID].priceMul = pMul:GetValue()
		pMul.OnValueChanged = function(s, value)
			self.cityData.items[itemID].priceMul = value
		end
		local pDiv = self:CreateLabeledNumWang(adjustment, "P.Div", LEFT, redTDMat)
		pDiv:SetValue(data and data.priceDiv or 2)
		self.cityData.items[itemID].priceDiv = pDiv:GetValue()
		pDiv.OnValueChanged = function(s, value)
			self.cityData.items[itemID].priceDiv = value
		end
	end
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

function PANEL:AddItemToCityData(itemID)
	self.cityData.items[itemID] = {}
end

function PANEL:BuildEditor(isMain, cityData)
	if IsValid(self.editorPanel) then
		self.editorPanel:Remove()
	end

	self.cityData = {}
	self.cityData = cityData

	self.editorPanel = self.cityPanel:Add("DScrollPanel")
	self.editorPanel:Dock(FILL)

	local cityID = cityData.id
	local cityName = self.editorPanel:Add("DLabel")
	cityName:SetFont("TitlesFontNoBoldNoClamp")
	cityName:Dock(TOP)
	cityName:SetText(cityID != "1" and "CITY-" .. cityID or "CITY-" .. ix.config.Get("mainCityNumber", 24))
	cityName:SetContentAlignment(5)
	cityName:SizeToContents()

	self:CreateDivider(self.editorPanel, TOP)
	if (!isMain) then
		local type = self.editorPanel:Add("DLabel")
		type:SetFont("TitlesFontNoBoldNoClamp")
		type:Dock(TOP)
		type:SetText("TYPE")
		type:SetContentAlignment(5)
		type:SizeToContents()

		local curType = self.editorPanel:Add("DLabel")
		curType:SetFont("MenuFontOutlined")
		curType:SetText(cityData.type.name and "CURRENT TYPE: " .. cityData.type.name or "THIS CITY DON'T HAVE ANY TYPE YET")
		curType:Dock(TOP)
		curType:SizeToContents()

		local typeButton = self.editorPanel:Add("DButton")
		self:CreateButton(typeButton, "CHANGE TYPE", Color(111, 111, 136, 255), function()
			local types = DermaMenu()
			for index, t in pairs(self.types) do
				types:AddOption(index, function()
					cityData.type = self.types[index]
					curType:SetText(cityData.type and "CURRENT TYPE: " .. cityData.type.name)
					curType:SizeToContents()
				end)
			end
			types:Open()
		end)
		typeButton:DockMargin(0, SScaleMin(16 / 3), 0, SScaleMin(16 / 3))
		typeButton:SetHeight(SScaleMin(29 / 3))


		self:CreateDivider(self.editorPanel, TOP)

		local items = self.editorPanel:Add("DLabel")
		items:SetFont("TitlesFontNoBoldNoClamp")
		items:Dock(TOP)
		items:SetText("ITEMS")
		items:SetContentAlignment(5)
		items:SizeToContents()
	end

	self.itemsPanel = self.editorPanel:Add("DScrollPanel")
	self.itemsPanel:Dock(TOP)
	self.itemsPanel:SetHeight(SScaleMin(400 / 3))
	self.itemsPanel.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 2)
	end
	self.itemsPanel.items = {}

	for item, itemTbl in pairs(self.cityData.items) do
		self:CreateItemButton(item, self.itemsPanel, itemTbl, isMain)
	end

	local createItemButton = self.editorPanel:Add("DButton")
	self:CreateButton(createItemButton, "ADD ITEM", Color(111, 111, 136, 255), function()
		Derma_StringRequest("Item ID", "Insert item's ID you want to add here.", "", function(text)
			if !ix.item.list[text] then
				return LocalPlayer():NotifyLocalized("Wrong item ID.")
			end
			self:AddItemToCityData(text)
			self:CreateItemButton(text, self.itemsPanel, nil, isMain)
		end)
	end)
	createItemButton:DockMargin(0, SScaleMin(16 / 3), 0, SScaleMin(16 / 3))
	createItemButton:SetHeight(SScaleMin(29 / 3))

	self:CreateDivider(self.editorPanel, TOP)

	local credits = self.editorPanel:Add("DLabel")
	credits:SetFont("TitlesFontNoBoldNoClamp")
	credits:Dock(TOP)
	credits:SetText("CREDITS")
	credits:SetContentAlignment(5)
	credits:SizeToContents()

	local credPanel = self.editorPanel:Add("Panel")
	credPanel:Dock(TOP)
	credPanel:SetHeight(SScaleMin(24 / 3))
	credPanel:DockMargin(0, SScaleMin(8 / 3), 0, 0)

	local credLabel = credPanel:Add("DLabel")
	credLabel:SetFont("TitlesFontNoBoldNoClamp")
	credLabel:Dock(LEFT)
	credLabel:SetText("CITY CREDITS:")
	credLabel:SetContentAlignment(4)
	credLabel:SizeToContents()

	local credWang = credPanel:Add("DNumberWang")
	credWang:Dock(LEFT)
	credWang:SetMax(999999)
	credWang:DockMargin(SScaleMin(8 / 3), 0, 0, 0)
	credWang.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 1)

		draw.SimpleText(s:GetValue(), "SubtitleFont", w * 0.25, h * 0.15)
	end
	credWang.OnValueChanged = function(s, value)
		self.cityData.credits = value
	end
	credWang:SetValue(self.cityData.credits or 0)

	self:CreateDivider(self.editorPanel, TOP)

	local saveChangesButton = self.editorPanel:Add("DButton")
	self:CreateButton(saveChangesButton, "SAVE CHANGES", Color(111, 111, 136, 255), function()
		Derma_Query("Are you sure you want to save the changes you've made?", "SAVING CHANGES",
		"Yes", function()
			net.Start("ix.city.UpdateCity")
				net.WriteString(util.TableToJSON(self.cityData))
				net.WriteBool(isMain)
			net.SendToServer()
		end,
		"No", nil)
	end)
	saveChangesButton:DockMargin(0, SScaleMin(16 / 3), 0, SScaleMin(16 / 3))
	saveChangesButton:SetHeight(SScaleMin(29 / 3))
end

function PANEL:Init()
	if (ix.gui.fundManager and ix.gui.fundManager != self) then
		ix.gui.fundManager:Remove()
	end

	if (ix.gui.ctEditor and IsValid(ix.gui.ctEditor)) then
		ix.gui.ctEditor:Remove()
	end

	ix.gui.fundManager = self

	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)

	self.cityList = {}
	self.cityData = {}

	self.innerContent = self:Add("Panel")
	self.innerContent:SetSize(SScaleMin(900 / 3), SScaleMin(640 / 3))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	self.innerContent.Paint = function(s, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawLine(w * 0.5, SScaleMin(40 / 3), w * 0.5, h)
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
	titleText:SetText("City Fund Manager")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	self.cityListPanel = self.innerContent:Add("Panel")
	self.cityListPanel:Dock(LEFT)
	self.cityListPanel:DockMargin(SScaleMin(12 / 3), SScaleMin(6 / 3), 0, SScaleMin(6 / 3))
	self.cityListPanel:SetWide(SScaleMin(400 / 3))

	self.cityPanel = self.innerContent:Add("Panel")
	self.cityPanel:Dock(FILL)
	self.cityPanel:DockMargin(SScaleMin(48 / 3), SScaleMin(16 / 3), SScaleMin(16 / 3), SScaleMin(16 / 3))

	self.citiesLabel = self.cityListPanel:Add("DLabel")
	self.citiesLabel:SetFont("TitlesFontNoBoldNoClamp")
	self.citiesLabel:Dock(TOP)
	self.citiesLabel:SetText("CITIES")
	self.citiesLabel:DockMargin(SScaleMin(8 / 3), SScaleMin(16 / 3), 0, 0)
	self.citiesLabel:SetContentAlignment(5)
	self.citiesLabel:SizeToContents()

	self.cityListFrame = self.cityListPanel:Add("DScrollPanel")
	self.cityListFrame:Dock(TOP)
	self.cityListFrame:DockMargin(SScaleMin(8 / 3), 1, 0, 0)
	self.cityListFrame:SetHeight(SScaleMin(400 / 3))
	self.cityListFrame.Paint = function(s, w, h)
		surface.SetDrawColor(111, 111, 136, 76)
		surface.DrawOutlinedRect(0, 0, w, h, 2)
	end

	self.cityCreate = self.cityListPanel:Add("DButton")
	self:CreateButton(self.cityCreate, "Create city", Color(111, 111, 136, 255), function()
		local cityNumber
		local cityType
		Derma_StringRequest("City number", "Insert city number here.", "", function(text)
			text = tonumber(text)
			if self.cities[text] or !text then
				return LocalPlayer():NotifyLocalized("City with this number already exists or you've entered words instead of number.")
			end
			cityNumber = tostring(text)
			Derma_StringRequest("City type", "Insert city type ID here. It must be accurate.", "", function(typeID)
				if !self.types[typeID] then
					return LocalPlayer():NotifyLocalized("Type doesn't exist.")
				end
				cityType = typeID
				net.Start("ix.city.CreateCity")
					net.WriteString(cityNumber)
					net.WriteString(cityType)
				net.SendToServer()

				net.Start("ix.city.RequestUpdateCities")
				net.SendToServer()
			end)
		end)
	end)

	self.switchToType = self.cityListPanel:Add("DButton")
	self:CreateButton(self.switchToType, "Switch to type editor", Color(111, 111, 136, 255), function()
		local ctEditor = vgui.Create("ixCtEditor")
		ctEditor.typeData = self.types
		ctEditor:Populate()
		self:Remove()
	end)

	self:RequestPopulate()
end

function PANEL:UpdateCities(newTbl)
	self.cities = newTbl

	for _, pnl in pairs(self.cityList) do
		pnl:Remove()
	end

	if IsValid(self.editorPanel) then
		self.editorPanel:Remove()
	end

	for index, city in pairs(self.cities) do
		self:AddCityToList(city.id, self.cityListFrame, city)
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(63, 58, 115, 220)
	surface.DrawRect(0, 0, w, h)

	Derma_DrawBackgroundBlur(self, 1)
end

vgui.Register("ixFundManager", PANEL, "Panel")