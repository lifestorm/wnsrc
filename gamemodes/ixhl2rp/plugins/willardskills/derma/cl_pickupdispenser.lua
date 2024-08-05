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

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self.Paint = function(this, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( this, 1 )
	end

	self.innerContent = self:Add("Panel")
	self.innerContent:SetSize(SScaleMin(500 / 3), SScaleMin(600 / 3))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	Schema:AllowMessage(self.innerContent)
	self.innerContent.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self:CreateTopBar()
	self:CreateItems()
end

function PANEL:CreateTopBar()
	local topbar = self.innerContent:Add("Panel")
	topbar:SetSize(self.innerContent:GetWide(), SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function( this, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.titleText = topbar:Add("DLabel")
	self.titleText:SetFont("CharCreationBoldTitleNoClamp")
	self.titleText:Dock(LEFT)
	self.titleText:SetText("Select item to dispense")
	self.titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	self.titleText:SetContentAlignment(4)
	self.titleText:SizeToContents()

	self.exit = topbar:Add("DImageButton")
	self.exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	self.exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	self.exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	self.exit:Dock(RIGHT)
	self.exit.DoClick = function()
		netstream.Start("ClosePanels", LocalPlayer().activePickupDispenser)
		LocalPlayer().activePickupDispenser = nil
		LocalPlayer().boughtItems = nil
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local function createDivider(parent)
		parent:SetSize(1, topbar:GetTall())
		parent:Dock(RIGHT)
		parent:DockMargin(0, SScaleMin(10 / 3), SScaleMin(SScaleMin(10 / 3) / 3), SScaleMin(10 / 3))
		parent.Paint = function(this, w, h)
			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawLine(0, 0, 0, h)
		end
	end

	local divider = topbar:Add("Panel")
	createDivider(divider)
end

function PANEL:CreateItems()
	if !LocalPlayer().boughtItems then
		return
	end

	local scrollPanel = self.innerContent:Add("DScrollPanel")
	scrollPanel:Dock(TOP)
	scrollPanel:SetSize(self.innerContent:GetWide(), self.innerContent:GetTall() - SScaleMin(50 / 3))

	for k, v in pairs (LocalPlayer().boughtItems) do
		local character = LocalPlayer():GetCharacter()
		local inventory = character:GetInventory()

		local width = istable(v) and 1 or ix.item.list[k].width or 1
		local height = istable(v) and 1 or ix.item.list[k].height or 1

		local frame, modelPanel, textPanel, amountPanel, amount, title = self:CreateItem(scrollPanel, k, v)
		local actualAmount = istable(v) and 1 or v or 1
		local actualTitle = istable(v) and v.title or ix.item.list[k].name or "Cardboard Box"

		if !inventory:FindEmptySlot(width, height) then
			amount:SetTextColor(Color(150, 150, 150, 255))
			title:SetTextColor(Color(150, 150, 150, 255))
		end

		self:CreateInvisibleButton(frame, modelPanel, textPanel, amountPanel, inventory, width, height, actualAmount, actualTitle, amount, k)
	end
end

function PANEL:CreateInvisibleButton(frame, modelPanel, textPanel, amountPanel, inventory, width, height, actualAmount, actualTitle, amount, k)
	local invisibleButton = frame:Add("DButton")
	invisibleButton:SetSize(modelPanel:GetWide() + textPanel:GetWide() + amountPanel:GetWide(), frame:GetTall())
	invisibleButton:SetText("")
	invisibleButton.Paint = function(this, w, h)
		if inventory then
			if (this:IsHovered() and !inventory:FindEmptySlot(width, height)) then
				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 15)))
				surface.DrawOutlinedRect(SScaleMin(4 / 3), SScaleMin(4 / 3), w - SScaleMin(8 / 3), h - SScaleMin(8 / 3))
			end

			return
		end

		if (this:IsHovered()) then
			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 15)))
			surface.DrawOutlinedRect(SScaleMin(4 / 3), SScaleMin(4 / 3), w - SScaleMin(8 / 3), h - SScaleMin(8 / 3))
		end
	end

	invisibleButton.DoClick = function()
		if inventory then
			if inventory:FindEmptySlot(width, height) then
				actualAmount = actualAmount - 1
				amount:SetText(actualAmount)

				if actualAmount == 0 then
					frame:Remove()
				end

				LocalPlayer():NotifyLocalized("You have picked up a "..actualTitle)
				surface.PlaySound("helix/ui/press.wav")
				netstream.Start("SetPurchasedItems", k, LocalPlayer().activePickupDispenser)
			else
				LocalPlayer():NotifyLocalized("You do not have enough space for "..actualTitle.."!")
			end
		end
	end

	return invisibleButton
