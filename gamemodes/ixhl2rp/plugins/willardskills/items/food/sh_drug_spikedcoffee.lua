--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Spiked Cup of Coffee"
ITEM.description = "Warm cup of coffee, helps keep you alert and awake for these strange times, this one seemingly even more so than usual.."
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/coffee.mdl"
ITEM.thirst = 30
ITEM.boosts = {
	agility = 3
}
ITEM.energyShift = 0.01 -- fatigue_system
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_coffeecup"
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applies whacky screen visuals. Other players will be able to detect if you're drugged.", ["blue"] = "[RP]: You can ignore FearRP if you are drugged."}
ITEM.drug = {
  ["distort1"] = 15, ["bloom"] = 15
}