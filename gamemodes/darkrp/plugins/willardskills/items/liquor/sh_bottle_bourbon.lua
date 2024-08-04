--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bourbon"
ITEM.description = "Bu burbon, seleflerinin duygusal zenginliğinden yoksundur ve hafif bir üretilmiş odunsuluk ipucu ile steril, tatsız bir deneyim sunar."
ITEM.category = "İçki"
ITEM.model = "models/willardnetworks/food/bourbon.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(175.16, 146.98, 114.93),
  ang = Angle(25.09, 220.04, 0),
  fov = 4.07
}
ITEM.thirst = 40  
ITEM.abv = 40
ITEM.strength = 50
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_bottle"
ITEM.shotItem = "shot_bourbon"
ITEM.shotsPerItem = 5
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