--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Zaprawiona kubek herbaty"
ITEM.description = "Komfortowy i ciepły w dotyku, ale z cierpkim posmakiem."
ITEM.category = "Drugs"
ITEM.model = "models/props_junk/garbage_coffeemug001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
  pos = Vector(-164.23, -189.89, 37.43),
  ang = Angle(8.47, 49.22, 0),
  fov = 2.05
}
ITEM.thirst = 35
ITEM.boosts = {
	intelligence = 2,
	perception = 2
}
ITEM.spoil = true
ITEM.useSound = "npc/barnacle/barnacle_gulp2.wav"
ITEM.junk = "junk_mug"
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
  ["distort1"] = 15, ["bloom"] = 15
}