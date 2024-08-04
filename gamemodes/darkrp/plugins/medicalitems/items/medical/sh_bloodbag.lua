--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Kan Torbası"
ITEM.model = Model("models/willardnetworks/skills/bloodbag.mdl")
ITEM.description = "Hortumu ve iğnesi olan plastik bir torba. İçinde kan var gibi görünüyor."
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
ITEM.outlineColor = Color(255, 204, 0, 100)

ITEM.colorAppendix = {["red"] = "Bu eşyayı savaşın ortasında kendi üzerinizde kullanamazsınız, başka bir oyuncu tarafından uygulanmalıdır."}