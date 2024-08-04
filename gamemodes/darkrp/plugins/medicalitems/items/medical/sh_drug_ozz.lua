--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Potion d'Ozz"
ITEM.description = "Liquide étrange dans un bocal en verre qui, à l'ouverture, a une odeur forte et étrange. Il a le goût de l'essence mais vous fait vous sentir intelligent et perspicace."
ITEM.model = Model("models/props_junk/glassjug01.mdl")
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = -3,
    perception = 5,
    agility =-3,
    intelligence = 5
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drogue]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
    ["greentint"] = 15, ["stealth"] = 15
}
ITEM.junk = "junk_brown_bottle"