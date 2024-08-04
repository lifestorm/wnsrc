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
ITEM.name = "Strzykawka"
ITEM.description = "Strzykawka w której możesz trzymać płyn, przydatna do zabiegów medycznych."
ITEM.category = "Medicine Components"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/syringeammo.mdl"
ITEM.colorAppendix = {["blue"] = "Ten przedmiot można stworzyć dzięki umiejętności Wytwarzania."}
ITEM.useSound = "items/medshot4.wav"
ITEM.openedItem = "comp_bloodsyringe"
ITEM.openRequirementAmount = 1

ITEM.functions.DrawBlood = {
    name = "Pobierz krew",
    OnRun = function(item)
        local client = item.player

        ix.chat.Send(client, "me", "zaczyna pobierać z siebie krew!")
        client:Freeze(true)
        client:SetAction("Drawing Blood", 5, function()
            client:Freeze(false)

            if client:Health() <= 10 then
                client:NotifyLocalized("Nie masz wystarczająco dużo punktów zdrowia, aby bezpiecznie pobrać krew.")
                return false
            end

            local inventory = client:GetCharacter():GetInventory()
            local requirementAmount = item.openRequirementAmount or 1

            if item.openedItem then
                local openedItemName = ix.item.list[item.openedItem] and ix.item.list[item.openedItem].name or item.openedItem
                if not inventory:Add(item.openedItem, requirementAmount) then
                    client:NotifyLocalized("Potrzebujesz "..requirementAmount.." slotów w ekwipunku dla strzykawki.")
                    return false  
                end

                client:NotifyLocalized("Pobrałeś krew za pomocą "..item.name.." oraz otrzymałeś "..openedItemName)

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
    name = "Pobierz krew od kogoś",
    OnRun = function(item)
        local client = item.player
        local target = client:GetEyeTrace().Entity
        local startPos = target:GetPos()

        if not target:IsPlayer() then
            client:NotifyLocalized("Musisz patrzeć na prawidłowy cel, aby pobrać jej krew.")
            return false
        end

        ix.chat.Send(client, "me", "zaczyna pobierać krew z " .. target:GetName())
        client:Freeze(true)
        client:SetAction("Drawing Blood", 5, function()
            client:Freeze(false)

            if target:Health() <= 10 then
                client:NotifyLocalized("Cel nie ma wystarczająco dużo punktów zdrowia, aby bezpiecznie pobrać krew.")
                return false
            end

            if client:GetPos():Distance(target:GetPos()) > 150 then
                client:NotifyLocalized("Jesteś zbyt daleko od celu.")
                return false
            end
            
            local inventory = client:GetCharacter():GetInventory()
            local requirementAmount = item.openRequirementAmount or 1

            if item.openedItem then
                local openedItemName = ix.item.list[item.openedItem] and ix.item.list[item.openedItem].name or item.openedItem
                if not inventory:Add(item.openedItem, requirementAmount) then
                    client:NotifyLocalized("Potrzebujesz "..requirementAmount.." slotów w ekwipunku dla strzykawki.")
                    return false
                end

                client:NotifyLocalized("Pobrałeś krew za pomocą "..item.name.." oraz otrzymałeś "..openedItemName)

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
            client:NotifyLocalized("Jesteś zbyt daleko od celu.")
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
