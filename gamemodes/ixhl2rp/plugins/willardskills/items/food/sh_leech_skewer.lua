--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Skewered Leech"
ITEM.description = "A skewered parasitic leech that appears juicy."
ITEM.category = "Food"
ITEM.model = "models/willardnetworks/food/meatskewer2.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(150.5, 126.23, 92.34),
  ang = Angle(25.07, 219.54, 0),
  fov = 2.7
}
ITEM.hunger = 6
ITEM.boosts = {
	perception = 1
}
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_crunch2.wav"
ITEM.maxStackSize = 3
ITEM.holdData = {
  vectorOffset = {
      right = -1.5,
      up = 0,
      forward = 5
  },
  angleOffset = {
      right = 0,
      up = 0,
      forward = 90
  },
}  