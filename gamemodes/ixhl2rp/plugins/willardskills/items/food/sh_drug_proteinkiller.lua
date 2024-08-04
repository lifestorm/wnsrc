--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Białkobójca"
ITEM.description = "Sproszkowane białko zmieszane ze środkami przeciwbólowymi i wodą Breena."
ITEM.model = Model("models/willardnetworks/food/cmb_food1.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/antlion_grub/squashed.wav"
ITEM.hunger = 25
ITEM.boosts = {
    strength = 3,
    perception = 2,
    intelligence = -3
}
ITEM.energyShift = 0.01 -- fatigue_system
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["sobel"] = 15
}
ITEM.junk = "comp_plastic"