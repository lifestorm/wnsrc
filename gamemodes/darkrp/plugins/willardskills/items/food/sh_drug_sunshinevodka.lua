--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Günışığı Votkası"
ITEM.description = "Tadı yapay güneş ışığı ve gökkuşağı gibi!"
ITEM.category = "Drugs"
ITEM.model = "models/willardnetworks/food/alcohol_bottle.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-248.7, -125.57, 62.84),
  ang = Angle(11.17, 386.79, 0),
  fov = 2.54
}
ITEM.thirst = 25
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.boosts = {
    strength = 3,
    agility = 3,
    intelligence = -3
}
ITEM.energyShift = 0.01 -- fatigue_system
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
    ["saturated"] = 15, ["jarate"] = 15, ["bloom"] = 15
}
ITEM.junk = "junk_empty_bottle"