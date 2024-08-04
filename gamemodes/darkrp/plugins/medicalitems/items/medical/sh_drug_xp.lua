--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Sirop"
ITEM.description = "Liquide brun dans une vieille bouteille. En la sentant, vous pouvez vous sentir vraiment léger. Ça a le goût du vieux sirop contre la toux."
ITEM.model = Model("models/willardnetworks/food/wine4.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = 6,
    perception = 6,
    agility = 6,
    intelligence = 6
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["gas"] = 15, ["sharpen"] = 15, ["bloom"] = 15
}
ITEM.junk = "junk_brown_bottle"