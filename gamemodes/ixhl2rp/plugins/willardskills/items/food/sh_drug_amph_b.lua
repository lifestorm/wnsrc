--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Amfetamina KLASY B"
ITEM.description = "Strzykawka oznaczona 'Zatwierdzony przez IMS stymulant 'KLASY 'B'. Po zażyciu można poczuć euforię, zwiększoną percepcje, energię, siłę i silne pobudzenie, które trwałoby przez godzinę lub dłużej."
ITEM.model = Model("models/willardnetworks/skills/hpsyringe.mdl")
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
    perception = 3,
    agility = 3,
    intelligence = -3
}
ITEM.energyShift = 0.05 -- fatigue_system
ITEM.outlineColor = Color(128, 200, 97, 255)
ITEM.colorAppendix = {
	["green"] = "[Narkotyk]: Nakłada efekty wizualne na ekran. Inni gracze mogą zauważyć, że jesteś naćpany.",
	["blue"] = "[RP]: Możesz ignorować FearRP jeżeli jesteś naćpany. Efekt tego narkotyku może utrzymywać się przez parę godzin.",
	["red"] = "[RP]: Ten narkotyk jest bardzo uzależniający."
}
ITEM.drug = {
    ["bloom"] = 15, ["distort1"] = 5, ["redUber"] = 15
}
ITEM.junk = "comp_syringe"
