--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Fioletowe tabletki"
ITEM.model = Model("models/willardnetworks/skills/pills6.mdl")
ITEM.description = "Ta tabletka wydaje się sprawiać, że szybciej myślisz i biegasz kosztem ekstremalnego osłabienia."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 1
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
	agility = 2,
	intelligence = 2,
    perception = 2,
    strength = -6
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