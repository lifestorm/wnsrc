--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Métal --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_reshaped_metal"
RECIPE.name = "Fer"
RECIPE.description = "Fer fabriqué à partir de métal recyclé. Il est plus solide et plus lourd qu'avant."
RECIPE.model = "models/willardnetworks/props/reshaped_metal.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Métaux"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_metal"] = 4, ["comp_nails_screws"] = 1}
RECIPE.result = {["comp_reshaped_metal"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full XP
	{level = 30, exp = 40}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_refined_metal"
RECIPE.name = "Acier"
RECIPE.description = "Acier trempé fabriqué par un excellent raffineur. Extrêmement solide et bien fait."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Métaux"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_reshaped_metal"] = 4, ["comp_strong_adhesive"] = 1}
RECIPE.result = {["comp_refined_metal"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 40, exp = 50}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

-- Plastique --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_refined_plastic"
RECIPE.name = "Feuilles de plastique"
RECIPE.description = "Feuilles de plastique. Fabriqué à partir de déchets plastiques."
RECIPE.model = "models/willardnetworks/food/snack01.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Plastique"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_plastic"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_refined_plastic"] = 1}
RECIPE.level = 15
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

-- Vis --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_nails_screws"
RECIPE.name = "Tas de vis"
RECIPE.description = "Une boîte contenant des vis. Ils ont l'air un peu rouillés."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Vis & Boulons"
RECIPE.tool = "tool_toolkit"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_metal"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_nails_screws"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_improved_nails_screws"
RECIPE.name = "Boîte de boulons"
RECIPE.description = "Une boîte de boulons robustes, utile pour les artisans expérimentés."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Vis & Boulons"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_nails_screws"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_improved_nails_screws"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full XP
	{level = 30, exp = 40}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

-- Tissus --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_stitched_cloth"
RECIPE.name = "Tissu cousu"
RECIPE.description = "Un morceau de tissu cousu. C'est plus solide qu'avant."
RECIPE.model = "models/willardnetworks/skills/stitched_cloth.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Tissus"
RECIPE.tool = "tool_scissors"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_cloth"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_stitched_cloth"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_fabric"
RECIPE.name = "Tissu travaillé"
RECIPE.description = "Un morceau de tissu bien travaillé. C'est assez doux."
RECIPE.model = "models/willardnetworks/skills/fabric.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Tissus"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_stitched_cloth"] = 4, ["comp_adhesive"] = 2}
RECIPE.result = {["comp_fabric"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

-- Bois --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_craftwork_wood"
RECIPE.name = "Planche de bois"
RECIPE.description = "Planche de bois bien travaillé et lisse."
RECIPE.model = "models/props_debris/wood_board06a.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Bois"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_wood"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_craftwork_wood"] = 1}
RECIPE.level = 15
RECIPE.experience = {
	{level = 20, exp = 80}, -- full XP
	{level = 30, exp = 40}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

-- Armes --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_explosive_material"
RECIPE.name = "Composé explosif"
RECIPE.description = "Un composé explosif doux. Ne jouez pas avec des explosifs maintenant."
RECIPE.model = "models/willardnetworks/skills/explosive_material.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Armes"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_redcompound"] = 1, ["comp_yellowcompound"] = 1, ["comp_bluecompound"] = 1, ["comp_greencompound"] = 1}
RECIPE.result = {["comp_explosive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 40, exp = 75}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_weapon_parts"
RECIPE.name = "Pièces d'armes"
RECIPE.description = "Pièces en métal pour une arme."
RECIPE.model = "models/willardnetworks/skills/weaponparts.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Armes"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_refined_metal"] = 2, ["comp_strong_adhesive"] = 2, ["comp_improved_nails_screws"] = 2, ["comp_craftwork_wood"] = 2, ["comp_refined_plastic"] = 1}
RECIPE.result = {["comp_weapon_parts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_grenadecase"
RECIPE.name = "Étui à grenades vide"
RECIPE.description = "Une caisse de grenade vide."
RECIPE.model = "models/weapons/tfa_mmod/w_grenade_thrown.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Armes"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_refined_metal"] = 1, ["comp_strong_adhesive"] = 1}
RECIPE.result = {["comp_grenadecase"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 40, exp = 50}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_heavy_weapon_parts"
RECIPE.name = "Pièces d'armes lourdes"
RECIPE.description = "Une pièce d'arme lourde. On dirait qu'il pourrait être fait pour fabriquer des carabines, des fusils de chasse et autres"
RECIPE.model = "models/willardnetworks/skills/weaponparts.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Armes"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_refined_metal"] = 5, ["comp_improved_nails_screws"] = 3, ["comp_craftwork_wood"] = 2, ["comp_refined_plastic"] = 2}
RECIPE.result = {["comp_heavy_weapon_parts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 150}, -- full xp
	{level = 45, exp = 75}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

-- Charbon --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_charcoal"
RECIPE.name = "Bloc de charbon de bois"
RECIPE.description = "Bloc de charbon de bois en utilisé dans plusieurs buts."
RECIPE.model = "models/willardnetworks/props/charcoal.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Charbon"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["comp_wood"] = 1, ["comp_refinedchemical"] = 1}
RECIPE.result = {["comp_charcoal"] = 1}
RECIPE.level = 15
RECIPE.experience = {
	{level = 20, exp = 40}, -- full XP
	{level = 30, exp = 20}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

-- Adhésif --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_adhesive"
RECIPE.name = "Adhésif fait main"
RECIPE.description = "Un adhésif pour coller des objets ensemble, utilisé dans l'artisanat."
RECIPE.model = "models/willardnetworks/props/glue.mdl"
RECIPE.category = "Matériaux"
RECIPE.subcategory = "Adhésif"
RECIPE.ingredients = {["ing_flour"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["comp_adhesive"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 120}, -- full xp
	{level = 10, exp = 60}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()