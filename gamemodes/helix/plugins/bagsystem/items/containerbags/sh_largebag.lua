--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Duża torba"
ITEM.description = "Plecak z insygniami Kombinatu."
ITEM.invWidth = 4
ITEM.invHeight = 4
ITEM.bodygroup = "bag"
ITEM.model = Model("models/willardnetworks/clothingitems/backpack.mdl")
ITEM.outfitCategory = "Bag"
ITEM.noOpen = true

ITEM.hooks.View = function(item, data)
    local client = item.player
    local inventory = client:GetCharacter():GetInventory()
    local items = inventory:GetItemsByUniqueID(item.uniqueID)
    if (#items > 1) then
        table.SortByMember(items, "id", true)
        if (items[1].id != item.id) then
            return false
        end
    end
end
