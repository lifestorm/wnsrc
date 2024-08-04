--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Jus de baies"
ITEM.description = "Un flacon étrange rempli de liquide bleu, qui a le goût d'un jus de baies, qui reste cependant avec un mauvais goût."
ITEM.model = Model("models/willardnetworks/skills/chemical_flask4.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = -2,
    perception = 5,
    intelligence = 5
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["blueUber"] = 15, ["bluetint"] = 15, ["bloom"] = 15
}
ITEM.junk = "comp_glass"