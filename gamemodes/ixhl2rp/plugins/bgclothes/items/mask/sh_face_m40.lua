--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "M40 Gas Mask - CCR"
ITEM.description = "A gasmask used mostly by the conscripts"
ITEM.category = "Clothing - Face"
ITEM.model = "models/willardnetworks/clothingitems/m40_item.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "Face"
ITEM.bodyGroups = {
    ["face"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

ITEM.filterQuality = 0.5
ITEM.maxFilterValue = 60
ITEM.isGasmask = true
ITEM.isMask = true
ITEM.filterDecayStart = 0.2
ITEM.refillItem = "highquality_filter"
ITEM.colorAppendix = {["red"] = "This item only works for Conscript Models."}