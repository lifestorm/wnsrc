--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- luacheck: globals SMUGGLER_TEXT
-- luacheck: read globals SMUGGLER_BUY SMUGGLER_SELL SMUGGLER_BOTH SMUGGLER_WELCOME SMUGGLER_LEAVE SMUGGLER_NOTRADE SMUGGLER_PRICE
-- luacheck: read globals SMUGGLER_STOCK SMUGGLER_MODE SMUGGLER_MAXSTOCK SMUGGLER_SELLANDBUY SMUGGLER_SELLONLY SMUGGLER_BUYONLY

local PLUGIN = PLUGIN

SMUGGLER_TEXT = {}
SMUGGLER_TEXT[SMUGGLER_SELLANDBUY] = "smugglerBoth"
SMUGGLER_TEXT[SMUGGLER_BUYONLY] = "smugglerBuy"
SMUGGLER_TEXT[SMUGGLER_SELLONLY] = "smugglerSell"

net.Receive("ixSmugglerOpen", function()
    local entity = net.ReadEntity()

    if (!IsValid(entity)) then
        return
    end

    entity.money = net.ReadUInt(16)
    entity.maxStock = net.ReadUInt(16)
    entity.pickupLocation = net.ReadString()
    entity.items = net.ReadTable()
    entity.stashList = net.ReadTable()

    ix.gui.smuggler = vgui.Create("ixSmuggler")
    ix.gui.smuggler:SetReadOnly(false)
    ix.gui.smuggler:Setup(entity)
end)

