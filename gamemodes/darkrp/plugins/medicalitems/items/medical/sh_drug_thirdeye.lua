--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Le troisième oeil"

ITEM.name = "Troisième oeil"

ITEM.description = "Un liquide blanc à l'intérieur de la seringue qui, après utilisation, pourrait vous faire ressentir une conscience accrue de l'environnement."
ITEM.model = Model("models/willardnetworks/skills/pyscho.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    strength =-3,
    perception = 6,
    agility = -3,
    intelligence = 6
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["jarate"] = 15, ["sobel"] = 15
}
ITEM.junk = "comp_syringe"