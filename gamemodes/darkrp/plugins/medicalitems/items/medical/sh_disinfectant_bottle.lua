--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Dezenfektan"
ITEM.model = Model("models/willardnetworks/props/disinfectant.mdl")
ITEM.description = "Yaraları bakterilerden arındırmak için kullanılan bir şişe dezenfektan."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 6
ITEM.healing = {
	disinfectant = 4
}
ITEM.junk = "comp_plastic"
ITEM.usableInCombat = true

ITEM.colorAppendix = {["blue"] = "Bu yığını bölmek için başka bir plastik şişeye ihtiyacınız var."}