--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Ładownica na amunicję"
ITEM.description = "Torba, która może pomieścić sporą ilość pocisków."
ITEM.model = Model("models/willardnetworks/clothingitems/backpack.mdl")
ITEM.noOpen = false
ITEM.noEquip = true
ITEM.invWidth = 4
ITEM.invHeight = 2
ITEM.width = 2
ITEM.height = 1
ITEM.restriction = { -- ammo is base_stackable, and thats kinda too broad for this so gotta list it manually
    "bullets_357",
    "bullets_assaultrifle",
    "bullets_buckshot",
    "bullets_heavypulse",
    "bullets_pistol",
    "bullets_pulse",
    "bullets_smg1",
    "bullets_sniper"
}