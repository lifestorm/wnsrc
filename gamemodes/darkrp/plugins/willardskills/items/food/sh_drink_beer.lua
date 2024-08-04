--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "drink_beer"
ITEM.name = "Bière"
ITEM.description = "Boisson alcoolisée à base de céréales fermentées."
ITEM.category = "Nourriture"
ITEM.model = "models/willardnetworks/food/beer.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-164.23, -189.89, 37.43),
  ang = Angle(6.75, 49.13, 0),
  fov = 4.07
}
ITEM.thirst = 40
ITEM.boosts = {
	strength = 2,
	intelligence = -1
}
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_beer"
