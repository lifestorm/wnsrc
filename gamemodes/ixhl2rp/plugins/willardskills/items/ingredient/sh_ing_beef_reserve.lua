--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Wzbogacona Wołowina"
ITEM.description = "Zawiera 2 kawałki wołowiny. Potrzeba noża do otworzenia."
ITEM.category = "Ingredient"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/cmb_food4.mdl"

ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav"
ITEM.openedItem = "ing_beef" -- the uniqueID e.g what comes after 'sh_' in the file name unless ITEM.uniqueID is specified
ITEM.openRequirementAmount = 2
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
                client:NotifyLocalized("Nie posiadasz "..requirementName.." aby otworzyć ten przedmiot.")
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
                client:NotifyLocalized("Potrzebujesz"..requirementAmount.." slotów w ekwipunku aby otworzyć ten przedmiot.")
				return
            end
            
            client:NotifyLocalized("Otworzyłeś "..item.name.." i dostałeś "..openedItemName)
        end
    end
}