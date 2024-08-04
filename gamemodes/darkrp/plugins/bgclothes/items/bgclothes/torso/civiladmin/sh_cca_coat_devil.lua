--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Manteau d'avocats du diable"
ITEM.description = "Un luxueux manteau diabolique offrant non seulement une confiance accrue, mais aussi une autorité et un pouvoir indéniables avec la représentation du mal."
ITEM.category = "Vêtements - H.A.A"
ITEM.model = "models/willardnetworks/clothingitems/torso_ca_suit_coat.mdl"
ITEM.outfitCategory = "Torso"
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
    blue = "Il est illégal pour les non-membres de la HAA de posséder ce costume sans l'approbation de la HAA.",
}
ITEM.bodyGroups = {
	torso = 35
}