--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.skill:RegisterSkill("crafting", {
	name = "Crafting",
	description = "Repairing, dismantling, and making items.",
	image = "willardnetworks/tabmenu/skills_v2/crafting_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/crafting.png",
})
ix.skill:RegisterSkill("cooking", {
	name = "Cooking",
	description = "How well you can cook.",
	icon = "willardnetworks/tabmenu/skills/skillicons/cooking.png",
	image = "willardnetworks/tabmenu/skills_v2/cooking_bg.png",
})
ix.skill:RegisterSkill("guns", {
	name = "Guns",
	description = "Knowledge how to tackle firearms.",
	icon = "willardnetworks/tabmenu/skills/skillicons/guns.png",
	image = "willardnetworks/tabmenu/skills_v2/guns_bg.png",
})
ix.skill:RegisterSkill("bartering", {
	name = "Bartering",
	description = "Purchase goods and start a local business.",
	icon = "willardnetworks/tabmenu/skills/skillicons/bartering.png",
	image = "willardnetworks/tabmenu/skills_v2/bartering_bg.png"
})
ix.skill:RegisterSkill("smuggling", {
	name = "Smuggling",
	description = "Purchase illegal goods from the black market.",
	icon = "willardnetworks/tabmenu/skills/skillicons/smuggling.png",
	image = "willardnetworks/tabmenu/skills_v2/smuggling_bg.png"
})
ix.skill:RegisterSkill("medicine", {
	name = "Medicine",
	description = "Heal yourself and others alike.",
	icon = "willardnetworks/tabmenu/skills/skillicons/medical.png",
	image = "willardnetworks/tabmenu/skills_v2/medicine_bg.png",
})
ix.skill:RegisterSkill("speed", {
	name = "Speed",
	description = "Gain combat initiative, run further & faster.",
	image = "willardnetworks/tabmenu/skills_v2/speed_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/speed.png",
})
ix.skill:RegisterSkill("vort", {
	name = "Vortessence",
	description = "How good you are with Vortessence.",
	faction = {FACTION_VORT},
	image = "willardnetworks/tabmenu/skills_v2/vortessence_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/vortessence.png",
})
ix.skill:RegisterSkill("melee", {
	name = "Melee",
	description = "How good you are with melee weapons.",
	image = "willardnetworks/tabmenu/skills_v2/melee_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/melee.png",
})


local minor = 1
local major = 2
ix.special:RegisterAttribute("strength", {
	name = "Strength",
	description = "How strong you are",
	icon = "willardnetworks/mainmenu/charcreation/strength.png",
	skills = {
		guns = major,
		melee = major,
		speed = minor,
		crafting = minor,
	}
})
ix.special:RegisterAttribute("perception", {
	name = "Perception",
	description = "How perceptive you are.",
	icon = "willardnetworks/mainmenu/charcreation/perception.png",
	skills = {
		cooking = major,
		smuggling = minor,
		guns = minor,
		vort = major,
	}
})
ix.special:RegisterAttribute("agility", {
	name = "Agility",
	description = "How agile you are.",
	icon = "willardnetworks/mainmenu/charcreation/agility.png",
	skills = {
		smuggling = major,
		speed = major,
		medicine = minor,
		vort = minor,
		melee = minor
	}
})
ix.special:RegisterAttribute("intelligence", {
	name = "Intelligence",
	description = "How intelligent you are.",
	icon = "willardnetworks/mainmenu/charcreation/intelligence.png",
	skills = {
		medicine = major,
		crafting = major,
		cooking = minor,
	}
})
