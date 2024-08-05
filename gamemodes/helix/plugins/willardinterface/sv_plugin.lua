--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


util.AddNetworkString("ixInventoryShiftMove")
util.AddNetworkString("ixReturnToMenu")

net.Receive("ixInventoryShiftMove", function(length, client)
	local itemTable = net.ReadFloat()
	local storageTable = net.ReadFloat()

	if (!itemTable or !storageTable) then return end

	itemTable = ix.item.instances[itemTable]
	storageTable = ix.item.inventories[storageTable]

	if (!itemTable or !storageTable) then return end

	if (itemTable.invID == storageTable.id) then
		local targetInventoryID = client:GetCharacter():GetInventory():GetID()

		itemTable:Transfer(targetInventoryID)
	else
		itemTable:Transfer(storageTable.id)
	end
end)

net.Receive("ixReturnToMenu", function(length, client)
	local currentCharacter = client:GetCharacter()
	local cantBypass = !CAMI.PlayerHasAccess(client, "Helix - Bypass CharSwap Disable")
	local nextSwap = client:GetData("nextCharacterSwap", -1)
	local timeCheck = nextSwap >= os.time()

	if (nextSwap == 0) then
		timeCheck = true
	end

	if (currentCharacter and cantBypass and (ix.config.Get("charSwapDisabled") == true or timeCheck)) then
		client:Notify("Character swapping is prohibited at this time.")

		return
	end

	ix.log.Add(client, "characterUnloaded", client:GetName())

	local character = client:GetCharacter()
	if (character) then
		character:Save()
		character:Kick()
	end
end)

ix.log.AddType("characterUnloaded", function(client, ...)
	local arguments = {...}

    return Format("%s has unloaded their \"%s\" character.", client:SteamName(), arguments[1])
end)

function PLUGIN:OnItemSpawned(itemEntity)
	local item = itemEntity:GetItemTable()

	if (item.color) then
		itemEntity:SetColor(item.color)
	end

	if (item.material) then
		itemEntity:SetMaterial(item.material)
	end
end
