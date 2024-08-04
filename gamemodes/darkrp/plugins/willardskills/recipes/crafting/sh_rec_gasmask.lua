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
RECIPE.uniqueID = "rec_clothing_gasmask"
RECIPE.name = "Masque à gaz"
RECIPE.description = "Fournit une légère protection contre les vapeurs nocives, les gaz et certaines odeurs nauséabondes."
RECIPE.model = "models/willardnetworks/clothingitems/head_gasmask.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Masque à gaz"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_reshaped_metal"] = 1, ["comp_plastic"] = 2, ["comp_strong_adhesive"] = 1}
RECIPE.result = {["head_gasmask"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 30, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_clothing_gasmask2"
RECIPE.name = "Masque à gaz M40"
RECIPE.description = "Fournit une protection adéquate contre les vapeurs nocives, les gaz et certaines odeurs nauséabondes."
RECIPE.model = "models/willardnetworks/clothingitems/m40_item.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Masque à gaz"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_reshaped_metal"] = 1, ["comp_plastic"] = 2, ["comp_strong_adhesive"] = 1}
RECIPE.result = {["head_gasmask2"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 30, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_charcoal_refill"
RECIPE.name = "Recharge de filtre à charbon"
RECIPE.description = "Enveloppe un charbon de bois dans une cartouche filtrante."
RECIPE.model = "models/gibs/shield_scanner_gib1.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Masque à gaz"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_charcoal"] = 1, ["comp_stitched_cloth"] = 1, ["comp_strong_adhesive"] = 1}
RECIPE.result = {["comp_charcoal_refill"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 40}, -- full XP
	{level = 30, exp = 20}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_makeshift_filter"
RECIPE.name = "Filtre de fortune"
RECIPE.description = "Un filtre de masque à gaz fait maison, que vous pouvez ouvrir pour remplir."
RECIPE.model = "models/willardnetworks/props/sovietfilter.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Masque à gaz"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_charcoal_refill"] = 1, ["comp_reshaped_metal"] = 2, ["comp_strong_adhesive"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.result = {["makeshift_filter"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full XP
	{level = 30, exp = 125}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_makeshift_filter"
RECIPE.name = "Filtre de fortune"
RECIPE.description = "Vous donne : 1 tissu - 1 métal"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["makeshift_filter"] = 1}
RECIPE.result = {["comp_cloth"] = 1, ["comp_metal"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_highquality_filter"
RECIPE.name = "Filtre de ventilation de haute qualité"
RECIPE.description = "Vous donne : 1 tissu - 1 métal"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["highquality_filter"] = 1}
RECIPE.result = {["comp_cloth"] = 1, ["comp_metal"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()