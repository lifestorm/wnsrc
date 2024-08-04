--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Dezenfekte Bandaj Rulosu"
ITEM.model = Model("models/stuff/bandages.mdl")
ITEM.description = "Dezenfekte edilmiş hijyenik bandaj rulosu. Kanamayı durdurmak ve yaraları temizlemek için kullanılır."
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