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

util.AddNetworkString("ixPlyGetInfo")
util.AddNetworkString("ixSendFindItemInfo")
util.AddNetworkString("ixGoToItemPos")
util.AddNetworkString("ixBringItemOrContainer")
util.AddNetworkString("ixCharBanAreYouSure")
util.AddNetworkString("ixSync3dSoundTestOrigin")
util.AddNetworkString("ixPlay3DSound")

ix.log.AddType("contextMenuUsed", function(client, name)
    return string.format("%s has used a context menu option with the name: %s", client:GetName(), name)
end)

ix.log.AddType("knockedOut", function(client, text)
    return string.format("%s was just knocked out due to: %s", client:GetName(), text)
end, FLAG_DANGER)

ix.log.AddType("qolDeathLog", function(client, text)
    return string.format("%s was just killed due to: %s", client:GetName(), text)
end, FLAG_DANGER)

ix.log.AddType("itemBreakageDurability", function(item, name, player)
    return string.format("%s owned by %s just broke due to usage.", name, player:GetName())
end)

ix.log.AddType("getFloppyDiskPassword", function(client, entID, password)
    return string.format("%s just revealed a password of the floppy disk '#%d' with the password '%s'", client:GetName(), entID, password)
end)

ix.log.AddType("ixBringItem", function(client, invType, id)
    return string.format("%s just brought an item '#%s' within %s", client:GetName(), id, invType)
end)

ix.log.AddType("ixBanCharacter", function(client, name, id)
    return string.format("%s just banned a character with the name %s '#%s'", client:GetName(), name, id)
end)

ix.log.AddType("ixBringContainer", function(client, name, id)
    return string.format("%s just brought a container with the name %s '#%s'", client:GetName(), name, id)
end)


function PLUGIN:InitPostEntity()
    if !properties then return end
    if !properties.List then return end

    for key, _ in pairs(properties.List) do
        local receive = properties.List[key].Receive

        --luacheck: ignore 122
        properties.List[key].Receive = function(this, length, client)
            receive(this, length, client)

            ix.log.Add(client, "contextMenuUsed", key)
        end
    end
end

function PLUGIN:PopulateListByItemEntity(client, sSearch)
    for _, ent in pairs(ents.FindByClass( "ix_item" )) do
        if !IsValid(ent) then continue end

        local id = ent.ixItemID
        if !id then continue end
        if isnumber(sSearch) and id != sSearch then continue end

        local itemTable = ix.item.instances[id]
        if !itemTable or itemTable and !istable(itemTable) then continue end
        if !itemTable.name then continue end
        local uniqueID = itemTable.uniqueID
        if !uniqueID then continue end
        local nameList = ix.item.list[uniqueID].name or false
        if !nameList then continue end

        if !ix.util.StringMatches(nameList, tostring(sSearch)) and sSearch != id then continue end

        client.findItemList[id] = {
            invID = itemTable.invID,
            name = nameList or itemTable.name,
            wPosition = ent:GetPos(),
            data = itemTable.data,
            origin = "world",
            itemID = tonumber(id),
            owner = itemTable:GetOwner() or "World",
            entID = ent:EntIndex()
        }
    end
end

function PLUGIN:PopulateListByContainerEntity(client, sSearch)
    for _, ent2 in pairs(ents.FindByClass( "ix_container" )) do
        if !IsValid(ent2) then continue end

        for _, item in pairs(ent2:GetInventory():GetItems()) do
            local id = item.id
            if !id then continue end
            if isnumber(sSearch) and id != sSearch then continue end
            local uniqueID = item.uniqueID
            if !uniqueID then continue end
            local nameList = ix.item.list[uniqueID].name or false
            if !nameList then continue end

            if !ix.util.StringMatches(nameList, tostring(sSearch)) and sSearch != id then continue end

            client.findItemList[id] = {
                invID = item.invID,
                name = nameList or item.name,
                wPosition = ent2:GetPos(),
                data = item.data,
                origin = "container",
                itemID = tonumber(id),
                owner = "Container",
                entID = ent2:EntIndex()
            }
        end
    end
end

