--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


if (SERVER) then
	util.AddNetworkString("ixBagDrop")
end

ITEM.name = "Bag"
ITEM.description = "A bag to hold items."
ITEM.model = "models/props_c17/suitcase001a.mdl"
ITEM.category = "Storage"
ITEM.width = 1
ITEM.height = 1
ITEM.invWidth = 4
ITEM.invHeight = 2
ITEM.isBag = true
ITEM.functions.View = {
	icon = "icon16/briefcase.png",
	OnClick = function(item)
		local index = item:GetData("id", "")

		if (index) then
			local panel = ix.gui["inv"..index]
			local inventory = ix.item.inventories[index]
			local parent
			local iconSize = SScaleMin(90 / 3)

			if ix.gui.menuInventoryParent then
				if IsValid(ix.gui.menuInventoryParent.backpacks) then
					parent = IsValid(ix.gui.menuInventoryParent.backpacks) and ix.gui.menuInventoryParent.backpacks
				else
					parent = ix.gui.openedStorage
				end
			else
				parent = ix.gui.openedStorage
			end

			if (IsValid(panel)) then
				panel:Remove()
			end

			if (inventory and inventory.slots) then
				panel = vgui.Create("ixInventory", IsValid(parent) and parent or nil)
				panel:SetInventory(inventory)
				panel:Dock(LEFT)
				panel:DockMargin(0, SScaleMin(30 / 3), 0, 0)

				if (parent == ix.gui.openedStorage or item.name == "Suitcase") then
					if (panel) then
						panel:Remove()
					end

					local DFrame = vgui.Create("DFrame", IsValid(parent) and parent or nil)
					-- 4 and 30 are accounting for the size of DFrame borders here
					DFrame:SetSize(
						item.invWidth * (iconSize + 2) + SScaleMin(4 / 3),
						item.invHeight * (iconSize + SScaleMin(2 / 3)) + SScaleMin(30 / 3)
					)
					DFrame:SetTitle(item.GetName and item:GetName() or L(item.name))
					DFrame:SetDraggable(true)
					DFrame:MoveToFront()

					if item.name == "Suitcase" and (ix.gui.menu and parent != ix.gui.openedStorage) then
						DFrame:SetParent(ix.gui.menuInventoryParent)
					else
						DFrame:MakePopup()
					end

					DFrameFixer(DFrame, true, true)

					parent.bagFrame = DFrame

					panel = vgui.Create("ixInventory", DFrame)
					panel:Dock(TOP)
					panel:SetInventory(inventory)

					DFrame:SetPos(input.GetCursorPos())
				else
					panel:MoveToFront()
				end

				ix.gui["inv"..index] = panel
			else
				ErrorNoHalt("[Helix] Attempt to view an uninitialized inventory '"..index.."'\n")
			end

		end

		return false
	end,
	OnCanRun = function(item)
		if (CLIENT) and item.name != "Suitcase" and
		(!ix.gui.openedStorage or ix.gui.openedStorage and !IsValid(ix.gui.openedStorage)) then return false end
		return !IsValid(item.entity) and item:GetData("id") and !IsValid(ix.gui["inv" .. item:GetData("id", "")])
	end
}
ITEM.functions.combine = {
	OnRun = function(item, data)
		ix.item.instances[data[1]]:Transfer(item:GetData("id"))

		return false
	end,
	OnCanRun = function(item, data)
		local index = item:GetData("id", "")

		if (index) then
			local inventory = ix.item.inventories[index]

			if (inventory) then
				return true
			end
		end

		return false
	end
}

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		end
	end
end

-- Called when a new instance of this item has been made.
function ITEM:OnInstanced(invID, x, y)
	local inventory = ix.item.inventories[invID]

	ix.inventory.New(inventory and inventory.owner or 0, self.uniqueID, function(inv)
		local client = inv:GetOwner()

		inv.vars.isBag = self.uniqueID
		self:SetData("id", inv:GetID())

		if (IsValid(client)) then
			inv:AddReceiver(client)
		end
	end)
end

function ITEM:GetInventory()
	local index = self:GetData("id")

	if (index) then
		return ix.item.inventories[index]
	end
end

ITEM.GetInv = ITEM.GetInventory

