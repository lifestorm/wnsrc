--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bandaj Rulosu"
ITEM.model = Model("models/stuff/bandages.mdl")
ITEM.description = "Bir rulo bandaj. Kanamayı durdurmak için kullanılır."
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
        right = 0,
        up = 0,
        forward = 0
    },
    angleOffset = {
        right = 0,
        up = 0,
        forward = 0
    },
}  