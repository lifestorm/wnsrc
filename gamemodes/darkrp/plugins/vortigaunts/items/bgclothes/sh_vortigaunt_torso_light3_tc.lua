--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Vortigaunt Kahverengi Trençkot"
ITEM.description = "Güneşten yanmış, yenilenmiş bir trençkot. Vücudun sıcak ve biraz kuru olmasını sağlar."
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