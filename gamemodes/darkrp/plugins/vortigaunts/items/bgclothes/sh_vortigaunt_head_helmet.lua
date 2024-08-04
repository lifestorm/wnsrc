--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Casque vortiguant"
ITEM.description = "La protection avant l'aspect pratique. Avec un peu de chance, l'ennemi peut essayer de viser un peu plus haut."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/head_helmet.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-117.67, -98.6, 71.58),
  ang = Angle(25, 400, 0),
  fov = 4.42
}
ITEM.outfitCategory = "Head"
ITEM.factionList = {FACTION_VORT}

ITEM.bodyGroups = {
    ["head"] = 2 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}