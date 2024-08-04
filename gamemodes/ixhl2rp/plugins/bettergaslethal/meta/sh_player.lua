--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local playerMeta = FindMetaTable("Player")

function playerMeta:HasPPE()
    local character = self:GetCharacter()
    if (!character) then return false end

    local inventory = character:GetInventory()
    if (!inventory) then return false end

    local clothingItems = inventory:GetItems(true)
    for _, v in pairs(clothingItems) do
        if (v.isPPE and v:GetData("equip")) then
            return true
        end
    end
end