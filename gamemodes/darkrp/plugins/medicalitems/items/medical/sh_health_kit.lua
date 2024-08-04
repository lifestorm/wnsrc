--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Kit de soin"

ITEM.model = Model("models/items/healthkit.mdl")
ITEM.description = "Une trousse médicale blanche utilisée par le Cartel pour soigner les blessés. Elle contient un gel vert étrange, des outils médicaux mineurs et bien d'autres choses encore."
ITEM.category = "Médical"
ITEM.width = 2
ITEM.height = 2

ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 75,
	disinfectant = 35,
	painkillers = 80
}

ITEM.outlineColor = Color(255, 78, 69, 100)

ITEM.colorAppendix = {["red"] = "Vous ne pouvez pas utiliser cet objet sur vous-même en plein combat, il doit être appliqué par un autre joueur."}
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