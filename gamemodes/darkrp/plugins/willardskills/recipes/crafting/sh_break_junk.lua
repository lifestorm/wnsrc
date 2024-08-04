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

RECIPE.uniqueID = "rec_junk_tv"
RECIPE.name = "Écran de TV détruit"
RECIPE.description = "Vous donne : 2 verres - 2 électroniques - 2 plastiques - 2 férailles"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_tv"] = 1}
RECIPE.result = {["comp_glass"] = 2, ["comp_electronics"] = 2, ["comp_plastic"] = 2, ["comp_metal"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 55}, -- full xp
	{level = 20, exp = 27}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_toy"
RECIPE.name = "Jouet détruit"
RECIPE.description = "Vous donne : 1 bois - 1 tas de vis"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_toy"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tire"
RECIPE.name = "Pneu détruit"
RECIPE.description = "Vous donne : 4 plastiques"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["junk_tire"] = 1}
RECIPE.result = {["comp_plastic"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tincan"
RECIPE.name = "Vieille boîte de conserve"
RECIPE.description = "Vous donne : 1 féraille"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_tincan"] = 1}
RECIPE.result = {["comp_metal"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_takeaway"
RECIPE.name = "Vieille boîte de nouilles"
RECIPE.description = "Vous donne : 1 tissu sale"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_takeaway"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_sm_cardboard"
RECIPE.name = "Boîte en carton"
RECIPE.description = "Vous donne : 1 tissu sale"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_sm_cardboard"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_shoe"
RECIPE.name = "Chaussure détruite"
RECIPE.description = "Vous donne : 1 tissu sale"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_shoe"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_receiver"
RECIPE.name = "Récepteur"
RECIPE.description = "Vous donne : 1 tas de vis - 2 électroniques - 2 férailles"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_receiver"] = 1}
RECIPE.result = {["comp_nails_screws"] = 1, ["comp_electronics"] = 2, ["comp_metal"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plastic_bucket"
RECIPE.name = "Seau en plastique"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_plastic_bucket"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plasticcrate"
RECIPE.name = "Caisse en plastique"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_plasticcrate"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plantpot"
RECIPE.name = "Pot de fleurs"
RECIPE.description = "Vous donne : 1 verre"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_plantpot"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_pipe"
RECIPE.name = "Tuyau en métal fragile"
RECIPE.description = "Vous donne : 4 férailles"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_pipe"] = 1}
RECIPE.result = {["comp_metal"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_tattered_drawer"
RECIPE.name = "Tirroir"
RECIPE.description = "Vous donne : 2 bois"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_tattered_drawer"] = 1}
RECIPE.result = {["comp_wood"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_paintcan"
RECIPE.name = "Pot de peinture"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_paintcan"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_mug"
RECIPE.name = "Tasse"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_mug"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_pc_monitor"
RECIPE.name = "Moniteur de PC"
RECIPE.description = "Vous donne : 3 plastiques - 3 verres - 3 électroniques - 2 férailles - 1 tas de vis"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_pc_monitor"] = 1}
RECIPE.result = {["comp_plastic"] = 3, ["comp_glass"] = 3, ["comp_electronics"] = 3, ["comp_metal"] = 2, ["comp_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_lamp"
RECIPE.name = "Lampe grillée"
RECIPE.description = "Vous donne : 2 plastiques - 1 tas de vis - 2 férailles"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_lamp"] = 1}
RECIPE.result = {["comp_plastic"] = 2, ["comp_nails_screws"] = 1, ["comp_metal"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_keyboard"
RECIPE.name = "Clavier"
RECIPE.description = "Vous donne : 2 électroniques - 2 plastiques - 2 férailles - 1 tas de vis"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_keyboard"] = 1}
RECIPE.result = {["comp_electronics"] = 2, ["comp_plastic"] = 2, ["comp_metal"] = 2, ["comp_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_jug"
RECIPE.name = "Bidon en plastique"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_jug"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_jar"
RECIPE.name = "Pot vide"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_jar"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_green_bottle"
RECIPE.name = "Bouteille en verre"
RECIPE.description = "Vous donne : 1 verre"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_green_bottle"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_vodka"
RECIPE.name = "Bouteille de vodka vide"
RECIPE.description = "Vous donne : 1 verre"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_empty_vodka"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_beer"
RECIPE.name = "Bière vide"
RECIPE.description = "Vous donne : 1 verre"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_empty_beer"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_bourbon"
RECIPE.name = "Bouteille de bourbon vide"
RECIPE.description = "Vous donne : 1 verre"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_empty_bourbon"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_fruitjuice"
RECIPE.name = "Bouteille en carton"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_empty_fruitjuice"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_emptyvial"
RECIPE.name = "Fiole de soins"
RECIPE.description = "Vous donne : 1 verre."
RECIPE.model = "models/willardnetworks/syringeemptyy.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_emptyvial"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_whiskey"
RECIPE.name = "Bouteille de whisky vide"
RECIPE.description = "Vous donne : 1 verre"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_empty_whiskey"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_wine"
RECIPE.name = "Bouteille de vin vide"
RECIPE.description = "Vous donne : 1 verre"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_empty_wine"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_gear"
RECIPE.name = "Engrenage"
RECIPE.description = "Vous donne : 3 fers"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_gear"] = 1}
RECIPE.result = {["comp_metal"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 40}, -- full xp
	{level = 20, exp = 20}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_gascan"
RECIPE.name = "Bidon d'essence"
RECIPE.description = "Vous donne : 3 férailles"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_gascan"] = 1}
RECIPE.result = {["comp_metal"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_fridge_door"
RECIPE.name = "Porte de réfrigérateur"
RECIPE.description = "Vous donne : 4 férailles - 1 tas de vis"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_fridgedoor"] = 1}
RECIPE.result = {["comp_metal"] = 4, ["comp_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 40, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_frame"
RECIPE.name = "Cadre"
RECIPE.description = "Vous donne : 1 bois - 1 tas de vis"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_frame"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_biolock"
RECIPE.name = "Bio-lock brisé"
RECIPE.description = "Vous donne : 4 morceaux de feraille - 2 circuits electronique - 1 tas de vis "
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["trash_biolock"] = 1}
RECIPE.result = {["comp_metal"] = 4, ["comp_electronics"] = 2, ["comp_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_doll"
RECIPE.name = "Poupée"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_doll"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_coffeecup"
RECIPE.name = "Tasse à café vide"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_coffeecup"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_computerparts"
RECIPE.name = "Pièces d'ordinateur "
RECIPE.description = "Vous donne : 2 électroniques"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_computerparts"] = 1}
RECIPE.result = {["comp_electronics"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 70}, -- full xp
	{level = 10, exp = 35}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_computer_tower"
RECIPE.name = "Tour d'ordinateur cassée"
RECIPE.description = "Vous donne : 3 électroniques - 3 férailles"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_computer_tower"] = 1}
RECIPE.result = {["comp_electronics"] = 3, ["comp_metal"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_clock"
RECIPE.name = "Horloge"
RECIPE.description = "Vous donne : 1 bois - 2 électronique - 1 tas de vis"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_clock"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_electronics"] = 2, ["comp_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_carton"
RECIPE.name = "Carton de lait vide"
RECIPE.description = "Vous donne : 1 tissu sale"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_carton"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_cardboard"
RECIPE.name = "Carton vide"
RECIPE.description = "Vous donne : 1 tissu sale"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_cardboard"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_bucket"
RECIPE.name = "Seau"
RECIPE.description = "Vous donne : 2 férailles"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_bucket"] = 1}
RECIPE.result = {["comp_metal"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_brown_bottle"
RECIPE.name = "Bouteille marron"
RECIPE.description = "Vous donne : 1 verre"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_brown_bottle"] = 1}
RECIPE.result = {["comp_glass"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_empty_water"
RECIPE.name = "Canette d'eau vide"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["crafting_water"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_cigarettepack"
RECIPE.name = "Paquet de cigarette vide"
RECIPE.description = "Vous donne : 1 tissu sale"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["ciggie_pack"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_plushie"
RECIPE.name = "Un doudou en forme de tortue"
RECIPE.description = "Vous donne : 1 tissu sale"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.ingredients = {["junk_turtle"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_battery"
RECIPE.name = "Batterie de voiture"
RECIPE.description = "Vous donne : 2 férailles - 1 produit chimique brut"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Déchets"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_battery"] = 1}
RECIPE.result = {["comp_metal"] = 2, ["comp_unrefinedchemical"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()