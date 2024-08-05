--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Sandwich"
ITEM.description = "Very popular in City Two, a sandwich of artificial meat and cheese."
ITEM.category = "Food"
ITEM.model = "models/willardnetworks/food/sandwich.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(509.64, 427.61, 310.24),
  ang = Angle(24.9, 219.85, 0),
  fov = 0.75
}
ITEM.hunger = 45
ITEM.boosts = {
    intelligence = 3
}
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_crunch2.wav"
ITEM.holdData = {
  vectorOffset = {
      right = -2,
      up = 0,
      forward = -0.5
  },
  angleOffset = {
      right = 0,
      up = 0,
      forward = 90
  },
}