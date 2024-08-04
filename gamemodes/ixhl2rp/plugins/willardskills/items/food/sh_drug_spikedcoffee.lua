--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Zaprawiona kubek kawy"
ITEM.description = "Ciepła kubek kawy pomaga zachować czujność i przytomność w tych dziwnych czasach, ta wydaje się nawet bardziej niż zwykle."
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
ITEM.colorAppendix = {["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.", ["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany."}
ITEM.drug = {
  ["distort1"] = 15, ["bloom"] = 15
}