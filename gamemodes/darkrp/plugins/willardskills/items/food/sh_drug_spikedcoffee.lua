--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Tasse de café enrichie"
ITEM.description = "Une tasse de café chaude vous aide à rester alerte et éveillé pendant ces moments étranges, celui-ci apparemment encore plus que d'habitude."
ITEM.category = "Drogues"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/coffee.mdl"
ITEM.thirst = 30
ITEM.boosts = {
	agility = 3
}
ITEM.energyShift = 0.01 -- fatigue_system
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_coffeecup"
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
  ["distort1"] = 15, ["bloom"] = 15
}