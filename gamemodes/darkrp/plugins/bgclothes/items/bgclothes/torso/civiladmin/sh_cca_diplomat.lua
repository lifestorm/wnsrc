--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Diplomat"
ITEM.description = "İsviçre'de elde dikilmiş, gerçek bir diplomata mükemmel bir benzerlik."
ITEM.category = "Clothing - CCA"
ITEM.model = "models/willardnetworks/clothingitems/torso_ca_suit_jacket.mdl"
ITEM.outfitCategory = "Torso"
ITEM.width = 1
ITEM.height = 1

ITEM.adminCreation = true
ITEM.iconCam	=	{
		ang	=	Angle(117,-180.13999938965,0),
		pos	=	Vector(-94.419998168945,0.0099999997764826,176.30999755859),
		fov	=	3.64,
}
ITEM.proxy = {
ShirtColor = Vector(242 / 255, 236 / 255, 227 / 255), -- subtle yellow
TorsoColor = Vector(20 / 255, 32 / 255, 42 / 255) -- darkish green (matching)
}
ITEM.colorAppendix	=	{
		blue	=	"It is illegal for non-CCA members to own this suit without CCA approval.",
}
ITEM.bodyGroups	=	{
		torso	=	34
}