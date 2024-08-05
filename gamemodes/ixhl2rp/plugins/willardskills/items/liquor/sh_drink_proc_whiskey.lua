--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Artificial Whiskey"
ITEM.description = "Concocted from lab-engineered compounds, this hyper-processed whiskey offers a sharp, synthetic tang with hints of plastic and chrome."
ITEM.category = "Food"
ITEM.model = "models/willardnetworks/food/whiskey.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(230.3, 98.1, 48.72),
  ang = Angle(9.23, 203.18, 0),
  fov = 4.57
}
ITEM.thirst = 25
ITEM.abv = 20
ITEM.strength = 25
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_bottle"
ITEM.shotItem = "shot_proc_whiskey"
ITEM.shotsPerItem = 3
ITEM.shotsPoured = 0
ITEM.grade = "HIGH"
ITEM.holdData = {
  vectorOffset = {
      right = 0.7,
      up = -1.5,
      forward = -4
  },
  angleOffset = {
      right = 0,
      up = 30,
      forward = 0
  },
}
