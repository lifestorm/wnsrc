--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "drink_white_wine_premium_kofman"
ITEM.name = "Vin Blanc : Domaine Premium Kofman"
ITEM.description = "L'étiquette est propre, élégante. Une fois en bouche vos sens s'éveille, c'est du bon vin !"
ITEM.category = "Nourriture"
ITEM.model = "models/willardnetworks/food/red_wine.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
  pos = Vector(198.4, 22.59, 21.2),
  ang = Angle(3.26, 186.5, 0),
  fov = 2.17
}
ITEM.thirst = 100
ITEM.boosts = {
    agility = 1,
    intelligence = 5,
    perception = 5
}
ITEM.junk = "junk_empty_wine"

ITEM.useSound = "ambient/materials/platedrop3.wav"
ITEM.openedItem = "drink_white_wine_premium_glass" -- the uniqueID e.g what comes after 'sh_' in the file name unless ITEM.uniqueID is specified
ITEM.openRequirementAmount = 3

ITEM.functions.Share = {
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
                client:NotifyLocalized("You need "..requirementAmount.." inventory spaces to pour 3 wine glasses.")
                return
            end
            
            client:NotifyLocalized("You have poured a "..item.name.." and been given a "..openedItemName)
        end
    end
}