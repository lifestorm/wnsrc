--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bandana"
ITEM.description = "A red bandana that wraps around the lower half of the head."
ITEM.category = "Clothing - Face"
ITEM.model = "models/willardnetworks/clothingitems/head_facewrap.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-0.76, -0.13, 200),
  ang = Angle(90.05, 189.72, 0),
  fov = 2.5
}
ITEM.outfitCategory = "Face"
ITEM.bodyGroups = {
    ["face"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

ITEM.filterQuality = 0.3
ITEM.maxFilterValue = 60
ITEM.filterDecayStart = 0.2
ITEM.refillItem = "comp_chemcomp"