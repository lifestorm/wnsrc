--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "drink_whiskey"
ITEM.name = "Whisky"
ITEM.description = "Un véritable Whisky raffiné, une rareté de nos jours."
ITEM.category = "Nourriture"
ITEM.model = "models/willardnetworks/food/whiskey.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(230.3, 98.1, 48.72),
  ang = Angle(9.23, 203.18, 0),
  fov = 4.57
}
ITEM.thirst = 40
ITEM.boosts = {
	strength = -1,
	perception = -1,
	intelligence = 4
}
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_whiskey"