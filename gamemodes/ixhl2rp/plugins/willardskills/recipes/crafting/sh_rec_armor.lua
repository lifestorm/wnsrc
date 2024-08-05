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
RECIPE.name = "Blue Light Kevlar Uniform"
RECIPE.description = "A blue top with kevlar, offering decent armor. Often worn by resistance figures."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_torso_2.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "Green Light Kevlar Uniform"
RECIPE.description = "A green top with kevlar, offering decent armor. Often worn by resistance figures."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_torso_1.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "Medical Light Kevlar Uniform"
RECIPE.description = "A medical top with a kevlar, offering decent armor. Often worn by resistance medics."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_medic.mdl"
RECIPE.category = "Armor"
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

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c8_com_rebel"
RECIPE.name = "C8 Command Unit suit paintjob"
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_c24_com_rebel"
RECIPE.name = "C24 Medium Command Unit suit paintjob"
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "C24 Light Command Unit suit paintjob"
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "C24 Riot suit paintjob"
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "C24 CP suit paintjob"
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "Command Unit Mask salvaging"
RECIPE.description = "A Civil Protection mask that's been salvaged and painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice/n7_cp_gasmask7.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "CP Mask salvaging"
RECIPE.description = "A Civil Protection mask that's been salvaged and painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice/n7_cp_gasmask1.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "OTA Mask salvaging"
RECIPE.description = "A OTA mask that's been salvaged and painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice/n7_cp_gasmask4.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "CPT suit paintjob"
RECIPE.description = "A Civil Protection suit that's been painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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
RECIPE.name = "CP Uniform Repair"
RECIPE.description = "A Civil Protection suit that's been repaired and painted to easily identify someone as a resistance fighter."
RECIPE.model = "models/wn7new/metropolice_c8/cpuniform.mdl"
RECIPE.category = "Armor"
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