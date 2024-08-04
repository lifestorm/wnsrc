--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Le shot sombre"
ITEM.description = "Du sang mélangé à divers médicaments, en le consommant, vous pouvez ressentir une sensation de brûlure dans la gorge."

ITEM.name = "Shot sombre"
ITEM.description = "Du sang mélangé à divers médicament. En le consommant, vous pouvez ressentir une sensation de brûlure dans la gorge."

ITEM.model = Model("models/willardnetworks/skills/medjar.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    strength = 6,
    perception = -5,
    agility = 6
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["red"] = 15, ["bloom"] = 15, ["distort1"] = 15
}
ITEM.junk = "junk_jar"