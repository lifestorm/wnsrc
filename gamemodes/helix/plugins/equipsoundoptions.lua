--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN;

PLUGIN.name = "Equip Sound Options"
PLUGIN.author = "M!NT"
PLUGIN.description = "Add some more options for item equip/use sounds."

ix.config.Add("equipSoundLevel", 60, "The level the equip sound effect plays at.", nil, {
	data = {min = 0, max = 100},
	category = "Equip Sound Options"
})


ix.config.Add("equipSoundEnabled", true, "Enable item equip sounds?", nil, {
	category = "Equip Sound Options"
})
