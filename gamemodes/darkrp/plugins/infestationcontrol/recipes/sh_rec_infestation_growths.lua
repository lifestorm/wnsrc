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
	RECIPE.name = "Adhésif à base de sangsue"
	RECIPE.description = "Un adhésif fait à base de sangsue pour coller des objets ensemble."
	RECIPE.model = "models/willardnetworks/props/glue.mdl"
	RECIPE.category = "Matériaux"
	RECIPE.subcategory = "Adhésif"
	RECIPE.ingredients = {["ic_erebus_mucus"] = 3, ["ing_raw_leech"] = 6}
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
	RECIPE.name = "Mucus coarcté"
	RECIPE.description = "Un mucus plutôt collant et à forte odeur comme un liquide. Il semble avoir des applications médicales"
	RECIPE.model = "models/jq/hlvr/props/xenpack/xen_bulb002.mdl"
	RECIPE.category = "Médicale"
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
	RECIPE.name = "Alcool - Erebus"
	RECIPE.description = "Extrait de l'alcool du mucus Erebus."
	RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
	RECIPE.category = "Susbtances liquides"
	RECIPE.subcategory = "Alcool"
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
	RECIPE.name = "Adhésif fort"
	RECIPE.description = "Un adhésif plus fort que les autres, utilisés pour l'artisanat."
	RECIPE.model = "models/willardnetworks/props/spicyglue.mdl"
	RECIPE.category = "Matériaux"
	RECIPE.subcategory = "Adhésif"
	RECIPE.ingredients = {["comp_adhesive"] = 1, ["ic_cluster_hive"] = 1}
	RECIPE.result = {["comp_strong_adhesive"] = 1}
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
	RECIPE.name = "Extrait de cluster du Mucus Erebus"
	RECIPE.description = "Extrayez des composés chimiques non raffinés de cette substance extraterrestre."
	RECIPE.model = "models/props_junk/garbage_plasticbottle001a.mdl"
	RECIPE.category = "Susbtances liquides"
	RECIPE.subcategory = "Non Raffinés"
	RECIPE.station = {"tool_oven", "tool_oven_rusty"}
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["ic_cluster_hive"] = 1}
	RECIPE.result = {["comp_unrefinedchemical"] = 2}
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
	RECIPE.name = "Purificateur"
	RECIPE.description = "Poussière étrange qui peut purifier n'importe quel mélange ou substance de n'importe quel composé toxique."
	RECIPE.model = "models/willardnetworks/skills/pill_bottle.mdl"
	RECIPE.category = "Utilitaires"
	RECIPE.subcategory = "Outils"
	RECIPE.ingredients = {["ic_cluster_hive"] = 1, ["comp_unrefinedchemical"] = 1}
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
