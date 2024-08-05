--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Vortigaunt Boonie"
ITEM.description = "A wide rimmed hat. Keeps the sun off your vort head."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/head_boonie.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam	=	{
    ang	=	Angle(25.370000839233,399.98999023438,0),
    pos	=	Vector(-138.86999511719,-116.79000091553,85.76000213623),
    fov	=	3.82,
}
ITEM.outfitCategory = "Head"
ITEM.factionList = {FACTION_VORT}

ITEM.bodyGroups = {
    ["head"] = 6 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}
