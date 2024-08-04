--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "dummy_biolock_expar2"
ITEM.name = "Odd Combine Rifle (Biolocked)"
ITEM.description = "An odd looking Combine Rifle that seems to be restricted in terms of use, but looks different from that which you are used to."
ITEM.category = "Dummy"
ITEM.width = 4
ITEM.height = 2
ITEM.model = "models/weapons/irifle2/w_irifle2.mdl"

ITEM.useSound = "ambient/energy/weld1.wav"
ITEM.unlockedItem = "suppressionrifle"
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
