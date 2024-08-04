--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Demon's Bees"
ITEM.description = "Strzykawka wypełniona ciemnoczerwonym płynem w środku, po wstrzyknięciu możesz poczuć ekstremalne uczucie pieczenia w miejscu wstrzyknięcia."
ITEM.model = Model("models/willardnetworks/skills/medx.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    strength = 2,
    perception = 3,
    agility = 2,
    intelligence = -7
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["bloom"] = 15, ["distort1"] = 5, ["redUber"] = 15
}
ITEM.junk = "comp_syringe"