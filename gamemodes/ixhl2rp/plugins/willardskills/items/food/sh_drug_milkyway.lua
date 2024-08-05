--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "The Milky Way"
ITEM.description = "To become one with the universe.. At least for a little bit."
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/props_junk/garbage_milkcarton002a.mdl"
ITEM.thirst = 25
ITEM.boosts = {
    strength = -3,
    agility = -3,
    perception = 4,
    intelligence = 4
}
ITEM.energyShift = -0.02 -- fatigue_system
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applies whacky screen visuals. Other players will be able to detect if you're drugged.", ["blue"] = "[RP]: You can ignore FearRP if you are drugged."}
ITEM.drug = {
  ["bloom"] = 15, ["saturated"] = 15, ["sobel"] = 15
}
ITEM.junk = "junk_carton"