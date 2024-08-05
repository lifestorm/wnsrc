--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local RECEIVER_NAME = "ixInventoryItem"

-- The queue for the rendered icons.
ICON_RENDER_QUEUE = ICON_RENDER_QUEUE or {}

local iconSize = SScaleMin(90 / 3)

local function PaintLockedSlot(slot, w, h)
	surface.SetDrawColor(35, 35, 35, 85)
	surface.DrawRect(1, 1, w - SScaleMin(2 / 3), h - SScaleMin(2 / 3))
	surface.SetDrawColor(80, 80, 80, 255)
	surface.DrawOutlinedRect(1, 1, w - SScaleMin(2 / 3), h - SScaleMin(2 / 3))

	surface.SetDrawColor(80, 80, 80, 110)
	surface.DrawLine( 1, 1, iconSize - SScaleMin(2 / 3), iconSize - SScaleMin(2 / 3) )
	surface.DrawLine( 1, iconSize - SScaleMin(2 / 3), iconSize - SScaleMin(2 / 3), 1 )
end

-- To make making inventory variant, This must be followed up.
local function RenderNewIcon(panel, itemTable)
	local model = itemTable:GetModel()

	-- re-render icons
	if ((itemTable.iconCam and !ICON_RENDER_QUEUE[string.utf8lower(model)]) or itemTable.forceRender) then
		local iconCam = itemTable.iconCam
		iconCam = {
			cam_pos = iconCam.pos,
			cam_ang = iconCam.ang,
			cam_fov = iconCam.fov,
		}
		ICON_RENDER_QUEUE[string.utf8lower(model)] = true

		panel.Icon:RebuildSpawnIconEx(
			iconCam
		)
	end
end

local function InventoryAction(action, itemID, invID, data)
	net.Start("ixInventoryAction")
		net.WriteString(action)
		net.WriteUInt(itemID, 32)
		net.WriteUInt(invID, 32)
		net.WriteTable(data or {})
	net.SendToServer()
end

local PANEL = {}

AccessorFunc(PANEL, "itemTable", "ItemTable")
AccessorFunc(PANEL, "inventoryID", "InventoryID")

function PANEL:Init()
	self:Droppable(RECEIVER_NAME)
end

function PANEL:OnMousePressed(code)
	if (code == MOUSE_LEFT and self:IsDraggable()) then
		self:MouseCapture(true)
		self:DragMousePress(code)

		self.clickX, self.clickY = input.GetCursorPos()

		if (input.IsKeyDown(KEY_LSHIFT)) then
			self:DoShiftMove()
		end
	elseif (code == MOUSE_RIGHT and self.DoRightClick) then
		self:DoRightClick()
	end
end

function PANEL:OnMouseReleased(code)
	-- move the item into the world if we're dropping on something that doesn't handle inventory item drops
	if (!dragndrop.m_ReceiverSlot or dragndrop.m_ReceiverSlot.Name != RECEIVER_NAME) then
		self:OnDrop(dragndrop.IsDragging())
	end

	self:DragMouseRelease(code)
	self:SetZPos(99)
	self:MouseCapture(false)
end

function PANEL:DoShiftMove()
	local itemTable = self.itemTable
	local inventory = self.inventoryID
	local storageInv = ix.gui.openedStorage

	if (itemTable and inventory and storageInv and IsValid(storageInv)) then
		net.Start("ixInventoryShiftMove")
			net.WriteFloat(itemTable.id)
			net.WriteFloat(storageInv:GetStorageID())
		net.SendToServer()

		local path = "willardnetworks/inventory/"
		local randomSounds = {"inv_move1.wav", "inv_move2.wav", "inv_move3.wav", "inv_move4.mp3", "inv_move5.mp3", "inv_move6.mp3"}
		surface.PlaySound(path .. table.Random(randomSounds))
	end
end

function PANEL:DoRightClick()
	local itemTable = self.itemTable
	local inventory = self.inventoryID

	if (itemTable and inventory) then
		itemTable.player = LocalPlayer()

		local menu = DermaMenu()
		local override = hook.Run("CreateItemInteractionMenu", self, menu, itemTable)

		if (override == true) then
			if (menu.Remove) then
				menu:Remove()
			end

			return
		end

		for k, v in SortedPairs(itemTable.functions) do
			if (k == "drop" or k == "combine" or k == "combined" or (v.OnCanRun and v.OnCanRun(itemTable) == false)) then
				continue
			end

			-- is Multi-Option Function
			if (v.isMulti) then
				local subMenu, subMenuOption = menu:AddSubMenu(L(v.name or k), function()
					itemTable.player = LocalPlayer()
						local send = true

						if (v.OnClick) then
							send = v.OnClick(itemTable)
						end

						if (v.sound) then
							surface.PlaySound(v.sound)
						end

						if (send != false) then
							InventoryAction(k, itemTable.id, inventory)
						end
					itemTable.player = nil
				end)
				subMenuOption:SetImage(v.icon or "icon16/brick.png")

				if (v.multiOptions) then
					local options = isfunction(v.multiOptions) and v.multiOptions(itemTable, LocalPlayer()) or v.multiOptions

					for _, sub in pairs(options) do
						subMenu:AddOption(L(sub.name or "subOption"), function()
							itemTable.player = LocalPlayer()
								local send = true

								if (sub.OnClick) then
									send = sub.OnClick(itemTable)
								end

								if (sub.sound) then
									surface.PlaySound(sub.sound)
								end

								if (send != false) then
									InventoryAction(k, itemTable.id, inventory, sub.data)
								end
							itemTable.player = nil
						end)
					end
				end
			else
				menu:AddOption(L(v.name or k), function()
					itemTable.player = LocalPlayer()
						local send = true

						if (v.OnClick) then
							send = v.OnClick(itemTable)
						end

						if (v.sound) then
							surface.PlaySound(v.sound)
						end

						if (send != false) then
							InventoryAction(k, itemTable.id, inventory)
						end
					itemTable.player = nil
				end):SetImage(v.icon or "icon16/brick.png")
			end
		end

		-- we want drop to show up as the last option
		local info = itemTable.functions.drop

		if (info and info.OnCanRun and info.OnCanRun(itemTable) != false) then
			menu:AddOption(L(info.name or "drop"), function()
				itemTable.player = LocalPlayer()
					local send = true

					if (info.OnClick) then
						send = info.OnClick(itemTable)
					end

					if (info.sound) then
						surface.PlaySound(info.sound)
					end

					if (send != false) then
						InventoryAction("drop", itemTable.id, inventory)
					end
				itemTable.player = nil
			end):SetImage(info.icon or "icon16/brick.png")
		end

		menu:Open()
		for _, v in pairs(menu:GetChildren()[1]:GetChildren()) do
			v:SetFont("MenuFontNoClamp")
		end

		itemTable.player = nil
	end
