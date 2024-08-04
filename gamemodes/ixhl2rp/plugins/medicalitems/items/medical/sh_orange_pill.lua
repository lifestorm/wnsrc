--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Pomarańczowe tabletki"
ITEM.model = Model("models/willardnetworks/skills/pills7.mdl")
ITEM.description = "Ta tabletka pozornie sprawia, że czujesz się nieco silniejszy, a twój wzrok jest bardziej ostry."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 2
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
	strength = 3,
    perception = 3,
    agility = -3,
    intelligence = -3
}
ITEM.outlineColor = Color(255, 204, 0, 100)
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