function PLUGIN:PopulateListByLoadedChars(client, sSearch)
    for _, char in pairs(ix.char.loaded) do
        if !char:GetInventory() then continue end

        for _, item in pairs(char:GetInventory():GetItems()) do
            local id = item.id
            if !id then return end
            if isnumber(sSearch) and id != sSearch then continue end
            local uniqueID = item.uniqueID
            if !uniqueID then continue end

            if !ix.util.StringMatches(item.name, tostring(sSearch)) and sSearch != id then continue end
            local charPos = char:GetPlayer()
            if IsValid(charPos) then charPos = charPos:GetPos() end

            local nameList = ix.item.list[uniqueID].name or false
            if !nameList then continue end


            client.findItemList[id] = {
                invID = item.invID,
                name = nameList or item.name,
                wPosition = charPos or "N/A",
                data = item.data,
                origin = "character",
                itemID = tonumber(id),
                owner = char:GetName(),
                entID = char:GetPlayer():EntIndex()
            }
        end
    end
end

function PLUGIN:FindItem(client, sSearch)
    local query = mysql:Select("ix_items")
    query:Select("item_id")
    query:Select("unique_id")
    query:Select("character_id")
    query:Select("inventory_id")
    query:Select("data")
    if isnumber(sSearch) then
        query:Where("item_id", sSearch)
    else
        query:WhereLike("unique_id", sSearch)
    end

    query:Callback(function(result)
        client.findItemList = {}

        self:PopulateListByItemEntity(client, sSearch)
        self:PopulateListByContainerEntity(client, sSearch)
        self:PopulateListByLoadedChars(client, sSearch)

        if (istable(result)) then
            local data2 = util.JSONToTable(result[1].data or "[]")

            for key, v in pairs(result) do
                if client.findItemList[tonumber(result[key].item_id)] then continue end
                if tonumber(v.inventory_id) == 0 then continue end

                client.findItemList[tonumber(result[key].item_id)] = {
                    invID = tonumber(v.inventory_id),
                    name = ix.item.list[v.unique_id].name,
                    wPosition = "N/A",
                    data = data2,
                    origin = "database/offline",
                    itemID = tonumber(result[key].item_id),
                    owner = "N/A"
                }
            end

            -- so we can get the name of the character owning the inventory
            self:TranslateInventoryID(client)
        end


    end)

    query:Execute()
end

