--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bandana vortiguant"
ITEM.description = "La discrétion est de la plus haute importance. Je ne voudrais pas que quiconque sache qu'un Vortigaunt était ici."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/head_facewrap.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-0.76, -0.13, 200),
  ang = Angle(90.05, 189.72, 0),
  fov = 2.5
}
ITEM.outfitCategory = "Glasses"
ITEM.factionList = {FACTION_VORT}
ITEM.bodyGroups = {
    ["face"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}