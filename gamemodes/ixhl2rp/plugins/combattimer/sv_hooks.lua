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
        entity:Notify("Otrzymałeś obrażenia, przez co obecnie uznawany jesteś za znajdującego się w walce.")
        timer.Create("combattimer" .. entity:SteamID64(), 30, 1, function() if !IsValid(entity) then return end entity:Notify("Nie jesteś już uważany za znajdującego się w walce.") end )
    end
end
