--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLAYER = FindMetaTable("Player")

function PLAYER:GetQuickComms(number)
    local character = self:GetCharacter()
    if (!character) then return false end

    local items = character:GetInventory():GetItems()
    for k, v in pairs(items) do
        if (!v.isRadio or !v.isIFF) then continue end

        local channels = v:GetChannels()
        if (table.IsEmpty(channels)) then continue end

        if (channels[number]) then
            return channels[number]
        else
            return false
        end
    end

    return false
end

function PLAYER:HasQuickComms(channel)
    local character = self:GetCharacter()
    if (!character) then return false end

    local items = character:GetInventory():GetItems()
    for k, v in pairs(items) do
        if (!v.isRadio or !v.isIFF) then continue end

        local channels = v:GetChannels()
        if (table.IsEmpty(channels)) then continue end

        for k1, v1 in ipairs(channels) do
            if (v1 == channel) then
                return k1
            end
        end

        return false
    end

    return false
end