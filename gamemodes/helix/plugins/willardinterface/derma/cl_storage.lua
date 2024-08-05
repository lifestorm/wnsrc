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

AccessorFunc(PANEL, "money", "Money", FORCE_NUMBER)

function PANEL:Init()
	self:DockPadding(1, 1, 1, 1)
	self:SetTall(SScaleMin(64 / 3))

	local textPanel = self:Add("EditablePanel")
	textPanel:Dock(TOP)
	textPanel:SetTall(SScaleMin(18 / 3))

	self.moneyLabel = textPanel:Add("DLabel")
	self.moneyLabel:SetFont("MenuFontNoClamp")
	self.moneyLabel:SetText("")
	self.moneyLabel:SetTextInset(SScaleMin(2 / 3), 0)

	self.creditText = textPanel:Add("DLabel")
	self.creditText:Dock(LEFT)
	self.creditText:SetFont("MenuFontNoClamp")
	self.creditText:SetText(string.utf8upper(" Chips"))
	self.creditText:SetTextInset(SScaleMin(2 / 3), 0)
	self.creditText:SizeToContents()

	local amountPanel = self:Add("EditablePanel")
	amountPanel:Dock(FILL)
	amountPanel.Paint = function(this, w, h)
		surface.SetDrawColor(35, 35, 35, 85)
		surface.DrawRect(1, 1, w - 2, h - 2)

		surface.SetDrawColor(80, 80, 80, 255)
		surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
	end

	self.amountEntry = amountPanel:Add("DTextEntry")
	self.amountEntry:SetFont("MenuFontNoClamp")
	self.amountEntry:Dock(FILL)
	self.amountEntry:SetNumeric(true)
	self.amountEntry:SetValue("0")
	self.amountEntry.Paint = function(this, w, h)
		this:DrawTextEntryText( Color(255, 255, 255, 255), this:GetHighlightColor(), this:GetCursorColor() )
	end

	self.transferButton = amountPanel:Add("DButton")
	self.transferButton:SetFont("ixIconsMedium")
	self.transferButton:Dock(LEFT)
	self.transferButton:SetWide(SScaleMin(50 / 3))
	self:SetLeft(false)
	self.transferButton.DoClick = function()
		local amount = math.max(0, math.Round(tonumber(self.amountEntry:GetValue()) or 0))
		self.amountEntry:SetValue("0")

		if (amount != 0) then
			self:OnTransfer(amount)
		end
	end

	self.bNoBackgroundBlur = true
	self.transferButton.Paint = nil
end

function PANEL:SetLeft(bValue)
	if (bValue) then
		self.transferButton:Dock(RIGHT)
		self.transferButton:SetText("t")
	else
		self.transferButton:Dock(LEFT)
		self.amountEntry:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
		self.transferButton:SetText("s")
	end
end

function PANEL:SetMoney(money)
	self.money = math.max(math.Round(tonumber(money) or 0), 0)

	self.moneyLabel:SetText(money)
	self.moneyLabel:Dock(LEFT)
	self.moneyLabel:SizeToContents()
	self.moneyLabel:SetTextColor(Color(255, 204, 0, 255))
end

function PANEL:OnTransfer(amount)
end

vgui.Register("ixStorageMoney", PANEL, "EditablePanel")

DEFINE_BASECLASS("EditablePanel")
PANEL = {}

