--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Le pantalon allemand"
ITEM.description = "Une paire de pantalons de costume de haute qualité portés par divers membres de l'UTC."
ITEM.category = "Vêtements - H.A.A"
ITEM.model = "models/willardnetworks/clothingitems/legs_ca_suit_pants.mdl"
ITEM.outfitCategory = "Legs"
ITEM.width = 1
ITEM.height = 1

ITEM.iconCam	=	{
		ang	=	Angle(90.5,1.25,0),
		pos	=	Vector(0,0,200),
		fov	=	5.75,
}
ITEM.proxy = {
	PantsColor = Vector(99 / 255, 69 / 255, 64 / 255), -- light brown
}
ITEM.colorAppendix	=	{
		blue	=	"Il est illégal pour les non-membres de la Haute Autorité Administrative de posséder ce costume.",
}
ITEM.bodyGroups	=	{
	legs	=	7
}