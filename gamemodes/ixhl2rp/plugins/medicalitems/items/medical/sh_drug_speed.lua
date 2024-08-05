--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Speed"
ITEM.description = "A crushed pack of pills mixed in a can. Gives you feeling of being fast."
ITEM.model = Model("models/props_junk/popcan01a.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    agility = 6,
    strength = -4
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applies whacky screen visuals. Other players will be able to detect if you're drugged.", ["blue"] = "[RP]: You can ignore FearRP if you are drugged."}
ITEM.drug = {
    ["gas"] = 15, ["jarate"] = 15, ["bloom"] = 15, ["sharpen"] = 15
}
ITEM.junk = "junk_empty_water"