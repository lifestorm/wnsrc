--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Medical Pouch"
ITEM.description = "A pouch in which you can store all your medical items"
ITEM.model = Model("models/willardnetworks/clothingitems/satchel.mdl")
ITEM.noOpen = false
ITEM.noEquip = true
ITEM.invWidth = 2
ITEM.invHeight = 6
ITEM.restriction = {
    "base_medical",
    "drink_saline",
    "comp_antidote",
    "comp_bloodsyringe",
    "comp_syringe",
    "drug_amph_a",
    "drug_amph_b",
}