--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "İblis Arıları"
ITEM.description = "İçi koyu kırmızı sıvı ile dolu bir şırınga, enjeksiyon sırasında enjeksiyon yerinde aşırı yanma hissi hissedebilirsiniz."
ITEM.model = Model("models/willardnetworks/skills/medx.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "items/medshot4.wav"
ITEM.boosts = {
    strength = 4,
    perception = 6,
    agility = 4,
    intelligence = -7
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
    ["bloom"] = 15, ["distort1"] = 5, ["redUber"] = 15
}
ITEM.junk = "comp_syringe"