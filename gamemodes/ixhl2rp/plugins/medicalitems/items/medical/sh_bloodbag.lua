--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Torebka z krwią"
ITEM.model = Model("models/willardnetworks/skills/bloodbag.mdl")
ITEM.description = "Plastikowa torba z przymocowanym wężem i igłą. Wygląda na to, że jest w niej krew."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 4
ITEM.healing = {
	bandage = 30,
	disinfectant = 5
}
ITEM.holdData = {
    vectorOffset = {
        right = -0.5,
        up = 0,
        forward = 1,5
    },
    angleOffset = {
        right = 90,
        up = 0,
        forward = -90
    },
}  
ITEM.outlineColor = Color(255, 204, 0, 100)
ITEM.colorAppendix = {["red"] = "Nie możesz użyć tego przedmiotu na sobie w trakcie walki, musi to zrobić inny gracz."}
