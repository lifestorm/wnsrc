--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Disinfected Bandage Roll"
ITEM.model = Model("models/stuff/bandages.mdl")
ITEM.description = "A roll of disinfected sanitary bandages. Used to stop bleeding and clean wounds."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1

ITEM.maxStackSize = 4
ITEM.healing = {
    bandage = 15,
    disinfectant = 7
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