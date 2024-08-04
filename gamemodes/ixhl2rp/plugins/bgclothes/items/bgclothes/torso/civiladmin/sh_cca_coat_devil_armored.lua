--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Płaszcz Adwokata Diabła - opancerzony"
ITEM.description = "Luksusowy płaszcz zimowy, który sprawi że poczujesz się niczym złowieszczy Władca Piekieł. Jest to opancerzony wariant stroju."
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
    blue = "Posiadanie tego ubioru bez zgody CAB jest nielegalne.",
}
ITEM.bodyGroups = {
	torso = 35
}

ITEM.energyConsumptionRate = 0.001