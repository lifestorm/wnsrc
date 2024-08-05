--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "B SINIFI Amfetamin"
ITEM.description = "'SINIF 'B' IMS Onaylı Uyarıcı' etiketli bir şırınga. Kullanımdan sonra kullanıcı bir saat veya daha fazla sürecek bir öfori, yüksek algı, enerji, güç ve uyanıklık hissi duyacaktır."
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
	["green"] = "[Drug]: Applies whacky screen visuals. Other players will be able to detect if you're drugged.",
	["blue"] = "[RP]: You can ignore FearRP if you are drugged. The effect of this drug might linger for hours after use.",
	["red"] = "[RP]: This stubstance is very addictive."
}
ITEM.drug = {
    ["bloom"] = 15, ["distort1"] = 5, ["redUber"] = 15
}
ITEM.junk = "comp_syringe"