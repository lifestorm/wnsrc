--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Syntetyczny burbon"
ITEM.description = "Stworzony z syntetycznych składników, bourbon ten prezentuje niepokojąco gładką, sztuczną słodycz z nutami laboratoryjnie wytworzonego dębu i karmelu."
ITEM.category = "Food"
ITEM.model = "models/willardnetworks/food/bourbon.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(175.16, 146.98, 114.93),
  ang = Angle(25.09, 220.04, 0),
  fov = 4.07
}
ITEM.thirst = 25
ITEM.abv = 20
ITEM.strength = 25
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_bottle"
ITEM.shotItem = "shot_proc_bourbon"
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