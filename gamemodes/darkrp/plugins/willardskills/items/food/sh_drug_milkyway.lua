--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Samanyolu"
ITEM.description = "Evrenle bir olmak için. En azından bir süreliğine."
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/props_junk/garbage_milkcarton002a.mdl"
ITEM.thirst = 25
ITEM.boosts = {
    strength = -3,
    agility = -3,
    perception = 4,
    intelligence = 4
}
ITEM.energyShift = -0.02 -- fatigue_system
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
  ["bloom"] = 15, ["saturated"] = 15, ["sobel"] = 15
}
ITEM.junk = "junk_carton"