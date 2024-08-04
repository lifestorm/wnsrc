--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Çivili Fincan Kahve"
ITEM.description = "Ilık bir fincan kahve, bu garip zamanlarda sizi uyanık ve tetikte tutmaya yardımcı olur, bu seferki normalden daha da fazla..."
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/willardnetworks/food/coffee.mdl"
ITEM.thirst = 30
ITEM.boosts = {
	agility = 3
}
ITEM.energyShift = 0.01 -- fatigue_system
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_coffeecup"
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
  ["distort1"] = 15, ["bloom"] = 15
}