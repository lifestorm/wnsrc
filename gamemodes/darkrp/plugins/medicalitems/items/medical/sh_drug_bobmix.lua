--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Bob'un İz Karışımı"
ITEM.description = "(Halka açık) her bob içkisinin damıtılmış halini alıp karıştırsanız ve ortaya çıkan ürünü kolunuza enjekte etseniz ne olurdu? Bilim adamları 'İyi bir şey olmaz' derken, kenar mahallelerdeki keşler 'yükselirsin' derdi. Git ve ikisinden birinin haklı olduğunu kanıtla."
ITEM.model = Model("models/willardnetworks/food/bobdrinks_can.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = 3,
    perception = 5,
    agility = 5,
    intelligence = -5
}
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
    ["saturated"] = 15
}
ITEM.junk = "junk_empty_can"