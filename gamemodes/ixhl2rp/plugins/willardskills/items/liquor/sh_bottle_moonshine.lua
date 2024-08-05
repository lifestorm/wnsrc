--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Moonshine"
ITEM.description = "A slightly sweet-smelling liquor in an old soviet vodka bottle. It kicks like a mule. You could probably strip paint with it."
ITEM.category = "Liquor"
ITEM.model = "models/willardnetworks/food/alcohol_bottle.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
  pos = Vector(-248.7, -125.57, 62.84),
  ang = Angle(11.17, 386.79, 0),
  fov = 2.54
}
ITEM.thirst = 40
ITEM.abv = 80
ITEM.strength = 50
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_bottle"
ITEM.shotItem = "shot_moonshine"
ITEM.shotsPerItem = 6
ITEM.shotsPoured = 0
ITEM.grade = "HIGH"
ITEM.holdData = {
  vectorOffset = {
      right = 1,
      up = -1.5,
      forward = -4
  },
  angleOffset = {
      right = 0,
      up = 30,
      forward = 0
  },
} 