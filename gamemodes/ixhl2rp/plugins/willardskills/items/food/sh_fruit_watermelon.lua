--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "fruit_watermelon"
ITEM.name = "Watermelon"
ITEM.description = "A large, round, green fruit. Rather pink inside!"
ITEM.category = "Food"
ITEM.width = 2
ITEM.height = 2
ITEM.model = "models/willardnetworks/food/watermelon_unbreakable.mdl"
ITEM.cost = 32
ITEM.maxStock = 4
ITEM.hunger = 30
ITEM.thirst = 50
ITEM.spoil = true

ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav"
ITEM.openedItem = "fruit_watermelon_half" -- the uniqueID e.g what comes after 'sh_' in the file name unless ITEM.uniqueID is specified
ITEM.openRequirementAmount = 2
ITEM.openRequirements = {"tool_knife", "cleaver", "hatchet", "kitknife", "machete"} -- same desc as above

ITEM.functions.Slice = {
    OnRun = function(item)
        local client = item.player
        local character = item.player:GetCharacter()
        local inventory = character:GetInventory()
        local openerItem
        
        if (item.openRequirements) then
            for k, v in ipairs(item.openRequirements) do 
                if inventory:HasItem(v) then 
                    openerItem = inventory:HasItem(v) 
                    break
                end 
            end
            if !openerItem then
                client:NotifyLocalized("You do not have a required tool to assemble this item")
                return false
            else
                if (openerItem.isTool) then
                    openerItem:DamageDurability(1)
                end
            end
        end
        
        client:EmitSound(item.useSound)

        -- Spawn the opened item if it exists
		local requirementAmount = item.openRequirementAmount or 1
        if (item.openedItem) then
            local openedItemName = ix.item.list[item.openedItem].name or item.openedItem
            if (!inventory:Add(item.openedItem, requirementAmount)) then
                client:NotifyLocalized("You need "..requirementAmount.." inventory spaces to slice this item.")
				return
            end
            
            client:NotifyLocalized("You have sliced a "..item.name.." and been given a "..openedItemName)
        end
    end
}