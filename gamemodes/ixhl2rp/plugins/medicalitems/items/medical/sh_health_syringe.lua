--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Health Syringe"
ITEM.model = Model("models/willardnetworks/skills/hpsyringe.mdl")
ITEM.description = "A viscous viridescent fluid flows inside a small capsule upon the syringe. An auto-injector hides behind a translucent cap."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1

ITEM.maxStackSize = 3
ITEM.healing = {
	bandage = 25,
	disinfectant = 12,
	painkillers = 15
}

ITEM.outlineColor = Color(255, 204, 0, 100)
ITEM.usableInCombat = true