--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Fiole de Biogel"
ITEM.model = Model("models/healthvial.mdl")
ITEM.description = "Un tube de gel vert mystérieux utilisé par le Cartel pour ses propriétés curatives."
ITEM.category = "Médical"
ITEM.width = 1
ITEM.height = 1

ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 50,
	disinfectant = 20,
	painkillers = 40
}
ITEM.junk = "junk_emptyvial"

ITEM.outlineColor = Color(255, 204, 0, 100)

ITEM.colorAppendix = {["red"] = "Vous ne pouvez pas utliser cet item en plein combat, il doit être appliquer par un autre joueur."}