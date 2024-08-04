--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- luacheck: read globals SMUGGLER_BUY SMUGGLER_SELL SMUGGLER_BOTH SMUGGLER_WELCOME SMUGGLER_LEAVE SMUGGLER_NOTRADE SMUGGLER_PRICE
-- luacheck: read globals SMUGGLER_STOCK SMUGGLER_MODE SMUGGLER_MAXSTOCK SMUGGLER_SELLANDBUY SMUGGLER_SELLONLY SMUGGLER_BUYONLY SMUGGLER_TEXT
local PANEL = {}
local PLUGIN = PLUGIN

AccessorFunc(PANEL, "bReadOnly", "ReadOnly", FORCE_BOOL)

function PANEL:Init()
	self:SetSize(ScrW() * 0.45, ScrH() * 0.65)
	self:SetTitle("")
	self:DockPadding(SScaleMin(10 / 3), SScaleMin(18 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
	self:Center()
	DFrameFixer(self)

	local header = self:Add("Panel")
	header:SetTall(SScaleMin(45 / 3))
	header:Dock(TOP)
	header.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, h - 1, w, h - 1)
	end

	self.smugglerName = header:Add("DLabel")
	self.smugglerName:Dock(LEFT)
	self.smugglerName:SetText("John Doe")
	self.smugglerName:SetTextColor(color_white)
	self.smugglerName:SetFont("TitlesFontNoBoldNoClamp")
	self.smugglerName:SizeToContents()

	self.ourName = header:Add("DLabel")
	self.ourName:Dock(RIGHT)
	self.ourName:SetWide(self:GetWide() * 0.5 - SScaleMin(15 / 3))
	self.ourName:SetText(L"you".." ("..ix.currency.Get(LocalPlayer():GetCharacter():GetMoney())..")")
	self.ourName:SetTextInset(0, 0)
	self.ourName:SetTextColor(color_white)
	self.ourName:SetFont("TitlesFontNoBoldNoClamp")

	local footer = self:Add("Panel")
	footer:SetTall(SScaleMin(34 / 3))
	footer:Dock(BOTTOM)

	self.smugglerSell = footer:Add("DButton")
	self.smugglerSell:SetFont("TitlesFontNoBoldNoClamp")
	self.smugglerSell:Dock(LEFT)
	self.smugglerSell:SetContentAlignment(5)
	self.smugglerSell:DockMargin(0, 0, SScaleMin(10 / 3), 0)
	-- The text says purchase but the smuggler is selling it to us.
	self.smugglerSell:SetText(L"purchase")
	self.smugglerSell:SetTextColor(color_white)
	self.smugglerSell:SizeToContents()
	self.smugglerSell:SetWide(self.smugglerSell:GetWide() + SScaleMin(20 / 3))

	self.smugglerSell.DoClick = function(this)
		if (IsValid(self.activeSell)) then
			net.Start("ixSmugglerTrade")
				net.WriteString(self.activeSell.item)
				net.WriteBool(false)
				net.WriteBool(false)
			net.SendToServer()
		end
	end

	self.smugglerSellDeliver = footer:Add("DButton")
	self.smugglerSellDeliver:SetFont("TitlesFontNoBoldNoClamp")
	self.smugglerSellDeliver:Dock(FILL)
	self.smugglerSellDeliver:SetContentAlignment(5)
	-- The text says purchase but the smuggler is selling it to us.
	self.smugglerSellDeliver:SetText(L"smugglerSelectDelivery")
	self.smugglerSellDeliver:SetTextColor(color_white)
	self.smugglerSellDeliver:SizeToContents()
	self.smugglerSellDeliver:DockMargin(0, 0, SScaleMin(10 / 3), 0)
	self.smugglerSellDeliver.DoClick = function(this)
		if (!self.entity.pickupLocation or self.entity.pickupLocation == "") then
			local stashList = {}

			for k, v in pairs(self.entity.stashList) do
				stashList[v] = true
			end

			local list = {}
			for _, v in ipairs(ents.FindByClass("ix_pickupcache")) do
				if (stashList[v:GetLocationId()]) then
					list[#list + 1] = {text = v:GetDisplayName(), value = v}
				end
			end
			Derma_Select("Select a pickup location", "", list, "Select pickup location", "Select", function(value, text)
				net.Start("ixSmugglerChosePickup")
					net.WriteEntity(value)
				net.SendToServer()
			end, "Cancel", function() end)
		else
			if (IsValid(self.activeSell)) then
				net.Start("ixSmugglerTrade")
					net.WriteString(self.activeSell.item)
					net.WriteBool(false)
					net.WriteBool(true)
				net.SendToServer()
			end
		end
	end

	self.smugglerBuy = footer:Add("DButton")
	self.smugglerBuy:SetFont("TitlesFontNoBoldNoClamp")
	self.smugglerBuy:SetWide(self:GetWide() * 0.5 - SScaleMin(18 / 3))
	self.smugglerBuy:Dock(RIGHT)
	self.smugglerBuy:SetContentAlignment(5)
	self.smugglerBuy:SetText(L"sell")
	self.smugglerBuy:SetTextColor(color_white)
	self.smugglerBuy.DoClick = function(this)
		if (IsValid(self.activeBuy)) then
			net.Start("ixSmugglerTrade")
				net.WriteString(self.activeBuy.item)
				net.WriteBool(true)
			net.SendToServer()
		end
	end

	self.selling = self:Add("DScrollPanel")
	self.selling:SetWide(self:GetWide() * 0.5 - 7)
	self.selling:Dock(LEFT)
	self.selling:DockMargin(0, SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
	self.selling.Paint = function(this, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(w - 1, 0, w - 1, h)
	end

	self.sellingItems = self.selling:Add("DListLayout")
	self.sellingItems:SetSize(self.selling:GetSize())
	self.sellingItems:SetTall(ScrH())

	self.buying = self:Add("DScrollPanel")
	self.buying:SetWide(self:GetWide() * 0.5 - SScaleMin(7 / 3))
	self.buying:Dock(RIGHT)
	self.buying:DockMargin(SScaleMin(10 / 3), SScaleMin(10 / 3), 0, SScaleMin(10 / 3))

	self.buyingItems = self.buying:Add("DListLayout")
	self.buyingItems:SetSize(self.buying:GetSize())
	self.buyingItems.rightSide = true

	self.sellingList = {}
	self.buyingList = {}
end

function PANEL:addItem(uniqueID, listID)
	local entity = self.entity
	local items = entity.items
	local data = items[uniqueID]

	if ((!listID or listID == "selling") and !IsValid(self.sellingList[uniqueID])
	and ix.item.list[uniqueID] and PLUGIN.itemList[uniqueID] and PLUGIN.itemList[uniqueID].sell) then
		if (data and data[SMUGGLER_MODE] and data[SMUGGLER_MODE] != SMUGGLER_BUYONLY) then
			local item = self.sellingItems:Add("ixSmugglerItem")
			item:Setup(uniqueID)

			self.sellingList[uniqueID] = item
			self.sellingItems:InvalidateLayout()
		end
	end

	if ((!listID or listID == "buying") and !IsValid(self.buyingList[uniqueID])
	and LocalPlayer():GetCharacter():GetInventory():HasItem(uniqueID)
	and PLUGIN.itemList[uniqueID] and PLUGIN.itemList[uniqueID].buy) then
		if (data and data[SMUGGLER_MODE] and data[SMUGGLER_MODE] != SMUGGLER_SELLONLY) then
			local item = self.buyingItems:Add("ixSmugglerItem")
			item.isLocal = true
			item:Setup(uniqueID)

			self.buyingList[uniqueID] = item
			self.buyingItems:InvalidateLayout()
		end
	end
end

function PANEL:removeItem(uniqueID, listID)
	if (!listID or listID == "selling") then
		if (IsValid(self.sellingList[uniqueID])) then
			self.sellingList[uniqueID]:Remove()
			self.sellingItems:InvalidateLayout()
		end
	end

	if (!listID or listID == "buying") then
		if (IsValid(self.buyingList[uniqueID])) then
			self.buyingList[uniqueID]:Remove()
			self.buyingItems:InvalidateLayout()
		end
	end
end

function PANEL:Setup(entity)
	self.entity = entity
	self:SetTitle(entity:GetDisplayName())
	self.lblTitle:SizeToContents()
	self.smugglerName:SetText(entity:GetDisplayName()..(entity.money and " ("..ix.currency.Get(entity.money)..")" or "").." (total stock: "..entity:GetTotalStock().."/"..entity.maxStock..")")

	self.smugglerBuy:SetEnabled(!self:GetReadOnly())
	self.smugglerSell:SetEnabled(!self:GetReadOnly())
	self.smugglerSellDeliver:SetEnabled(!self:GetReadOnly())

	self:SetButtonStatus(self.smugglerBuy, !self:GetReadOnly())
	self:SetButtonStatus(self.smugglerSell, !self:GetReadOnly())
	self:SetButtonStatus(self.smugglerSellDeliver, !self:GetReadOnly())

	if (entity.pickupLocation and entity.pickupLocation != "") then
		self.smugglerSellDeliver:SetText(L("smugglerDeliverTo", entity.pickupLocation))
	end

	for k, _ in SortedPairs(entity.items) do
		self:addItem(k, "selling")
	end

	for _, v in SortedPairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
		self:addItem(v.uniqueID, "buying")
	end
end

function PANEL:OnRemove()
	net.Start("ixSmugglerClose")
	net.SendToServer()

	if (IsValid(ix.gui.smugglerEditor)) then
		ix.gui.smugglerEditor:Remove()
	end
end

function PANEL:Think()
	local entity = self.entity

	if (!IsValid(entity)) then
		self:Remove()

		return
	end

	if ((self.nextUpdate or 0) < CurTime()) then
		self.smugglerName:SetText(entity:GetDisplayName()..(entity.money and " ("..ix.currency.Get(entity.money)..")" or "").." (total stock: "..entity:GetTotalStock().."/"..entity.maxStock..")")
		self.smugglerName:SizeToContents()
		self.ourName:SetText(L"you".." ("..ix.currency.Get(LocalPlayer():GetCharacter():GetMoney())..")")

		self.nextUpdate = CurTime() + 0.25
	end
end

function PANEL:OnItemSelected(panel)
	local price = self.entity:GetPrice(panel.item, panel.isLocal)

	if (panel.isLocal) then
		self.smugglerBuy:SetText(L"sell".." ("..ix.currency.Get(price)..")")
	else
		self.smugglerSell:SetText(L"purchase".." ("..ix.currency.Get(price)..")")
		self.smugglerSell:SizeToContents()
		self.smugglerSell:SetWide(self.smugglerSell:GetWide() + SScaleMin(20 / 3))
	end
end

function PANEL:SetButtonStatus(parent, bDisabled)
	if (bDisabled) then
		parent:SetTextColor(color_white)
	else
		parent:SetTextColor(Color(255, 255, 255, 30))
	end
end

vgui.Register("ixSmuggler", PANEL, "DFrame")

PANEL = {}

function PANEL:Init()
	self:SetTall(SScaleMin(36 / 3))
	self:DockMargin(self:GetParent().rightSide and SScaleMin(15 / 3) or 0, self:GetParent().firstItem and SScaleMin(4 / 3) or 0, !self:GetParent().rightSide and SScaleMin(10 / 3) or 0, 0)

	if !self:GetParent().firstItem then
		self:GetParent().firstItem = true
	end

	self.icon = self:Add("SpawnIcon")
	self.icon:SetPos(SScaleMin(2 / 3), SScaleMin(2 / 3))
	self.icon:SetSize(SScaleMin(32 / 3), SScaleMin(32 / 3))
	self.icon:SetModel("models/error.mdl")

	self.name = self:Add("DLabel")
	self.name:Dock(FILL)
	self.name:DockMargin(SScaleMin(42 / 3), 0, 0, 0)
	self.name:SetFont("TitlesFontNoClamp")
	self.name:SetTextColor(color_white)

	self.click = self:Add("DButton")
	self.click:Dock(FILL)
	self.click:SetText("")
	self.click.Paint = function() end
	self.click.DoClick = function(this)
		if (self.isLocal) then
			ix.gui.smuggler.activeBuy = self
		else
			ix.gui.smuggler.activeSell = self
		end

		ix.gui.smuggler:OnItemSelected(self)
	end
end

function PANEL:SetCallback(callback)
	self.click.DoClick = function(this)
		callback()
		self.selected = true
	end
end

function PANEL:Setup(uniqueID)
	local item = ix.item.list[uniqueID]

	if (item and PLUGIN.itemList[uniqueID]) then
		self.item = uniqueID
		self.icon:SetModel(item:GetModel(), item:GetSkin())
		self.name:SetText(item:GetName())
		self.itemName = item:GetName()

		self.click:SetHelixTooltip(function(tooltip)
			ix.hud.PopulateItemTooltip(tooltip, item)

			local entity = ix.gui.smuggler.entity
			if (entity and entity.items[self.item]) then
				local stock = tooltip:AddRowAfter("name", "stock")
				local stockLvl, maxStock = entity:GetStock(uniqueID)
				if (self.isLocal) then
					local canBuy = math.min(entity.maxStock - stockLvl, maxStock - stockLvl)
					local inventory = LocalPlayer():GetCharacter():GetInventory()
					stock:SetText(L("smugglerStock", canBuy, inventory:GetItemCount(uniqueID)))
				else
					if (stockLvl > 0) then
						stock:SetText(L("smugglerAvailable", stockLvl))
					else
						stock:SetText(L("smugglerAvailableDelivery"))
					end
				end

				stock:SetBackgroundColor(derma.GetColor("Info", self))
				stock:SizeToContents()
			end

			if (PLUGIN.itemList[uniqueID].stackSize) then
				local stackSize = tooltip:AddRowAfter("name", "stackSize")
				stackSize:SetText(L("smugglerStackSize", PLUGIN.itemList[uniqueID].stackSize))
				stackSize:SetBackgroundColor(derma.GetColor("Info", self))
				stackSize:SizeToContents()
			end
		end)
	end
end

function PANEL:Think()
	if ((self.nextUpdate or 0) < CurTime()) then
		local entity = ix.gui.smuggler.entity

		if (entity and self.isLocal) then
			local count = LocalPlayer():GetCharacter():GetInventory():GetItemCount(self.item)

			if (count == 0) then
				self:Remove()
			end
		end

		self.nextUpdate = CurTime() + 0.1
	end
end

function PANEL:Paint(w, h)
	if (ix.gui.smuggler.activeBuy == self or ix.gui.smuggler.activeSell == self) then
		surface.SetDrawColor(ix.config.Get("color"))
	else
		surface.SetDrawColor(0, 0, 0, 100)
	end

	surface.DrawRect(0, 0, w, h)
end

vgui.Register("ixSmugglerItem", PANEL, "DPanel")
