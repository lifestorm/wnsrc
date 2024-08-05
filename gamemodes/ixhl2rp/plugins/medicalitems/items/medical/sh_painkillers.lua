--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Painkillers"
ITEM.model = Model("models/willardnetworks/skills/pills1.mdl")
ITEM.description = "A package of painkillers. It provides temporary relief from minor pains."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.maxStackSize = 4
ITEM.healing = {
    painkillers = 25
}
ITEM.usableInCombat = true
ITEM.holdData = {
    vectorOffset = {
        right = 0.5,
        up = -0.5,
        forward = 1.5
    },
    angleOffset = {
        right = 10,
        up = 0,
        forward = -80
    },
}