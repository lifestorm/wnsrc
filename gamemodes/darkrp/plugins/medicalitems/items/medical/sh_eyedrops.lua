--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Göz Damlası"
ITEM.model = Model("models/willardnetworks/skills/hpsyringe.mdl")
ITEM.description = "Gözler için sıvı bir ilaç içeren küçük bir dispenser. Yan tarafındaki etikette şunlar yazılıdır; Kuru gözler, küçük tahrişler ve kalıntıları ve yabancı cisimleri temizlemek için genel yıkama için Kullanmak için başınızı geriye doğru eğin ve gözlerinizi açın, iki veya üç damlanın göze girmesine izin verin, ardından hızla göz kırpın."
ITEM.category = "Pharma"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 5,
	disinfectant = 2
}
ITEM.boosts = {
    perception = 1,
}

ITEM.outlineColor = Color(255, 204, 0, 100)