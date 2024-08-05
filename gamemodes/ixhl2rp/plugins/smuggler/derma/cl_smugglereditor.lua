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

function PANEL:Init()
	local entity = ix.gui.smuggler.entity

	self:SetSize(320, ScrH() * 0.65)
	self:MoveLeftOf(ix.gui.smuggler, 8)
	self:CenterVertical()
	self:SetTitle(L"smugglerEditor")
	self.lblTitle:SetTextColor(color_white)
	DFrameFixer(self, false, true)

	self.name = self:Add("DTextEntry")
	self.name:Dock(TOP)
	self.name:SetText(entity:GetDisplayName())
	self.name:SetPlaceholderText(L"name")
	self.name.OnEnter = function(this)
		if (entity:GetDisplayName() != this:GetText()) then
			self:updateSmuggler("name", this:GetText())

			if IsValid(ix.gui.smuggler) then
				ix.gui.smuggler:SetTitle(this:GetText())
				ix.gui.smuggler.lblTitle:SizeToContents()
				ix.gui.smuggler.smugglerName:SizeToContents()
			end
		end
	end

	self.description = self:Add("DTextEntry")
	self.description:Dock(TOP)
	self.description:DockMargin(0, 4, 0, 0)
	self.description:SetText(entity:GetDescription())
	self.description:SetPlaceholderText(L"description")
	self.description.OnEnter = function(this)
		if (entity:GetDescription() != this:GetText()) then
			self:updateSmuggler("description", this:GetText())
		end
	end

	self.model = self:Add("DTextEntry")
	self.model:Dock(TOP)
	self.model:DockMargin(0, 4, 0, 0)
	self.model:SetText(entity:GetModel())
	self.model:SetPlaceholderText(L"model")
	self.model.OnEnter = function(this)
		if (entity:GetModel():lower() != this:GetText():lower()) then
			self:updateSmuggler("model", this:GetText():lower())
		end
	end

	local useMoney = tonumber(entity.money) != nil

	self.money = self:Add("DTextEntry")
	self.money:Dock(TOP)
	self.money:DockMargin(0, 4, 0, 0)
	self.money:SetText(!useMoney and "∞" or entity.money)
	self.money:SetPlaceholderText(L"money")
	self.money:SetDisabled(!useMoney)
	self.money:SetEnabled(useMoney)
	self.money:SetNumeric(true)
	self.money.OnEnter = function(this)
		local value = tonumber(this:GetText()) or entity.money

		if (value == entity.money) then
			return
		end

		self:updateSmuggler("money", value)
	end

	self.useMoney = self:Add("DCheckBoxLabel")
	self.useMoney:SetText(L"smugglerUseMoney")
	self.useMoney:Dock(TOP)
	self.useMoney:DockMargin(0, 4, 0, 0)
	self.useMoney:SetChecked(useMoney)
	self.useMoney.OnChange = function(this, value)
		self:updateSmuggler("useMoney")
	end

	self.maxStock = self:Add("DTextEntry")
	self.maxStock:Dock(TOP)
	self.maxStock:DockMargin(0, 4, 0, 0)
	self.maxStock:SetText(entity.maxStock)
	self.maxStock:SetPlaceholderText(L"maxStock")
	self.maxStock:SetNumeric(true)
	self.maxStock.OnEnter = function(this)
		local value = tonumber(this:GetText()) or entity.maxStock

		if (value == entity.maxStock) then
			return
		end

		self:updateSmuggler("stockMax", value)
	end

	self.stashList = self:Add("DListView")
	self.stashList:Dock(TOP)
	self.stashList:DockMargin(0, 4, 0, 0)
	self.stashList:AddColumn("Location Id")
	self.stashList:SetTooltip("Leave list empty to use all locations and not assigned stashes\nDouble click to remove entry")
	self.stashList:SetTall(ScrH() * 0.075)
	self.stashList:SetSortable(false)

	function self.stashList:GetStashList()
		local stashes = {}

		for k, v in pairs(self:GetLines(1)) do
			if (k != 1) then
				table.insert(stashes, v:GetValue(1))
			end
		end

		return stashes
	end

	local addButton = self.stashList:AddLine("Add...")
	function addButton:OnSelect()
		Derma_StringRequest("Location Id", "Enter any location Id of the stashes that will be used", "", function(text)
			local stashList = self:GetListView()
			text = string.utf8upper(text)

			for k, v in pairs(stashList:GetLines()) do
				if (v:GetValue(1) == text) then
					return
				end
			end

			stashList:AddLine(text)

			PANEL:updateSmuggler("stashList", stashList:GetStashList())
		end)
	end

	function self.stashList:DoDoubleClick(lineId, linePanel)
		if (lineId == 1) then return end

		self:RemoveLine(lineId)

		PANEL:updateSmuggler("stashList", self:GetStashList())
	end

	if (entity.stashList and !table.IsEmpty(entity.stashList)) then
		for k, v in pairs(entity.stashList) do
			self.stashList:AddLine(v)
		end
	end

	self.searchBar = self:Add("DTextEntry")
	self.searchBar:Dock(TOP)
	self.searchBar:DockMargin(0, 4, 0, 0)
	self.searchBar:SetUpdateOnType(true)
	self.searchBar:SetPlaceholderText("Search...")
	self.searchBar.OnValueChange = function(this, value)
		self:ReloadItemList(value)
	end

	self.items = self:Add("DListView")
	self.items:Dock(FILL)
	self.items:DockMargin(0, 4, 0, 0)
	self.items:AddColumn(L"name").Header:SetTextColor(color_black)
	self.items:AddColumn(L"category").Header:SetTextColor(color_black)
	self.items:AddColumn(L"mode").Header:SetTextColor(color_black)
	self.items:AddColumn(L"stock").Header:SetTextColor(color_black)
	self.items:SetMultiSelect(false)
	self.items.OnRowRightClick = function(this, index, line)
		if (IsValid(self.menu)) then
			self.menu:Remove()
		end

		local uniqueID = line.item

		self.menu = DermaMenu()
			-- Modes of the item.
			local mode, panel = self.menu:AddSubMenu(L"mode")
			panel:SetImage("icon16/key.png")

			-- Disable buying/selling of the item.
			mode:AddOption(L"none", function()
				self:updateSmuggler("mode", {uniqueID, nil})
			end):SetImage("icon16/cog_error.png")

			if (PLUGIN.itemList[uniqueID].buy and PLUGIN.itemList[uniqueID].sell) then
				-- Allow the smuggler to sell and buy this item.
				mode:AddOption(L"smugglerBoth", function()
					self:updateSmuggler("mode", {uniqueID, SMUGGLER_SELLANDBUY})
				end):SetImage("icon16/cog.png")
			end

			if (PLUGIN.itemList[uniqueID].buy) then
				-- Only allow the smuggler to buy this item from players.
				mode:AddOption(L"smugglerBuy", function()
					self:updateSmuggler("mode", {uniqueID, SMUGGLER_BUYONLY})
				end):SetImage("icon16/cog_delete.png")
			end

			if (PLUGIN.itemList[uniqueID].sell) then
				-- Only allow the smuggler to sell this item to players.
				mode:AddOption(L"smugglerSell", function()
					self:updateSmuggler("mode", {uniqueID, SMUGGLER_SELLONLY})
				end):SetImage("icon16/cog_add.png")
			end

			local itemTable = ix.item.list[uniqueID]
			-- Only allow the smuggler to sell this item to players.
			self.menu:AddOption(L"smugglerEditCurStock", function()
			Derma_StringRequest(
				itemTable.GetName and itemTable:GetName() or L(itemTable.name),
				L"smugglerStockCurReq",
				entity:GetStock(uniqueID),
				function(text)
					self:updateSmuggler("stock", {uniqueID, text})
				end
			)
			end):SetImage("icon16/table_edit.png")
			self.menu:Open()
			self.menu.Think = function()
			if (IsValid(self.menu)) then
				self.menu:MoveToFront()
			end
		end
	end
	self:ReloadItemList()
