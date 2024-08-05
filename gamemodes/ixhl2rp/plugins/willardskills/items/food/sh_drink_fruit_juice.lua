--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "drink_fruit_juice"
ITEM.name = "Fruit Juice"
ITEM.description = "Refreshing fruit juice, tastes somewhat authentic."
ITEM.category = "Food"
ITEM.model = "models/props_junk/garbage_plasticbottle003a.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
  pos = Vector(230.3, 98.1, 48.72),
  ang = Angle(11.04, 203.05, 0),
  fov = 3.05
}
ITEM.cost = 15
ITEM.thirst = 50
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_fruitjuice"
ITEM.holdData = {
  vectorOffset = {
      right = -1.5,
      up = -1,
      forward = -3
  },
  angleOffset = {
      right = 10,
      up = 0,
      forward = 10
  },
}