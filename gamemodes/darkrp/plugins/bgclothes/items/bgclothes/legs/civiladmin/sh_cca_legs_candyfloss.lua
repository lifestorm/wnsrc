--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Pantalon rose"
ITEM.description = "Un pantalon de costume de haute qualité portés par divers membres de l'UTC. Ce pantalon a été spécialement fait après être demander par un membre de la Haute Autorité Administrative"
ITEM.category = "Vêtements - H.A.A"
ITEM.model = "models/willardnetworks/clothingitems/legs_ca_suit_pants.mdl"
ITEM.outfitCategory = "Legs"
ITEM.width = 1
ITEM.height = 1

ITEM.adminCreation = true
ITEM.iconCam	=	{
		ang	=	Angle(90.5,1.25,0),
		pos	=	Vector(0,0,200),
		fov	=	5.75,
}
ITEM.proxy = {
	PantsColor = Vector(238 / 255, 130 / 255, 238 / 255) -- pink
}
ITEM.colorAppendix	=	{
		blue	=	"Il est illégal pour les non-membres de la Haute Autorité Administrative de posséder ce costume.",
}
ITEM.bodyGroups	=	{
	legs	=	7
}