-- Called when the item first appears for a client.
function ITEM:OnSendData()
	local index = self:GetData("id")

	if (index) then
		local inventory = ix.item.inventories[index]

		if (inventory) then
			inventory.vars.isBag = self.uniqueID
			inventory:Sync(self.player)
			inventory:AddReceiver(self.player)
		else
			local owner = self.player:GetCharacter():GetID()

			ix.inventory.Restore(self:GetData("id"), self.invWidth, self.invHeight, function(inv)
				inv.vars.isBag = self.uniqueID
				inv:SetOwner(owner, true)

				if (!inv.owner) then
					return
				end

				for client, character in ix.util.GetCharacters() do
					if (character:GetID() == inv.owner) then
						inv:AddReceiver(client)
						break
					end
				end
			end)
		end
	else
		ix.inventory.New(self.player:GetCharacter():GetID(), self.uniqueID, function(inv)
			self:SetData("id", inv:GetID())
		end)
	end
end

ITEM.postHooks.drop = function(item, result)
	local index = item:GetData("id")
	local inventory = ix.item.inventories[index]

	-- don't allow transferring items within bag that are in use
	if (inventory) then
		for _, v in pairs(inventory:GetItems()) do
			if (v:GetData("equip") == true) then
				local owner = item.player

				if (owner and IsValid(owner)) then
					return
				end
			end
		end
	end

	local query = mysql:Update("ix_inventories")
		query:Update("character_id", 0)
		query:Where("inventory_id", index)
	query:Execute()

	net.Start("ixBagDrop")
		net.WriteUInt(index, 32)
	net.Send(item.player)

	if item.name != "Suitcase" and item:GetData("equip", false) then
		local bodyGroupIndex = item.player:FindBodygroupByName(item.bodygroup)
		local client = item.player
		local char = client:GetCharacter()
		local groups = char:GetData("groups", {})

		if (bodyGroupIndex > -1) then
			groups[bodyGroupIndex] = 0
			char:SetData("groups", groups)
			item.player:SetBodygroup(bodyGroupIndex, 0)

			item:SetData("equip", false)
			netstream.Start(client, "ItemEquipBodygroups", bodyGroupIndex, 0)
		end
	end

	net.Start("ixSyncBagSlots")
	net.Send(item.player)
end

if (CLIENT) then
	net.Receive("ixBagDrop", function()
		local index = net.ReadUInt(32)
		local panel = ix.gui["inv"..index]
		if (panel and panel:IsVisible() and string.find(tostring(panel:GetParent()), "DFrame")) then
			panel:GetParent():Close()
			return
		end

		if panel and panel:IsVisible() and string.find(tostring(panel), "Panel") then
			panel:Remove()
			return
		end

		if (panel and panel:IsVisible()) then
			panel:Close()
			return
		end
	end)
end

-- Called before the item is permanently deleted.
function ITEM:OnRemoved()
	local index = self:GetData("id")

	if (index) then
		local query = mysql:Delete("ix_items")
			query:Where("inventory_id", index)
		query:Execute()

		query = mysql:Delete("ix_inventories")
			query:Where("inventory_id", index)
		query:Execute()
	end
end

-- Called when the item should tell whether or not it can be transfered between inventories.
function ITEM:CanTransfer(oldInventory, newInventory)
	local index = self:GetData("id")

	if (newInventory) then
		if (newInventory.vars and newInventory.vars.isBag) then
			return false
		end

		local index2 = newInventory:GetID()

		if (index == index2) then
			return false
		end

		for _, v in pairs(self:GetInventory():GetItems()) do
			if (v:GetData("id") == index2) then
				return false
			end
		end

		if index2 and newInventory.vars then
			for _, v in pairs(newInventory:GetItems()) do
				if v.name == self.name then
					if newInventory:GetOwner() then
						if v.name == "Suitcase" then
							newInventory:GetOwner():NotifyLocalized("You can't carry more than one suitcase!")
						else
							newInventory:GetOwner():NotifyLocalized("You can't carry more than one of this bag!")
						end
					end

					return false
				end
			end
		end
	end

	return !newInventory or newInventory:GetID() != oldInventory:GetID() or newInventory.vars.isBag
end

function ITEM:OnTransferred(curInv, inventory)
	local bagInventory = self:GetInventory()

	if (isfunction(curInv.GetOwner)) then
		local owner = curInv:GetOwner()

		if (IsValid(owner)) then
			bagInventory:RemoveReceiver(owner)
		end
	end

	if (isfunction(inventory.GetOwner)) then
		local owner = inventory:GetOwner()

		if (IsValid(owner)) then
			bagInventory:AddReceiver(owner)
			bagInventory:SetOwner(owner)
		end
	else
		-- it's not in a valid inventory so nobody owns this bag
		bagInventory:SetOwner(nil)
	end

	hook.Run("OnBagItemTransferred", self, curInv, inventory)
end

-- Called after the item is registered into the item tables.
function ITEM:OnRegistered()
	ix.inventory.Register(self.uniqueID, self.invWidth, self.invHeight, true)
end
