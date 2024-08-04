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
	name = "Wytwarzanie",
	description = "Naprawiaj, rozkładaj i twórz przedmioty.",
	image = "willardnetworks/tabmenu/skills_v2/crafting_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/crafting.png",
})
ix.skill:RegisterSkill("cooking", {
	name = "Gotowanie",
	description = "Wyznacznik tego jak dobrym kucharzem jesteś.",
	icon = "willardnetworks/tabmenu/skills/skillicons/cooking.png",
	image = "willardnetworks/tabmenu/skills_v2/cooking_bg.png",
})
ix.skill:RegisterSkill("guns", {
	name = "Broń palna",
	description = "Twoja umiejętność w posługiwaniu się bronią palną.",
	icon = "willardnetworks/tabmenu/skills/skillicons/guns.png",
	image = "willardnetworks/tabmenu/skills_v2/guns_bg.png",
})
ix.skill:RegisterSkill("bartering", {
	name = "Handel",
	description = "Kupuj dobra i zacznij swój własny biznes.",
	icon = "willardnetworks/tabmenu/skills/skillicons/bartering.png",
	image = "willardnetworks/tabmenu/skills_v2/bartering_bg.png"
})
ix.skill:RegisterSkill("smuggling", {
	name = "Przemyt",
	description = "Kupuj nielegalne przedmioty z czarnego rynku.",
	icon = "willardnetworks/tabmenu/skills/skillicons/smuggling.png",
	image = "willardnetworks/tabmenu/skills_v2/smuggling_bg.png"
})
ix.skill:RegisterSkill("medicine", {
	name = "Medycyna",
	description = "Umiejętność opatrywania siebie jak i innych.",
	icon = "willardnetworks/tabmenu/skills/skillicons/medical.png",
	image = "willardnetworks/tabmenu/skills_v2/medicine_bg.png",
})
ix.skill:RegisterSkill("speed", {
	name = "Prędkość",
	description = "Biegaj szybciej i na większe dystanse.",
	image = "willardnetworks/tabmenu/skills_v2/speed_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/speed.png",
})
ix.skill:RegisterSkill("vort", {
	name = "Vortesencja",
	description = "Twoja umiejętność w posługiwaniu się Vortesencją.",
	faction = {FACTION_VORT},
	image = "willardnetworks/tabmenu/skills_v2/vortessence_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/vortessence.png",
})
ix.skill:RegisterSkill("melee", {
	name = "Broń biała",
	description = "Twoja umiejętność w posługiwaniu się bronią białą.",
	image = "willardnetworks/tabmenu/skills_v2/melee_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/melee.png",
})


local minor = 1
local major = 2
ix.special:RegisterAttribute("strength", {
	name = "Siła",
	description = "Decyduje o twojej sile.",
	icon = "willardnetworks/mainmenu/charcreation/strength.png",
	skills = {
		guns = major,
		melee = major,
		speed = minor,
		crafting = minor,
	}
})
ix.special:RegisterAttribute("perception", {
	name = "Percepcja",
	description = "Decyduje o twojej spostrzegawczości i percepcji.",
	icon = "willardnetworks/mainmenu/charcreation/perception.png",
	skills = {
		cooking = major,
		smuggling = minor,
		guns = minor,
		vort = major,
	}
})
ix.special:RegisterAttribute("agility", {
	name = "Zręczność",
	description = "Decyduje o twojej zwinności i zręczności.",
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
	name = "Inteligencja",
	description = "Decyduje o twojej inteligencji.",
	icon = "willardnetworks/mainmenu/charcreation/intelligence.png",
	skills = {
		medicine = major,
		crafting = major,
		cooking = minor,
	}
})
