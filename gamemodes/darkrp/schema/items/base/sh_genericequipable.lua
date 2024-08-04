--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Generic Equipable Item"
ITEM.description = "An item that can be equipped."
ITEM.category = "Equipable"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.width = 1
ITEM.height = 1

-- Inventory drawing
if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawOutlinedRect(1, 1, w - 2, h - 2)
		end
	end

	function ITEM:PopulateTooltip(tooltip)
		if (self:GetData("equip")) then
			local name = tooltip:GetRow("name")
			name:SetBackgroundColor(derma.GetColor("Success", tooltip))
		end
	end
end

function ITEM:Equip(client)
	self:SetData("equip", true)
	self:OnEquipped(client)
end

function ITEM:Unequip(client)
	self:SetData("equip", false)
	self:OnUnequipped(client)
end


ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

		item.player = client
		item:Unequip(item:GetOwner())
	end
end)

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		item:Unequip(item.player)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		local client = item.player
		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()

		if (item.equipableCategory) then
			for _, v in pairs(items) do
				if (v.id != item.id) then
					local itemTable = ix.item.instances[v.id]

					if (v.equipableCategory == item.equipableCategory and itemTable:GetData("equip")) then
						client:NotifyLocalized(item.equippedNotify or "itemAlreadyEquipped")

						return false
					end
				end
			end
		end

		item:Equip(item.player)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and item:CanEquip(client) and hook.Run("CanPlayerEquipItem", client, item) != false
	end
}

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnRemoved()
	if (self.invID != 0 and self:GetData("equip")) then
		self.player = self:GetOwner()
		self:Unequip(self.player)
		
		self.player = nil
	end
end

function ITEM:OnEquipped(client) end

function ITEM:OnUnequipped(client) end

function ITEM:CanEquip(client)
	return client:GetCharacter():GetInventory():GetID() == self.invID
end
