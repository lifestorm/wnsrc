--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Albuterol (Breathing)"
ITEM.model = Model("models/props_c17/TrapPropeller_Lever.mdl")
ITEM.description = "Albuterol stored inside an inhaler, is used to prevent and treat wheezing and shortness of breath caused by breathing problems. It is also used to prevent asthma brought on by exercise. It is a quick-relief medication and dispensed through a tube. Instruction read; insert inhaler mouthpiece, depress plunger and breath in deeply, hold breath for five seconds, then exhale. Repeat as necessary."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 3
ITEM.healing = {
	bandage = 5,
	disinfectant = 1,
	painkillers = 5
}
ITEM.boosts = {
    agility = 1,
}

ITEM.outlineColor = Color(255, 204, 0, 100)