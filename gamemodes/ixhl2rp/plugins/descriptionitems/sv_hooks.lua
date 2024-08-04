--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:InventoryItemAdded(oldInv, inventory, item)
	-- New Inventory
	if (inventory) then
		local client = inventory.owner and ix.char.loaded[inventory.owner] and ix.char.loaded[inventory.owner]:GetPlayer()

		if (client) then
			if (item.width >= 3 and item.height >= 4) then
				local currentItems = client:GetNetVar("visibleItems", {})

				currentItems[item.name] = true

				client:SetNetVar("visibleItems", currentItems)
			end
		end
	end

	-- Old Inventory
	if (oldInv) then
		local client = oldInv.owner and ix.char.loaded[oldInv.owner] and ix.char.loaded[oldInv.owner]:GetPlayer()

		if (client and item.width >= 3 and item.height >= 4) then
			local currentItems = client:GetNetVar("visibleItems", {})
			
			if (currentItems[item.name]) then
				currentItems[item.name] = nil
			end

			client:SetNetVar("visibleItems", currentItems)
		end
	end
end

function PLUGIN:PlayerInteractItem(client, action, item)
	if (action == "drop") then
		if (item.width >= 3 and item.height >= 4) then
			local currentItems = client:GetNetVar("visibleItems", {})
			
			if (currentItems[item.name]) then
				currentItems[item.name] = nil
			end

			client:SetNetVar("visibleItems", currentItems)
		end
	end
end

function PLUGIN:PlayerSpawn(client)
	local character = client:GetCharacter()
	if (!character) then return end

	timer.Simple(1, function()
		local currentItems = {}

		for _, item in pairs(character:GetInventory():GetItems()) do
			if (item.width < 3 or item.height < 4) then continue end

			currentItems[item.name] = true
		end

		client:SetNetVar("visibleItems", currentItems)
	end)
end
