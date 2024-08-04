--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Trousse chirurgicale"
ITEM.model = Model("models/willardnetworks/skills/surgicalkit.mdl")
ITEM.description = "Une trousse rigide de couleur rouge, fermée par deux clips métalliques. À l'intérieur, des instruments tranchants et précis sont soigneusement disposés dans des poches élastiques. Des ciseaux, des pinces, un bistouri et bien plus encore."

ITEM.category = "Médical"
ITEM.maxStackSize = 3
ITEM.useSound = "items/medshot4.wav"
ITEM.healing = {
	bandage = 65,
	disinfectant = 20,
	painkillers = 35
}
ITEM.junk = "comp_stitched_cloth"
ITEM.outlineColor = Color(255, 78, 69, 100)
ITEM.colorAppendix = {["blue"] = "Vous avez besoin d'un autre morceau de tissu cousu pour diviser cette pile.", ["red"] = "Vous ne pouvez pas utliser cet item en plein combat, il doit être appliquer par un autre joueur."}
