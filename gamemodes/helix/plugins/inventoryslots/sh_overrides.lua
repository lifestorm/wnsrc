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
--luacheck: ignore global GAMEMODE
function GAMEMODE:CanPlayerEquipItem(client, item)
	return PLUGIN:CanEquipOrUnequip(client, item, true)
end

function GAMEMODE:CanPlayerUnequipItem(client, item)
	return PLUGIN:CanEquipOrUnequip(client, item, false)
end

local playerMeta = FindMetaTable("Player")

function playerMeta:GetItems()
	local char = self:GetCharacter()

	if (char) then
		local inv = char:GetInventory()
		local eqInv = char:GetEquipInventory()
		if !eqInv or eqInv == 0 then return inv:GetItems() end
		local equipInv = ix.item.inventories[eqInv]

		local invItems = inv:GetItems()
		local eqInvItems = equipInv:GetItems()

		if (inv and equipInv) then
			local mergedInv = table.Merge(eqInvItems, invItems)
			return mergedInv
		end

		if (inv) then
			return inv:GetItems()
		end
	end
end

local invMeta = ix.meta.inventory or ix.middleclass("ix_inventory")

function invMeta:GetItems(onlyMain, onlyWithin)
	local items = {}

	for _, v in pairs(self.slots) do
		for _, v2 in pairs(v) do
			if (istable(v2) and !items[v2.id]) then
				items[v2.id] = v2

				v2.data = v2.data or {}
				local isBag = v2.data.id
				if (isBag and isBag != self:GetID() and onlyMain != true) then
					local bagInv = ix.item.inventories[isBag]

					if (bagInv) then
						local bagItems = bagInv:GetItems()

						table.Merge(items, bagItems)
					end
				end
			end
		end
	end

	if !onlyWithin then
		local invOwner = self.GetOwner and IsValid(self:GetOwner()) and self:GetOwner()
		if invOwner then
			local ownerChar = invOwner.GetCharacter and invOwner:GetCharacter()
			if self == ownerChar:GetInventory() then
				local equipInventory = ownerChar.GetEquipInventory and ownerChar:GetEquipInventory()

				if equipInventory and equipInventory != 0 then
					local equipInv = ix.item.inventories[equipInventory]
					if equipInv and equipInv.GetItems and equipInventory != self:GetID() then
						local equipSlotsInvItems = equipInv:GetItems(false, true)
						local mergedInv = table.Merge(equipSlotsInvItems, items)

						return mergedInv
					end
				end
			end
		end
	end

	return items
end

function invMeta:GetBags()
	local invs = {}
	for _, v in pairs(self.slots) do
		for _, v2 in pairs(v) do
			if (istable(v2) and v2.data) then
				local isBag = (((v2.base == "base_bags") or v2.isBag) and v2.data.id)

				if (!table.HasValue(invs, isBag)) then
					if (isBag and isBag != self:GetID()) then
						invs[#invs + 1] = isBag
					end
				end
			end
		end
	end

	local invOwner = self.GetOwner and IsValid(self:GetOwner()) and self:GetOwner()
	if invOwner then
		local ownerChar = invOwner.GetCharacter and invOwner:GetCharacter()
		if self == ownerChar:GetInventory() then
			local equipInventory = ownerChar.GetEquipInventory and ownerChar:GetEquipInventory()

			if equipInventory then
				local equipInv = ix.item.inventories[equipInventory]
				for _, v3 in pairs(equipInv.slots) do
					for _, v4 in pairs(v3) do
						if (istable(v4) and v4.data) then
							local isBag = (((v4.base == "base_bags") or v4.isBag) and v4.data.id)

							if (!table.HasValue(invs, isBag)) then
								if (isBag and isBag != self:GetID()) then
									invs[#invs + 1] = isBag
								end
							end
						end
					end
				end
			end
		end
	end

	return invs
end