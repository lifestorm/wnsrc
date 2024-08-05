--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "CLASS A Amphetamine"
ITEM.description = "A syringe labeled with 'CLASS 'A' IMS Approved Stimulant'. After useage the user would feel a sense of euphoria, heightened perception, energy, strength, and wakefullness that would last for an hour or more."
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
    strength = 6,
    perception = 5,
    agility = 4,
    intelligence = -4
}
ITEM.energyShift = 0.01 -- fatigue_system
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
