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
	name = "Artisanat",
	description = "Réparer, démanteler et fabriquer des objets.",
	image = "willardnetworks/tabmenu/skills_v2/crafting_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/crafting.png",
})
ix.skill:RegisterSkill("cooking", {
	name = "Cuisine",
	description = "Votre savoir dans la cuisine.",
	icon = "willardnetworks/tabmenu/skills/skillicons/cooking.png",
	image = "willardnetworks/tabmenu/skills_v2/cooking_bg.png",
})
ix.skill:RegisterSkill("guns", {
	name = "Armes",
	description = "Votre savoir de maniement des armes.",
	icon = "willardnetworks/tabmenu/skills/skillicons/guns.png",
	image = "willardnetworks/tabmenu/skills_v2/guns_bg.png",
})
ix.skill:RegisterSkill("bartering", {
	name = "Commerce",
	description = "Acheter des produits et commencer un commerce local.",
	icon = "willardnetworks/tabmenu/skills/skillicons/bartering.png",
	image = "willardnetworks/tabmenu/skills_v2/bartering_bg.png"
})
ix.skill:RegisterSkill("smuggling", {
	name = "Contrebande",
	description = "Acheter & revendre des produits du marché noir.",
	icon = "willardnetworks/tabmenu/skills/skillicons/smuggling.png",
	image = "willardnetworks/tabmenu/skills_v2/smuggling_bg.png"
})
ix.skill:RegisterSkill("medicine", {
	name = "Médecine",
	description = "Soigner les autres et soi-même.",
	icon = "willardnetworks/tabmenu/skills/skillicons/medical.png",
	image = "willardnetworks/tabmenu/skills_v2/medicine_bg.png",
})
ix.skill:RegisterSkill("speed", {
	name = "Vitesse",
	description = "Courir plus vite, et plus longtemps.",
	image = "willardnetworks/tabmenu/skills_v2/speed_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/speed.png",
})
ix.skill:RegisterSkill("vort", {
	name = "Vortessence",
	description = "Votre maniement de la vortessence.",
	faction = {FACTION_VORT},
	image = "willardnetworks/tabmenu/skills_v2/vortessence_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/vortessence.png",
})
ix.skill:RegisterSkill("melee", {
	name = "Mêlée",
	description = "Votre maniement des armes de mêlées.",
	image = "willardnetworks/tabmenu/skills_v2/melee_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/melee.png",
})


local minor = 1
local major = 2
ix.special:RegisterAttribute("strength", {
	name = "Force",
	description = "Votre force.",
	icon = "willardnetworks/mainmenu/charcreation/force.png",
	skills = {
		guns = major,
		melee = major,
		speed = minor,
		crafting = minor,
	}
})
ix.special:RegisterAttribute("perception", {
	name = "Perception",
	description = "Votre perception.",
	icon = "willardnetworks/mainmenu/charcreation/perception.png",
	skills = {
		cooking = major,
		smuggling = minor,
		guns = minor,
		vort = major,
	}
})
ix.special:RegisterAttribute("agility", {
	name = "Agilité",
	description = "Votre agilité.",
	icon = "willardnetworks/mainmenu/charcreation/agilité.png",
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
	description = "Votre intelligence.",
	icon = "willardnetworks/mainmenu/charcreation/intelligence.png",
	skills = {
		medicine = major,
		crafting = major,
		cooking = minor,
	}
})
