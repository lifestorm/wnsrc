--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "drink_champagne"
ITEM.name = "Bouteille de champagne pétillant"
ITEM.description = "Selon les rumeurs, le champagne est toujours dans les hautes sphères, un régal prestigieux et rare à découvrir de nos jours."
ITEM.category = "Nourriture"
ITEM.model = "models/willardnetworks/food/prop_bar_bottle_a.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
  pos = Vector(200.72, -2.98, 15.5),
  ang = Angle(2.1, 179.15, 0),
  fov = 2.69
}
ITEM.thirst = 100
ITEM.boosts = {
    perception = 3,
    agility = 3,
	intelligence = 5
}

ITEM.useSound = "ambient/materials/platedrop3.wav"
ITEM.openedItem = "drink_champagne_glass"
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
                client:NotifyLocalized("You need "..requirementAmount.." inventory spaces to pour 3 champagne glasses.")
				return
            end
            
            client:NotifyLocalized("You have poured a "..item.name.." and been given a "..openedItemName)
        end
    end
}