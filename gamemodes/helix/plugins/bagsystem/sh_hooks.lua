--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Called to check if an item can be transferred.
-- Allows inventories to be nested inside containers. NOTE: Also needs custom bag base.
function PLUGIN:CanTransferItem(itemObject, curInv, inventory)
	if (SERVER) then
		local client = itemObject.GetOwner and itemObject:GetOwner() or nil

		if (IsValid(client) and curInv.GetReceivers) then
			local bAuthorized = false

			for _, v in ipairs(curInv:GetReceivers()) do
				if (client == v) then
					bAuthorized = true
					break
				end
			end

			if (!bAuthorized) then
				return false
			end
		end
	end

	-- don't allow bags to be put inside bags
	if (inventory.id != 0 and curInv.id != inventory.id) then
		if (inventory.vars and inventory.vars.isBag and !inventory.vars.isContainer and !itemObject.allowNesting and itemObject.isBag) then
			local owner = itemObject:GetOwner()

			if (IsValid(owner)) then
				owner:NotifyLocalized("nestedBags")
			end

			return false
		end

		if (inventory.vars and inventory.vars.restriction and #inventory.vars.restriction > 0) then
			if (!table.HasValue(inventory.vars.restriction, itemObject.uniqueID) and !table.HasValue(inventory.vars.restriction, itemObject.base)) then
				local owner = itemObject:GetOwner()

				if (IsValid(owner)) then
					owner:NotifyLocalized("restrictedBag")
				end

				return false
			end
		end
	elseif (inventory.id != 0 and curInv.id == inventory.id) then
		-- we are simply moving items around if we're transferring to the same inventory
		return
	end

	inventory = ix.item.inventories[itemObject:GetData("id")]

	-- don't allow transferring items that are in use
	if (inventory) then
		for _, v in pairs(inventory:GetItems()) do
			if (v:GetData("equip") == true) then
				local owner = itemObject:GetOwner()

				if (owner and IsValid(owner)) then
					owner:NotifyLocalized("equippedBag")
				end

				return false
			end
		end
	end
end
