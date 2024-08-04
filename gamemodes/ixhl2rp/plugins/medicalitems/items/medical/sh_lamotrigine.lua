--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Lamotrigine (epilepsy)"
ITEM.model = Model("models/willardnetworks/skills/daytripper.mdl")
ITEM.description = "A rather large tub and coloured in green, this medication is used to treat epilepsy and stabilize mood in bipolar disorder. For epilepsy, this includes focal seizures, tonic-clonic seizures, and seizures in Lennox-Gastaut syndrome. Pills are located within small strips."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 5,
	disinfectant = 5,
	painkillers = 5
}
ITEM.boosts = {
    intelligence = 1,
}

ITEM.outlineColor = Color(255, 204, 0, 100)