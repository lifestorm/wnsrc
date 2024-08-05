--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "metropolicesupplements"
ITEM.name = "Metropolice Supplements"
ITEM.description = "A standard issued metropolice supplement containing various powdered substances and decent food items."
ITEM.category = "Food"
ITEM.model = "models/willardnetworks/food/cproids.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-200, 0, 0),
  ang = Angle(0, 0, 0),
  fov = 3.05
}
ITEM.hunger = 60
ITEM.boosts = {
	strength = 3
}
ITEM.energyShift = 10 -- fatigue_system
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_crunch2.wav"