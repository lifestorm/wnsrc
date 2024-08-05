--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:GenerateRecipes() -- Make sure crafting is initialized before we try to add recipes.
	local RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "rec_leech_adhesive"
	RECIPE.name = "Leech-Based Adhesive"
	RECIPE.description = "An adhesive for sticking objects together. Very sticky."
	RECIPE.model = "models/willardnetworks/props/glue.mdl"
	RECIPE.category = "Components"
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["ing_raw_leech"] = 3}
	RECIPE.result = {["comp_adhesive"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "crafting"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "rec_coarctate_mucus"
	RECIPE.name = "Coarctate Mucus"
	RECIPE.description = "A rather sticky and strong smelling mucus like fluid. To the trained eye, it seems to have some medicine applications"
	RECIPE.model = "models/jq/hlvr/props/xenpack/xen_bulb002.mdl"
	RECIPE.category = "Medical"
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["ic_cluster_hive"] = 1}
	RECIPE.result = {["ic_coarctate_mucus"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "crafting"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "break_mucus_alcohol"
	RECIPE.name = "Extract Erebus Mucus"
	RECIPE.description = "Extract the alcohol from the Erebus Mucus."
	RECIPE.model = "models/props_lab/jar01a.mdl"
	RECIPE.category = "Alcohol/chemical extraction"
	RECIPE.subcategory = "Alcohol"
	RECIPE.station = {"tool_oven", "tool_oven_rusty"}
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["crafting_water"] = 1}
	RECIPE.result = {["comp_alcohol"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "medicine"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "rec_strong_adhesive"
	RECIPE.name = "Strong Adhesive"
	RECIPE.description = "A stronger adhesive from sticking objects together. Very sticky."
	RECIPE.model = "models/willardnetworks/props/spicyglue.mdl"
	RECIPE.category = "Components"
	RECIPE.ingredients = {["comp_adhesive"] = 1, ["ic_cluster_hive"] = 1}
	RECIPE.result = {["comp_adhesive"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "crafting"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "break_cluster_mucus_chemical"
	RECIPE.name = "Extract Cluster Hive/Erebus Mucus"
	RECIPE.description = "Extract unrefined chemical compounds from these two alien substances."
	RECIPE.model = "models/jq/hlvr/props/xenpack/xen_bulb002.mdl"
	RECIPE.category = "Alcohol/chemical extraction"
	RECIPE.subcategory = "Unrefined Chemicals"
	RECIPE.station = {"tool_oven", "tool_oven_rusty"}
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["ic_cluster_hive"] = 1}
	RECIPE.result = {["comp_chemicals"] = 2}
	RECIPE.hidden = false
	RECIPE.skill = "medicine"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "rec_comp_purifier_cluster"
	RECIPE.name = "Purifier"
	RECIPE.description = "Strange dust which can purify any mixture or substance of any toxic compounds."
	RECIPE.model = "models/willardnetworks/skills/pill_bottle.mdl"
	RECIPE.category = "Components"
	RECIPE.ingredients = {["ic_cluster_hive"] = 1, ["comp_chemicals"] = 1}
	RECIPE.result = {["comp_purifier"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "crafting"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()
end
