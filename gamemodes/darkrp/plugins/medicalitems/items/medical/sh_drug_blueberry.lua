--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Mavi Yemiş"
ITEM.description = "Mavi sıvıyla dolu garip bir şişe, tadı meyve suyuna benziyor ama iğrenç bir şekilde kokuyor."
ITEM.model = Model("models/willardnetworks/skills/chemical_flask4.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = -2,
    perception = 5,
    intelligence = 5
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
    ["blueUber"] = 15, ["bluetint"] = 15, ["bloom"] = 15
}