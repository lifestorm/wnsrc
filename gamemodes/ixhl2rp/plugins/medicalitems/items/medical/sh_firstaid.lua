--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "First Aid Kit"
ITEM.model = Model("models/willardnetworks/skills/medkit.mdl")
ITEM.description = "A small red bag with a decent and immediate response to health issues."
ITEM.category = "Medical"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.maxStackSize = 3
ITEM.healing = {
	bandage = 50,
	disinfectant = 15,
	painkillers = 25
}
ITEM.junk = "comp_stitched_cloth" 
ITEM.outlineColor = Color(255, 204, 0, 100)
ITEM.colorAppendix = {["blue"] = "You need another piece of stitched cloth to split this stack.", ["red"] = "You cannot use this item on yourself mid-combat, must be applied by another player."}
ITEM.holdData = {
    vectorOffset = {
        right = -2,
        up = -0.5,
        forward = 1.5
    },
    angleOffset = {
        right = 90,
        up = -90,
        forward = 0
    },
}