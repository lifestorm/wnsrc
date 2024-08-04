--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Tasse de thé enrichie"
ITEM.description = "Cette tasse de thé chaud enrichi éveille les sens avec son parfum envoûtant et son goût délicieux, vous offrant une expérience de thé unique et revitalisante."

ITEM.name = "Tasse de thé modifiée"
ITEM.description = "Cette tasse de thé chaud modifiée éveille les sens avec son parfum envoûtant et son goût délicieux, vous offrant une expérience de thé unique et revitalisante."

ITEM.category = "Drogues"
ITEM.model = "models/props_junk/garbage_coffeemug001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-164.23, -189.89, 37.43),
  ang = Angle(8.47, 49.22, 0),
  fov = 2.05
}
ITEM.thirst = 35
ITEM.boosts = {
	intelligence = 2,
	perception = 2
}
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_mug"
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applique des visuels d'écran loufoques. Les autres joueurs pourront détecter si vous êtes drogué.", ["blue"] = "[RP] : Vous pouvez ignorer le FearRP si vous êtes drogué."}
ITEM.drug = {
  ["distort1"] = 15, ["bloom"] = 15
}