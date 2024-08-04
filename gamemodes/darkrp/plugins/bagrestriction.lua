--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name = "Bag Restriction"
PLUGIN.author = "Naast"
PLUGIN.description = "Don't allow players to pick any bag if they have one already."

if SERVER then
	function PLUGIN:CanPlayerTakeItem(client, item)
		item = item:GetItemTable()
		local inv = client:GetCharacter():GetInventory()
		local equipInv = ix.item.inventories[client:GetCharacter():GetEquipInventory()]
		local hasItem = inv:HasItem(item.uniqueID) or equipInv:HasItem(item.uniqueID)

		if item.isBag and hasItem then
			client:NotifyLocalized("You already have a bag of this type on you!")
			return false
		end
	end
end

function PLUGIN:CanTransferItem(item, oldInv, newInv)
	local client = item.player or item.GetOwner and item:GetOwner() or item.playerID and player.GetBySteamID64(item.playerID) or nil -- what the fuck? Why is this so inconsistent? p.s stole from aspect :33

	if (!IsValid(client) or !item or !item.isBag) then
		return
	end

	local clientInv = client:GetCharacter():GetInventory()
	local equipInv = ix.item.inventories[client:GetCharacter():GetEquipInventory()]
	local hasItem = clientInv:HasItem(item.uniqueID) or equipInv:HasItem(item.uniqueID)

	if (clientInv.id == newInv.id and oldInv != newInv) then
		return hasItem
	end
end