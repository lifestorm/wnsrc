--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "dummy_biolock_ar2"
ITEM.name = "Biolocked Pulse-Rifle"
ITEM.description = "An Overwatch Pulse-Rifle dropped by a Comine Soldier... it seems to be locked by some form of internal component. It requires a Vortigaunt to unlock this."
ITEM.category = "Dummy"
ITEM.width = 4
ITEM.height = 2
ITEM.model = "models/weapons/w_IRifle.mdl"

ITEM.useSound = "ambient/energy/weld1.wav"
ITEM.unlockedItem = "pulse"
ITEM.unlockRequirementAmount = 1

ITEM.functions.Unlock = {
    OnRun = function(item)
        local client = item.player
        local position = item.player:GetPos()
        local character = item.player:GetCharacter()
        local inventory = character:GetInventory()
        
        client:EmitSound(item.useSound)

        -- Spawn the opened item if it exists
		local requirementAmount = item.unlockRequirementAmount or 1
        if (character:GetFaction() == FACTION_VORT) then
            if (item.unlockedItem) then
                local openedItemName = ix.item.list[item.unlockedItem].name or item.unlockedItem
                if (!inventory:Add(item.unlockedItem, requirementAmount)) then
                    client:NotifyLocalized("You need "..requirementAmount.." inventory spaces to open this item.")
                    return
                end
                
                client:NotifyLocalized("You have unlocked a "..item.name.." and been given a "..openedItemName)
            end
        else
            return false
        end
    end,
    OnCanRun = function(item)
        if (IsValid(item.entity) or !IsValid(item.player)) then return false end
    end
}
