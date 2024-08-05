--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.holdItems = ix.holdItems or {}
ix.holdItems.holdableList = ix.holdItems.holdableList or {}
ix.holdItems.holdTypes = ix.holdItems.holdTypes or {}
ix.holdItems.forbiddenFactions = ix.holdItems.forbiddenFactions or {}

function ix.holdItems:AddItemToHoldables(itemID, holdData)
    ix.holdItems.holdableList[itemID] = {
        itemID = itemID,
        holdData = holdData
    }
end

function ix.holdItems:AddHoldType(holdTypeID, name, attachment)
    ix.holdItems.holdTypes[holdTypeID] = {
        id = holdTypeID,
        name = name,
        attachment = attachment
    }
end

function ix.holdItems:CanHold(itemID)
    return ix.holdItems.holdableList[itemID]
end

ix.holdItems:AddHoldType("rhand", "Right Hand", "anim_attachment_RH")
ix.holdItems:AddHoldType("lhand", "Left Hand", "anim_attachment_LH")