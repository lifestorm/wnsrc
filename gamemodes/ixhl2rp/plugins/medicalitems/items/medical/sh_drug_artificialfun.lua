--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Artificial Fun"
ITEM.description = "Mushed up artificial paste with a bit of car battery acid for good measure."
ITEM.model = Model("models/props_lab/jar01b.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/antlion_grub/squashed.wav"
ITEM.boosts = {
    strength = 5,
    perception = -3,
    intelligence = -3
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applies whacky screen visuals. Other players will be able to detect if you're drugged.", ["blue"] = "[RP]: You can ignore FearRP if you are drugged."}
ITEM.drug = {
    ["blackAndWhite"] = 15, ["bloom"] = 15, ["stealth"] = 15
}
ITEM.junk = "junk_jar"
ITEM.holdData = {
    vectorOffset = {
        right = -1.5,
        up = 0,
        forward = 0
    },
    angleOffset = {
        right = 0,
        up = 0,
        forward = 0
    },
}