end

function PANEL:CreateItem(scrollPanel, itemID, number)
	local frame = scrollPanel:Add("Panel")
	frame:Dock(TOP)
	frame:DockMargin(0, 0, 0, -1)
	frame:SetTall(SScaleMin(110 / 3) - 5)
	frame.Paint = function(this, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	local modelPanel = frame:Add("Panel")
	modelPanel:Dock(LEFT)
	modelPanel:SetWide(scrollPanel:GetWide() / 3)
	modelPanel.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(w - 1, SScaleMin(10 / 3), w - 1, h - SScaleMin(10 / 3))
	end

	local modelIcon = modelPanel:Add("SpawnIcon")
	local model = istable(number) and "models/props_c17/paper01.mdl" or ix.item.list[itemID].model or "models/props_junk/cardboard_box004a.mdl"
	modelIcon:Dock(FILL)
	modelIcon:DockMargin(SScaleMin(43 / 3), SScaleMin(10 / 3), SScaleMin(43 / 3), SScaleMin(10 / 3))
	modelIcon:SetModel(model)
	modelIcon.Paint = nil

	modelIcon.PaintOver = nil
	modelIcon:SetTooltip(nil)

	local textPanel = frame:Add("Panel")
	textPanel:Dock(LEFT)
	textPanel:DockPadding(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), 0)
	textPanel:SetSize(scrollPanel:GetWide() / 2, frame:GetTall())
	textPanel.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(w - 1, SScaleMin(10 / 3), w - 1, h - SScaleMin(10 / 3))
	end

	local title = textPanel:Add("DLabel")
	local actualTitle = istable(number) and number.title or ix.item.list[itemID].name or "Cardboard Box"
	title:Dock(TOP)
	title:SetText(actualTitle..(istable(number) and " - FROM: "..number.fromName.." | "..number.fromCID or ""))
	title:SetFont(istable(number) and "MenuFontBoldNoClamp" or "WNBleedingMinutesBoldNoClamp")
	title:SetWrap(true)
	title:SetAutoStretchVertical(true)
	title.PerformLayout = function(this)
		this:DockMargin(0, textPanel:GetTall() * 0.5 - this:GetTall() * 0.5, 0, textPanel:GetTall() * 0.5 - this:GetTall() * 0.5)
	end

	local amountPanel = frame:Add("Panel")
	amountPanel:Dock(FILL)
	amountPanel:SetSize(scrollPanel:GetWide() - modelPanel:GetWide() - textPanel:GetWide(), frame:GetTall())
	if LocalPlayer().boughtItems and istable(LocalPlayer().boughtItems) then
		if table.Count(LocalPlayer().boughtItems) >= 6 then
			amountPanel:SetWide(amountPanel:GetWide() - SScaleMin(15 / 3))
		end
	end

	local amount = amountPanel:Add("DLabel")
	local actualAmount = istable(number) and 1 or number or 1
	amount:SetContentAlignment(5)
	amount:SetText(actualAmount)
	amount:SetFont("WNBleedingMinutesBoldNoClamp")
	amount:SizeToContents()
	amount:Center()

	return frame, modelPanel, textPanel, amountPanel, amount, title
end

vgui.Register("PickupDispenser", PANEL, "EditablePanel")