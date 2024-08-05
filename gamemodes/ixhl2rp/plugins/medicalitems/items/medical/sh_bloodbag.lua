--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Blood Bag"
ITEM.model = Model("models/willardnetworks/skills/bloodbag.mdl")
ITEM.description = "A plastic bag with a hose and needle attached. It seems to have blood in it."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.maxStackSize = 4
ITEM.healing = {
	bandage = 30,
	disinfectant = 5
}
ITEM.holdData = {
    vectorOffset = {
        right = -0.5,
        up = 0,
        forward = 1,5
    },
    angleOffset = {
        right = 90,
        up = 0,
        forward = -90
    },
}  
ITEM.outlineColor = Color(255, 204, 0, 100)
ITEM.colorAppendix = {["red"] = "You cannot use this item on yourself mid-combat, must be applied by another player."}
