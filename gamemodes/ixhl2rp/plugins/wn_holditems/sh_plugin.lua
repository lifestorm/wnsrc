--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name = "Hold Items"
PLUGIN.author = "Naast"
PLUGIN.description = "Allows you to hold items."

ix.util.IncludeDir(PLUGIN.folder .. "/meta", true)
ix.util.Include("sv_plugin.lua")

function PLUGIN:InitializedPlugins()
    ix.holdItems.forbiddenFactions = {
        [FACTION_EVENT] = true,
        [FACTION_OTA] = true,
        [FACTION_SERVERADMIN] = true,
        [FACTION_BIRD] = true,
        [FACTION_STALKER] = true,
        [FACTION_VORT] = true,
        [FACTION_HEADCRAB] = true,
        [FACTION_CREMATOR] = true,
    }

    for _, v in pairs(ix.item.list) do
        v:InitializeHoldable()
    end
end