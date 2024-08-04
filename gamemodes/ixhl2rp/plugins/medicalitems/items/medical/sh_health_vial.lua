--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Ampułka lecznicza"
ITEM.model = Model("models/willardnetworks/syringefull.mdl")
ITEM.description = "Ampułka wypełniona tajemniczym zielonym żelem o właściwościach medycznych, przez to właśnie używany jest przez Kombinat."
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

ITEM.colorAppendix = {["red"] = "Nie możesz użyć tego przedmiotu na sobie w trakcie walki, musi to zrobić inny gracz."}