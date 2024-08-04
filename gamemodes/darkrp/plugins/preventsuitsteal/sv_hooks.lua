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
local ix = ix

function PLUGIN:OnItemTransferred(item, lastInventory, inventory)
    if lastInventory:GetID() == 0 then
        return
    end

    local isDroppedToWorld = (inventory:GetID() == 0)
    local lastOwnerCharacter = ix.char.loaded[lastInventory.owner]

    if lastOwnerCharacter and (item.isCP or item.isOTA) and (lastOwnerCharacter:GetBleedout() > 0) then
        local faction = lastOwnerCharacter:GetFaction()
        if faction == FACTION_CP or faction == FACTION_OTA then
            local replaceItem = item.replaceOnDeath

            if replaceItem then
                if isDroppedToWorld then
                    local dropPos = lastOwnerCharacter:GetPlayer():GetPos()
                    ix.item.Spawn(replaceItem, dropPos)
					item:Remove()
                else
					item:Remove()
                    inventory:Add(replaceItem)
                end
            end
        end
    end
end
