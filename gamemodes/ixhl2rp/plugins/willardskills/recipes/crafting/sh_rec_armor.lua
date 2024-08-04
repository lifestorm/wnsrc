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

RECIPE.uniqueID = "rec_armor_blue_kevlar"
RECIPE.name = "Lekka niebieska kamizelka"
RECIPE.description = "Lekka niebieska kamizelka, często noszona przez ruch oporu."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_torso_2.mdl"
RECIPE.category = "Pancerz"
RECIPE.station = "tool_metalbench"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["torso_blue_rebel_uniform"] = 1, ["comp_adhesive"] = 1, ["comp_iron"] = 4, ["comp_rivbolts"] = 1}
RECIPE.result = {["torso_blue_kevlar"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_armor_green_kevlar"
RECIPE.name = "Lekka zielona kamizelka"
RECIPE.description = "Lekka zielona kamizelka, często noszona przez ruch oporu."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_torso_1.mdl"
RECIPE.category = "Pancerz"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["torso_green_rebel_uniform"] = 1, ["comp_adhesive"] = 1, ["comp_iron"] = 4, ["comp_rivbolts"] = 1}
RECIPE.result = {["torso_green_kevlar"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_armor_medical_kevlar"
RECIPE.name = "Lekka kamizelka z oznaczeniem medyka"
RECIPE.description = "Lekka kamizelka z medycznym krzyżem, często noszona przez medyków ruchu oporu."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_medic.mdl"
RECIPE.category = "Pancerz"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["torso_medical_rebel_uniform"] = 1, ["comp_adhesive"] = 1, ["comp_iron"] = 4, ["comp_rivbolts"] = 1}
RECIPE.result = {["torso_medical_kevlar"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()
/*
local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c8_com_rebel"
RECIPE.name = "C8 Command Unit suit paintjob"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_c8_com"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_riot_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c8_cp_rebel"
RECIPE.name = "C8 CP suit paintjob"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_c8_cp"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c8_cpt_rebel"
RECIPE.name = "C8 CPT suit paintjob"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_c8_cpt"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_riot_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c8_riot_rebel"
RECIPE.name = "C8 riot suit paintjob"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_c8_riot"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_riot_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c8_rl_rebel"
RECIPE.name = "C8 RL suit paintjob"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_c8_rl"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_riot_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()
*/
local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c24_com_rebel"
RECIPE.name = "Malowanie średniego munduru jednostki Dowodzącej C24"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_com"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_riot_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c24_com_rebel2"
RECIPE.name = "Malowanie lekkiego munduru jednostki Dowodzącej C24"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_cp_com"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_riot_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c24_riot_rebel"
RECIPE.name = "Malowanie munduru Riot C24"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_cp_riot"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_riot_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c24_cp_rebel"
RECIPE.name = "Malowanie mundur CP C24"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_cp"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mask_com_rebel"
RECIPE.name = "Odzysk maski jednostki Dowódzctwa"
RECIPE.description = "Maska Civil Protection, która została odzyskana i pomalowana, aby łatwo zidentyfikować kogoś jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice/n7_cp_gasmask7.mdl"
RECIPE.category = "Pancerz"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["mask_com"] = 1}
RECIPE.result = {["mask_com_rebel"] = 1, ["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mask_cp_rebel"
RECIPE.name = "Odzysk maski CP"
RECIPE.description = "Maska Civil Protection, która została odzyskana i pomalowana, aby łatwo zidentyfikować kogoś jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice/n7_cp_gasmask1.mdl"
RECIPE.category = "Pancerz"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["mask_cp"] = 1}
RECIPE.result = {["mask_cp_rebel"] = 1, ["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mask_ota_rebel"
RECIPE.name = "Odzysk maski OTA"
RECIPE.description = "Maska OTA, która została odzyskana i pomalowana, tak aby łatwo zidentyfikować noszącego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice/n7_cp_gasmask4.mdl"
RECIPE.category = "Pancerz"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["mask_ota"] = 1, }
RECIPE.result = {["mask_ota_rebel"] = 1, ["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_cpt_rebel"
RECIPE.name = "Malowanie munduru CPT"
RECIPE.description = "Mundur Civil Protection, który został pomalowany, tak aby łatwo zidentyfikować nosząego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["uniform_ofc"] = 1, ["comp_fabric"] = 1, ["comp_iron"] = 1}
RECIPE.result = {["uniform_cp_riot_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_repair_cp_rebel"
RECIPE.name = "Naprawa munduru CP"
RECIPE.description = "Mundur Civil Protection, który został naprawiony i pomalowany, tak aby łatwo zidentyfikować noszącego jako bojownika ruchu oporu."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Pancerz"
RECIPE.ingredients = {["broken_cpuniform"] = 1, ["comp_adhesive"] = 1, ["comp_steel"] = 2, ["comp_rivbolts"] = 1}
RECIPE.result = {["uniform_cp_rebel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}

RECIPE:Register()