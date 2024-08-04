--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Syntetyczna papka"
ITEM.description = "Biały słoik wypełniony żelową substancją. Smakuje bardzo chemicznie, nie jest zbyt sycący, a jego tekstura z pewnością nie zachęca."
ITEM.category = "Food"
ITEM.model = "models/props_lab/jar01b.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(6.22, -199.61, 10.73),
  ang = Angle(3.12, 91.84, 0),
  fov = 3.64
}
ITEM.hunger = 20
ITEM.spoil = true
ITEM.spoilTime = 2
ITEM.boosts = {
	strength = -2,
	agility = -1
}

ITEM.useSound = "ambient/levels/canals/toxic_slime_gurgle4.wav"
ITEM.junk = "junk_jar"