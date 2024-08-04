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
	name = "Zanaatkarlık",
	description = "Tamir, söküm ve eşya yapımı.",
	image = "willardnetworks/tabmenu/skills_v2/crafting_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/crafting.png",
})
ix.skill:RegisterSkill("cooking", {
	name = "Pişirme",
	description = "Ne kadar iyi yemek yapabildiğin.",
	icon = "willardnetworks/tabmenu/skills/skillicons/cooking.png",
	image = "willardnetworks/tabmenu/skills_v2/cooking_bg.png",
})
ix.skill:RegisterSkill("guns", {
	name = "Silahlar",
	description = "Ateşli silahlarla nasıl mücadele edileceğini bilmek.",
	icon = "willardnetworks/tabmenu/skills/skillicons/guns.png",
	image = "willardnetworks/tabmenu/skills_v2/guns_bg.png",
})
ix.skill:RegisterSkill("bartering", {
	name = "Takas",
	description = "Mal satın alın ve yerel bir iş kurun.",
	icon = "willardnetworks/tabmenu/skills/skillicons/bartering.png",
	image = "willardnetworks/tabmenu/skills_v2/bartering_bg.png"
})
ix.skill:RegisterSkill("smuggling", {
	name = "Kaçakçılık",
	description = "Karaborsadan yasadışı mal satın al.",
	icon = "willardnetworks/tabmenu/skills/skillicons/smuggling.png",
	image = "willardnetworks/tabmenu/skills_v2/smuggling_bg.png"
})
ix.skill:RegisterSkill("medicine", {
	name = "Tıp",
	description = "Hem kendinizi hem de başkalarını iyileştirin.",
	icon = "willardnetworks/tabmenu/skills/skillicons/medical.png",
	image = "willardnetworks/tabmenu/skills_v2/medicine_bg.png",
})
ix.skill:RegisterSkill("speed", {
	name = "Hız",
	description = "Savaş inisiyatifi kazanın, daha uzağa ve daha hızlı koşun.",
	image = "willardnetworks/tabmenu/skills_v2/speed_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/speed.png",
})
ix.skill:RegisterSkill("vort", {
	name = "Vortessence",
	description = "Vortessence ile ne kadar iyisin.",
	faction = {FACTION_VORT},
	image = "willardnetworks/tabmenu/skills_v2/vortessence_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/vortessence.png",
})
ix.skill:RegisterSkill("melee", {
	name = "Yakın Dövüş",
	description = "Yakın dövüş silahlarında ne kadar iyi olduğunuz.",
	image = "willardnetworks/tabmenu/skills_v2/melee_bg.png",
	icon = "willardnetworks/tabmenu/skills/skillicons/melee.png",
})


local minor = 1
local major = 2
ix.special:RegisterAttribute("strength", {
	name = "Güç",
	description = "Ne kadar güçlü olduğun.",
	icon = "willardnetworks/mainmenu/charcreation/strength.png",
	skills = {
		guns = major,
		melee = major,
		speed = minor,
		crafting = minor,
	}
})
ix.special:RegisterAttribute("perception", {
	name = "Algı",
	description = "Algılarının ne kadar iyi olduğu.",
	icon = "willardnetworks/mainmenu/charcreation/perception.png",
	skills = {
		cooking = major,
		smuggling = minor,
		guns = minor,
		vort = major,
	}
})
ix.special:RegisterAttribute("agility", {
	name = "Çeviklik",
	description = "Ne kadar çevik olduğun.",
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
	name = "Zeka",
	description = "Ne kadar zeki olduğun.",
	icon = "willardnetworks/mainmenu/charcreation/intelligence.png",
	skills = {
		medicine = major,
		crafting = major,
		cooking = minor,
	}
})
