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

local padding = SScaleMin(10 / 3)
local PLUGIN = PLUGIN

function PANEL:Init()
	ix.gui.apartmentseditor = self
	self:SetSize(ScrW(), ScrH())
	self.Paint = function(this, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( this, 1 )
	end

	self.content = self:Add("EditablePanel")
	self.content:SetSize(SScaleMin(700 / 3), SScaleMin(600 / 3))
	self.content:Center()
	self.content:MakePopup()
	self.content:DockPadding(padding, 0, padding, padding)
	self.content.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.content)

	self:CreateTopBar()

	self.combineutilities = ix.plugin.list["combineutilities"]
	if !self.combineutilities then return end

	self.topHalf = self.content:Add("Panel")
	self.topHalf:Dock(TOP)

	local titleFrame = self.topHalf:Add("EditablePanel")
	self.combineutilities:CreateTitle(titleFrame, self.topHalf, "apartments")
	self.topHalf:SetTall(self.content:GetTall() * 0.5 - titleFrame:GetTall())

	local titleSubframe = titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(300 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	local addApartment = titleSubframe:Add("DButton")
	self.combineutilities:CreateTitleFrameRightTextButton(addApartment, titleSubframe, 87, "add housing", RIGHT)
	addApartment.DoClick = function()
		local window = Derma_StringRequest("Select Apartment Type", "Jakiego typu mieszkanie ma to być?", false, false, false, false, false, true)
		local types = {"shop", "priorytetowy", "normalny"}

		PLUGIN:ConvertStringRequestToComboselect(window, "Wybiesz typ", function(comboBox)
			for _, type in pairs(types) do
				comboBox:AddChoice( type, type )
			end
		end, function(comboBox)
			local _, type = comboBox:GetSelected()
			if !type then window:Close() return end

			Derma_StringRequest("Ustaw nazwę", "Ustaw nazwę nowego mieszkania.", "", function(name)
				netstream.Start("CreateApartmentApartmentsUI", type, name)
				surface.PlaySound("willardnetworks/datapad/navigate.wav")
			end)
		end)
	end

	self.apartmentPanel = self.topHalf:Add("DScrollPanel")
	self.apartmentPanel:Dock(FILL)
	self.apartmentPanel:DockMargin(0, 0, 0, padding)

	self.bottomHalf = self.content:Add("Panel")
	self.bottomHalf:Dock(FILL)

	local titleFrame1 = self.bottomHalf:Add("EditablePanel")
	self.combineutilities:CreateTitle(titleFrame1, self.bottomHalf, "sklepy")

	self.shopPanel = self.bottomHalf:Add("DScrollPanel")
	self.shopPanel:Dock(FILL)

	self:RequestContent()
end

function PANEL:RequestContent()
	netstream.Start("RequestApartmentNamesApartmentsPanel")
end

function PANEL:CreateContent(appTable)
	self.apartmentPanel:Clear()
	self.shopPanel:Clear()

	local appCounter = 0
	local shopCounter = 0

	for appID, tApartment in SortedPairsByMemberValue(appTable, "name") do
		if tApartment.type == "shop" then
			shopCounter = shopCounter + 1
			
			self:CreateRow(self.shopPanel, appID, tApartment, shopCounter)
			continue
		end
		
		appCounter = appCounter + 1

		self:CreateRow(self.apartmentPanel, appID, tApartment, appCounter)
	end
end

function PANEL:CreateRow(parent, appID, tApartment, counter)
	local appRow = parent:Add("EditablePanel")
	self.combineutilities:CreateRow(appRow, "name | rent", tApartment.name.." | "..tApartment.rent or "", nil, (counter % 2 == 0 and true or false))

	self:CreateBottomOrTopTextOrButton(appRow:GetChildren()[1], "OPCJE:", true)
	local editName = self:CreateBottomOrTopTextOrButton(appRow.bottom, "EDYTUJ NAZWĘ", false, true)
	editName.DoClick = function()
		Derma_StringRequest("Zmień nazwę", "Zmień nazwę mieszkania.", tApartment.name, function(text)
			netstream.Start("ChangeApartmentName", appID, text)
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end)
	end

	local editRent = self:CreateBottomOrTopTextOrButton(appRow.bottom, "EDYTUJ CZYNSZ", false, true)
	editRent.DoClick = function()
		Derma_StringRequest("Zmień czynsz", "Zmień wymagany czynsz mieszkania.", tApartment.rent, function(text)
			netstream.Start("ApartmentUpdateRent", appID, tonumber(text))
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
		end)

		surface.PlaySound("willardnetworks/datapad/navigate.wav")
	end

	local remove = self:CreateBottomOrTopTextOrButton(appRow.bottom, "USUŃ", false, true)
	remove.DoClick = function()
		netstream.Start("RemoveApartmentHousing", tApartment.name)
	end
end

function PANEL:CreateBottomOrTopTextOrButton(parent, text, bTop, bButton)
	local labelText = parent:Add(bButton and "DButton" or "DLabel")
	labelText:SetTextColor(bTop and Color(154, 169, 175, 255) or Color(41, 243, 229, 255))
	labelText:SetFont("MenuFontNoClamp")
	labelText:SetText(text)
	labelText:Dock(RIGHT)
	labelText:DockMargin(0, 0, SScaleMin(20 / 3), 0)
	labelText:SizeToContents()
	labelText.Paint = nil

	return labelText
end

function PANEL:CreateTopBar()
	self.topbar = self.content:Add("Panel")
	self.topbar:SetSize(self:GetWide(), SScaleMin(50 / 3))
	self.topbar:Dock(TOP)
	self.topbar:DockMargin(0, 0, 0, padding)
	self.topbar.Paint = function( this, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.titleText = self.topbar:Add("DLabel")
	self.titleText:SetFont("CharCreationBoldTitleNoClamp")
	self.titleText:Dock(LEFT)
	self.titleText:SetText("Apartments Information")
	self.titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	self.titleText:SetContentAlignment(4)
	self.titleText:SizeToContents()

	local exit = self.topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local divider = self.topbar:Add("Panel")
	self:CreateDivider(divider)
end

function PANEL:CreateDivider(parent)
	parent:SetSize(1, self.topbar:GetTall())
	parent:Dock(RIGHT)
	parent:DockMargin(SScaleMin(5 / 3), padding, padding + SScaleMin(5 / 3), padding)
	parent.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, 0, 0, h)
	end
end

netstream.Hook("ixHousingShowAllApartments", function()
	vgui.Create("ixHousingShowAllApartments")
end)

netstream.Hook("UpdateApartmentList", function()
	if IsValid(ix.gui.apartmentseditor) then
		ix.gui.apartmentseditor:RequestContent()
	end
end)

netstream.Hook("SyncApartmentsApartmentsPanel", function(nameAndType)
	if IsValid(ix.gui.apartmentseditor) then
		ix.gui.apartmentseditor:CreateContent(nameAndType)
	end
end)

vgui.Register("ixHousingShowAllApartments", PANEL, "EditablePanel")