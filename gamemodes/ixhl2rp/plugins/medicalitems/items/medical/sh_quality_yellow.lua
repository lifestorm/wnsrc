--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Żółte tabletki doskonałej jakości"
ITEM.model = Model("models/willardnetworks/skills/pills3.mdl")
ITEM.description = "Ciekawa żółta pigułka, jej smak jest bardziej wyrafinowany niż dotychczas. Doskonale wyostrza percepcję wzrokową."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 1
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
    perception = 3,
    intelligence = -3
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