--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Surgical Kit"
ITEM.model = Model("models/willardnetworks/skills/surgicalkit.mdl")
ITEM.description = "A red pouch that unfolds to reveal an assortment of surgical tools. Used by medical professionals for immediate aid."
ITEM.category = "Medical"
ITEM.maxStackSize = 3
ITEM.useSound = "items/medshot4.wav"
ITEM.healing = {
	bandage = 65,
	disinfectant = 25,
	painkillers = 35
}
ITEM.junk = "comp_stitched_cloth"
ITEM.outlineColor = Color(255, 78, 69, 100)
ITEM.colorAppendix = {["blue"] = "You need another piece of stitched cloth to split this stack.", ["red"] = "You cannot use this item on yourself mid-combat, must be applied by another player."}
ITEM.holdData = {
    vectorOffset = {
        right = -0.5,
        up = -0.5,
        forward = 0
    },
    angleOffset = {
        right = 90,
        up = 0,
        forward = 0
    },
}