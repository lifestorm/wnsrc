--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "comp_syringe"
ITEM.name = "Seringue"
ITEM.description = "Une seringue capable de contenir des substances de type liquide, utiles à des fins médicinales."
ITEM.category = "Composants Médicaux"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/syringeammo.mdl"
ITEM.colorAppendix = {["blue"] = "Cet objet peut être fabriqué avec la compétence Artisanat."}

ITEM.useSound = "items/medshot4.wav"
ITEM.openedItem = "comp_bloodsyringe"
ITEM.openRequirementAmount = 1

ITEM.functions.Use = {
    name = "Utiliser",
    OnRun = function(item)
        local client = item.player
        local character = item.player:GetCharacter()
        local inventory = character:GetInventory()

        client:EmitSound(item.useSound)

        -- Spawn the opened item if it exists
		local requirementAmount = item.openRequirementAmount or 1
        if (item.openedItem) then
            local openedItemName = ix.item.list[item.openedItem] and ix.item.list[item.openedItem].name or item.openedItem
            if (!inventory:Add(item.openedItem, requirementAmount)) then
                client:NotifyLocalized("Vous avez besoin de  "..requirementAmount.." d'emplacement d'inventaire pour la seringue")
				return
            end

            client:NotifyLocalized("Vous avez extrait du sang avec le "..item.name.." et reçu un "..openedItemName)
        end
    end
}