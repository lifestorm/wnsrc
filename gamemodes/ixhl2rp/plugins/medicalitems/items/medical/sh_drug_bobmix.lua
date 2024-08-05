--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bob's Trail Mix"
ITEM.description = "What would happen if you took the distillate of every bob drink (publicly) available, mixed them together and injected the resulting product right into your arm? Scientists said 'Nothing Good', while the Crackhead down in the slums said 'you ascend'. Go prove one or the other right."
ITEM.model = Model("models/willardnetworks/food/bobdrinks_can.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = -1,
    perception = 3,
    agility = 3,
    intelligence = -4
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Drug]: Applies whacky screen visuals. Other players will be able to detect if you're drugged.", ["blue"] = "[RP]: You can ignore FearRP if you are drugged."}
ITEM.drug = {
    ["saturated"] = 15
}
ITEM.junk = "junk_empty_can"