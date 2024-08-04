--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Pâte artificielle"

ITEM.name = "Pâte artificielle modifiée"

ITEM.description = "Pâte artificielle mélangée avec un peu d'acide de batterie de voiture pour faire bonne mesure."
ITEM.model = Model("models/props_lab/jar01b.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/antlion_grub/squashed.wav"
ITEM.boosts = {
    strength = 5,
    perception = -3,
    intelligence = -3
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["blackAndWhite"] = 15, ["bloom"] = 15, ["stealth"] = 15
}
ITEM.junk = "junk_jar"