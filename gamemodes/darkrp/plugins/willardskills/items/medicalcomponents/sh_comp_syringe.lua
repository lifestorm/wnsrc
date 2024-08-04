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
ITEM.name = "Şırınga"
ITEM.description = "Tıbbi amaçlar için yararlı, sıvı benzeri maddeler içerebilen bir şırınga."
ITEM.category = "Medicine Components"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/skills/syringeammo.mdl"
ITEM.colorAppendix = {["blue"] = "Bu eşya Zanaatkarlık becerisi ile yapılabilir."}
ITEM.useSound = "items/medshot4.wav"
ITEM.openedItem = "comp_bloodsyringe"
ITEM.openRequirementAmount = 1

ITEM.functions.DrawBlood = {
    name = "Kan Al",
    OnRun = function(item)
        local client = item.player

        ix.chat.Send(client, "me", "kendinden kan çekmeye başlar!")
        client:Freeze(true)
        client:SetAction("Kan Alınıyor", 5, function()
            client:Freeze(false)

            if client:Health() <= 10 then
                client:NotifyLocalized("Güvenli bir şekilde kan almak için yeterli sağlığınız yok.")
                return false
            end

            local inventory = client:GetCharacter():GetInventory()
            local requirementAmount = item.openRequirementAmount or 1

            if item.openedItem then
                local openedItemName = ix.item.list[item.openedItem] and ix.item.list[item.openedItem].name or item.openedItem
                if not inventory:Add(item.openedItem, requirementAmount) then
                    client:NotifyLocalized("Şırınga için "..requirementAmount.." adet envanter slotuna ihtiyacınız var")
                    return false  
                end

                client:NotifyLocalized(item.name.." ile kan aldınız ve "..openedItemName.." kazandınız.")

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
    name = "Birinden Kan Al",
    OnRun = function(item)
        local client = item.player
        local target = client:GetEyeTrace().Entity
        local startPos = target:GetPos()

        if not target:IsPlayer() then
            client:NotifyLocalized("Kanını almak için geçerli bir hedefe bakmanız gerekir.")
            return false
        end

        ix.chat.Send(client, "me", target:GetName().." adlı kişiden kan almaya başlıyor!")
        client:Freeze(true)
        client:SetAction("Kan Alınıyor", 5, function()
            client:Freeze(false)

            if target:Health() <= 10 then
                client:NotifyLocalized("Hedef, güvenli bir şekilde kan almak için yeterli sağlığa sahip değil.")
                return false
            end

            if client:GetPos():Distance(target:GetPos()) > 150 then
                client:NotifyLocalized("Hedeften çok uzaktasınız.")
                return false
            end
            
            local inventory = client:GetCharacter():GetInventory()
            local requirementAmount = item.openRequirementAmount or 1

            if item.openedItem then
                local openedItemName = ix.item.list[item.openedItem] and ix.item.list[item.openedItem].name or item.openedItem
                if not inventory:Add(item.openedItem, requirementAmount) then
                    client:NotifyLocalized("Şırınga için "..requirementAmount.." adet envanter slotuna ihtiyacınız var")
                    return false
                end

                client:NotifyLocalized(item.name.." ile kan aldınız ve "..openedItemName.." kazandınız.")

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
            client:NotifyLocalized("Hedeften çok uzaktasınız.")
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
