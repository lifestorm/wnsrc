--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

ix.util.Include("sv_plugin.lua")
ix.util.Include("sh_overrides.lua")

PLUGIN.name = "Inventory Slots"
PLUGIN.author = "Fruity"
PLUGIN.description = "Equip shit here."

PLUGIN.slotsW, PLUGIN.slotsH = 1, 10
PLUGIN.slots = {
	["Head"] = 1,
	["Glasses"] = 2,
	["Face"] = 3,
	["Torso"] = 4,
	["Hands"] = 5,
	["Legs"] = 6,
	["Shoes"] = 7,
	["Satchel"] = 8,
	["Bag"] = 9,
	["model"] = 10,
}

PLUGIN.noEquipFactions = PLUGIN.noEquipFactions or {}

ix.inventory.Register("equipInventory", PLUGIN.slotsW, PLUGIN.slotsH, true)

ix.char.RegisterVar("equipInventory", {
	field = "equipInventory",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true
})

function PLUGIN:IsSameOwner(oldInv, newInv)
	-- need to check for owner because it might be world
	local oldOwner = oldInv and oldInv.GetOwner and oldInv:GetOwner() or false
	local newOwner = newInv and newInv.GetOwner and newInv:GetOwner() or false

	if (oldOwner and newOwner) and (oldOwner == newOwner) then
		return oldInv:GetOwner()
	end

	return false
end

function PLUGIN:CanTransferBGClothes(oldInv, newInv)
	local owner = self:IsSameOwner(oldInv, newInv)
	local oldInvOwner = oldInv and oldInv.GetOwner and oldInv:GetOwner()
	local newInvOwner = newInv and newInv.GetOwner and newInv:GetOwner()

	if !owner and !oldInvOwner and !newInvOwner then return false end
	if !owner and IsValid(newInvOwner) then owner = newInvOwner end
	if !owner and IsValid(oldInvOwner) then owner = oldInvOwner end

	return owner or false
end

function PLUGIN:CanEquipOrUnequip(client, item, bEquip)
	if !item.outfitCategory then
		return item.invID == client:GetCharacter():GetInventory():GetID()
	end

	if (CLIENT) then return false end -- no more right clicking shit

	local player = item.GetOwner and item:GetOwner() or item.player or client
	local char = IsValid(player) and player.GetCharacter and player:GetCharacter()

	if !char then return false end

	local inv = char:GetInventory()
	if !inv then return false end

	local inventoryID = inv:GetID()
	if !inventoryID then return false end

	local equipID = char:GetEquipInventory()
	if !equipID then return item.invID == inventoryID end
	if (item.invID != equipID and bEquip) then return false end

	return true
end

function PLUGIN:CanTransferItem(itemTable, oldInv, inventory, x, y)
	return self:CanTransferToEquipSlots(itemTable, inventory, x, y, oldInv)
end

function PLUGIN:CanMoveItemSameInv(itemTable, inventory, x, y)
	return self:CanTransferToEquipSlots(itemTable, inventory, x, y)
end

function PLUGIN:Notify(client, text)
	if !client or client and !IsValid(client) then return end

	if (!client.nextEqSlotsNotify or client.nextEqSlotsNotify < CurTime()) then
		if client.Notify then client:Notify(text) end

		client.nextEqSlotsNotify = CurTime() + 2
	end
end

