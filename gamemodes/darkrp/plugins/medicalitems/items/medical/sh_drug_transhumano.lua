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
ITEM.description = "Ultra güçlü hissetmenizi sağlayan rafine bir hap, bazıları bunun transhumanların kullandığı şey olduğuna inanıyor."
ITEM.model = Model("models/willardnetworks/skills/pills2.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "willardnetworks/inventory/inv_pills.wav"
ITEM.boosts = {
    strength = 7,
    perception = 7
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
    ["sobel"] = 15, ["blueUber"] = 15, ["stealth"] = 15, ["sharpen"] = 15
}
ITEM.junk = "comp_plastic"