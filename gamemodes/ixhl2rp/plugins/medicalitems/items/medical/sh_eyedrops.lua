--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Eye Drops"
ITEM.model = Model("models/willardnetworks/skills/hpsyringe.mdl")
ITEM.description = "A small dispenser, containing a liquid drug for the eyes. A label on the side reads; For dry eyes, minor irritations and general wash to remove debris and foreign objects.To use, tilt your head back and open the eyes, allow two or three drops to enter the eye, then blink rapidly."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 5,
	disinfectant = 2
}
ITEM.boosts = {
    perception = 1,
}

ITEM.outlineColor = Color(255, 204, 0, 100)