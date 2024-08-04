--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "İlk Yardım Kiti"
ITEM.model = Model("models/willardnetworks/skills/medkit.mdl")
ITEM.description = "Sağlık sorunlarına iyi ve anında yanıt veren küçük kırmızı bir çanta."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 3
ITEM.healing = {
	bandage = 50,
	disinfectant = 15,
	painkillers = 25
}
ITEM.junk = "comp_stitched_cloth"
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

ITEM.colorAppendix = {["blue"] = "Bu yığını ayırmak için başka bir dikişli kumaş parçasına ihtiyacınız var.", ["red"] = "Bu eşyayı savaşın ortasında kendi üzerinizde kullanamazsınız, başka bir oyuncu tarafından uygulanmalıdır."}