--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Stimulant"
ITEM.description = "Un paquet écrasé de pilules mélangées dans une canette. Vous donne le sentiment d'être rapide."
ITEM.model = Model("models/props_junk/popcan01a.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    agility = 6
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["gas"] = 15, ["jarate"] = 15, ["bloom"] = 15, ["sharpen"] = 15
}
ITEM.junk = "crafting_water"