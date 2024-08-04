--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Trousse de premiers secours"
ITEM.model = Model("models/willardnetworks/skills/medkit.mdl")
ITEM.description = "La trousse de premier secours contient plusieurs articles essentiels pour les premiers secours, tels que des pansements, des compresses, une paire de ciseaux, du ruban adhésif et d'autres articles médicaux de base. Elle est conçue pour être facilement transportable et est souvent utilisée dans les situations d'urgence ou lors de voyages en plein air."
ITEM.category = "Médical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 3
ITEM.healing = {
	bandage = 50,
	disinfectant = 10,
	painkillers = 25
}
ITEM.junk = "comp_stitched_cloth"

ITEM.outlineColor = Color(255, 204, 0, 100)

ITEM.colorAppendix = {["blue"] = "Vous avez besoin d'un autre morceau de tissu cousu pour diviser cette pile.", ["red"] = "Vous ne pouvez pas utliser cet item en plein combat, il doit être appliquer par un autre joueur."}
