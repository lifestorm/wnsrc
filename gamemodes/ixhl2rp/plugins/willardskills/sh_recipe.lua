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

ix.config.Add("PickupDispenserMaxItems", 8, "Pickup Dispenser - Max unique items purchased.", nil, {
	data = {min = 1, max = 8, decimals = 0},
	category = "Pickup Dispenser"
})

ix.char.RegisterVar("purchasedItems", {
	default = {},
	isLocal = true,
	bNoDisplay = true,
	field = "purchasedItems",
	fieldType = ix.type.string,
	OnSet = function(character, itemID, amount)
		if (!itemID) then
			ErrorNoHalt("Attempted to set purchased items but no item uniqueID was specified!")
			return
		end

		local items = character:GetPurchasedItems()
		if !istable(amount) and !string.find(itemID, "letter") then
			if amount then
				items[itemID] = (items[itemID] or 0) + amount
			else
				if items[itemID] > 0 then
					items[itemID] = items[itemID] - 1

					if items[itemID] == 0 then
						items[itemID] = nil
					end
				else
					return
				end
			end
		else
			if items[itemID] then items[itemID] = nil end
			items[itemID] = amount
		end

		if (IsValid(character:GetPlayer())) then
			net.Start("ixCharacterVarChanged")
				net.WriteUInt(character:GetID(), 32)
				net.WriteString("purchasedItems")
				net.WriteType(character.vars.purchasedItems)
			net.Send(character:GetPlayer())
		end

		character.vars.purchasedItems = items
	end,
	OnGet = function(character)
		return character.vars.purchasedItems or {}
	end
})