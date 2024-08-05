--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Surgical Mask"
ITEM.description = "Surgical mask worn by doctors for surgery."
ITEM.category = "Clothing - Face"
ITEM.model = "models/willardnetworks/clothingitems/medicmask_item.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "Face"
ITEM.bodyGroups = {
    ["face"] = 4 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

ITEM.filterQuality = 0.3
ITEM.maxFilterValue = 60
ITEM.refillItem = nil
ITEM.filterDecayStart = 0.2
ITEM.refillItem = "comp_chemcomp"