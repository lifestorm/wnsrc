--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Devil's Advocates Coat - Armored"
ITEM.description = "Luxurious devlisih trench coat providing a boost of not only confidence, but sheer authority and power with the representation of evil. This is a armored varient of the suit."
ITEM.category = "Clothing - CCA"
ITEM.model = "models/willardnetworks/clothingitems/torso_ca_suit_coat.mdl"
ITEM.outfitCategory = "Torso"
ITEM.maxArmor = 50
ITEM.width = 1
ITEM.height = 1

ITEM.iconCam = {
	ang	= Angle(100.36000061035,-179.50999450684,0),
	pos	= Vector(-41.919998168945,-0.15999999642372,195.55999755859),
	fov	= 3.85,
}
ITEM.proxy = {
    ShirtColor = Vector(161 / 255, 58 / 255, 58 / 255), -- red
    TorsoColor = Vector(30 / 255, 30 / 255, 30 / 255) -- black (matching)
}
ITEM.colorAppendix = {
    blue = "It is illegal for non-CCA members to own this suit without CCA approval.",
}
ITEM.bodyGroups = {
	torso = 35
}

ITEM.energyConsumptionRate = 0.001