--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Health Kit"
ITEM.model = Model("models/items/healthkit.mdl")
ITEM.description = "A white medical kit used by the Combine to heal injured. Come with strange green gel, minor medical tools, and more."
ITEM.category = "Medical"
ITEM.width = 2
ITEM.height = 2

ITEM.maxStackSize = 2
ITEM.healing = {
	bandage = 50,
	disinfectant = 20,
	painkillers = 40
} 
ITEM.outlineColor = Color(255, 78, 69, 100)
ITEM.colorAppendix = {["red"] = "You cannot use this item on yourself mid-combat, must be applied by another player."}
ITEM.holdData = {
    vectorOffset = {
        right = 0,
        up = -0.5,
        forward = 6
    },
    angleOffset = {
        right = 0,
        up = 90,
        forward = -90
    },
}