end

function PANEL:ReloadItemList(filter)
	local entity = ix.gui.smuggler.entity
	self.lines = {}

	self.items:Clear()

	for k, info in SortedPairs(PLUGIN.itemList) do
		local v = ix.item.list[k]
		local itemName = v.GetName and v:GetName() or L(v.name)

		if (filter and !itemName:lower():find(filter:lower(), 1, false)) then
			continue
		end

		local mode = entity.items[k] and entity.items[k][SMUGGLER_MODE]
		local current, max = entity:GetStock(k)
		local panel = self.items:AddLine(
			itemName,
			info.cat or v.category or L"none",
			mode and L(SMUGGLER_TEXT[mode]) or L"none",
			max != entity.maxStock and current.."/"..max or current
		)

		panel.item = k
		self.lines[k] = panel
	end
end

function PANEL:OnRemove()
	if (IsValid(ix.gui.smuggler)) then
		ix.gui.smuggler:Remove()
	end
end

function PANEL:updateSmuggler(key, value)
	net.Start("ixSmugglerEdit")
		net.WriteString(key)
		net.WriteType(value)
	net.SendToServer()
end

function PANEL:Think()
	if (self.menu and !self.menu:IsVisible()) or !self.menu then
		self:MoveToFront()
	end
end

vgui.Register("ixSmugglerEditor", PANEL, "DFrame")
