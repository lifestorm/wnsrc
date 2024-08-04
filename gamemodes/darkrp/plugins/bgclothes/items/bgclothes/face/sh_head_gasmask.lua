--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Masque à gaz"
ITEM.description = "Fournit une protection adéquate contre les vapeurs nocives, les gaz et certaines odeurs nauséabondes."
ITEM.category = "Vêtements - Visage"
ITEM.model = "models/willardnetworks/clothingitems/head_gasmask.mdl"
ITEM.outfitCategory = "Face"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam	=	{
	ang	=	Angle(24.60000038147,219.99000549316,0),
	pos	=	Vector(161.4700012207,136.11000061035,101.09999847412),
	fov	=	3.1,
}
ITEM.bodyGroups	=	{
		face	=	2,
}
--ITEM.isMask = true keeping this here to remember the command (automatically works on gas masks)
ITEM.isGasmask = true
ITEM.isMask = true
-- fatigue_system
ITEM.energyConsumptionRate = 0.001
