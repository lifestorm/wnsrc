--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

function PLUGIN:TakeGrenadeItem(client, class)
    for k, v in pairs(client:GetCharacter():GetInventory():GetItems(true)) do
        if (v.isGrenade and v:GetData("equip", false)
        and (v.grenadeEntityClass and v.grenadeEntityClass == class
        or v.class == (class or client:GetActiveWeapon():GetClass()))) then
            v:Unequip(client, false, true)
            break
        end
    end
end

function PLUGIN:OnEntityCreated(entity)
    if (IsValid(entity) and self.grenades[entity:GetClass()]) then
        -- Setting owner is not instant, so using timer
        timer.Simple(0, function()
            if (IsValid(entity)) then
                local client = entity:GetOwner()

                if (IsValid(client) and client:IsPlayer() and client:GetCharacter()) then
                    self:TakeGrenadeItem(client, entity:GetClass())
                end
            end
        end)

        timer.Create("GrenadesCleanup"..entity:EntIndex(), 60, 0, function()
            if (IsValid(entity) and IsValid(entity:GetOwner())) then
                local client = entity:GetOwner()

                entity:Remove()
            end

            timer.Remove("GrenadesCleanup"..entity:EntIndex())
        end)
    end
end

function PLUGIN:EntityRemoved(entity)
    if (IsValid(entity) and self.grenades[entity:GetClass()] and timer.Exists("GrenadesCleanup"..entity:EntIndex())) then
        timer.Remove("GrenadesCleanup"..entity:EntIndex())
    end
end

function PLUGIN:PlayerInteractItem(client, action, item)
    if (IsValid(client) and client:GetCharacter()) then
        local weapon = client:GetActiveWeapon()

        if (IsValid(weapon) and weapon:GetClass() == "tfa_rustalpha_flare" and item.isGrenade and item.class == weapon:GetClass()
        and weapon:GetStatus() == TFA.Enum.STATUS_GRENADE_READY) then
            weapon:StopSounds(weapon.OwnerViewModel)
            self:TakeGrenadeItem(client, weapon:GetClass())
        end
    end
end
