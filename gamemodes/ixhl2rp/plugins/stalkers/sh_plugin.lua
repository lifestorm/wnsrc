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

PLUGIN.name = "Stalkers Faction"
PLUGIN.author = "Syn"
PLUGIN.description = "Adds Half-Life 2 stalkers faction"

ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sh_anims.lua")

function PLUGIN:InitializedPlugins()
	if (ix.plugin.list.inventoryslosts and FACTION_STALKER) then
		ix.plugin.list.inventoryslots.noEquipFactions[FACTION_STALKER] = true
	end
end