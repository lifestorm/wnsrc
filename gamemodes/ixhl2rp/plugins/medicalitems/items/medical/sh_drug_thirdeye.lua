--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "The Third Eye"
ITEM.description = "A white liquid inside of the syringe, after usage someone could feel increased awareness of the surroundings."
ITEM.model = Model("models/willardnetworks/skills/pyscho.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    strength =-5,
    perception = 6,
    agility = -4,
    intelligence = 6
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applies whacky screen visuals. Other players will be able to detect if you're drugged.", ["blue"] = "[RP]: You can ignore FearRP if you are drugged."}
ITEM.drug = {
    ["jarate"] = 15, ["sobel"] = 15
}
ITEM.junk = "comp_syringe"