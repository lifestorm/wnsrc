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
	self.Paint = function(panel, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur(panel, 1)
	end

	self.innerContent = self:Add("Panel")
	self.innerContent:SetSize(SScaleMin(500 / 3), SScaleMin(600 / 3))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	Schema:AllowMessage(self.innerContent)
	self.innerContent.Paint = function(_, w, h)
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
	topbar.Paint = function(_, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText(L("smugglerSelectPickupItem"))
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()

	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		netstream.Start("ClosePickupCache")
		LocalPlayer().pickupItems = nil
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local function createDivider(parent)
		parent:SetSize(1, topbar:GetTall())
		parent:Dock(RIGHT)
		parent:DockMargin(0, SScaleMin(10 / 3), SScaleMin(SScaleMin(10 / 3) / 3), SScaleMin(10 / 3))
		parent.Paint = function(_, w, h)
			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawLine(0, 0, 0, h)
		end
	end

	local divider = topbar:Add("Panel")
	createDivider(divider)
end

function PANEL:CreateItems()
	local client = LocalPlayer()
	if (!client.pickupItems) then
		return
	end

	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	local tblCount = table.Count(client.pickupItems)

	local scrollPanel = self.innerContent:Add("DScrollPanel")
	scrollPanel:Dock(TOP)
	scrollPanel:SetSize(self.innerContent:GetWide(), self.innerContent:GetTall() - SScaleMin(50 / 3))

	for k, v in pairs(client.pickupItems) do
		if (!ix.item.list[k]) then
			continue
		end

		local width = ix.item.list[k].width or 1
		local height = ix.item.list[k].height or 1

		local frame = scrollPanel:Add("Panel")
		frame:Dock(TOP)
		frame:DockMargin(0, 0, 0, -1)
		frame:SetTall(SScaleMin(110 / 3) - 5)
		frame.Paint = function(_, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local modelPanel = frame:Add("Panel")
		modelPanel:Dock(LEFT)
		modelPanel:SetWide(scrollPanel:GetWide() / 3)
		modelPanel.Paint = function(_, w, h)
			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawLine(w - 1, SScaleMin(10 / 3), w - 1, h - SScaleMin(10 / 3))
		end

		local modelIcon = modelPanel:Add("SpawnIcon")
		local model = ix.item.list[k].model or "models/props_junk/cardboard_box004a.mdl"
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
		textPanel.Paint = function(_, w, h)
			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawLine(w - 1, SScaleMin(10 / 3), w - 1, h - SScaleMin(10 / 3))
		end

		local title = textPanel:Add("DLabel")
		local actualTitle = ix.item.list[k].name or "Cardboard Box"
		title:Dock(TOP)
		title:SetText(actualTitle)
		title:SetFont("WNBleedingMinutesBoldNoClamp")
		title:SetWrap(true)
		title:SetAutoStretchVertical(true)
		title.PerformLayout = function(panel)
			panel:DockMargin(0, textPanel:GetTall() * 0.5 - panel:GetTall() * 0.5, 0, textPanel:GetTall() * 0.5 - panel:GetTall() * 0.5)
		end

		local amountPanel = frame:Add("Panel")
		amountPanel:Dock(FILL)
		amountPanel:SetSize(scrollPanel:GetWide() - modelPanel:GetWide() - textPanel:GetWide(), frame:GetTall())
		if (tblCount >= 6) then
			amountPanel:SetWide(amountPanel:GetWide() - SScaleMin(15 / 3))
		end

		local amount = amountPanel:Add("DLabel")
		local actualAmount = v or 1
		amount:SetContentAlignment(5)
		amount:SetText(actualAmount)
		amount:SetFont("WNBleedingMinutesBoldNoClamp")
		amount:SizeToContents()
		amount:Center()

		if (!inventory:FindEmptySlot(width, height)) then
			amount:SetTextColor(Color(150, 150, 150, 255))
			title:SetTextColor(Color(150, 150, 150, 255))
		end

		local invisibleButton = frame:Add("DButton")
		invisibleButton:SetSize(modelPanel:GetWide() + textPanel:GetWide() + amountPanel:GetWide(), frame:GetTall())
		invisibleButton:SetText("")
		invisibleButton.Paint = function(panel, w, h)
			if (panel:IsHovered() and inventory:FindEmptySlot(width, height)) then
				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 15)))
				surface.DrawOutlinedRect(SScaleMin(4 / 3), SScaleMin(4 / 3), w - SScaleMin(8 / 3), h - SScaleMin(8 / 3))
			end
		end

		invisibleButton.DoClick = function()
			if (inventory:FindEmptySlot(width, height)) then
				actualAmount = actualAmount - 1
				if (actualAmount == 0) then
					frame:Remove()
				else
					amount:SetText(actualAmount)
				end

				client:NotifyLocalized(L("smugglerPickupItem", actualTitle))
				surface.PlaySound("helix/ui/press.wav")
				netstream.Start("SmugglingCachePickup", k)
			else
				client:NotifyLocalized(L("smugglerPickupNoSpace", actualTitle))
			end
		end
	end
end

vgui.Register("PickupCache", PANEL, "EditablePanel")