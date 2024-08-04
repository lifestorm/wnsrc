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

PLUGIN.name = "Combine Monitors"
PLUGIN.author = "Fruity"
PLUGIN.description = "Screens to state the status of the City. A helpful info terminal for broadcasts and city-state which helps citizens know what the CPs are currently doing and what the sociostability is, work cycle status and all that."

PLUGIN.clip = ix.util.Include("sh_3d2d_clipping.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")