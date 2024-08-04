--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Sangsues en conserve"
ITEM.description = "Conserve de sangsue pour la cuisine."
ITEM.category = "Ingrédients"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/cmb_food2.mdl"
ITEM.colorAppendix = {["blue"] = "Procurez-vous cet ingrédient avec la compétence Troc (nécessite un permis d'ingrédient alimentaire) ou dans un magasin."}
ITEM.junk = "junk_tincan"

ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav"
ITEM.openedItem = "ing_raw_leech" -- the uniqueID e.g what comes after 'sh_' in the file name unless ITEM.uniqueID is specified
ITEM.openRequirementAmount = 3
ITEM.openRequirement = "tool_knife" -- same desc as above

ITEM.functions.Open = {
name = "Diviser",
    OnRun = function(item)
        local client = item.player
        local character = item.player:GetCharacter()
        local inventory = character:GetInventory()
        local requirementTable = ix.item.list[item.openRequirement]
        local requirementName = requirementTable.name or item.openRequirement
        
        if (item.openRequirement) then
            local openerItem = inventory:HasItem(item.openRequirement)
            if !openerItem then
                client:NotifyLocalized("Vous n'avez pas de "..requirementName.." pour assembler cet article")
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
                client:NotifyLocalized("Vous avez besoin de"..requirementAmount.." d'espaces d'inventaire pour ouvrir cet article.")
				return
            end
            
            client:NotifyLocalized("Vous avez ouvert un "..item.name.." et reçu un "..openedItemName)
        end
    end
}
