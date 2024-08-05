--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "LN | Vending Machines"
PLUGIN.description = "Adds dynamic Vending Machines."
PLUGIN.author = "Aspect™ & Chessnut"

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

function PLUGIN:InitializedPlugins()
	ix.inventory.Register("vendingMachine", 10, 8)
end
