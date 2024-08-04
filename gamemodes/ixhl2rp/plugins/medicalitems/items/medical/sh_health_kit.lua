--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Apteczka"
ITEM.model = Model("models/items/healthkit.mdl")
ITEM.description = "Biała apteczka używana przez Kombinat do opatrywania ran. W środku znajduje się dziwny zielony żel, jakieś przyrządy i wiele więcej."
ITEM.category = "Medical"
ITEM.width = 2
ITEM.height = 2

ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 50,
	disinfectant = 20,
	painkillers = 40
} 
ITEM.outlineColor = Color(255, 78, 69, 100)
ITEM.colorAppendix = {["red"] = "Nie możesz użyć tego przedmiotu na sobie w trakcie walki, musi to zrobić inny gracz."}
ITEM.holdData = {
    vectorOffset = {
        right = 0,
        up = -0.5,
        forward = 6
    },
    angleOffset = {
        right = 0,
        up = 90,
        forward = -90
    },
}
