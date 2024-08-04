--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Zestaw chirurgiczny"
ITEM.model = Model("models/willardnetworks/skills/surgicalkit.mdl")
ITEM.description = "Kompletny zestaw narzędzi i przyrządów chirurgicznych, zapakowany w praktyczną torbę, służący do przeprowadzania operacji w warunkach szpitalnych lub w terenie. "
ITEM.category = "Medical"
ITEM.maxStackSize = 3
ITEM.useSound = "items/medshot4.wav"
ITEM.healing = {
	bandage = 65,
	disinfectant = 25,
	painkillers = 35
}
ITEM.junk = "comp_stitched_cloth"
ITEM.outlineColor = Color(255, 78, 69, 100)
ITEM.colorAppendix = {["blue"] = "Do podziału tego przedmiotu potrzebujesz jeszcze jednego kawałka zszytego materiału."}, {["red"] = "Nie możesz użyć tego przedmiotu na sobie w trakcie walki, musi to zrobić inny gracz."}
ITEM.holdData = {
    vectorOffset = {
        right = -0.5,
        up = -0.5,
        forward = 0
    },
    angleOffset = {
        right = 90,
        up = 0,
        forward = 0
    },
}
