--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Amoxicillin (anti-biotic)"
ITEM.model = Model("models/willardnetworks/skills/pill_bottle.mdl")
ITEM.description = "A small orange pot of antibiotic medication pills that can be used to treat a number of bacterial infections. Treatments include middle ear infection, strep throat, pneumonia, skin infections, and urinary tract infections among others."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 4
ITEM.healing = {
	bandage = 6,
	disinfectant = 4,
	painkillers = 10
}
ITEM.boosts = {
    strength = 1,
}

ITEM.outlineColor = Color(255, 204, 0, 100)