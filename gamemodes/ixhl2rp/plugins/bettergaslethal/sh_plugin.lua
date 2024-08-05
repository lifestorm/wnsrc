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

PLUGIN.name = "Better Lethal Gas"
PLUGIN.author = "Asimo but mainly Gr4ss"
PLUGIN.description = "Essentially a broken down copy of the Better Gas plugin. Major thanks to Gr4ss for essentially coming up with 90% of this."

ix.util.Include("meta/sh_player.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

if (SERVER) then
    PLUGIN.timerLethalGasChangeCallback = function(_, newVal)
        for k, v in ipairs(player.GetAll()) do
            local uniqueID = "ixLethalGas"..v:SteamID64()
            if (timer.Exists(uniqueID)) then
                timer.Adjust(uniqueID, newVal)
            end
        end
    end
end

ix.config.Add("LethalGasDamageTimer", 5, "How often, in seconds, the damage timer for being in lethal gas should run.", PLUGIN.timerLethalGasChangeCallback, {
    data = {min = 1, max = 10, decimals = 0},
    category = "LethalGas"
})
ix.config.Add("LethalGasDamage", 5, "How much should the default damage of gas be?", nil, {
    data = {min = 1, max = 100, decimals = 1},
    category = "LethalGas"
})
ix.config.Add("GasVorts", true, "Should lethal gas damage those factions that are immune to gas?", nil, {
	category = "LethalGas"
})
ix.config.Add("GasBleedout", true, "Should lethal gas damage players in bleedout?", nil, {
	category = "LethalGas"
})

ix.lang.AddTable("english", {
	lethalGasEntered = "Something in the air weighs heavy on your body. You feel like you shouldn't stick around here without proper protection."
})