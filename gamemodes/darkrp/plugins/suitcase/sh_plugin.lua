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

PLUGIN.name = "Suitcase"
PLUGIN.description = "Adds a wearable suitcase"
PLUGIN.author = "Exobit"

function PLUGIN:PlayerLoadedCharacter(client, character)
    local characterInv = character:GetInventory()
    local suitcase = characterInv:HasItem("suitcase")
    if suitcase then
        suitcase:SetData("equip", false)
    end
end

function PLUGIN:DoPlayerDeath(client, attacker, damageinfo)
    local character = client:GetCharacter()
    if (!character) then return end

    local inventory = character:GetInventory()
    if (character and inventory) then
        if inventory:HasItem("suitcase") then
            local item = inventory:HasItem("suitcase")
            item:SetData("equip", false)
            item.player = client
            item.functions.EquipUn.OnRun(item)
            item.player = nil
        end
    end
end