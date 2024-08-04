--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Niebieskie tabletki lepszej jakości"
ITEM.model = Model("models/willardnetworks/skills/pills5.mdl")
ITEM.description = "Niewielkich rozmiarów niebieska tabletka. Dzięki niej jesteś inteligentniejszy."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 2
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
	intelligence = 2,
    perception = -2
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