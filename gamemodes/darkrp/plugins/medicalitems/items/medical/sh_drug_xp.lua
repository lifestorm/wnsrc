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
ITEM.description = "Eski bir şişede kahverengi sıvı, kokladığınızda gerçekten hafif hissedebilirsiniz. Tadı eski öksürük şurubu gibi."
ITEM.model = Model("models/willardnetworks/food/wine4.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = 6,
    perception = 6,
    agility = 6,
    intelligence = 6
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
    ["gas"] = 15, ["sharpen"] = 15, ["bloom"] = 15
}
ITEM.junk = "junk_empty_bottle"