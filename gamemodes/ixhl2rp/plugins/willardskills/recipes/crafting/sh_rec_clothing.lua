--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_legs_padded_blue"
RECIPE.name = "Wzmocnione niebieskie spodnie"
RECIPE.description = "Wzmocnione niebieskie spodnie, często zakładane przez ruch oporu."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel2.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_blue_pants"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_blue_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_legs_padded_black"
RECIPE.name = "Wzmocnione czarne spodnie"
RECIPE.description = "Wzmocnione czarne spodnie, często zakładane przez ruch oporu."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel3.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_civilian_black"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_black_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_legs_padded_green"
RECIPE.name = "Wzmocnione zielone spodnie"
RECIPE.description = "Wzmocnione zielone spodnie, często zakładane przez ruch oporu."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel1.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_civilian_green"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_green_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_green"
RECIPE.name = "Zielony uniform ruchu oporu"
RECIPE.description = "Zielony uniform z paskami oraz miejscem na insygnie."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel02.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["denim_green"] = 1, ["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_iron"] = 1}
RECIPE.result = {["torso_green_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_blue"
RECIPE.name = "Niebieski uniform ruchu oporu"
RECIPE.description = "Niebieski uniform z paskami oraz miejscem na insygnie."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel01.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["denim_blue"] = 1, ["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_iron"] = 1}
RECIPE.result = {["torso_blue_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_medic"
RECIPE.name = "Medyczny uniform ruchu oporu"
RECIPE.description = "Medyczny uniform z paskami oraz miejscem na insygnie."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebelmedic.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["torso_medic_shirt"] = 1, ["comp_adhesive"] = 2, ["comp_iron"] = 1}
RECIPE.result = {["torso_medical_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_helmet"
RECIPE.name = "Hełm"
RECIPE.description = "Metalowy hełm, chroni twoją głowę przed spadającymi przedmiotami oraz odłamkami."
RECIPE.model = "models/willardnetworks/clothingitems/head_helmet.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.result = {["head_helmet"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_medichelmet"
RECIPE.name = "Hełm medyka"
RECIPE.description = "Metalowy hełm z oznaczeniem medyka, chroni twoją głowę przed spadającymi przedmiotami oraz odłamkami."
RECIPE.model = "models/willardnetworks/clothingitems/head_helmet_med.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.result = {["helmet_medic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_blue"
RECIPE.name = "Niebieska czapka"
RECIPE.description = "Niebieska czapka, chroni twoją głowę przed zimnem."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["head_blue_beanie"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_green"
RECIPE.name = "Zielona czapka"
RECIPE.description = "Zielona czapka, chroni twoją głowę przed zimnem."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["head_green_beanie"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_red"
RECIPE.name = "Czerwona czapka"
RECIPE.description = "Czerwona czapka, chroni twoją głowę przed zimnem."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_red"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_brown"
RECIPE.name = "Brązowa czapka"
RECIPE.description = "Brązowa czapka, chroni twoją głowę przed zimnem."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_brown"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_grey"
RECIPE.name = "Szara czapka"
RECIPE.description = "Szara czapka, chroni twoją głowę przed zimnem."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_grey"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_bandana"
RECIPE.name = "Bandana"
RECIPE.description = "Czerwona bandana zawinięta wokół twoich ust i nosa, chroni w małym stopniu przed zarodnikami."
RECIPE.model = "models/willardnetworks/clothingitems/head_facewrap.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["face_bandana"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_hands_tipless"
RECIPE.name = "Rękawiczki bez palców"
RECIPE.description = "Para czarnych rękawiczek z wyciętymi palcami."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove_fingerless.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["hands_gloves"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["hands_tipless_gloves"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 60}, -- full XP
	{level = 10, exp = 30}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_trenchcoat"
RECIPE.name = "Brązowy płaszcz"
RECIPE.description = "Brązowy znoszony płaszcz, w miare chroni przed deszczem."
RECIPE.model = "models/willardnetworks/clothingitems/torso_refugee_coat.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["buttoned_white"] = 1, ["comp_fabric"] = 2, ["comp_adhesive"] = 1, ["comp_iron"] = 2}
RECIPE.result = {["overcoat_trench"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_medic"
RECIPE.name = "Koszula medyka"
RECIPE.description = "Biała koszula z krzyżami medyka na ramieniu."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen_medic.mdl"
RECIPE.category = "Ubrania ruchu oporu"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["buttoned_white"] = 1, ["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["torso_medic_shirt"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

