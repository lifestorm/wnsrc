--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bandage Roll"
ITEM.model = Model("models/stuff/bandages.mdl")
ITEM.description = "A roll of bandages. Used to stop bleeding."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 6
ITEM.healing = {
	bandage = 15
}
ITEM.useSound = "willardnetworks/inventory/inv_bandage.wav"
ITEM.usableInCombat = true
ITEM.holdData = {
    vectorOffset = {
        right = 1.5,
        up = 0,
        forward = 1
    },
    angleOffset = {
        right = 0,
        up = 90,
        forward = -90
    },
}