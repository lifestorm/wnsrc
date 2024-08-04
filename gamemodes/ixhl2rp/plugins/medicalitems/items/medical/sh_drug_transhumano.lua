--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Transhumano"
ITEM.description = "Wyrafinowana pigułka, która sprawia, że czujesz się ultra silny, niektórzy wierzą, że to właśnie jej używają żołnierze Overwatch."
ITEM.model = Model("models/willardnetworks/skills/pills2.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
    strength = 5,
    perception = 6,
    agility = -5,
    intelligence = -3
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["sobel"] = 15, ["blueUber"] = 15, ["stealth"] = 15, ["sharpen"] = 15
}
ITEM.junk = "comp_plastic"