AccessorFunc(PANEL, "fadeTime", "FadeTime", FORCE_NUMBER)
AccessorFunc(PANEL, "frameMargin", "FrameMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "storageID", "StorageID", FORCE_NUMBER)

local dividerWidth = SScaleMin(1920 / 3)
local dividerHeight = SScaleMin(1080 / 3)
local halfWidth = dividerWidth * 0.5

function PANEL:Init()
	if (IsValid(ix.gui.openedStorage)) then
		ix.gui.openedStorage:Remove()
	end

	ix.gui.openedStorage = self

	self:SetSize(ScrW(), ScrH())
	self:SetFadeTime(0.25)
	self:SetFrameMargin(4)

	local background = self:Add("EditablePanel")
	background:SetSize(ScrW(), ScrH())
	background.Paint = function(this, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( this, 1 )
	end

	background:MakePopup()

	self.dividerPanel = background:Add("EditablePanel")
	self.dividerPanel:SetSize(dividerWidth, dividerHeight)
	self.dividerPanel:Center()

	self.leftSide = self.dividerPanel:Add("EditablePanel")
	self.leftSide:Dock(LEFT)
	self.leftSide:SetSize(self.dividerPanel:GetWide() * 0.5, dividerHeight)
	self.leftSide.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(w - 1, SScaleMin(50 / 3), w - 1, h)
	end

	self.storageIcon = self.dividerPanel:Add("DImage")
	self.storageIcon:SetSize(SScaleMin(90 / 3), SScaleMin(90 / 3))
	self.storageIcon:SetImage("willardnetworks/storage/icon.png")
	self.storageIcon:Center()

	local topbar = background:Add("EditablePanel")
	topbar:SetSize(background:GetWide(), SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function( this, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.titleText = topbar:Add("DLabel")
	self.titleText:SetFont("CharCreationBoldTitleNoClamp")
	self.titleText:SetText("Storage Container")
	self.titleText:SetContentAlignment(5)
	self.titleText:SizeToContents()
	self.titleText:Center()

	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(20 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end
end

function PANEL:CreateContents(data, entity)
	local isEquipSlots = data and data.vars and data.vars.equipSlots or false

	self.storageInventory = self.dividerPanel:Add(isEquipSlots and "ixEquipSlots" or "ixInventory")
	self.storageInventory.bNoBackgroundBlur = true
	self.storageInventory:MoveToBack()
	self.storageInventory.Close = function(this)
		net.Start("ixStorageClose")
		net.SendToServer()
		self:Remove()
	end

	hook.Run("CreateStoreViewContents", self, data, entity)
	if entity and IsValid(entity) then
		if ix.plugin.list["inventoryslots"] and entity.GetCharacter then
			if entity:GetCharacter() and ix.plugin.list["inventoryslots"].noEquipFactions[entity:GetCharacter():GetFaction()] then
				self.storageInventory.isNoEquipFaction = true
			end
		end
	end

	if !isEquipSlots then
		self.storageMoney = self.dividerPanel:Add("ixStorageMoney")
		self.storageMoney:SetVisible(false)
		self.storageMoney.OnTransfer = function(_, amount)
			net.Start("ixStorageMoneyTake")
				net.WriteUInt(self.storageID, 32)
				net.WriteUInt(amount, 32)
			net.SendToServer()
		end

		if (self.storageMoney.creditText) then
			self.storageMoney.creditText:SetText(" CHIPS IN STORAGE")
			self.storageMoney.creditText:SizeToContents()
			self.storageMoney.creditText:Dock(LEFT)
		end
	end

	ix.gui.inv1 = self.leftSide:Add("ixInventory")
	ix.gui.inv1.bNoBackgroundBlur = true
	ix.gui.inv1.Close = function(this)
		net.Start("ixStorageClose")
		net.SendToServer()
		self:Remove()
	end

	ix.gui.equipSlots = self.leftSide:Add("ixEquipSlots")

	self.localMoney = ix.gui.inv1:Add("ixStorageMoney")
	self.localMoney:SetVisible(false)
	self.localMoney:SetLeft(true)
	self.localMoney.OnTransfer = function(_, amount)
		net.Start("ixStorageMoneyGive")
			net.WriteUInt(self.storageID, 32)
			net.WriteUInt(amount, 32)
		net.SendToServer()
	end

	self:SetAlpha(0)
	self:AlphaTo(255, self:GetFadeTime())
end

function PANEL:Think()
	if self.bagFrame and IsValid(self.bagFrame) then
		self.bagFrame:MoveToFront()
	end
end

function PANEL:OnChildAdded(panel)
	panel:SetPaintedManually(true)
end

function PANEL:OnKeyCodePressed(key)
	if (key == KEY_TAB and IsValid(self)) then
		self:Remove()
	end
end

function PANEL:SetLocalInventory(inventory)
	if (IsValid(ix.gui.inv1) and !IsValid(ix.gui.menu)) then
		ix.gui.inv1:SetInventory(inventory)

		ix.gui.inv1:Center()

		local x2, y2 = ix.gui.inv1:GetPos()

		self.localMoney:Dock(NODOCK)
		self.localMoney:SetWide(ix.gui.inv1:GetWide())
		self.localMoney:SetPos(0, ix.gui.inv1:GetTall() + SScaleMin(10 / 3))

		local padding = SScaleMin(10 / 3)

		ix.gui.inv1.invTitleIcon = self.dividerPanel:Add("DImage")
		ix.gui.inv1.invTitleIcon:SetImage("willardnetworks/tabmenu/navicons/inventory.png")
		ix.gui.inv1.invTitleIcon:SetSize(SScaleMin(19 / 3), SScaleMin(17 / 3))
		ix.gui.inv1.invTitleIcon:SetPos(x2, y2 - ix.gui.inv1.invTitleIcon:GetTall() - padding)

		ix.gui.inv1.invTitle = self.dividerPanel:Add("DLabel")
		ix.gui.inv1.invTitle:SetFont("TitlesFontNoClamp")
		ix.gui.inv1.invTitle:SetText("Inventory")
		ix.gui.inv1.invTitle:SizeToContents()
		ix.gui.inv1.invTitle:SetPos(x2 + SScaleMin(27 / 3), y2 - (ix.gui.inv1.invTitle:GetTall() * 0.8) - padding)
		ix.gui.inv1:MoveToBack()

		self.changeInv = self.dividerPanel:Add("DButton")
		self.changeInv:SetFont("MenuFontNoClamp")
		self.changeInv:SetText("VIEW EQUIP INVENTORY")
		self.changeInv:SizeToContents()
		self.changeInv:SetWide(self.changeInv:GetWide() + (padding * 2))
		self.changeInv:SetPos(x2 + ix.gui.inv1:GetWide() - self.changeInv:GetWide(), y2 - (ix.gui.inv1.invTitle:GetTall() * 0.8) - padding)
		self.changeInv.DoClick = function()
			if !ix.gui.inv1 or ix.gui.inv1 and !IsValid(ix.gui.inv1) then return end
			if !ix.gui.equipSlots or ix.gui.equipSlots and !IsValid(ix.gui.equipSlots) then return end

			if ix.gui.inv1:IsVisible() then
				ix.gui.inv1:SetVisible(false)
				ix.gui.inv1.invTitleIcon:SetVisible(false)
				ix.gui.inv1.invTitle:SetVisible(false)

				ix.gui.equipSlots:SetVisible(true)
				ix.gui.equipSlots.invTitleIcon:SetVisible(true)
				ix.gui.equipSlots.invTitle:SetVisible(true)

				local _, y3 = ix.gui.equipSlots:GetPos()
				self.changeInv:SetText("VIEW DEFAULT INVENTORY")
				self.changeInv:SizeToContents()
				self.changeInv:SetWide(self.changeInv:GetWide() + (padding * 2))

				-- Get the new pos if we need the button in the alternate position
				if (self.changeInv.altPos) then
					x2, y2 = ix.gui.inv1:GetPos()
				end

				self.changeInv:SetPos(x2 + ix.gui.inv1:GetWide() - self.changeInv:GetWide(), y3 - (ix.gui.inv1.invTitle:GetTall() * 0.8) - padding)
			else
				ix.gui.equipSlots:SetVisible(false)
				ix.gui.equipSlots.invTitleIcon:SetVisible(false)
				ix.gui.equipSlots.invTitle:SetVisible(false)

				ix.gui.inv1:SetVisible(true)
				ix.gui.inv1.invTitleIcon:SetVisible(true)
				ix.gui.inv1.invTitle:SetVisible(true)

				self.changeInv:SetText("VIEW EQUIP INVENTORY")
				self.changeInv:SizeToContents()
				self.changeInv:SetWide(self.changeInv:GetWide() + (padding * 2))

				-- Get the new pos if we need the button in the alternate position
				if (self.changeInv.altPos) then
					x2, y2 = ix.gui.inv1:GetPos()
				end

				self.changeInv:SetPos(x2 + ix.gui.inv1:GetWide() - self.changeInv:GetWide(), y2 - (ix.gui.inv1.invTitle:GetTall() * 0.8) - padding)
			end
		end
	end
end

function PANEL:SetEquipInv(inventory)
	if (IsValid(ix.gui.equipSlots) and !IsValid(ix.gui.menu)) then
		ix.gui.equipSlots:SetInventory(inventory)
		ix.gui.equipSlots:PaintParts()
		ix.gui["inv" .. inventory.id] = ix.gui.equipSlots

		ix.gui.equipSlots:Center()

		local x2, y2 = ix.gui.equipSlots:GetPos()
		local padding = SScaleMin(10 / 3)

		ix.gui.equipSlots.invTitleIcon = self.dividerPanel:Add("DImage")
		ix.gui.equipSlots.invTitleIcon:SetImage("willardnetworks/tabmenu/navicons/inventory.png")
		ix.gui.equipSlots.invTitleIcon:SetSize(SScaleMin(19 / 3), SScaleMin(17 / 3))
		ix.gui.equipSlots.invTitleIcon:SetPos(x2, y2 - ix.gui.equipSlots.invTitleIcon:GetTall() - padding)

		ix.gui.equipSlots.invTitle = self.dividerPanel:Add("DLabel")
		ix.gui.equipSlots.invTitle:SetFont("TitlesFontNoClamp")
		ix.gui.equipSlots.invTitle:SetText("Equip Inventory")
		ix.gui.equipSlots.invTitle:SizeToContents()
		ix.gui.equipSlots.invTitle:SetPos(x2 + SScaleMin(27 / 3), y2 - (ix.gui.equipSlots.invTitle:GetTall() * 0.8) - padding)

		ix.gui.equipSlots:MoveToBack()
		ix.gui.equipSlots:SetVisible(false)
		ix.gui.equipSlots.invTitleIcon:SetVisible(false)
		ix.gui.equipSlots.invTitle:SetVisible(false)
	end
end

function PANEL:SetLocalMoney(money)
	if (!self.localMoney:IsVisible()) then
		self.localMoney:SetVisible(true)
		ix.gui.inv1:SetTall(ix.gui.inv1:GetTall() + self.localMoney:GetTall() + SScaleMin(10 / 3))
	end

	self.localMoney:SetMoney(money)
end

function PANEL:SetStorageTitle(title)
end

function PANEL:SetStorageInventory(inventory)
	local isEquipSlots = inventory and inventory.vars and inventory.vars.equipSlots or false
	local isStash = inventory and inventory.vars and inventory.vars.isStash or false
	local isBag = inventory and inventory.vars and inventory.vars.noEquipInv or false
	local isCardDeck = inventory and inventory.w == 13 and inventory.h == 4 and true or false -- I know this is dumb, but helix has forced my hand.
	self.storageInventory:SetInventory(inventory)

	if (isEquipSlots) then
		self.storageInventory:PaintParts()
		if self.changeInv then self.changeInv:SetVisible(false) end
	end

	self.storageInventory:SetPos(halfWidth + (halfWidth * (isCardDeck and 0.335 or 0.5)) - self.storageInventory:GetWide() * 0.5, dividerHeight * 0.5 - self.storageInventory:GetTall() * 0.5)

	if (!isEquipSlots) then
		local x2, y2 = self.storageInventory:GetPos()

		self.storageMoney:Dock(NODOCK)
		self.storageMoney:SetWide(self.storageInventory:GetWide())
		self.storageMoney:SetPos(x2, y2 + self.storageInventory:GetTall() + SScaleMin(10 / 3))
	end

	if (isCardDeck) then -- Force some things to move around.
		self.leftSide:SetSize(self.dividerPanel:GetWide() * 0.335, dividerHeight)

		ix.gui.inv1:Center()
		ix.gui.equipSlots:Center()

		local x2, y2 = ix.gui.inv1:GetPos()
		local padding = SScaleMin(10 / 3)

		ix.gui.inv1.invTitleIcon:SetPos(x2, y2 - ix.gui.inv1.invTitleIcon:GetTall() - padding)
		ix.gui.inv1.invTitle:SetPos(x2 + SScaleMin(27 / 3), y2 - (ix.gui.inv1.invTitle:GetTall() * 0.8) - padding)

		self.changeInv.altPos = true
		self.changeInv:SetPos(x2 + ix.gui.inv1:GetWide() - self.changeInv:GetWide(), y2 - (ix.gui.inv1.invTitle:GetTall() * 0.8) - padding)

		x2, y2 = ix.gui.equipSlots:GetPos()

		ix.gui.equipSlots.invTitleIcon:SetPos(x2, y2 - ix.gui.equipSlots.invTitleIcon:GetTall() - padding)
		ix.gui.equipSlots.invTitle:SetPos(x2 + SScaleMin(27 / 3), y2 - (ix.gui.equipSlots.invTitle:GetTall() * 0.8) - padding)

		self.storageIcon:SetX(self.dividerPanel:GetWide() * 0.335 - (SScaleMin(90 / 3) * 0.5))
	end

	local x, y = self.storageInventory:GetPos()
	local padding = SScaleMin(10 / 3)

	local invTitleIcon = self.dividerPanel:Add("DImage")
	invTitleIcon:SetImage("willardnetworks/mainmenu/content.png")
	invTitleIcon:SetSize(SScaleMin(16 / 3), SScaleMin(16 / 3))
	invTitleIcon:SetPos(x, y - invTitleIcon:GetTall() - padding)

	local invTitle = self.dividerPanel:Add("DLabel")
	invTitle:SetFont("TitlesFontNoClamp")
	invTitle:SetText("Storage")
	invTitle:SizeToContents()
	invTitle:SetPos(x + SScaleMin(27 / 3), y - (invTitle:GetTall() * 0.8) - padding)

	ix.gui["inv" .. inventory:GetID()] = self.storageInventory

	if (inventory.owner and !isStash and !isBag) then
		self.changeStorageInv = self.dividerPanel:Add("DButton")
		self.changeStorageInv:SetFont("MenuFontNoClamp")
		self.changeStorageInv:SetText(!isEquipSlots and "VIEW EQUIP INVENTORY" or "VIEW DEFAULT INVENTORY")
		self.changeStorageInv:SizeToContents()
		self.changeStorageInv:SetWide(self.changeStorageInv:GetWide() + (padding * 2))
		self.changeStorageInv:SetPos(x + self.storageInventory:GetWide() - self.changeStorageInv:GetWide(), y - (invTitle:GetTall() * 0.8) - padding)
		self.changeStorageInv.DoClick = function()
			if (!IsValid(ix.gui.menu)) then
				self.shouldntRunStorage = true

				BaseClass.Remove(self)
				self.storageInventory:Remove()
				ix.gui.inv1:Remove()

				net.Start("ixSwitchPlayerInv")
				net.SendToServer()
			end
		end
	end
end

function PANEL:SetStorageMoney(money)
	if !self.storageMoney then return end

	if (!self.storageMoney:IsVisible()) then
		self.storageMoney:SetVisible(true)
		self.storageInventory:SetTall(self.storageInventory:GetTall() + self.storageMoney:GetTall() + SScaleMin(2 / 3))
	end

	self.storageMoney:SetMoney(money)
end

function PANEL:Paint(width, height)
	ix.util.DrawBlurAt(0, 0, width, height)

	for _, v in ipairs(self:GetChildren()) do
		v:PaintManual()
	end
end

function PANEL:Remove()
	self:SetAlpha(255)
	self:AlphaTo(0, self:GetFadeTime(), 0, function()
		BaseClass.Remove(self)
	end)
end

function PANEL:OnRemove()
	if (!IsValid(ix.gui.menu) and !self.shouldntRunStorage) then
		self.storageInventory:Remove()
		ix.gui.inv1:Remove()

		net.Start("ixStorageClose")
		net.SendToServer()
	end
end

vgui.Register("ixStorageView", PANEL, "EditablePanel")
