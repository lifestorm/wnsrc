--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Basic Red Pill"
ITEM.model = Model("models/willardnetworks/skills/pills4.mdl")
ITEM.description = "A basic and small red pill. It makes you feel... somewhat stronger."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 2
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
	strength = 1
}
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