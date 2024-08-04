--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Sağlık Kiti"
ITEM.model = Model("models/items/healthkit.mdl")
ITEM.description = "Combine tarafından yaralıları iyileştirmek için kullanılan beyaz bir tıbbi kit. Garip yeşil jel, küçük tıbbi aletler ve daha fazlasıyla birlikte gelir."
ITEM.category = "Medical"
ITEM.width = 2
ITEM.height = 2

ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 50,
	disinfectant = 20,
	painkillers = 40
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
ITEM.outlineColor = Color(255, 78, 69, 100)

ITEM.colorAppendix = {["red"] = "Bu eşyayı savaşın ortasında kendi üzerinizde kullanamazsınız, başka bir oyuncu tarafından uygulanmalıdır."}