--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Logging"
PLUGIN.author = "Black Tea"
PLUGIN.description = "Vous pouvez modifier le texte/les listes de journalisation sur ce plugin."

if (SERVER) then
	local L = Format

	ix.log.AddType("chat", function(client, ...)
		local arg = {...}
		return L("[%s] %s: %s", arg[1], client:Name(), arg[2])
	end)

	ix.log.AddType("command", function(client, ...)
		local arg = {...}

		if (arg[2] and #arg[2] > 0) then
			return L("%s a utilisé la commande '%s %s'.", client:Name(), arg[1], arg[2])
		else
			return L("%s a utilisé la commande '%s'.", client:Name(), arg[1])
		end
	end)

	ix.log.AddType("cfgSet", function(client, ...)
		local arg = {...}
		return L("%s a réglé %s sur '%s'.", client:Name(), arg[1], arg[2])
	end, FLAG_DANGER)

	ix.log.AddType("connect", function(client, ...)
		return L("%s s'est connecté.", client:SteamName())
	end, FLAG_NORMAL)

	ix.log.AddType("disconnect", function(client, ...)
		if (client:IsTimingOut()) then
			return L("%s (%s) s'est déconnecté (expiré).", client:SteamName(), client:SteamID())
		else
			return L("%s (%s) s'est déconnecté.", client:SteamName(), client:SteamID())
		end
	end, FLAG_NORMAL)

	ix.log.AddType("charCreate", function(client, ...)
		local arg = {...}
		return L("%s créé le personnage '%s'", client:SteamName(), arg[1])
	end, FLAG_SERVER)

	ix.log.AddType("charLoad", function(client, ...)
		local arg = {...}
		return L("%s chargé le personnage '%s'", client:SteamName(), arg[1])
	end, FLAG_SERVER)

	ix.log.AddType("charDelete", function(client, ...)
		local arg = {...}
		return L("%s (%s) personnage supprimé '%s'", client:SteamName(), client:SteamID(), arg[1])
	end, FLAG_SERVER)

	ix.log.AddType("itemAction", function(client, ...)
		local arg = {...}
		local item = arg[2]
		return L("%s a exécuté '%s' sur l'article '%s' (#%s)", client:Name(), arg[1], item:GetName(), item:GetID())
	end, FLAG_NORMAL)

	ix.log.AddType("itemDestroy", function(client, itemName, itemID)
		local name = client:GetName() ~= "" and client:GetName() or client:GetClass()
		return L("%s détruit un '%s' #%d.", name, itemName, itemID)
	end, FLAG_WARNING)

	ix.log.AddType("shipmentTake", function(client, ...)
		local arg = {...}
		return L("%s a pris '%s' de l'envoi", client:Name(), arg[1])
	end, FLAG_WARNING)

	ix.log.AddType("shipmentOrder", function(client, ...)
		return L("%s a commandé une livraison", client:Name())
	end, FLAG_SUCCESS)

	ix.log.AddType("buy", function(client, ...)
		local arg = {...}
		return L("%s a acheté '%s' au PNJ", client:Name(), arg[1])
	end, FLAG_SUCCESS)

	ix.log.AddType("buydoor", function(client, ...)
		return L("%s a acheté une porte.", client:Name())
	end, FLAG_SUCCESS)

	ix.log.AddType("selldoor", function(client, ...)
		return L("%s a vendu une porte.", client:Name())
	end, FLAG_SUCCESS)

	ix.log.AddType("playerHurt", function(client, ...)
		local arg = {...}
		return L("%s a subi %d dégâts de %s.", client:Name(), arg[1], arg[2])
	end, FLAG_WARNING)

	ix.log.AddType("playerDeath", function(client, ...)
		local arg = {...}
		return L("%s a tué %s%s.", arg[1], client:Name(), arg[2] and (" avec " .. arg[2]) or "")
	end, FLAG_DANGER)

	ix.log.AddType("money", function(client, amount)
		return L("%s a %s %s.", client:Name(), amount < 0 and "perdu" or "gagné", ix.currency.Get(math.abs(amount)))
	end, FLAG_SUCCESS)

	ix.log.AddType("inventoryAdd", function(client, characterName, itemName, itemID, storageName, storageID)
		return string.format("%s a gagné un '%s' #%d"..(storageName and " depuis un conteneur nommé '%s' #%d" or "")..".",
		characterName, itemName, itemID, storageName, storageID)
	end, FLAG_WARNING)

	ix.log.AddType("inventoryTransfer", function(client, characterName, itemName, itemID, storageName, storageID)
		return string.format("%s a transféré un '%s' #%d"..(storageName and " vers un conteneur nommé '%s' #%d" or "")..".",
		characterName, itemName, itemID, storageName, storageID)
	end, FLAG_WARNING)

	ix.log.AddType("inventoryRemove", function(client, characterName, itemName, itemID)
		return L("%s a perdu un '%s' #%d.", characterName, itemName, itemID)
	end, FLAG_WARNING)

	ix.log.AddType("storageMoneyTake", function(client, entity, amount, total)
		local name = entity.GetDisplayName and entity:GetDisplayName() or entity:GetName()

		return string.format("%s a pris %d %s à '%s' #%d (reste %d %s).",
			client:GetName(), amount, ix.currency.plural, name,
			entity:GetInventory():GetID(), total, ix.currency.plural)
	end)

	ix.log.AddType("storageMoneyGive", function(client, entity, amount, total)
		local name = entity.GetDisplayName and entity:GetDisplayName() or entity:GetName()

		return string.format("%s a donné %d %s à '%s' #%d (reste %d %s).",
			client:GetName(), amount, ix.currency.plural, name,
			entity:GetInventory():GetID(), total, ix.currency.plural)
	end)

	ix.log.AddType("roll", function(client, value, max)
		return string.format("%s a sorti %d sur %d.", client:Name(), value, max)
	end)

	ix.log.AddType("pluginLoaded", function(client, uniqueID)
		return string.format("%s a activé le plug-in %s pour le prochain redémarrage.", client:GetName(), uniqueID)
	end)

	ix.log.AddType("pluginUnloaded", function(client, uniqueID)
		return string.format("%s a désactivé le plug-in %s pour le prochain redémarrage.", client:GetName(), uniqueID)
	end)

	function PLUGIN:PlayerInitialSpawn(client)
		ix.log.Add(client, "connect")
	end

	function PLUGIN:PlayerDisconnected(client)
		ix.log.Add(client, "disconnect")
	end

	function PLUGIN:OnCharacterCreated(client, character)
		ix.log.Add(client, "charCreate", character:GetName())
	end

	function PLUGIN:CharacterLoaded(character)
		local client = character:GetPlayer()
		ix.log.Add(client, "charLoad", character:GetName())
	end

	function PLUGIN:PreCharacterDeleted(client, character)
		ix.log.Add(client, "charDelete", character:GetName())
	end

	function PLUGIN:ShipmentItemTaken(client, itemClass, amount)
		local itemTable = ix.item.list[itemClass]
		ix.log.Add(client, "shipmentTake", itemTable:GetName())
	end

	function PLUGIN:CreateShipment(client, shipmentEntity)
		ix.log.Add(client, "shipmentOrder")
	end

	function PLUGIN:CharacterVendorTraded(client, vendor, x, y, invID, price, isSell)
	end

	function PLUGIN:PlayerInteractItem(client, action, item)
		if (isentity(item)) then
			if (IsValid(item)) then
				local itemID = item.ixItemID
				item = ix.item.instances[itemID]
			else
				return
			end
		elseif (isnumber(item)) then
			item = ix.item.instances[item]
		end

		if (!item) then
			return
		end

		ix.log.Add(client, "itemAction", action, item)
	end

	function PLUGIN:IsStorage(inv)
        if !inv then return false end
        if !inv.storageInfo then return false end
        if !inv.storageInfo.name then return false end
        if !inv.storageInfo.id then return false end

        return true, inv.storageInfo.name, inv.storageInfo.id
	end

	function PLUGIN:InventoryItemAdded(oldInv, inventory, item)
        if (!inventory.owner or (oldInv and oldInv.owner == inventory.owner)) then
            return
        end

        local character = ix.char.loaded[inventory.owner]
        local isStorage, name, id = self:IsStorage(oldInv)

        ix.log.Add(character:GetPlayer(), "inventoryAdd", character:GetName(), item:GetName(), item:GetID(), isStorage and name,
		isStorage and id)

        if (item.isBag) then
            local bagInventory = item:GetInventory()

            if (!bagInventory) then
                return
            end

            for _, v in pairs(bagInventory:GetItems()) do
                ix.log.Add(character:GetPlayer(), "inventoryAdd", character:GetName(), v:GetName(), v:GetID(), isStorage and
				name, isStorage and id)
            end
        end
	end

	function PLUGIN:InventoryItemRemoved(inventory, item)
		if (!inventory.owner) then
			return
		end

		local character = ix.char.loaded[inventory.owner]

		ix.log.Add(character:GetPlayer(), "inventoryRemove", character:GetName(), item:GetName(), item:GetID())

		if (item.isBag) then
			for _, v in pairs(item:GetInventory():GetItems()) do
				ix.log.Add(character:GetPlayer(), "inventoryRemove", character:GetName(), v:GetName(), v:GetID())
			end
		end
	end

	function PLUGIN:OnItemTransferred(item, curInv, inventory)
		if !curInv.owner then return end
		if !self:IsStorage(inventory) then return end

		local character = ix.char.loaded[curInv.owner]
		local isStorage, name, id = self:IsStorage(inventory)

		ix.log.Add(character:GetPlayer(), "inventoryTransfer", character:GetName(), item:GetName(), item:GetID(), isStorage and name,
		isStorage and id)
	end
end
