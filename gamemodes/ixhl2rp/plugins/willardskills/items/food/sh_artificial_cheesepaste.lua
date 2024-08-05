--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Artificial Cheese Paste"
ITEM.description = "White jar of gooey artificial slop, supplemented with cheese for a slightly improved texture and fill."
ITEM.category = "Food"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/props_lab/jar01b.mdl"
ITEM.color = Color(254, 255, 212)
ITEM.hunger = 35
ITEM.boosts = {
    perception = 2,
    intelligence = 2
}
ITEM.spoil = true
ITEM.useSound = "ambient/levels/canals/toxic_slime_gurgle4.wav"
ITEM.junk = "junk_jar"
ITEM.iconCam = {
  pos = Vector(6.22, -199.61, 10.73),
  ang = Angle(3.12, 91.84, 0),
  fov = 3.64
}
ITEM.holdData = {
  vectorOffset = {
      right = -1.5,
      up = 0,
      forward = 0
  },
  angleOffset = {
      right = 0,
      up = 0,
      forward = 0
  },
}