function PLUGIN:CanTransferToEquipSlots(itemTable, inventory, x, y, oldInv)
	local owner = self:IsSameOwner(oldInv, inventory)
	local oldInvOwner = oldInv and oldInv.GetOwner and oldInv:GetOwner()
	local newInvOwner = inventory and inventory.GetOwner and inventory:GetOwner()

	if (!inventory or inventory and inventory.GetID and inventory:GetID() == 0) and oldInv and oldInv.vars and !oldInv.vars.equipSlots then return end
	if !itemTable.outfitCategory and inventory.vars and inventory.vars.equipSlots then return false end
	if !owner and !oldInvOwner and !newInvOwner then return end
	if !owner and IsValid(newInvOwner) then owner = newInvOwner end
	if !owner and IsValid(oldInvOwner) then owner = oldInvOwner end

	if !inventory or inventory and !inventory.vars or inventory.vars and !inventory.vars.equipSlots then
		local bSuccess, reason = hook.Run("CheckCanTransferToEquipSlots", itemTable, oldInv, inventory)
		if (bSuccess == false) then
			if (reason) then self:Notify(reason) end
			return false
		else
			return true
		end
	end

	if !x or !y then return false end

	local category = itemTable.outfitCategory
	if !category then return false end

	if x != 1 then return false end -- inv w: 1, h: 10
	if (y != self.slots[itemTable.outfitCategory]) then return false end

	if owner and IsValid(owner) then
		local char = owner:GetCharacter()
		local charFaction = char and char:GetFaction() or 0

		if itemTable.outfitCategory == "model" then
			local found = false
			for _, v in pairs(inventory:GetItems()) do
				if v:GetData("equip") and v.outfitCategory != "model" and v.base != "base_maskcp" then
					found = true
					break
				end
			end

			if found and oldInv and oldInv.vars and !oldInv.vars.equipSlots then
				self:Notify(owner, "You need to unequip everything before being able to wear this outfit!")
				return false
			end
		end

		if self.noEquipFactions and self.noEquipFactions[charFaction] then
			self:Notify(owner, "Your/Target's faction cannot equip anything!")
			return false
		end

		if (itemTable.isGasmask and owner.HasGasmask and owner:HasGasmask() and oldInv and oldInv.vars and !oldInv.vars.equipSlots) then
			self:Notify(owner, "You/Target is already wearing a gas deterring item!")
			return false
		end

		if (itemTable.isCombineMask) then
			local character = owner:GetCharacter()
			if (!character) then return false end

			local suit = ix.item.instances[character:GetCombineSuit()]
			if (!suit) then
				self:Notify(owner, "You/Target is not wearing a combine suit!")

				return false
			end
		end

		local factionList = itemTable.factionList and istable(itemTable.factionList) and itemTable.factionList or false
		if factionList and !table.HasValue(factionList, charFaction) then
			if !itemTable.isBag then
				self:Notify(owner, "This clothing is not meant for your/target's faction!")
				return false
			end
		end

		local bSuccess, reason = hook.Run("PostCanTransferToEquipSlots", owner, itemTable, oldInv, inventory)
		if (bSuccess == false) then
			if (reason) then self:Notify(reason) end
			return false
		end
	end

	return true
end

properties.Add("ixViewEquipInventory", {
	MenuLabel = "#View Equip Inventory",
	Order = 11,
	MenuIcon = "icon16/eye.png",
	PrependSpacer = true,

	Filter = function(self, target, client)
		client = client or LocalPlayer()
		return target:IsPlayer()
            and CAMI.PlayerHasAccess(client, "Helix - View Inventory")
            and hook.Run("CanProperty", client, "ixViewInventory", target) != false
	end,

	Action = function(self, target)
		self:MsgStart()
			net.WriteEntity(target)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local target = net.ReadEntity()

		if (!IsValid(target)) then return end
		if (!self:Filter(target, client)) then return end

		PLUGIN:OpenInventory(client, target)
	end
})

if (CLIENT) then -- if (CLIENT) then
	net.Receive("ixSlotsSyncPlayerToItem", function()
		local id = net.ReadUInt(32)
		if ix.item.instances[id] then
			ix.item.instances[id].player = LocalPlayer()
		end
	end)

	net.Receive("ixSyncBagSlots", function()
		if !ix.gui.inv1 or ix.gui.inv1 and !IsValid(ix.gui.inv1) then return end
		if !ix.gui.inv1.UpdateNoSlots then return end
		ix.gui.inv1:UpdateNoSlots()
	end)

	net.Receive("ixOnBagItemTransferred", function()
		local itemID = net.ReadUInt(32)
		local inventoryID = net.ReadUInt(32)

		local item = ix.item.instances[itemID]
		if !item then return end

		local inventory = ix.item.inventories[inventoryID]
		if !inventory then return end

		PLUGIN:OnBagItemTransferred(item, false, inventory)
	end)

	function PLUGIN:OnBagItemTransferred(item, _, inventory)
		if !inventory.vars then return end
		if !ix.gui.inv1 or ix.gui.inv1 and !IsValid(ix.gui.inv1) then return false end
		if ix.gui.openedStorage and IsValid(ix.gui.openedStorage) then return false end

		if inventory.vars.equipSlots then
			local itemFunctions = item.functions
			if !itemFunctions or itemFunctions and !itemFunctions.View then return end

			if itemFunctions.View then
				local itemEnt = IsValid(item.entity)
				local id = item:GetData("id")
				local alreadyOpen = IsValid(ix.gui["inv" .. id])
				if id and !alreadyOpen and !itemEnt then
					itemFunctions.View.OnClick(item)
				end
			end
		end
	end

	hook.Add("PostCharInfoFrameOpened", "ixEquipInventoryOpen", function(charFrame)
		if !IsValid(charFrame) then return end
		local char = LocalPlayer():GetCharacter()
		if !char then return end

		local equipInvID = char:GetEquipInventory()
		if !equipInvID then return end

		local inventory = ix.item.inventories[equipInvID]
		if !inventory then return end

		ix.gui.equipSlots = charFrame:Add("ixEquipSlots")
		ix.gui.equipSlots:SetInventory(inventory)
		ix.gui.equipSlots:PaintParts()

		ix.gui["inv" .. equipInvID] = ix.gui.equipSlots
	end)
end