--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Adrénaline"
ITEM.model = Model("models/willardnetworks/skills/adrenaline.mdl")
ITEM.description = "Cette petite seringue contient de l'adrénaline, une hormone qui peut aider à stimuler le système nerveux en cas d'urgence médicale. Elle est facilement reconnaissable grâce à son corps en plastique transparent et à son aiguille fine à l'extrémité."
ITEM.category = "Médical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 3
ITEM.healing = {
	painkillers = 60
}
ITEM.boosts = {
    agility = 4,
}
-- Drug effects list declared in plugins/drugs/sh_plugin.lua
ITEM.drug = {
    ["sharpen"] = 5
}

ITEM.outlineColor = Color(255, 204, 0, 100)
