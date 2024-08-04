--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Enjekte Edilmiş Elma"
ITEM.description = "Tadı biraz garip olsa da diğer elmalara benziyor..."
ITEM.category = "Drugs"
ITEM.model = "models/willardnetworks/food/apple.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(169.82, 142.5, 102.64),
  ang = Angle(24.79, 220.01, 0),
  fov = 1.76
}
ITEM.boosts = {
  strength = -2,
  perception = 3,
  agility = 2
}
ITEM.energyShift = -0.01 -- fatigue_system
ITEM.hunger = 12
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav"
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[İlaç]: Tuhaf ekran görselleri uygular. Diğer oyuncular uyuşturucu alıp almadığınızı anlayabilir.", ["blue"] = "[RP]: Eğer uyuşturulmuşsanız FearRP'yi yok sayabilirsiniz."}
ITEM.drug = {
  ["green"] = 15, ["bloom"] = 15
}