--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bouteille de désinfectant"
ITEM.model = Model("models/props_junk/glassjug01.mdl")
ITEM.description = "Une bouteille de désinfectant, utilisée pour nettoyer les plaies des bactéries."
ITEM.category = "Médical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 6
ITEM.healing = {
	disinfectant = 4
}
ITEM.junk = "comp_plastic"

ITEM.colorAppendix = {["blue"] = "Vous avez besoin d'une autre bouteille en plastique pour diviser cette pile."}