--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Yapay Eğlence"
ITEM.description = "İyi bir önlem için biraz araba aküsü asidi ile yapay macun ezildi."
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
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
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