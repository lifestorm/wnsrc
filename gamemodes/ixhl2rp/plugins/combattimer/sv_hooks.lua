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

function PLUGIN:EntityTakeDamage(entity, damage)
    if !entity:IsPlayer() then
        return
    end

    if timer.Exists("combattimer" .. entity:SteamID64()) then
        timer.Adjust("combattimer" .. entity:SteamID64(), 30, nil, nil)
    else
        entity:Notify("You have taken damage and are now considered to be in combat.")
        timer.Create("combattimer" .. entity:SteamID64(), 30, 1, function() if !IsValid(entity) then return end entity:Notify("You are no longer considered to be in combat.") end )
    end
end
