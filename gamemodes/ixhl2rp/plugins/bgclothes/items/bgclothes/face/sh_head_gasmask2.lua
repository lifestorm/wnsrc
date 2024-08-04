--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Maska przeciwgazowa M40"
ITEM.description = "Zapewnia ochronę przed szkodliwymi gazami i oparami, ale lepiej zaopatrz się jeszcze w filtr."
ITEM.category = "Clothing - Face"
ITEM.model = "models/willardnetworks/clothingitems/m40_item.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "Face"
--ITEM.colorAppendix = {["blue"] = "Clothing can be acquired with the Bartering skill (requires the Clothing permit) or from a shop.\n Can also be broken down into its basic components with the Crafting skill."}
ITEM.bodyGroups = {
    ["face"] = 3 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}
--ITEM.isMask = true keeping this here to remember the command (automatically works on gas masks)
ITEM.isGasmask = true
ITEM.isMask = true
-- fatigue_system
ITEM.energyConsumptionRate = 0.001