function PLUGIN:TranslateInventoryID(client)
    for itemID, tItem in pairs(client.findItemList) do
        local nInvID = tItem.invID
        if !nInvID then continue end

        if tonumber(nInvID) == 0 then continue end

        local query = mysql:Select("ix_inventories")
        query:Select("inventory_id")
        query:Select("character_id")
        query:Select("inventory_type")
        query:Where("inventory_id", nInvID)
        query:Callback(function(result)
            if (istable(result)) then
                for _, tResult in pairs(result) do
                    if !tResult.character_id then continue end
                    if tonumber(tResult.character_id) == 0 then
                        local isBag = (ix.item.list[tResult.inventory_type] and ix.item.list[tResult.inventory_type].isBag)
                        if tResult.inventory_type:find("container") or isBag then
                            if isBag then
                                client.findItemList[itemID].owner = "Bag"
                            else
                                client.findItemList[itemID].owner = "Container"
                            end
                        end
                    end

                    local query2 = mysql:Select("ix_characters")
                    query2:Select("id")
                    query2:Select("name")
                    query2:Where("id", tResult.character_id)
                    query2:Limit(1)
                    query2:Callback(function(result2)
                        if (istable(result2)) then
                            client.findItemList[itemID].owner = result2[#result2].name
                        end
                    end)

                    query2:Execute()
                end
            end
        end)

        query:Execute()
    end

    net.Start("ixSendFindItemInfo")
    net.WriteTable(client.findItemList)
    net.Send(client)

    timer.Simple(1, function()
        if IsValid(client) then
            client.findItemList = nil
        end
    end)
end

function PLUGIN:BanSomeone(client, sTarget, minutes)
    if (minutes) then
        minutes = os.time() + math.max(math.ceil(tonumber(minutes * 60)), 60)
    end

    local found = false
    for _, target in pairs(ix.char.loaded) do
        if found then break end
        if (target.GetPlayer and !target:GetPlayer()) or (target:GetPlayer() and !IsValid(target:GetPlayer())) then continue end
        local name = target:GetName()
        if !ix.util.StringMatches(name, sTarget) then continue end

        self:AreYouSure(client, target:GetID(), minutes, name)

        found = true
    end

    if found then return end

    local query = mysql:Select("ix_characters")
    query:Select("id")
    query:Select("name")
    query:Select("cid")
    query:WhereLike("name", sTarget)
    query:Limit(1)
    query:Callback(function(result)
        if (!result or !istable(result) or #result == 0) then
            client:Notify("Character not found in database!")
            return
        end

        if !result[1].id then return end

        self:AreYouSure(client, result[1].id, minutes, result[1].name, result[1].cid)
    end)

    query:Execute()
end

function PLUGIN:AreYouSure(client, charID, minutes, name, cid)
	client.banningCharID = charID
	client.banningMinutes = minutes
    client.banningCID = cid
    client.banningName = name

	net.Start("ixCharBanAreYouSure")
	net.WriteString(name)
    net.WriteString(charID)
	net.Send(client)
end

function PLUGIN:Confirm(client, charID, minutes)
	local char = ix.char.loaded[tonumber(charID)]
	if char and char.GetPlayer and char:GetPlayer() and IsValid(char:GetPlayer()) then
		char:Ban(minutes)
		char:Save()

		char:GetPlayer():Notify("Your character "..char:GetName().." has been banned.")
		client:Notify("The character "..char:GetName().." has been banned.")

        ix.log.Add(client, "ixBanCharacter", char:GetName(), char:GetID())
        self:VoidClientInfo(client)
		return
	end

    if char then
		minutes = tonumber(minutes)

		hook.Run("OnCharacterBanned", char, minutes or true)

		if (minutes) then
			-- If time is provided, adjust it so it becomes the un-ban time.
			minutes = os.time() + math.max(math.ceil(minutes), 60)
		end

		-- Mark the character as banned and kick the character back to menu.
		char:SetData("banned", minutes or true)
    end

	local query2 = mysql:Select("ix_characters_data")
	query2:Select("data")
	query2:Where("id", charID)
	query2:Where("key", "data")
	query2:Limit(1)
	query2:Callback(function(result2)
		if (!result2 or !istable(result2) or #result2 == 0) then return end

		local data = util.JSONToTable(result2[1].data)
		data.banned = minutes or true

		local queryObj = mysql:Update("ix_characters_data")
		queryObj:Where("id", charID)
		queryObj:Where("key", "data")
		queryObj:Update("data", util.TableToJSON(data))
		queryObj:Execute()

        hook.Run("OnCharacterBannedByID", charID, data.banned)

		client:Notify("The character "..(client.banningName or "N/A").." has been banned.")
        local name, id = client.banningName, client.banningCharID
        ix.log.Add(client, "ixBanCharacter", name, id)
        self:VoidClientInfo(client)
	end)

	query2:Execute()
end

function PLUGIN:VoidClientInfo(client)
    client.banningCharID = nil
    client.banningMinutes = nil
    client.banningCID = nil
    client.banningName = nil
end

net.Receive("ixGoToItemPos", function(len, client)
    if !CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands") then return false end
    local vector = net.ReadVector()
    if !isvector(vector) then return false end

    client:SetPos(vector)
end)

net.Receive("ixBringItemOrContainer", function(len, client)
    if !CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands") then return false end
    local vector = net.ReadVector()
    local entIndex = net.ReadInt(17)
    local itemID = net.ReadInt(17)
    local origin = net.ReadString()
    if !isvector(vector) then return false end

    if !IsValid(Entity(entIndex)) then return end
    Entity(entIndex):SetPos(client:GetPos())

    ix.log.Add(client, "ixBringItem", origin, itemID)
end)

net.Receive("ixCharBanAreYouSure",  function(len, client)
    if !CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands") then return false end
    PLUGIN:Confirm(client, client.banningCharID, client.banningMinutes)
end)