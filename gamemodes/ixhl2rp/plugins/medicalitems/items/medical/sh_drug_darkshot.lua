--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Dark Shot"
ITEM.description = "Blood mixed with various medications, upon consuming it you can feel a burning sensation in your throat."
ITEM.model = Model("models/willardnetworks/skills/medjar.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    strength = 4,
    perception = -5,
    agility = 3
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applies whacky screen visuals. Other players will be able to detect if you're drugged.", ["blue"] = "[RP]: You can ignore FearRP if you are drugged."}
ITEM.drug = {
    ["red"] = 15, ["bloom"] = 15, ["distort1"] = 15
}
ITEM.junk = "junk_jar"