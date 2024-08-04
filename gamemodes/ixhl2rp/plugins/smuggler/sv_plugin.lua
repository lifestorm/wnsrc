--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- luacheck: read globals SMUGGLER_BUY SMUGGLER_SELL SMUGGLER_BOTH SMUGGLER_WELCOME SMUGGLER_LEAVE SMUGGLER_NOTRADE SMUGGLER_PRICE
-- luacheck: read globals SMUGGLER_STOCK SMUGGLER_MODE SMUGGLER_MAXSTOCK SMUGGLER_SELLANDBUY SMUGGLER_SELLONLY SMUGGLER_BUYONLY SMUGGLER_TEXT

local PLUGIN = PLUGIN

util.AddNetworkString("ixSmugglerOpen")
util.AddNetworkString("ixSmugglerClose")
util.AddNetworkString("ixSmugglerTrade")

util.AddNetworkString("ixSmugglerEdit")
util.AddNetworkString("ixSmugglerEditFinish")
util.AddNetworkString("ixSmugglerEditor")
util.AddNetworkString("ixSmugglerMoney")
util.AddNetworkString("ixSmugglerStock")
util.AddNetworkString("ixSmugglerAddItem")

util.AddNetworkString("ixSmugglerChosePickup")

PLUGIN.pickupCaches = PLUGIN.pickupCaches or {}

function PLUGIN:UpdateCacheID(entity, newID, oldID)
    self.pickupCaches[newID] = entity

    if (oldID and oldID != "") then
        self.pickupCaches[oldID] = nil
    end

    self.cacheIDList[entity:EntIndex()] = {
        uniqueID = newID,
        locationId = entity:GetLocationId()
    }

    CAMI.GetPlayersWithAccess("Helix - Manage Smugglers", function(receivers)
        netstream.Start(receivers, "ixSmugglingCacheUIDs", self.cacheIDList)
    end)
end

function PLUGIN:CanSmugglerSellItem(client, smuggler, itemID)
    local tradeData = smuggler.items[itemID]
    local char = client:GetCharacter()

    if (!tradeData or !char) then
        return false
    end

    if (!char:HasMoney(tradeData[1] or 0)) then
        return false
    end

    return true
end

