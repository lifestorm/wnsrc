--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "drink_bourbon"
ITEM.name = "Bourbon"
ITEM.description = "Une liqueur forte et brune."
ITEM.category = "Nourriture"
ITEM.model = "models/willardnetworks/food/bourbon.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(175.16, 146.98, 114.93),
  ang = Angle(25.09, 220.04, 0),
  fov = 4.07
}
ITEM.thirst = 40
ITEM.boosts = {
	strength = 4,
	perception = -2
}
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_bourbon"