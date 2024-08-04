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
RECIPE.name = "Uniforme - Kevlar Bleu"
RECIPE.description = "Un haut bleu avec du kevlar, offrant une armure décente."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_torso_2.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Armure"
RECIPE.station = "tool_metalbench"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["torso_blue_rebel_uniform"] = 1, ["comp_strong_adhesive"] = 1, ["comp_refined_metal"] = 2, ["comp_improved_nails_screws"] = 2, ["comp_fabric"] = 1}
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
RECIPE.name = "Uniforme - Kevlar Vert"
RECIPE.description = "Un haut vert avec du kevlar, offrant une armure décente. Souvent porté par des figures de la résistance."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_torso_1.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Armure"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["torso_green_rebel_uniform"] = 1, ["comp_strong_adhesive"] = 1, ["comp_reshaped_metal"] = 4, ["comp_improved_nails_screws"] = 1}
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
RECIPE.name = "Uniforme - Kevlar Médical"
RECIPE.description = "Un haut médical avec un kevlar, offrant une armure décente. Souvent porté par les médecins de la résistance."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel_medic.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Armure"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["torso_medical_rebel_uniform"] = 1, ["comp_strong_adhesive"] = 1, ["comp_reshaped_metal"] = 4, ["comp_improved_nails_screws"] = 1}
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