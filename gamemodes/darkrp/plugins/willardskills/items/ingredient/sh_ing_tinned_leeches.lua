--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Konserve Sülükler"
ITEM.description = "Konserve sülük. Yemek pişirmek için kullanılır ve kesinlikle henüz tüketime hazır değildir."
ITEM.category = "Ingredient"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/cmb_food2.mdl"
ITEM.colorAppendix = {["blue"] = "Bu malzemeyi Takas becerisi ile (gıda malzemesi izni gerektirir) veya bir dükkandan edinin."}
ITEM.junk = "junk_tincan"

ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav"
ITEM.openedItem = "ing_raw_leech" -- the uniqueID e.g what comes after 'sh_' in the file name unless ITEM.uniqueID is specified
ITEM.openRequirementAmount = 3
ITEM.openRequirement = "tool_knife" -- same desc as above

ITEM.functions.Open = {
    OnRun = function(item)
        local client = item.player
        local character = item.player:GetCharacter()
        local inventory = character:GetInventory()
        local requirementTable = ix.item.list[item.openRequirement]
        local requirementName = requirementTable.name or item.openRequirement
        
        if (item.openRequirement) then
            local openerItem = inventory:HasItem(item.openRequirement)
            if !openerItem then
                client:NotifyLocalized("You do not have a "..requirementName.." to assemble this item")
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
                client:NotifyLocalized("You need "..requirementAmount.." inventory spaces to open this item.")
				return
            end
            
            client:NotifyLocalized("You have opened a "..item.name.." and been given a "..openedItemName)
        end
    end
}