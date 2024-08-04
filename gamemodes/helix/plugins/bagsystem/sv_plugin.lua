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

function PLUGIN:CanPlayerTradeWithVendor(client, entity, uniqueID, isSellingToVendor)
    if (isSellingToVendor) then return end

    if (uniqueID == "smallbag" or uniqueID == "largebag") then
        if (client:GetCharacter():GetInventory():HasItem(uniqueID)) then
            return false
        end
    end
end