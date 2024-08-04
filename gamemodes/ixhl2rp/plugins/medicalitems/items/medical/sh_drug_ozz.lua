--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Ozz's Potion"
ITEM.description = "Dziwny płyn w szklanym słoiku, po otwarciu ma mocny i dziwny zapach. Smakuje jak benzyna, ale sprawia, że czujesz się mądrzejszy i bardziej spostrzegawczy. It tastes like gasoline but makes you feel clever and perceptive."
ITEM.model = Model("models/props_junk/glassjug01.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = -4,
    perception = 5,
    agility =-3,
    intelligence = 5
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["greentint"] = 15, ["stealth"] = 15
}
ITEM.junk = "junk_empty_bottle"