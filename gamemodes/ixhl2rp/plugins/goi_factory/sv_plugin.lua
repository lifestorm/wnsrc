--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

util.AddNetworkString("ixBatteryChargerUse")

function PLUGIN:EntityRemoved(ent)
    if (ent:GetClass() == "ix_item") then
        if (ent:GetItemID() == "id_card" and ent.attached and IsValid(ent.attached)) then
            ent.attached:OnCIDDetach()
            ent.attached:SetCID(-1)
        elseif (ent:GetItemID() == "datadisc" and ent.attached and IsValid(ent.attached)) then
            ent.attached:OnDiscDetach()
        elseif (ent:GetItemID() == "cwu_card" and ent.attached and IsValid(ent.attached)) then
            ent.attached:OnCWUCardDetach()
            ent.attached:SetCWUCard(-1)
        end
        if ent.dispenser and IsValid(ent.dispenser) then
            ent.dispenser.dispensedObject = nil
            ent.dispenser:OnDispensedItemTaken()
        end
    end
end

ix.saveEnts:RegisterEntity("ix_shopterminal", true, true, true, {
    OnSave = function(entity, data) --OnSave
        data.shop = entity:GetShop()
        data.cost = entity:GetShopCost()
        data.scReq = entity:GetShopSocialCreditReq()
    end,
    OnRestore = function(entity, data) --OnRestore
        timer.Simple( 60, function() -- For some reason, I think when the entity initializes it resets these values. So I did this timer in my branch to fix it - it's not a permanent solution but it works for now.
            entity:SetShop(data.shop)
            entity:SetShopCost(data.cost)
            entity:SetShopSocialCreditReq(data.scReq)
        end )
    end,
})

ix.saveEnts:RegisterEntity("ix_cwuterminal", true, true, true, {
    OnSave = function(entity, data) --OnSave
        return {pos = data.pos, angles = data.angles, motion = false}
    end,
})

ix.saveEnts:RegisterEntity("ix_discscanner", true, true, true, {
    OnSave = function(entity, data) --OnSave
        return {pos = data.pos, angles = data.angles, motion = false}
    end,
})

ix.saveEnts:RegisterEntity("ix_fabricator", true, true, true, {
    OnSave = function(entity, data) --OnSave
        return {pos = data.pos, angles = data.angles, motion = false}
    end,
})

ix.saveEnts:RegisterEntity("ix_batterycharger", true, true, true, {
    OnSave = function(entity, data) --OnSave
        return {pos = data.pos, angles = data.angles, motion = false}
    end,
})