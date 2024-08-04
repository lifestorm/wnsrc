--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "XP"
ITEM.description = "Brązowy płyn w starej butelce, po powąchaniu go można poczuć się naprawdę lekko. Smakuje jak stary syrop na kaszel."
ITEM.model = Model("models/willardnetworks/food/wine4.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = 4,
    perception = 3,
    agility = 5,
    intelligence = 2
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["gas"] = 15, ["sharpen"] = 15, ["bloom"] = 15
}
ITEM.junk = "junk_empty_bottle"