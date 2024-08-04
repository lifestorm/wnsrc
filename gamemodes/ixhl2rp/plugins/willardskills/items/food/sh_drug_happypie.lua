--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Szczęśliwy placuszek"
ITEM.description = "Pyszna szarlotka, która z pewnością sprawi Ci radość."
ITEM.model = Model("models/willardnetworks/food/pie.mdl")
ITEM.category = "Drugs"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
    pos = Vector(169.82, 142.5, 102.64),
    ang = Angle(24.95, 219.95, 0),
    fov = 2.78
  }
ITEM.useSound = "npc/antlion_grub/squashed.wav"
ITEM.hunger = 65
ITEM.boosts = {
    strength = 5,
    agility = 5
}
ITEM.energyShift = 0.01 -- fatigue_system
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
    ["saturated"] = 15, ["gas"] = 15
}