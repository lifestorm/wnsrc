--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Poche de sang"
ITEM.model = Model("models/willardnetworks/skills/bloodbag.mdl")
ITEM.description = "Cette poche de sang est un sac en plastique souple, contenant du sang qui a été prélevé et conservé pour une utilisation ultérieure."
ITEM.category = "Médical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 4
ITEM.healing = {
	bandage = 30,
	disinfectant = 5
}

ITEM.outlineColor = Color(255, 204, 0, 100)

ITEM.colorAppendix = {["red"] = "Vous ne pouvez pas utiliser cet objet sur vous-même en plein combat, il doit être appliqué par un autre joueur."}