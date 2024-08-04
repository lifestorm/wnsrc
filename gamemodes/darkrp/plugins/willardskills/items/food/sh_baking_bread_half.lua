--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Pain coupé en deux"
ITEM.description = "Une demi-miche de pain prête à être consommée."
ITEM.category = "Nourriture"
ITEM.model = "models/willardnetworks/food/bread_half.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(258.35, 217.47, 159.76),
  ang = Angle(25.14, 219.92, 0),
  fov = 1.49
}
ITEM.hunger = 20
ITEM.boosts = {
	strength = 2
}
ITEM.spoil = true

ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav"
ITEM.openedItem = "baking_bread_slice" -- the uniqueID e.g what comes after 'sh_' in the file name unless ITEM.uniqueID is specified
ITEM.openRequirementAmount = 4
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
                client:NotifyLocalized("Vous n'avez pas d'outil requis pour assembler cet article")
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
                client:NotifyLocalized("Vous avez besoin de  "..requirementAmount.." d'espaces d'inventaire pour trancher cet article.")
				return
            end
            
            client:NotifyLocalized("Vous avez tranché un "..item.name.." et reçu un "..openedItemName)
        end
    end
}