end

local XYchanges = {
	[1] = {x = 1, y = 6},
	[2] = {x = 1, y = 7},
	[3] = {x = 1, y = 8},
	[4] = {x = 1, y = 9},
	[5] = {x = 1, y = 10},
}

function PANEL:OnDrop(bDragging, inventoryPanel, inventory, gridX, gridY)
	local item = self.itemTable

	if (!item or !bDragging) then
		return
	end

	if (inventory and inventory.vars and inventory.vars.isEquipSlots) then
		if (gridX == 5 and gridY <= 5) then
			gridX, gridY = XYchanges[gridY].x, XYchanges[gridY].y
		end
	end

	if (!IsValid(inventoryPanel)) then
		local inventoryID = self.inventoryID

		if (inventoryID) then
			InventoryAction("drop", item.id, inventoryID, {})
		end
	elseif (inventoryPanel:IsAllEmpty(gridX, gridY, item.width, item.height, self)) then
		local oldX, oldY = self.gridX, self.gridY

		if (oldX != gridX or oldY != gridY or self.inventoryID != inventoryPanel.invID) then
			self:Move(gridX, gridY, inventoryPanel)
		end
	elseif (inventoryPanel.combineItem) then
		local combineItem = inventoryPanel.combineItem
		local inventoryID = combineItem.invID

		if (inventoryID) then
			local info = combineItem.functions.combine

			if (info and info.OnCanRun and info.OnCanRun(combineItem, {item.id}) != false) then
				combineItem.player = LocalPlayer()

				if (combineItem.functions.combine.sound) then
					surface.PlaySound(combineItem.functions.combine.sound)
				end

				InventoryAction("combine", combineItem.id, inventoryID, {item.id})
				combineItem.player = nil
			end

			local info2 = item.functions.combined

			if (info2 and info2.OnCanRun and info2.OnCanRun(item, {combineItem.id}) != false) then
				item.player = LocalPlayer()
				
				InventoryAction("combined", item.id, inventoryID, {combineItem.id})
				item.player = nil
			end
		end
	end
end