function PLUGIN:RotateActiveSmuggler()
    local activeSmuggler
    local smugglers = ents.FindByClass("ix_smuggler")
    for k, v in ipairs(smugglers) do
        if (v.ixIsActiveSmuggler) then
            activeSmuggler = v
            table.remove(smugglers, k)
            break
        end
    end

    if (#smugglers > 0) then
        self.nextRotation = os.time() + ix.config.Get("SmugglerMoveInterval") * 3600 * math.Rand(0.8, 1.2)

        if (activeSmuggler) then
            activeSmuggler:SetInactive()
        end

        local newSmuggler = smugglers[math.random(#smugglers)]
        newSmuggler:SetActive()
    elseif (IsValid(activeSmuggler)) then
        activeSmuggler:ResetSmuggler()
    end
end

function PLUGIN:PreRotateActiveSmuggler()
    for _, v in ipairs(ents.FindByClass("ix_smuggler")) do
        if (v.ixIsActiveSmuggler) then
            v.ixSmugglerPrepRotation = true

            for _, client in ipairs(v.receivers) do
                client:NotifyLocalized("The smuggler is starting to prepare to move, better finish your trades.")
            end

            break
        end
    end
end

local playerMeta = FindMetaTable("Player")

function playerMeta:UpdateStashWaypoints(pickupItems)
    pickupItems = pickupItems or self:GetCharacter():GetSmugglingPickupItems()
    local stashEntities = {}
    local waypoints = {}

    for k, v in pairs(pickupItems) do
        local stashEntity = PLUGIN.pickupCaches[k]

        if (IsValid(stashEntity)) then
            table.insert(stashEntities, stashEntity:EntIndex())
            local amount = 0
            for _, itemAmount in pairs(v) do
                amount = amount + itemAmount
            end

            table.insert(waypoints, {
                pos = stashEntity:GetPos() + Vector(0, 0, 30),
                name = string.format("%s (%d items)", stashEntity:GetDisplayName(), amount)
            })
        end
    end

    if (!table.IsEmpty(stashEntities)) then
        self:NotifyLocalized("smugglerDeliveryNotify")
    end

    if (ix.config.Get("SmugglingShowWaypoints")) then
        netstream.Start(self, "ixShowStashWaypoints", waypoints, stashEntities)
    end
end

ix.log.AddType("smugglerUse", function(client, ...)
    local arg = {...}
    return string.format("%s used the '%s' smuggler.", client:Name(), arg[1])
end)

ix.log.AddType("smugglerBuy", function(client, item, smuggler, delivery)
    return string.format("%s bought a '%s' from the '%s' smuggler%s.", client:Name(), item, smuggler, delivery and " for delivery to "..delivery or "")
end)

ix.log.AddType("smugglerSell", function(client, item, smuggler)
    return string.format("%s sold a '%s' to the '%s' smuggler.", client:Name(), item, smuggler)
end)

ix.log.AddType("smugglerPickup", function(client, item, pickup)
    return string.format("%s picked up a '%s' from '%s.", client:Name(), item, pickup)
end)

net.Receive("ixSmugglerClose", function(length, client)
    local entity = client.ixSmuggler

    if (IsValid(entity)) then
        for k, v in ipairs(entity.receivers) do
            if (v == client) then
                table.remove(entity.receivers, k)

                break
            end
        end

        if (client.ixSmugglerDelivery) then
            local delay = client:GetCharacter():GetSmugglingNextPickup() - os.time()
            delay = math.Round(delay / 60)
            if (delay % 5 != 0) then
                delay = delay - (delay % 5) + 5
            end
            client:NotifyLocalized("smugglerItemsDelivery", delay)
            client.ixSmugglerDelivery = nil
        end

        client.ixSmuggler = nil
    end
end)

local function UpdateEditReceivers(receivers, key, value)
    net.Start("ixSmugglerEdit")
        net.WriteString(key)
        net.WriteType(value)
    net.Send(receivers)
end

net.Receive("ixSmugglerEdit", function(length, client)
    if (!CAMI.PlayerHasAccess(client, "Helix - Manage Smugglers", nil)) then
        return
    end

    local entity = client.ixSmuggler

    if (!IsValid(entity)) then
        return
    end

    local key = net.ReadString()
    local data = net.ReadType()
    local feedback = true

    if (key == "name") then
        entity:SetDisplayName(data)
    elseif (key == "description") then
        entity:SetDescription(data)
    elseif (key == "mode") then
        local uniqueID = data[1]
        local mode = data[2]

        if ((mode == SMUGGLER_BUYONLY or mode == SMUGGLER_SELLANDBUY) and !PLUGIN.itemList[uniqueID].buy) then
            return
        elseif ((mode == SMUGGLER_SELLONLY or mode == SMUGGLER_SELLANDBUY) and !PLUGIN.itemList[uniqueID].sell) then
            return
        end

        entity.items[uniqueID] = entity.items[uniqueID] or {}
        entity.items[uniqueID][SMUGGLER_MODE] = data[2]

        UpdateEditReceivers(entity.receivers, key, data)
    elseif (key == "stockMax") then
        data = math.Round(math.abs(tonumber(data) or 0))

        entity.maxStock = data

        UpdateEditReceivers(entity.receivers, key, data)
    elseif (key == "stock") then
        local uniqueID = data[1]

        entity.items[uniqueID] = entity.items[uniqueID] or {}
        data[2] = math.max(math.Round(tonumber(data[2]) or 0), 0)
        entity.items[uniqueID][SMUGGLER_STOCK] = data[2]

        UpdateEditReceivers(entity.receivers, key, data)

        data = uniqueID
    elseif (key == "model") then
        entity:SetModel(data)
        entity:SetSolid(SOLID_BBOX)
        entity:PhysicsInit(SOLID_BBOX)
        entity:SetAnim()
    elseif (key == "useMoney") then
        if (entity.money) then
            entity:SetMoney()
        else
            entity:SetMoney(0)
        end
    elseif (key == "money") then
        data = math.Round(math.abs(tonumber(data) or 0))

        entity:SetMoney(data)
        feedback = false
    elseif (key == "stashList") then
        entity.stashList = data
    end

    ix.saveEnts:SaveEntity(entity)
    PLUGIN:SaveData()

    if (feedback) then
        local receivers = {}

        for _, v in ipairs(entity.receivers) do
            if (CAMI.PlayerHasAccess(v, "Helix - Manage Smugglers", nil)) then
                receivers[#receivers + 1] = v
            end
        end

        net.Start("ixSmugglerEditFinish")
            net.WriteString(key)
            net.WriteType(data)
        net.Send(receivers)
    end
end)

net.Receive("ixSmugglerTrade", function(length, client)
    if ((client.ixSmugglerTry or 0) < CurTime()) then
        client.ixSmugglerTry = CurTime() + 0.33
    else
        return
    end

    local entity = client.ixSmuggler
    if (!IsValid(entity) or client:GetPos():DistToSqr(entity:GetPos()) > 192 * 192) then
        return
    end

    if (!entity.ixIsActiveSmuggler) then return end

    local uniqueID = net.ReadString()
    local isSellingToSmuggler = net.ReadBool()
    if (!client:GetCharacter():CanDoAction("recipe_smuggling_"..uniqueID)) then
        return client:NotifyLocalized("smugglerNoTrust")
    end

    if (entity.items[uniqueID] and PLUGIN.itemList[uniqueID] and
        hook.Run("CanPlayerTradeWithSmuggler", client, entity, uniqueID, isSellingToSmuggler, PLUGIN.itemList[uniqueID]) != false) then
        local price = entity:GetPrice(uniqueID, isSellingToSmuggler)

        if (isSellingToSmuggler) then
            local found = false
            local name

            if (!PLUGIN.itemList[uniqueID].buy) then
                client:NotifyLocalized("smugglerNoTrade")
            end

            if (!entity:HasMoney(price)) then
                return client:NotifyLocalized("smugglerNoMoney")
            end

            local stock, max = entity:GetStock(uniqueID)
            if (stock and stock >= max) then
                return client:NotifyLocalized("smugglerMaxStock")
            end

            if (entity:GetTotalStock() >= entity.maxStock) then
                return client:NotifyLocalized("smugglerMaxStock")
            end

            local invOkay = true
            local amount = 0
            local candidates = {}
            local amountNeeded = PLUGIN.itemList[uniqueID].stackSize
            if (!amountNeeded and ix.item.list[uniqueID].bInstanceMaxstack) then
                amountNeeded = ix.item.list[uniqueID].maxStackSize
            end

            for _, v in pairs(client:GetCharacter():GetInventory():GetItems()) do
                if (v.uniqueID == uniqueID and v:GetID() != 0 and ix.item.instances[v:GetID()] and v:GetData("equip", false) == false) then
                    if (v.maxStackSize and amountNeeded) then
                        candidates[#candidates + 1] = v
                        amount = amount + v:GetStackSize()
                    else
                        invOkay = v:Remove()
						found = true
						name = L(v.name, client)
                        break
                    end
                end
            end

            if (!found and amountNeeded) then
                if (amountNeeded > amount) then
                    price = math.floor(price * amount / amountNeeded)
                end

                found = true
                name = L(candidates[1].name, client)
                local i = #candidates
                while (amountNeeded > 0 and i > 0) do
                    local toRemove = math.min(amountNeeded, candidates[i]:GetStackSize())
                    amountNeeded = amountNeeded - toRemove
                    invOkay = invOkay and candidates[i]:RemoveStack(toRemove)
                    i = i - 1

                    if (!invOkay) then break end
                end
            end

            if (!found) then
                return
            end

            if (!invOkay) then
                client:GetCharacter():GetInventory():Sync(client, true)
                return client:NotifyLocalized("tellAdmin", "trd!iid")
            end

            client:GetCharacter():GiveMoney(price)
            client:NotifyLocalized("businessSell", name, ix.currency.Get(price))
            entity:TakeMoney(price)
            entity:AddStock(uniqueID)

            client:GetCharacter():DoAction("recipe_smuggling_"..uniqueID, false)

            ix.saveEnts:SaveEntity(entity)
            PLUGIN:SaveData()

            ix.log.Add(client, "smugglerSell", uniqueID, entity:GetDisplayName())

            --TODO: grant experience if not railroad item
            hook.Run("CharacterSmugglerTraded", client, entity, uniqueID, isSellingToSmuggler)
        else
            local bDelivery = net.ReadBool()
            if (!PLUGIN.itemList[uniqueID].sell) then
                client:NotifyLocalized("smugglerNoTrade")
            end

            if (!client:GetCharacter():HasMoney(price)) then
                return client:NotifyLocalized("canNotAfford")
            end

            if (bDelivery) then
                if (!IsValid(entity.pickupCache)) then
                    client:NotifyLocalized("smugglerInvalidPickupLocation")
                    return
                end

                client:GetCharacter():SetSmugglingPickupDelay(uniqueID, entity.pickupCache.uniqueID, entity.ixSmugglerDeliveryOffset)
                client.ixSmugglerDelivery = true

                ix.log.Add(client, "smugglerBuy", uniqueID, entity:GetDisplayName(), entity.pickupCache.uniqueID)
            else
                local stock = entity:GetStock(uniqueID)
                if (stock <= 0) then
                    return client:NotifyLocalized("smugglerNoStock")
                end

                local data = nil
                if (PLUGIN.itemList[uniqueID].stackSize) then
                    data = {stack = PLUGIN.itemList[uniqueID].stackSize}
                end

                if (!client:GetCharacter():GetInventory():Add(uniqueID, nil, data)) then
                    ix.item.Spawn(uniqueID, client, function(item)
                        if (data and data.stack) then
                            item:SetStack(data.stack)
                        end
                    end)
                else
                    net.Start("ixSmugglerAddItem")
                        net.WriteString(uniqueID)
                    net.Send(client)
                end

                entity:TakeStock(uniqueID)

                ix.log.Add(client, "smugglerBuy", uniqueID, entity:GetDisplayName())
            end
            client:GetCharacter():TakeMoney(price)
            entity:GiveMoney(price)

            client:GetCharacter():DoAction("recipe_smuggling_"..uniqueID, true)

            local name = L(ix.item.list[uniqueID].name, client)
            client:NotifyLocalized("businessPurchase", name, ix.currency.Get(price))

            ix.saveEnts:SaveEntity(entity)
            PLUGIN:SaveData()

            hook.Run("CharacterSmugglerTraded", client, entity, uniqueID, isSellingToSmuggler)
        end
    else
        client:NotifyLocalized("smugglerNoTrade")
    end
end)

net.Receive("ixSmugglerChosePickup", function(len, client)
    local entity = net.ReadEntity()
    if (!IsValid(client.ixSmuggler)) then
        return
    elseif (IsValid(client.ixSmuggler.pickupCache)) then
        netstream.Start(client, "ixSmugglerUpdateLocation", client.ixSmuggler, client.ixSmuggler.pickupCache:GetDisplayName())
        return
    end

    client.ixSmuggler.pickupCache = entity
    if (IsValid(client.ixSmuggler.pickupCache)) then
        netstream.Start(client, "ixSmugglerUpdateLocation", client.ixSmuggler, client.ixSmuggler.pickupCache:GetDisplayName())
    end
end)

netstream.Hook("SmugglingCachePickup", function(client, itemID)
    local character = client:GetCharacter()
    if (!character) then return end

    local cache = client.ixPickupCache
    if (!IsValid(cache) or cache.uniqueID == "") then
        return
    end

    local pickupItems = character:GetSmugglingPickupItems()
    if (pickupItems[cache.uniqueID] and pickupItems[cache.uniqueID][itemID] and pickupItems[cache.uniqueID][itemID] > 0) then
        if (character:SetSmugglingPickupItems(itemID, cache.uniqueID) == false) then return end
        local data = nil
        if (PLUGIN.itemList[itemID].stackSize) then
            data = {stack = PLUGIN.itemList[itemID].stackSize}
        end

        if (!client:GetCharacter():GetInventory():Add(itemID, nil, data)) then
            ix.item.Spawn(itemID, client, function(item)
                if (data and data.stack) then
                    item:SetStack(data.stack)
                end
            end)
        end

        ix.log.Add(client, "smugglerPickup", itemID, cache.uniqueID)

        client:UpdateStashWaypoints()

        character:Save()
    end
end)

netstream.Hook("ClosePickupCache", function(client)
    client.ixPickupCache = nil
end)
