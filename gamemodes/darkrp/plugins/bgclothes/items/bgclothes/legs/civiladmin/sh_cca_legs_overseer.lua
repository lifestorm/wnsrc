--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Pantalons du superviseur"
ITEM.description = "Un ensemble de pantalons bordeaux foncé, pour articuler élégamment le manteau du superviseur."
ITEM.category = "Vêtements - H.A.A"
ITEM.model = "models/willardnetworks/clothingitems/legs_ca_suit_pants.mdl"
ITEM.outfitCategory = "Legs"
ITEM.width = 1
ITEM.height = 1

ITEM.iconCam = {
    ang = Angle(90.5, 1.25, 0),
    pos = Vector(0, 0, 200),
    fov = 5.75,
}

ITEM.proxy = {
    PantsColor = Vector(70 / 255, 0.26 / 255, 0.26 / 255) -- midnight blue
}

ITEM.colorAppendix = {
    blue = "Il est illégal pour les non-membres de la HAA de posséder ce costume sans l'approbation de la HAA.",
}

ITEM.bodyGroups = {
    legs = 7
}