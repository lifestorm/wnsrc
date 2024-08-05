--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Beer"
ITEM.description = "Brewed in sterile chambers, this beer lacks the rustic charm of traditional brewing, offering a cold, clinical taste with metallic undertones."
ITEM.category = "Liquor"
ITEM.model = "models/willardnetworks/food/beer.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
    pos = Vector(-164.23, -189.89, 37.43),
    ang = Angle(6.75, 49.13, 0),
    fov = 4.07
}
ITEM.thirst = 10
ITEM.abv = 8
ITEM.strength = 10
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.shareable = false
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