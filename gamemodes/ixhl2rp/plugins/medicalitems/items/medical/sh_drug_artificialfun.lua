--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Artificial Fun"
ITEM.description = "Zmiksowana sztuczna pasta z odrobiną kwasu z akumulatora samochodowego."
ITEM.model = Model("models/props_lab/jar01b.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/antlion_grub/squashed.wav"
ITEM.boosts = {
    strength = 5,
    perception = -3,
    intelligence = -3
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["blackAndWhite"] = 15, ["bloom"] = 15, ["stealth"] = 15
}
ITEM.junk = "junk_jar"
ITEM.holdData = {
    vectorOffset = {
        right = -1.5,
        up = 0,
        forward = 0
    },
    angleOffset = {
        right = 0,
        up = 0,
        forward = 0
    },
}