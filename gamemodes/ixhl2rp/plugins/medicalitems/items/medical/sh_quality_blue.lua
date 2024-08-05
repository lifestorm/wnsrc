--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Niebieskie tabletki doskonałej jakości"
ITEM.model = Model("models/willardnetworks/skills/pills5.mdl")
ITEM.description = "Ciekawa niebieska tabletka, jej smak jest bardziej wyrafinowany niż dotychczas. Dzięki niej jesteś super inteligentny... wiedza po prostu pędzi przez umysł."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 1
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
	intelligence = 3,
    perception = -3
}
ITEM.outlineColor = Color(255, 78, 69, 100)
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