net.Receive("ixSmugglerEditor", function()
    local entity = net.ReadEntity()

    if (!IsValid(entity) or !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Manage Smugglers", nil)) then
        return
    end

    entity.money = net.ReadUInt(16)
    entity.maxStock = net.ReadUInt(16)
    entity.items = net.ReadTable()
    entity.messages = net.ReadTable()

    ix.gui.smuggler = vgui.Create("ixSmuggler")
    ix.gui.smuggler:SetReadOnly(true)
    ix.gui.smuggler:Setup(entity)
    ix.gui.smugglerEditor = vgui.Create("ixSmugglerEditor")
end)

net.Receive("ixSmugglerEdit", function()
    local panel = ix.gui.smuggler

    if (!IsValid(panel)) then
        return
    end

    local entity = panel.entity

    if (!IsValid(entity)) then
        return
    end

    local key = net.ReadString()
    local data = net.ReadType()

    if (key == "mode") then
        entity.items[data[1]] = entity.items[data[1]] or {}
        entity.items[data[1]][SMUGGLER_MODE] = data[2]

        if (!data[2]) then
            panel:removeItem(data[1])
        elseif (data[2] == SMUGGLER_SELLANDBUY) then
            panel:addItem(data[1])
        else
            panel:addItem(data[1], data[2] == SMUGGLER_SELLONLY and "selling" or "buying")
            panel:removeItem(data[1], data[2] == SMUGGLER_SELLONLY and "buying" or "selling")
        end
    elseif (key == "stockMax") then
        entity.maxStock = data

        for k in pairs(entity.items) do
            panel:addItem(k)
        end
    elseif (key == "stock") then
        local uniqueID = data[1]
        local value = data[2]

        entity.items[uniqueID] = entity.items[uniqueID] or {}
        entity.items[uniqueID][SMUGGLER_STOCK] = value
    end
end)

net.Receive("ixSmugglerEditFinish", function()
    local panel = ix.gui.smuggler
    local editor = ix.gui.smugglerEditor

    if (!IsValid(panel) or !IsValid(editor)) then
        return
    end

    local entity = panel.entity

    if (!IsValid(entity)) then
        return
    end

    local key = net.ReadString()
    local data = net.ReadType()

    if (key == "name") then
        editor.name:SetText(data)
    elseif (key == "description") then
        editor.description:SetText(data)
    elseif (key == "mode") then
        if (data[2] == nil) then
            editor.lines[data[1]]:SetValue(3, L"none")
        else
            editor.lines[data[1]]:SetValue(3, L(SMUGGLER_TEXT[data[2]]))
        end
    elseif (key == "stock") then
        local current, max = entity:GetStock(data)

        if (max == entity.maxStock) then
            editor.lines[data]:SetValue(4, current)
        else
            editor.lines[data]:SetValue(4, current.."/"..max)
        end
    elseif (key == "stockMax") then
        for k, v in pairs(editor.lines) do
            local current, max = entity:GetStock(k)
            if (max == entity.maxStock) then
                v:SetValue(5, current)
            else
                v:SetValue(5, current.."/"..max)
            end
        end
    elseif (key == "model") then
        editor.model:SetText(entity:GetModel())
    elseif (key == "stashList") then
        local lines = editor.stashList:GetLines()
        for k, v in pairs(lines) do
            if (k != 1) then
                editor.stashList:RemoveLine(k)
            end
        end

        for k, v in pairs(data) do
            editor.stashList:AddLine(v)
        end
    end

    surface.PlaySound("buttons/button14.wav")
end)

net.Receive("ixSmugglerMoney", function()
    local panel = ix.gui.smuggler

    if (!IsValid(panel)) then
        return
    end

    local entity = panel.entity

    if (!IsValid(entity)) then
        return
    end

    local value = net.ReadUInt(16)
    value = value != -1 and value or nil

    entity.money = value

    local editor = ix.gui.smugglerEditor

    if (IsValid(editor)) then
        local useMoney = tonumber(value) != nil

        editor.money:SetDisabled(!useMoney)
        editor.money:SetEnabled(useMoney)
        editor.money:SetText(useMoney and value or "∞")
    end
end)

net.Receive("ixSmugglerStock", function()
    local panel = ix.gui.smuggler

    if (!IsValid(panel)) then
        return
    end

    local entity = panel.entity

    if (!IsValid(entity)) then
        return
    end

    local uniqueID = net.ReadString()
    local amount = net.ReadUInt(16)

    entity.items[uniqueID] = entity.items[uniqueID] or {}
    entity.items[uniqueID][SMUGGLER_STOCK] = amount

    local editor = ix.gui.smugglerEditor

    if (IsValid(editor)) then
        local _, max = entity:GetStock(uniqueID)

        if (max == entity.maxStock) then
            editor.lines[uniqueID]:SetValue(4, amount)
        else
            editor.lines[uniqueID]:SetValue(4, amount.."/"..max)
        end
    end
end)

net.Receive("ixSmugglerAddItem", function()
    local uniqueID = net.ReadString()

    if (IsValid(ix.gui.smuggler)) then
        ix.gui.smuggler:addItem(uniqueID, "buying")
    end
end)

netstream.Hook("ixSmugglingPickupItems", function(items)
    LocalPlayer().pickupItems = items

    vgui.Create("PickupCache")
end)

netstream.Hook("ixSmugglingCacheUIDs", function(cacheIDList)
    PLUGIN.cacheIDList = cacheIDList
end)

netstream.Hook("ixSmugglerUpdateLocation", function(entity, location)
    entity.pickupLocation = location

    if (IsValid(ix.gui.smuggler) and ix.gui.smuggler.entity == entity) then
        ix.gui.smuggler.smugglerSellDeliver:SetText(L("smugglerDeliverTo", entity.pickupLocation))
    end
end)

netstream.Hook("ixShowStashWaypoints", function(waypoints, stashEntities)
    LocalPlayer().ixStashWaypoints = waypoints
    LocalPlayer().ixStashEntities = stashEntities
end)

local function cacheESP(client, entity, x, y, factor)
    ix.util.DrawText("Pickup Cache - "..(PLUGIN.cacheIDList[entity:EntIndex()] and PLUGIN.cacheIDList[entity:EntIndex()].uniqueID or "no id set"), x, y - math.max(10, 32 * factor), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, factor)
end
ix.observer:RegisterESPType("ix_pickupcache", cacheESP, "cache", "Show Pickup Cache ESP")

local function smugglerESP(client, entity, x, y, factor)
    cam.Start3D()
        render.SuppressEngineLighting(true)
        render.SetColorModulation(1, 1, 1)
        render.SetBlend(factor)
        entity:DrawModel()
        render.MaterialOverride()
        render.SuppressEngineLighting(false)
    cam.End3D()

    ix.util.DrawText("Smuggler - "..entity:GetDisplayName(), x, y - math.max(10, 32 * factor), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, factor)
end
ix.observer:RegisterESPType("ix_smuggler", smugglerESP, "smuggler")
