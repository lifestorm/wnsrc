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

RECIPE.uniqueID = "rec_craft_vort_shackles_fake"
RECIPE.name = "Kajdany Vortigaunta (fałszywe)"
RECIPE.description = "Metalowe kajdany połączone ze sobą, sprawiają bół podczas noszenia. Po założeniu nie można ich zdjąć."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1, ["comp_refined_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_shackles_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_collar_fake"
RECIPE.name = "Obroża Vortigaunta (fałszywa)"
RECIPE.description = "Ciężka metalowa obroża, po jej założeniu moc Vortigaunta jest tłumiona. Nie można jej zdjąć bez specjalnych narzędzi."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_collar_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 70}, -- full XP
	{level = 30, exp = 35}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_hooks_fake"
RECIPE.name = "Haki Vortigaunta (fałszywe)"
RECIPE.description = "Podstawowy element obroży oraz kajdanek, ociskają nogi Vortigaunta sprawiając mu ból."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_hooks_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 30}, -- full XP
	{level = 30, exp = 15}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_meat01"
RECIPE.name = "Pas z pożywienia"
RECIPE.description = "Kolekcja smakowitych skór z headcraba, zebrana z zakątków."
RECIPE.model = "models/n7/vorti_outfit/meat01.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["headcrab_skewer"] = 3, ["comp_rivbolts"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_meat01"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 200}, -- full XP
	{level = 10, exp = 100}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_meat02"
RECIPE.name = "Pas z mięsem z pustkowia"
RECIPE.description = "Bardzo trudne do zdobycia oraz bardzo cenne w tych czasach."
RECIPE.model = "models/n7/vorti_outfit/meat02.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["antlion_skewer"] = 3, ["comp_rivbolts"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_meat02"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full XP
	{level = 10, exp = 150}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_bandanna"
RECIPE.name = "Bandana dla Vortigaunta"
RECIPE.description = "Dyskrecja to podstawa, nikt nie chciałby wiedzieć, że napada Cię Vortigaunt."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_bandana"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_helmet"
RECIPE.name = "Hełm Vortigaunta"
RECIPE.description = "Ochrona przed praktycznością, z dużą ilością szczęścia przeciwnik będzie mierzył troche wyżej."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 3, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_head_helmet"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_kevlar"
RECIPE.name = "Pancerz Vortigaunta"
RECIPE.description = "Nie ma strachu przed ciemnościa jednak też nie ma powodu aby szybciej ją zobaczyć, podstawowy zestaw pancerza używany przez ludzi."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 1, ["comp_steel"] = 3, ["comp_rivbolts"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_vest"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full XP
	{level = 40, exp = 75}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_labcoat2"
RECIPE.name = "Fartuch Vortigaunta"
RECIPE.description = "Strój dla Vortigaunta naukowca."
RECIPE.model = "models/willardnetworks/clothingitems/torso_labcoat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_doc2"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_labcoat"
RECIPE.name = "Fartuch Vortigaunta z odznaką"
RECIPE.description = "Strój dla Vortigaunta naukowca, ten jest razem z odznaką."
RECIPE.model = "models/willardnetworks/clothingitems/torso_labcoat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_doc"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_chef_hat"
RECIPE.name = "Czapka szefa kuchni dla Vortigaunta"
RECIPE.description = "Vortigaunty znane są z ich zamiłowania do gotowania, tym razem może to nawet pokazać przez swój ubiór."
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_head_chefhat"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_hoodie"
RECIPE.name = "Bluza Vortigaunta"
RECIPE.description = "Specjalnie zrobiona bluza z dłuższą szyją tak aby pasowała na Vortigaunta, utrzyma go przy cieple nawet w najtrudniejszych warunkach."
RECIPE.model = "models/n7/vorti_outfit/hoodie.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 3, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_hoodie"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 70}, -- full XP
	{level = 20, exp = 35}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_trench_coat"
RECIPE.name = "Brązowy płaszcz Vortigaunta"
RECIPE.description = "Blady wytarty płaszcz, pomoże Vortigauntowi wtopić się w tłum."
RECIPE.model = "models/willardnetworks/clothingitems/torso_refugee_coat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_stitched_cloth"] = 4, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light3_tc"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_poncho"
RECIPE.name = "Ponczo Vortigaunta"
RECIPE.description = "Ponczo stworzone ze znalezionych kawałków materiału pozszywanego razem ze sobą. Luźny design i wygodne wycięcia pozwalają na komfort i swobodę ruchów."
RECIPE.model = "models/n7/vorti_outfit/light01.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 2, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full XP
	{level = 20, exp = 25}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_covering"
RECIPE.name = "Własnoręczna narzuta Vortigaunta"
RECIPE.description = "Proste, zwykłe okrycie. Dobre do tego, by zapewnić ci przytulność w chłodną noc i niewiele więcej."
RECIPE.model = "models/n7/vorti_outfit/light02.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 2, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light2"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_armour"
RECIPE.name = "Płyta ochronna z antiliona dla Vortigaunta"
RECIPE.description = "Stworzona z pancerza antiliona nie tylko zapewnia pancerz ale również pokazuje prawdziwego wojownika."
RECIPE.model = "models/n7/vorti_outfit/armor.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["ing_antlion_meat"] = 8, ["comp_steel"] = 3, ["comp_rivbolts"] = 2, ["comp_fabric"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_armor"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 300}, -- full XP
	{level = 40, exp = 150}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}

RECIPE:Register()