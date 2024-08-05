--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.base = "base_bags"
ITEM.allowNesting = false -- Whether to allow this bag to be stored inside other bags.
ITEM.restriction = {} -- List of item IDs allowed to be put inside this bag. Supports item bases.
ITEM.noOpen = false -- Whether to disallow this bag from being opened through right click or not.
ITEM.noEquip = false -- Whether to disallow this bag from being 'equipped' by the player.

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

				if (parent == ix.gui.openedStorage or !item.noOpen) then
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

					if (!item.noOpen and (ix.gui.menu and parent != ix.gui.openedStorage)) then
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
		if (CLIENT) and item.noOpen and
		(!ix.gui.openedStorage or ix.gui.openedStorage and !IsValid(ix.gui.openedStorage)) then return false end
		return !IsValid(item.entity) and item:GetData("id") and !IsValid(ix.gui["inv" .. item:GetData("id", "")])
	end
}

-- Allows bags to be opened from the world.
ITEM.functions.ViewAlt = {
	name = "View",
	OnRun = function(item)
		local inventory = item:GetInventory()

		if (inventory) then
			ix.storage.Open(item.player, inventory, {
				name = item.name,
				entity = item.entity,
				searchTime = 0
			})
		end

		return false
	end,
	OnCanRun = function(item)
		return IsValid(item.entity)
	end
}

ITEM.functions.Equip = {
	OnRun = function(item, data)
        local owner = item:GetOwner()
		
        if (owner) then
            local index = owner:FindBodygroupByName(item.uniqueID == "largebag" and owner:GetActiveCombineSuit() and "cp_Bag" or item.bodygroup)
            local groups = owner:GetCharacter():GetData("groups", {})

            if (index > -1) then
                groups[index] = 1
                owner:GetCharacter():SetData("groups", groups)
                owner:SetBodygroup(index, 1)

                netstream.Start(owner, "ItemEquipBodygroups", index, 1)
            end

			item:SetData("equip", true)
        end

		return false
	end,
	OnCanRun = function(item, creationClient)
		local client = item.player or creationClient
		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and hook.Run("CanPlayerEquipItem", client, item) != false and !item.noEquip 
	end
}

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "unequipTip",
	icon = "icon16/cross.png",
	OnRun = function(item, creationClient)
		local client = item.player or creationClient

		if (client) then
            local index = client:FindBodygroupByName(item.uniqueID == "largebag" and client:GetActiveCombineSuit() and "cp_Bag" or item.bodygroup)
            local groups = client:GetCharacter():GetData("groups", {})

            if (index > -1) then
                groups[index] = 0
                client:GetCharacter():SetData("groups", groups)
                client:SetBodygroup(index, 0)

                netstream.Start(client, "ItemEquipBodygroups", index, 0)
            end

			item:SetData("equip", false)
		end

		return false
	end,
	OnCanRun = function(item, creationClient)
		local client = item.player or creationClient

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}

-- Called when the item should tell whether or not it can be transfered between inventories.
-- Allows bags to be put inside containers.
function ITEM:CanTransfer(oldInventory, newInventory)
	local index = self:GetData("id")

	if (newInventory) then
		if (newInventory.vars and newInventory.vars.isBag and !newInventory.vars.isContainer and !self.allowNesting) then
			return false
		end

		local index2 = newInventory:GetID()

		if (index == index2) then
			return false
		end

		local curInv = self.GetInventory and self:GetInventory()
		local curInvItems = curInv and curInv.GetItems and curInv:GetItems()
		if curInvItems then
			for _, v in pairs(curInvItems) do
				if (v:GetData("id") == index2) then
					return false
				end
			end
		end
	end

	return !newInventory or newInventory:GetID() != oldInventory:GetID() or newInventory.vars.isBag
end

-- Called when a new instance of this item has been made.
function ITEM:OnInstanced(invID, x, y)
	if (self.invBeingMade) then return end
	self.invBeingMade = true

	local inventory = ix.item.inventories[invID]

	ix.inventory.New(inventory and inventory.owner or 0, self.uniqueID, function(inv)
		local client = inv:GetOwner()

		inv.vars.isBag = self.uniqueID
		inv.vars.allowNesting = self.allowNesting
		inv.vars.restriction = self.restriction
		inv.vars.noEquipInv = true
		self:SetData("id", inv:GetID())

		if (IsValid(client)) then
			inv:AddReceiver(client)
		end

		if (self.OnBagInitialized) then
			self:OnBagInitialized(inv)
		end
	end)
end

-- Called when the item first appears for a client.
function ITEM:OnSendData()
	local index = self:GetData("id")

	if (index) then
		local inventory = ix.item.inventories[index]

		if (inventory) then
			inventory.vars.isBag = self.uniqueID
			inventory.vars.allowNesting = self.allowNesting
			inventory.vars.restriction = self.restriction
			inventory.vars.noEquipInv = true

			inventory:Sync(self.player)
			inventory:AddReceiver(self.player)
		else
			local owner = self.player:GetCharacter():GetID()

			ix.inventory.Restore(self:GetData("id"), self.invWidth, self.invHeight, function(inv)
				inv.vars.isBag = self.uniqueID
				inv.vars.allowNesting = self.allowNesting
				inv.vars.restriction = self.restriction
				inv.vars.noEquipInv = true

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
		if (self.invBeingMade) then return end
		self.invBeingMade = true

		ix.inventory.New(self.player:GetCharacter():GetID(), self.uniqueID, function(inv)
			local client = inv:GetOwner()

			inv.vars.isBag = self.uniqueID
			inv.vars.allowNesting = self.allowNesting
			inv.vars.restriction = self.restriction
			inv.vars.noEquipInv = true
			self:SetData("id", inv:GetID())

			if (IsValid(client)) then
				inv:AddReceiver(client)
			end

			if (self.OnBagInitialized) then
				self:OnBagInitialized(inv)
			end
		end)
	end
end
