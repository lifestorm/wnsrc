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
ITEM.name = "Syringe"
ITEM.description = "A syringe able to contain liquid-like substances, useful for medicinal purposes."
ITEM.category = "Medicine Components"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/syringeammo.mdl"
ITEM.colorAppendix = {["blue"] = "This item can be made with the Crafting skill."}
ITEM.useSound = "items/medshot4.wav"
ITEM.openedItem = "comp_bloodsyringe"
ITEM.openRequirementAmount = 1

ITEM.functions.DrawBlood = {
    name = "Draw Blood",
    OnRun = function(item)
        local client = item.player

        ix.chat.Send(client, "me", "starts to draw blood from themselves!")
        client:Freeze(true)
        client:SetAction("Drawing Blood", 5, function()
            client:Freeze(false)

            if client:Health() <= 10 then
                client:NotifyLocalized("You don't have enough health to draw blood safely.")
                return false
            end

            local inventory = client:GetCharacter():GetInventory()
            local requirementAmount = item.openRequirementAmount or 1

            if item.openedItem then
                local openedItemName = ix.item.list[item.openedItem] and ix.item.list[item.openedItem].name or item.openedItem
                if not inventory:Add(item.openedItem, requirementAmount) then
                    client:NotifyLocalized("You need "..requirementAmount.." inventory slot for the syringe")
                    return false  
                end

                client:NotifyLocalized("You've extracted blood with the "..item.name.." and been given a "..openedItemName)

                client:SetHealth(client:Health() - 10)
                client:EmitSound(item.useSound)

                item:Remove()
                return true 
            end

            return false  
        end)

        return false 
    end,
    OnCanRun = function(item)
        local client = item.player
        return client:Health() > 10
    end
}

ITEM.functions.DrawBloodTarget = {
    name = "Draw Blood from Someone",
    OnRun = function(item)
        local client = item.player
        local target = client:GetEyeTrace().Entity
        local startPos = target:GetPos()

        if not target:IsPlayer() then
            client:NotifyLocalized("You need to look at a valid target to draw their blood.")
            return false
        end

        ix.chat.Send(client, "me", "starts to draw blood from " .. target:GetName())
        client:Freeze(true)
        client:SetAction("Drawing Blood", 5, function()
            client:Freeze(false)

            if target:Health() <= 10 then
                client:NotifyLocalized("The target doesn't have enough health to draw blood safely.")
                return false
            end

            if client:GetPos():Distance(target:GetPos()) > 150 then
                client:NotifyLocalized("You are too far away from the target.")
                return false
            end
            
            local inventory = client:GetCharacter():GetInventory()
            local requirementAmount = item.openRequirementAmount or 1

            if item.openedItem then
                local openedItemName = ix.item.list[item.openedItem] and ix.item.list[item.openedItem].name or item.openedItem
                if not inventory:Add(item.openedItem, requirementAmount) then
                    client:NotifyLocalized("You need "..requirementAmount.." inventory slot for the syringe")
                    return false
                end

                client:NotifyLocalized("You've extracted blood with the "..item.name.." and been given a "..openedItemName)

                target:SetHealth(target:Health() - 10)
                client:EmitSound(item.useSound)

                item:Remove()
                return true 
            end

            return false  
        end)

        return false 
    end,
    OnCanRun = function(item)
        local client = item.player
        local target = client:GetEyeTrace().Entity

        if not target:IsPlayer() or target:Health() <= 10 then
            return false
        end

        if client:GetPos():Distance(target:GetPos()) > 150 then
            client:NotifyLocalized("You are too far away from the target.")
            return false
        end

        return true
    end
}

-- am doing this cuz im not sure if the item instances this function or not!! and am too lazy to check!
ITEM.functions.Use = {
    OnRun = function(item)
        return false 
    end,
    OnCanRun = function(item)
        return false 
    end
}
