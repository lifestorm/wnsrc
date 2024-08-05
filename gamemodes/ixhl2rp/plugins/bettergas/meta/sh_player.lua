--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local pairs = pairs
local math = math
local ix = ix

local playerMeta = FindMetaTable("Player")

function playerMeta:HasGasmask()
    local character = self:GetCharacter()
    if (!character) then return false end

    local inventory = character:GetInventory()
    if (!inventory) then return false end

    local clothingItems = inventory:GetItems(true)
    for _, v in pairs(clothingItems) do
        if (v.isGasmask and v:GetData("equip")) then
            return true
        end
    end
end

function playerMeta:GetFilterItem()
    if (!self:HasGasmask()) then return nil end

    local itemID = self:GetCharacter():GetFilterItem()
    if (ix.item.instances[itemID]) then
        return ix.item.instances[itemID]
    end
end

function playerMeta:GetFilterQuality()
    local filter = self:GetFilterItem()

    if (!filter) then return 0 end

    if (filter.GetFilterQuality) then
        return filter:GetFilterQuality()
    else
        return filter.filterQuality or 0.1
    end
end

function playerMeta:GetFilterValue()
    local filter = self:GetFilterItem()

    if (!filter) then return 0 end

    return filter:GetData("filterValue", filter.maxFilterValue)
end

function playerMeta:UpdateFilterValue(amount)
    local filter = self:GetFilterItem()
    if (!filter) then return end

    local oldValue = filter:GetData("filterValue", filter.maxFilterValue)
    filter:SetData("filterValue", math.Clamp(oldValue - amount, 0, filter.maxFilterValue))

    if (ix.option.Get(self, "gasNotificationWarnings") and
        oldValue >= filter.filterDecayStart * filter.maxFilterValue) then
        if (filter:GetData("filterValue") == 0) then
            self:NotifyLocalized("filterOut")
        elseif (filter:GetData("filterValue") < filter.filterDecayStart * filter.maxFilterValue) then
            self:NotifyLocalized("filterDecay")
        end
    end
end