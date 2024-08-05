--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "The Heartwick Trousers"
ITEM.description = "A pair of high quality suit trousers worn by various members of Civil Administration."
ITEM.category = "Clothing - CCA"
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
	PantsColor = Vector(31 / 255, 35 / 255, 51 / 255) -- midnight blue 
}
ITEM.colorAppendix	=	{
		blue	=	"It is illegal for non-CCA members to own this suit without CCA approval.",
}
ITEM.bodyGroups	=	{
	legs	=	7
}