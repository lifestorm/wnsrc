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
ITEM.description = "Zastanawiasz się co by się stało, gdybyś wziął destylat każdego dostępnego (publicznie) napoju bobowego, zmieszał go ze sobą i wstrzyknął powstały produkt prosto w ramię? Sprawdź sam, śmiało."
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
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["saturated"] = 15
}
ITEM.junk = "junk_empty_can"