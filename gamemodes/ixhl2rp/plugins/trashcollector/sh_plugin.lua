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

PLUGIN.name = "Trash Collector"
PLUGIN.author = "Fruity"
PLUGIN.description = "Press E and throw empty cans and misc trash away."

PLUGIN.disAllowedJunk = {
    "junk_pc_monitor",
    "junk_frame",
    "trash_biolock",
    "junk_cardboard"
}

ix.util.Include("sv_plugin.lua")