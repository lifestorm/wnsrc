--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Morphine"
ITEM.model = Model("models/willardnetworks/skills/adrenaline.mdl")
ITEM.description = "A syringe filled with morphine. It provides temporary relief from severe pain."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 3
ITEM.useSound = "items/medshot4.wav"
ITEM.healing = {
    painkillers = 80
}
ITEM.boosts = {
	strength = 4
}

ITEM.outlineColor = Color(255, 204, 0, 100)

ITEM.usableInCombat = true