--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Mundur Riot CP Rebelii"
ITEM.description = "Mundur CP, który został ozdobiony graffiti i oznaczeniami związanymi z globalnym ruchem oporu w celu łatwiejszej identyfikacji."
ITEM.category = "Clothing - Resistance"
ITEM.replacementString = "wn7new/metropolice_rebel"
ITEM.model = Model("models/wn7new/metropolice/cpuniform.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.isCP = false
ITEM.bodyGroups = {
    ["cp_Armor"] = 2 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}
    
ITEM.maxArmor = 75

ITEM.energyConsumptionRate = 0.002 -- fatigue_system