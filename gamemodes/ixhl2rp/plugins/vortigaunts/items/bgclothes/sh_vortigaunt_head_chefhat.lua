--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Czapka szefa kuchni dla Vortigaunta"
ITEM.description = "Vortigaunty znane są z ich zamiłowania do gotowania, tym razem mogą to nawet pokazać przez swój ubiór."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-138.87, -116.79, 85.76),
  ang = Angle(25.28, 400.12, 0),
  fov = 4.26
}
ITEM.outfitCategory = "Head"
ITEM.factionList = {FACTION_VORT}

ITEM.bodyGroups = {
    ["head"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}