function PANEL:Move(newX, newY, givenInventory, bNoSend)
	local iconSize2 = givenInventory.iconSize
	local oldX, oldY = self.gridX, self.gridY
	local oldParent = self:GetParent()

	if (givenInventory:OnTransfer(oldX, oldY, newX, newY, oldParent, bNoSend) == false) then
		return
	end

	local isEqSlots = givenInventory:IsEquipSlotsPanel()
	local x = (newX - 1 + (isEqSlots and newY > 5 and 4 or 0)) * iconSize2
	local y = (newY - 1 - (isEqSlots and newY > 5 and 5 or 0)) * iconSize2 + givenInventory:GetPadding(2)

	self.gridX = newX
	self.gridY = newY

	self:SetParent(givenInventory)
	self:SetPos(x, y)

	if (self.slots) then
		for _, v in ipairs(self.slots) do
			if (IsValid(v) and v.item == self) then
				v.item = nil
			end
		end
	end

	self.slots = {}

	for currentX = 1, self.gridW do
		for currentY = 1, self.gridH do
			local slot = givenInventory.slots[self.gridX + currentX - 1][self.gridY + currentY - 1]

			slot.item = self
			self.slots[#self.slots + 1] = slot
		end
	end

	local path = "willardnetworks/inventory/"
	local randomSounds = {"inv_move1.wav", "inv_move2.wav", "inv_move3.wav", "inv_move4.mp3", "inv_move5.mp3", "inv_move6.mp3"}
	surface.PlaySound(path..table.Random(randomSounds))
end

function PANEL:PaintOver(width, height)
	local itemTable = self.itemTable

	if (itemTable and itemTable.PaintOver) then
		itemTable.PaintOver(self, itemTable, width, height)
	end
end

function PANEL:ExtraPaint(width, height)
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(0, 0, 0, 85)
	surface.DrawRect(2, 2, width - 0, height - 4)

	self:ExtraPaint(width, height)
end

vgui.Register("ixItemIcon", PANEL, "SpawnIcon")

DEFINE_BASECLASS("DModelPanel")

PANEL = {}

AccessorFunc(PANEL, "itemTable", "ItemTable")
AccessorFunc(PANEL, "inventoryID", "InventoryID")

function PANEL:Init()
	self:Droppable(RECEIVER_NAME)
end

function PANEL:OnMousePressed(code)
	if (code == MOUSE_LEFT and self:IsDraggable()) then
		self:MouseCapture(true)
		self:DragMousePress(code)

		self.clickX, self.clickY = input.GetCursorPos()

		if (input.IsKeyDown(KEY_LSHIFT)) then
			self:DoShiftMove()
		end
	elseif (code == MOUSE_RIGHT and self.DoRightClick) then
		self:DoRightClick()
	end
end

function PANEL:OnMouseReleased(code)
	-- move the item into the world if we're dropping on something that doesn't handle inventory item drops
	if (!dragndrop.m_ReceiverSlot or dragndrop.m_ReceiverSlot.Name != RECEIVER_NAME) then
		self:OnDrop(dragndrop.IsDragging())
	end

	self:DragMouseRelease(code)
	self:SetZPos(99)
	self:MouseCapture(false)
end

function PANEL:DoShiftMove()
	local itemTable = self.itemTable
	local inventory = self.inventoryID
	local storageInv = ix.gui.openedStorage

	if (itemTable and inventory and storageInv and IsValid(storageInv)) then
		net.Start("ixInventoryShiftMove")
			net.WriteFloat(itemTable.id)
			net.WriteFloat(storageInv:GetStorageID())
		net.SendToServer()

		local path = "willardnetworks/inventory/"
		local randomSounds = {"inv_move1.wav", "inv_move2.wav", "inv_move3.wav", "inv_move4.mp3", "inv_move5.mp3", "inv_move6.mp3"}
		surface.PlaySound(path .. table.Random(randomSounds))
	end
end

function PANEL:DoRightClick()
	local itemTable = self.itemTable
	local inventory = self.inventoryID

	if (itemTable and inventory) then
		itemTable.player = LocalPlayer()

		local menu = DermaMenu()
		local override = hook.Run("CreateItemInteractionMenu", self, menu, itemTable)

		if (override == true) then
			if (menu.Remove) then
				menu:Remove()
			end

			return
		end

		for k, v in SortedPairs(itemTable.functions) do
			if (k == "drop" or k == "combine" or (v.OnCanRun and v.OnCanRun(itemTable) == false)) then
				continue
			end

			-- is Multi-Option Function
			if (v.isMulti) then
				local subMenu, subMenuOption = menu:AddSubMenu(L(v.name or k), function()
					itemTable.player = LocalPlayer()
						local send = true

						if (v.OnClick) then
							send = v.OnClick(itemTable)
						end

						if (v.sound) then
							surface.PlaySound(v.sound)
						end

						if (send != false) then
							InventoryAction(k, itemTable.id, inventory)
						end
					itemTable.player = nil
				end)
				subMenuOption:SetImage(v.icon or "icon16/brick.png")

				if (v.multiOptions) then
					local options = isfunction(v.multiOptions) and v.multiOptions(itemTable, LocalPlayer()) or v.multiOptions

					for _, sub in pairs(options) do
						subMenu:AddOption(L(sub.name or "subOption"), function()
							itemTable.player = LocalPlayer()
								local send = true

								if (sub.OnClick) then
									send = sub.OnClick(itemTable)
								end

								if (sub.sound) then
									surface.PlaySound(sub.sound)
								end

								if (send != false) then
									InventoryAction(k, itemTable.id, inventory, sub.data)
								end
							itemTable.player = nil
						end)
					end
				end
			else
				menu:AddOption(L(v.name or k), function()
					itemTable.player = LocalPlayer()
						local send = true

						if (v.OnClick) then
							send = v.OnClick(itemTable)
						end

						if (v.sound) then
							surface.PlaySound(v.sound)
						end

						if (send != false) then
							InventoryAction(k, itemTable.id, inventory)
						end
					itemTable.player = nil
				end):SetImage(v.icon or "icon16/brick.png")
			end
		end

		-- we want drop to show up as the last option
		local info = itemTable.functions.drop

		if (info and info.OnCanRun and info.OnCanRun(itemTable) != false) then
			menu:AddOption(L(info.name or "drop"), function()
				itemTable.player = LocalPlayer()
					local send = true

					if (info.OnClick) then
						send = info.OnClick(itemTable)
					end

					if (info.sound) then
						surface.PlaySound(info.sound)
					end

					if (send != false) then
						InventoryAction("drop", itemTable.id, inventory)
					end
				itemTable.player = nil
			end):SetImage(info.icon or "icon16/brick.png")
		end

		menu:Open()
		for _, v in pairs(menu:GetChildren()[1]:GetChildren()) do
			v:SetFont("MenuFontNoClamp")
		end

		itemTable.player = nil
	end
end

local XYchanges = {
	[1] = {x = 1, y = 6},
	[2] = {x = 1, y = 7},
	[3] = {x = 1, y = 8},
	[4] = {x = 1, y = 9},
	[5] = {x = 1, y = 10},
}

function PANEL:OnDrop(bDragging, inventoryPanel, inventory, gridX, gridY)
	local item = self.itemTable

	if (!item or !bDragging) then
		return
	end

	if (inventory and inventory.vars and inventory.vars.isEquipSlots) then
		if (gridX == 5 and gridY <= 5) then
			gridX, gridY = XYchanges[gridY].x, XYchanges[gridY].y
		end
	end

	if (!IsValid(inventoryPanel)) then
		local inventoryID = self.inventoryID

		if (inventoryID) then
			InventoryAction("drop", item.id, inventoryID, {})
		end
	elseif (inventoryPanel:IsAllEmpty(gridX, gridY, item.width, item.height, self)) then
		local oldX, oldY = self.gridX, self.gridY

		if (oldX != gridX or oldY != gridY or self.inventoryID != inventoryPanel.invID) then
			self:Move(gridX, gridY, inventoryPanel)
		end
	elseif (inventoryPanel.combineItem) then
		local combineItem = inventoryPanel.combineItem
		local inventoryID = combineItem.invID

		if (inventoryID) then
			local info = combineItem.functions.combine

			if (info and info.OnCanRun and info.OnCanRun(combineItem, {item.id}) != false) then
				combineItem.player = LocalPlayer()

				if (combineItem.functions.combine.sound) then
					surface.PlaySound(combineItem.functions.combine.sound)
				end

				InventoryAction("combine", combineItem.id, inventoryID, {item.id})
				combineItem.player = nil
			end

			local info2 = item.functions.combined

			if (info2 and info2.OnCanRun and info2.OnCanRun(item, {combineItem.id}) != false) then
				item.player = LocalPlayer()
				InventoryAction("combined", item.id, inventoryID, {combineItem.id})
				item.player = nil
			end
		end
	end
end

function PANEL:Move(newX, newY, givenInventory, bNoSend)
	local iconSize2 = givenInventory.iconSize
	local oldX, oldY = self.gridX, self.gridY
	local oldParent = self:GetParent()

	if (givenInventory:OnTransfer(oldX, oldY, newX, newY, oldParent, bNoSend) == false) then
		return
	end

	local isEqSlots = givenInventory:IsEquipSlotsPanel()
	local x = (newX - 1 + (isEqSlots and newY > 5 and 4 or 0)) * iconSize2
	local y = (newY - 1 - (isEqSlots and newY > 5 and 5 or 0)) * iconSize2 + givenInventory:GetPadding(2)

	self.gridX = newX
	self.gridY = newY

	self:SetParent(givenInventory)
	self:SetPos(x, y)

	if (self.slots) then
		for _, v in ipairs(self.slots) do
			if (IsValid(v) and v.item == self) then
				v.item = nil
			end
		end
	end

	self.slots = {}

	for currentX = 1, self.gridW do
		for currentY = 1, self.gridH do
			local slot = givenInventory.slots[self.gridX + currentX - 1][self.gridY + currentY - 1]

			slot.item = self
			self.slots[#self.slots + 1] = slot
		end
	end

	local path = "willardnetworks/inventory/"
	local randomSounds = {"inv_move1.wav", "inv_move2.wav", "inv_move3.wav", "inv_move4.mp3", "inv_move5.mp3", "inv_move6.mp3"}
	surface.PlaySound(path .. table.Random(randomSounds))
end

function PANEL:PaintOver(width, height)
	local itemTable = self.itemTable

	if (itemTable and itemTable.PaintOver) then
		itemTable.PaintOver(self, itemTable, width, height)
	end
end

function PANEL:ExtraPaint(width, height) end

function PANEL:Paint(width, height)
	surface.SetDrawColor(0, 0, 0, 85)
	surface.DrawRect(2, 2, width - 0, height - 4)

	self:ExtraPaint(width, height)

	BaseClass.Paint(self, width, height)
end

vgui.Register("ixItemIconAdvanced", PANEL, "DModelPanel")

PANEL = {}

AccessorFunc(PANEL, "iconSize", "IconSize", FORCE_NUMBER)
AccessorFunc(PANEL, "bHighlighted", "Highlighted", FORCE_BOOL)

function PANEL:Init()
	self:SetIconSize(iconSize)
	self:Receiver(RECEIVER_NAME, self.ReceiveDrop)
	self:RequestFocus()

	self.Paint = function(this, w, h)
		render.ClearDepth() -- Fix for broken DModelPanel item icon depth
		surface.SetDrawColor(0, 0, 0, 85)
	end

	self.panels = {}
end

function PANEL:GetPadding(index)
	return select(index, self:GetDockPadding())
end

function PANEL:FitParent(invWidth, invHeight)
	local parent = self:GetParent()

	if (!IsValid(parent)) then
		return
	end

	local width, height = parent:GetSize()
	local padding = 4
	local iconSize2

	if (invWidth > invHeight) then
		iconSize2 = (width - padding * 2) / invWidth
	elseif (invHeight > invWidth) then
		iconSize2 = (height - padding * 2) / invHeight
	else
		-- we use height because the titlebar will make it more tall than it is wide
		iconSize2 = (height - padding * 2) / invHeight - 4
	end

	self:SetSize(iconSize2 * invWidth + padding * 2, iconSize2 * invHeight + padding * 2)
	self:SetIconSize(iconSize2)
end

function PANEL:OnRemove()
	if (self.childPanels) then
		for _, v in ipairs(self.childPanels) do
			if (v != self) then
				v:Remove()
			end
		end
	end
end

function PANEL:ViewOnly()
	self.viewOnly = true

	for _, icon in pairs(self.panels) do
		icon.OnMousePressed = nil
		icon.OnMouseReleased = nil
		icon.doRightClick = nil
	end
end

function PANEL:SetInventory(inventory, bFitParent)
	if (inventory.slots) then
		local invWidth, invHeight = inventory:GetSize()
		self.invID = inventory:GetID()

		if (IsValid(ix.gui.inv1) and ix.gui.inv1.childPanels and inventory != LocalPlayer():GetCharacter():GetInventory()) then
			self:SetIconSize(ix.gui.inv1:GetIconSize())
			self:SetPaintedManually(true)
			self.bNoBackgroundBlur = true

			ix.gui.inv1.childPanels[#ix.gui.inv1.childPanels + 1] = self
		elseif (bFitParent) then
			self:FitParent(invWidth, invHeight)
		else
			self:SetSize(self.iconSize, self.iconSize)
		end

		self:SetGridSize(invWidth, invHeight)

		for x, items in pairs(inventory.slots) do
			for y, data in pairs(items) do
				if (!data.id) then continue end

				local item = ix.item.instances[data.id]

				if (item and !IsValid(self.panels[item.id])) then
					local icon = self:AddIcon(item, item:GetModel() or "models/props_junk/popcan01a.mdl",
						x, y, item.width, item.height, item:GetSkin(), item:GetModelBodygroups(), item.color, item.material, item.rotate, item.OnInventoryDraw)

					if (IsValid(icon)) then
						icon:SetHelixTooltip(function(tooltip)
							ix.hud.PopulateItemTooltip(tooltip, item)
						end)

						self.panels[item.id] = icon
					end
				end
			end
		end
	end
end

function PANEL:OnKeyCodePressed(key)
	local hoveredPanel = vgui.GetHoveredPanel()

	if (hoveredPanel and (hoveredPanel:GetName() == "ixItemIcon" or hoveredPanel:GetName() == "ixItemIconAdvanced")) then
		if (key == KEY_Q) then
			hoveredPanel:OnDrop(true)
		elseif (key == KEY_R) then
			local itemTable = hoveredPanel:GetItemTable()
			local itemBase = itemTable.base

			if (itemBase == "base_ammo") then
				InventoryAction("use", itemTable.id, itemTable.invID)
			end
		end
	end
end

function PANEL:SetGridSize(w, h)
	local iconSize2 = self.iconSize
	local newWidth = w * iconSize2
	local newHeight = h * iconSize2 + self:GetPadding(2) + self:GetPadding(4)

	self.gridW = w
	self.gridH = h

	self:SetSize(newWidth, newHeight)
	self:BuildSlots()
end

function PANEL:PerformLayout(width, height)
	if (self.Sizing and self.gridW and self.gridH) then
		local newWidth = (width - 8) / self.gridW
		local newHeight = (height - self:GetPadding(2) + self:GetPadding(4)) / self.gridH

		self:SetIconSize((newWidth + newHeight) / 2)
		self:RebuildItems()
	end
end

function PANEL:BuildSlots()
	local iconSize2 = self.iconSize

	self.slots = self.slots or {}

	local function PaintSlot(slot, w, h)
		surface.SetDrawColor(35, 35, 35, 85)
		surface.DrawRect(1, 1, w - SScaleMin(2 / 3), h - SScaleMin(2 / 3))

		surface.SetDrawColor(80, 80, 80, 255)
		surface.DrawOutlinedRect(1, 1, w - SScaleMin(2 / 3), h - SScaleMin(2 / 3))
	end

	for _, v in ipairs(self.slots) do
		for _, v2 in ipairs(v) do
			v2:Remove()
		end
	end

	self.slots = {}

	for x = 1, self.gridW do
		self.slots[x] = {}

		for y = 1, self.gridH do
			local slot = self:Add("DPanel")
			slot:SetZPos(-999)
			slot.gridX = x
			slot.gridY = y
			slot:SetPos((x - 1) * iconSize2, (y - 1) * iconSize2 + self:GetPadding(2))
			slot:SetSize(iconSize2, iconSize2)
			slot.Paint = PaintSlot

			self.slots[x][y] = slot
		end
	end
end

function PANEL:RebuildItems()
	local iconSize2 = self.iconSize

	for x = 1, self.gridW do
		for y = 1, self.gridH do
			local slot = self.slots[x][y]

			slot:SetPos((x - 1) * iconSize2, (y - 1) * iconSize2 + self:GetPadding(2))
			slot:SetSize(iconSize2, iconSize2)
		end
	end

	for _, v in pairs(self.panels) do
		if (IsValid(v)) then
			v:SetPos(self.slots[v.gridX][v.gridY]:GetPos())
			v:SetSize(v.gridW * iconSize2, v.gridH * iconSize2)
		end
	end
end

function PANEL:PaintDragPreview(width, height, mouseX, mouseY, itemPanel)
	local iconSize2 = self.iconSize
	local item = itemPanel:GetItemTable()

	if (item) then
		local inventory = ix.item.inventories[self.invID]
		local dropX = math.ceil((mouseX - 0 - (itemPanel.gridW - 1) * 32) / iconSize2)
		local dropY = math.ceil((mouseY - self:GetPadding(2) - (itemPanel.gridH - 1) * 32) / iconSize2)

		local hoveredPanel = vgui.GetHoveredPanel()

		if (IsValid(hoveredPanel) and hoveredPanel != itemPanel and hoveredPanel.GetItemTable) then
			local hoveredItem = hoveredPanel:GetItemTable()

			if (hoveredItem) then
				local info = hoveredItem.functions.combine
				local info2 = item.functions.combined

				if ((info and info.OnCanRun and info.OnCanRun(hoveredItem, {item.id}) != false) or (info2 and info2.OnCanRun and info2.OnCanRun(item, {hoveredItem.id}) != false)) then
					surface.SetDrawColor(ColorAlpha(derma.GetColor("Info", self, Color(200, 0, 0)), 20))
					surface.DrawRect(
						hoveredPanel.x,
						hoveredPanel.y,
						hoveredPanel:GetWide(),
						hoveredPanel:GetTall()
					)

					self.combineItem = hoveredItem

					return
				end
			end
		end

		self.combineItem = nil
		local isEquipSlots = inventory.vars and inventory.vars.isEquipSlots or false

		-- don't draw grid if we're dragging it out of bounds
		if (inventory) then
			local invWidth, invHeight = inventory:GetSize()
			if (dropX < 1 or dropY < 1 or
				dropX - (isEquipSlots and dropX == 5 and 4 or 0) + itemPanel.gridW - 1 > invWidth or
				dropY + itemPanel.gridH - 1 > invHeight) then
				return
			end
		end

		for x = 0, itemPanel.gridW - 1 do
			for y = 0, itemPanel.gridH - 1 do
				local x2, y2 = dropX + x, dropY + y
				local eqX2, eqY2 = (!isEquipSlots and x2 or 1), (!isEquipSlots and y2 or x2 == 5 and y2 + 5 or y2)

				local bEmpty = self:IsEmpty(eqX2, eqY2, itemPanel)
				local canMove = (hook.Run("CanMoveItemSameInv", item, inventory, eqX2, eqY2) == true)

				if (isEquipSlots and canMove and bEmpty) then
					surface.SetDrawColor(0, 255, 0, 10)
				elseif (!isEquipSlots and bEmpty) then
					surface.SetDrawColor(0, 255, 0, 10)
				else
					surface.SetDrawColor(255, 255, 0, 10)
				end

				surface.DrawRect((x2 - 1) * iconSize, (y2 - 1) * iconSize2 + self:GetPadding(2), iconSize2, iconSize2)
			end
		end
	end
end

function PANEL:PaintOver(width, height)
	local panel = self.previewPanel

	if (IsValid(panel)) then
		local itemPanel = (dragndrop.GetDroppable() or {})[1]

		if (IsValid(itemPanel)) then
			if not (self.slots) then
				return
			end

			self:PaintDragPreview(width, height, self.previewX, self.previewY, itemPanel)
		end
	end

	self.previewPanel = nil
end

function PANEL:IsEmpty(x, y, this)
	if (self.slots) then
		return (self.slots[x] and self.slots[x][y]) and (!IsValid(self.slots[x][y].item) or self.slots[x][y].item == this)
	end
end

function PANEL:IsAllEmpty(x, y, width, height, this)
	for x2 = 0, width - 1 do
		for y2 = 0, height - 1 do
			if (!self:IsEmpty(x + x2, y + y2, this)) then
				return false
			end
		end
	end

	return true
end

function PANEL:OnTransfer(oldX, oldY, x, y, oldInventory, noSend)
	local inventories = ix.item.inventories
	local inventory = inventories[oldInventory.invID]
	local inventory2 = inventories[self.invID]
	local item
	if (inventory) then
		item = inventory:GetItemAt(oldX, oldY)

		if (!item) then
			return false
		end

		if (hook.Run("CanTransferItem", item, inventories[oldInventory.invID], inventories[self.invID], x, y) == false) then
			return false, "notAllowed"
		end

		if (item.CanTransfer and
			item:CanTransfer(inventory, inventory != inventory2 and inventory2 or nil) == false) then
			return false
		end
	end

	if (!noSend) then
		net.Start("ixInventoryMove")
			net.WriteUInt(oldX, 6)
			net.WriteUInt(oldY, 6)
			net.WriteUInt(x, 6)
			net.WriteUInt(y, 6)
			net.WriteUInt(oldInventory.invID, 32)
			net.WriteUInt(self != oldInventory and self.invID or oldInventory.invID, 32)
		net.SendToServer()
	end

	if (inventory) then
		inventory.slots[oldX][oldY] = nil
	end

	if (item and inventory2) then
		inventory2.slots[x] = inventory2.slots[x] or {}
		inventory2.slots[x][y] = item
	end
end

function PANEL:IsEquipSlotsPanel()
	local inventory = ix.item.inventories[self.invID]
	if inventory and inventory.vars then
		if inventory.vars.isEquipSlots then
			return true
		end
	end

	return false
end

function PANEL:AddIcon(item, model, x, y, w, h, skin, bodygroups, color, material, bRotate, OnInventoryDraw)
	local iconSize2 = self.iconSize
	local advanced = color or material or bRotate or OnInventoryDraw

	w = w or 1
	h = h or 1

	if (self.slots[x] and self.slots[x][y]) then
		local panel = advanced and self:Add("ixItemIconAdvanced") or self:Add("ixItemIcon")
		panel:SetSize(w * iconSize2, h * iconSize2)
		panel:SetZPos(999)
		panel:InvalidateLayout(true)
		panel:SetModel(model, skin, bodygroups)
		panel:SetPos(self.slots[x][y]:GetPos())
		panel.gridX = x
		panel.gridY = y

		if (advanced) then
			local entity = panel:GetEntity()
			color = color or Color(255, 255, 255)

			if (color) then
				panel:SetColor(color)
			end

			if (material) then
				entity:SetMaterial(material)
			end

			if (skin) then
				entity:SetSkin(skin)
			end

			if (OnInventoryDraw) then
				OnInventoryDraw(item, entity)
			end

			panel.LayoutEntity = function(this, entity)
				if (ix.gui.menu and IsValid(ix.gui.menu)) then
					this:SetColor(ColorAlpha(color, ix.gui.menu:GetAlpha()))
				end

				if (!bRotate) then return end

				local angle = entity:GetAngles()
				angle.y = angle.y + FrameTime() * 30
				entity:SetAngles(angle)
			end
		end

		if (self:IsEquipSlotsPanel()) then
			if self.slots[1] then
				-- witness my error noia
				local x1W = self.slots[1][1] and self.slots[1][1].GetWide and self.slots[1][1]:GetWide()
				local x1Pos = self.slots[1][1] and self.slots[1][1].GetPos and self.slots[1][1]:GetPos()
				local _, newY = false, false
				if self.slots[1][y - 5] and self.slots[1][y - 5].GetPos then
					_, newY = self.slots[1][y - 5]:GetPos()
				end

				if (y > 5 and x == 1) and (x1W and x1Pos and newY) then
					panel:SetPos(x1Pos + (x1W * 4), newY)
				end
			end
		end

		panel.gridW = w
		panel.gridH = h

		local inventory = ix.item.inventories[self.invID]

		if (!inventory) then
			return
		end

		local itemTable = inventory:GetItemAt(panel.gridX, panel.gridY)

		panel:SetInventoryID(inventory:GetID())
		panel:SetItemTable(itemTable)

		if (self.panels[itemTable:GetID()]) then
			self.panels[itemTable:GetID()]:Remove()
		end

		if (advanced) then
			if (itemTable.iconCam) then
				panel:SetCamPos(itemTable.iconCam.pos)
				panel:SetFOV(itemTable.iconCam.fov)
				panel:SetLookAng(itemTable.iconCam.ang)
			else
				local entity = panel:GetEntity()
				local pos = entity:GetPos()
				local camData = PositionSpawnIcon(entity, pos)

				if (camData) then
					panel:SetCamPos(camData.origin)
					panel:SetFOV(camData.fov)
					panel:SetLookAng(camData.angles)
				end
			end
		else
			if (itemTable.exRender) then
				panel.Icon:SetVisible(false)
				panel.ExtraPaint = function(this, panelX, panelY)
					local exIcon = ikon:GetIcon(itemTable.uniqueID)
					if (exIcon) then
						surface.SetMaterial(exIcon)
						surface.SetDrawColor(color_white)
						surface.DrawTexturedRect(0, 0, panelX, panelY)
					else
						ikon:renderIcon(
							itemTable.uniqueID,
							itemTable.width,
							itemTable.height,
							itemTable:GetModel(),
							itemTable.iconCam
						)
					end
				end
			else
				-- yeah..
				RenderNewIcon(panel, itemTable)
			end
		end

		panel.slots = {}

		for i = 0, w - 1 do
			for i2 = 0, h - 1 do
				local slot = self.slots[x + i] and self.slots[x + i][y + i2]

				if (IsValid(slot)) then
					slot.item = panel
					panel.slots[#panel.slots + 1] = slot
				else
					for _, v in ipairs(panel.slots) do
						v.item = nil
					end

					panel:Remove()

					return
				end
			end
		end

		return panel
	end
end

function PANEL:ReceiveDrop(panels, bDropped, menuIndex, x, y)
	local panel = panels[1]

	if (!IsValid(panel)) then
		self.previewPanel = nil
		return
	end

	if (bDropped) then
		local inventory = ix.item.inventories[self.invID]

		if (inventory and panel.OnDrop) then
			local dropX = math.ceil((x - 0 - (panel.gridW - 1) * 32) / self.iconSize)
			local dropY = math.ceil((y - self:GetPadding(2) - (panel.gridH - 1) * 32) / self.iconSize)

			panel:OnDrop(true, self, inventory, dropX, dropY)
		end

		self.previewPanel = nil
	else
		self.previewPanel = panel
		self.previewX = x
		self.previewY = y
	end
end

function PANEL:CreateNoSlots(backpacks, type)
	if backpacks.slots then
		for _, v in pairs(backpacks.slots) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end

	backpacks.slots = {}

	if type == "noSlots" then return end

	for x = 1, (!type and 7 or type == "noLarge" and 4 or 3) do
		for y = 1, 4 do
			local noSlot = backpacks:Add("Panel")
			noSlot:SetPos((x - 1) * iconSize + (iconSize * self:GetNoSlotsXPosMultiplier(type)), (y - 1) * iconSize + SScaleMin(30 / 3))
			noSlot:SetSize(iconSize, iconSize)

			noSlot.Paint = PaintLockedSlot

			backpacks.slots[#backpacks.slots + 1] = noSlot
		end
	end
end

function PANEL:UpdateNoSlots()
	local backpacks = ix.gui.menuInventoryParent.backpacks
	if !backpacks or backpacks and !IsValid(backpacks) then return end

	local char = LocalPlayer():GetCharacter()
	if !char then return end

	local inventory = char:GetInventory()
	if !inventory then return end

	local hasSmallBag = inventory:HasItem("smallbag")
	local hasLargeBag = inventory:HasItem("largebag")

	local smallBag = hasSmallBag and self:GetIsInEquipSlots(char, hasSmallBag)
	local largeBag = hasLargeBag and self:GetIsInEquipSlots(char, hasLargeBag)

	if (!smallBag and !largeBag) then
		self:CreateNoSlots(backpacks)
	elseif largeBag and !smallBag then
		self:CreateNoSlots(backpacks, "noSmall")
	elseif !largeBag and smallBag then
		self:CreateNoSlots(backpacks, "noLarge")
	elseif largeBag and smallBag then
		self:CreateNoSlots(backpacks, "noSlots")
	end
end

function PANEL:GetIsInEquipSlots(char, item)
	local eqSlots = char:GetEquipInventory()
	if !eqSlots then return false end

	if !item.invID then return false end
	if item.invID != eqSlots then return false end

	return true
end

function PANEL:GetNoSlotsXPosMultiplier(type)
	return (!type and 0 or type == "noLarge" and 3 or 4)
end

vgui.Register("ixInventory", PANEL, "Panel")

hook.Add("CreateMenuButtons", "ixInventory", function(tabs)
	if (hook.Run("CanPlayerViewInventory") == false) then
		return
	end

	tabs["inv"] = {
		bDefault = true,

		RowNumber = 2,

		Width = 19,

		Height = 17,

		Icon = "willardnetworks/tabmenu/navicons/inventory.png",

		Create = function(info, tempCont)
			local titlePushDown = SScaleMin(30 / 3)
			local padding = SScaleMin(30 / 3)
			local topPushDown = SScaleMin(150 / 3)
			local scale780 = SScaleMin(780 / 3)
			local scale120 = SScaleMin(120 / 3)

			tempCont:SetSize(ScrW(), ScrH())

			local newCont = tempCont:Add("Panel")
			newCont:SetSize(ScrW() - (topPushDown * 2), scale120 + scale780 + titlePushDown)
			newCont:Center()

			local sizeXtitle, sizeYtitle = newCont:GetWide(), scale120
			local sizeXcontent, sizeYcontent = newCont:GetWide(), (scale780)

			newCont.titlePanel = newCont:Add("Panel")
			newCont.titlePanel:SetSize(sizeXtitle, sizeYtitle)
			newCont.titlePanel:SetPos(newCont:GetWide() * 0.5 - newCont.titlePanel:GetWide() * 0.5)

			local invTitleIcon = newCont.titlePanel:Add("DImage")
			invTitleIcon:SetImage("willardnetworks/tabmenu/navicons/inventory.png")
			invTitleIcon:SetSize(SScaleMin(19 / 3), SScaleMin(17 / 3))

			local invTitle = newCont.titlePanel:Add("DLabel")
			invTitle:SetFont("TitlesFontNoClamp")
			invTitle:SetText("Inventory")
			invTitle:SizeToContents()
			invTitle:SetPos(SScaleMin(27 / 3), (SScaleMin(17 / 3) - invTitle:GetTall()) * 0.5)

			newCont.contentFrame = newCont:Add("Panel")
			newCont.contentFrame:SetSize(sizeXcontent, sizeYcontent)
			newCont.contentFrame:SetPos(newCont:GetWide() * 0.5 - newCont.contentFrame:GetWide() * 0.5, titlePushDown)

			newCont.invFrame = newCont.contentFrame:Add("Panel")
			newCont.invFrame:SetSize(newCont.contentFrame:GetWide() * 0.5 - padding, newCont.contentFrame:GetTall())
			newCont.invFrame:Dock(LEFT)
			newCont.invFrame:DockMargin(0, 0, padding, 0)

			newCont.backpacks = newCont.invFrame:Add("Panel")
			newCont.backpacks:SetTall(((iconSize + SScaleMin(2 / 3)) * 4) + SScaleMin(21 / 3))
			newCont.backpacks:Dock(BOTTOM)

			ix.gui.menuInventoryParent = newCont

			local canvas = newCont.invFrame:Add("DTileLayout")
			local canvasLayout = canvas.PerformLayout
			canvas.PerformLayout = nil -- we'll layout after we add the panels instead of each time one is added
			canvas:SetBorder(0)
			canvas:SetSpaceX(2)
			canvas:SetSpaceY(2)
			canvas:Dock(FILL)

			ix.gui.menuInventorynewCont = canvas

			local panel = canvas:Add("ixInventory")
			panel.bNoBackgroundBlur = true
			panel.childPanels = {}

			local char = LocalPlayer():GetCharacter()
			local inventory = char:GetInventory()

			if (inventory) then
				panel:SetInventory(inventory)
			end

			ix.gui.inv1 = panel
			ix.gui.inv1:UpdateNoSlots()

			local bFoundLarge, bFoundSmall = false, false
			for _, v in SortedPairsByMemberValue(inventory:GetItemsByBase("base_containerbags", true), "id") do
				if v.invID and char.GetEquipInventory and v.invID != char:GetEquipInventory() then continue end
				if (!v.isBag) then
					continue
				end

				if (v.name != "Large Bag" and v.name != "Small Bag") then
					continue
				elseif (v.name == "Large Bag") then
					if (bFoundLarge) then
						continue
					else
						bFoundLarge = true
					end
				elseif (v.name == "Small Bag") then
					if (bFoundSmall) then
						continue
					else
						bFoundSmall = true
					end
				end
				v.functions.View.OnClick(v)
			end

			canvas.PerformLayout = canvasLayout
			canvas:Layout()

			newCont.charFrame = newCont.contentFrame:Add("CharFrame")
			hook.Run("PostCharInfoFrameOpened", newCont.charFrame)

			local backspaceTitleIcon = newCont.backpacks:Add("DImage")
			backspaceTitleIcon:SetImage("willardnetworks/mainmenu/content.png")
			backspaceTitleIcon:SetSize(SScaleMin(16 / 3), SScaleMin(16 / 3))
			backspaceTitleIcon:SetPos(SScaleMin(1 / 3), SScaleMin(2 / 3))

			local backspaceTitle = newCont.backpacks:Add("DLabel")
			backspaceTitle:SetFont("SmallerTitleFontNoClamp")
			backspaceTitle:SetText("Backspace")
			backspaceTitle:SizeToContents()
			backspaceTitle:SetPos(SScaleMin(25 / 3))
		end
	}
end)

hook.Add("PostRenderVGUI", "ixInvHelper", function()
	local pnl = ix.gui.inv1

	hook.Run("PostDrawInventory", pnl)
end)
