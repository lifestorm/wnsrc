--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "The Third Eye"
ITEM.description = "Strzykawka wypełniona białym płynem, po użyciu od razu możesz poczuć, że jesteś o wiele bardziej spostrzegawczy."
ITEM.model = Model("models/willardnetworks/skills/pyscho.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    strength =-5,
    perception = 6,
    agility = -4,
    intelligence = 6
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["jarate"] = 15, ["sobel"] = 15
}
ITEM.junk = "comp_syringe"