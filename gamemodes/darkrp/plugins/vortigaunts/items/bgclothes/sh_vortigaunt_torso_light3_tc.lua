--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Trench marron"
ITEM.description = "Un trench-coat marron et remis à neuf. Ils garantissent que le corps est chaud et un peu sec. Ça ne fait pas de mal de se fondre non plus."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/torso_refugee_coat.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-39.23, -7.19, 195.95),
  ang = Angle(77.11, 10.12, 0),
  fov = 4.05
}
ITEM.outfitCategory = "Torso"
ITEM.maxArmor = 25
ITEM.factionList = {FACTION_VORT}

ITEM.bodyGroups = {
    ["torso"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}