--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "The Pharaoh's Jacket - Armored"
ITEM.description = "Made from the finest materials of silk available, this ivory complex and red shirt displays influence, cunning, and control. This is a armored varient of the suit."
ITEM.category = "Clothing - CCA"
ITEM.model = "models/willardnetworks/clothingitems/cajacket_item.mdl"
ITEM.outfitCategory = "Torso"
ITEM.maxArmor = 50
ITEM.width = 1
ITEM.height = 1

ITEM.adminCreation = true
ITEM.iconCam	=	{
		ang	=	Angle(117,-180.13999938965,0),
		pos	=	Vector(-94.419998168945,0.0099999997764826,176.30999755859),
		fov	=	3.64,
}
ITEM.proxy = {
	TorsoColor = Vector(255 / 255, 255 / 255, 243 / 255), -- subtle ivory
	ShirtColor = Vector(183 / 255, 33 / 255, 16 / 255)
}
ITEM.colorAppendix	=	{
		blue	=	"It is illegal for non-CCA members to own this suit without CCA approval.",
}
ITEM.bodyGroups	=	{
		torso	=	34
}

ITEM.energyConsumptionRate = 0.001
