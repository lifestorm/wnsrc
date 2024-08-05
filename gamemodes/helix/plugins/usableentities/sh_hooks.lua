--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- I should probably add this in the storage plugin but meh.
function PLUGIN:CanTransferItem(itemTable, curInv, inventory)
	if (inventory and inventory.storageInfo and inventory.storageInfo.entity and inventory.storageInfo.entity:IsValid()) then
		local containerInfo = ix.container.stored[inventory.storageInfo.entity:GetModel()]

		if (containerInfo and containerInfo.restriction) then
			if (!table.HasValue(containerInfo.restriction, itemTable.uniqueID) and !table.HasValue(containerInfo.restriction, itemTable.base)) then
				return false
			end
		end
	end
end
