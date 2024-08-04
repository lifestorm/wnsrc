--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Sağlık Şişesi"
ITEM.model = Model("models/willardnetworks/syringefull.mdl")
ITEM.description = "Combine tarafından iyileştirici özellikleri için kullanılan gizemli yeşil jelden bir tüp."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1

ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 35,
	disinfectant = 15,
	painkillers = 25
}
ITEM.junk = "junk_emptyvial"

ITEM.outlineColor = Color(255, 204, 0, 100)

ITEM.colorAppendix = {["red"] = "Bu eşyayı savaşın ortasında kendi üzerinizde kullanamazsınız, başka bir oyuncu tarafından uygulanmalıdır."}