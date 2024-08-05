--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bottle of Sparkling Champagne"
ITEM.description = "Rumored to still be around in high circles, champagne is highly a prestigious and rare treat to discover these days, although the Combine loves to keep it on tight control."
ITEM.category = "Liquor"
ITEM.model = "models/willardnetworks/food/prop_bar_bottle_a.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
    pos = Vector(200.72, -2.98, 15.5),
    ang = Angle(2.1, 179.15, 0),
    fov = 2.69
}
ITEM.thirst = 40
ITEM.abv = 16
ITEM.strength = 50
ITEM.spoil = false
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_empty_bottle"
ITEM.shotItem = "glass_champagne"
ITEM.shotsPerItem = 6
ITEM.shotsPoured = 0
ITEM.grade = "HIGH"
ITEM.holdData = {
    vectorOffset = {
        right = 0,
        up = -1.5,
        forward = -4
    },
    angleOffset = {
        right = 0,
        up = 0,
        forward = 0
    },
}