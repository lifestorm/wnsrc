--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Ozz'un İksiri"
ITEM.description = "Cam kavanozda garip bir sıvı, açıldığında güçlü ve garip bir kokusu var. Tadı benzin gibi ama sizi zeki ve anlayışlı hissettiriyor."
ITEM.model = Model("models/props_junk/glassjug01.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = -3,
    perception = 5,
    agility =-3,
    intelligence = 5
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
    ["greentint"] = 15, ["stealth"] = 15
}
ITEM.junk = "junk_empty_bottle"