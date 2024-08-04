--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_ref_reshaped_metal"
RECIPE.name = "Ferraille"
RECIPE.description = "Ferraille créée à partir de métal recyclé. Elle est plus lourde et résistante qu'avant."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Raffiné"
RECIPE.station = "tool_refinery"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_metal"] = 6, ["comp_nails_screws"] = 2}
RECIPE.result = {["comp_reshaped_metal"] = 2}
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 100},
    {level = 50, exp = 0}
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ref_refined_metal"
RECIPE.name = "Feuille de métal"
RECIPE.description = "Feuille de métal créée à partir de ferraille recyclée. Elle est bien plus résistante qu'avant."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Raffiné"
RECIPE.station = "tool_refinery"
RECIPE.ingredients = {["comp_reshaped_metal"] = 6, ["comp_strong_adhesive"] = 2}
RECIPE.result = {["comp_refined_metal"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 100}
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ref_weapon_parts"
RECIPE.name = "Composants d'armes"
RECIPE.description = "Composants métalliques utilisés dans les armes à feu."
RECIPE.model = "models/willardnetworks/skills/weaponparts.mdl"
RECIPE.category = "Raffiné"
RECIPE.station = "tool_refinery"
RECIPE.ingredients = {["comp_refined_metal"] = 2, ["comp_strong_adhesive"] = 2, ["comp_improved_nails_screws"] = 2, ["comp_craftwork_wood"] = 2, ["comp_refined_plastic"] = 1}
RECIPE.result = {["comp_weapon_parts"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
    {level = 40, exp = 250},
	{level = 50, exp = 0}
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ref_explosive_material"
RECIPE.name = "Composants explosifs"
RECIPE.description = "Du composant pouvant résulter en une explosion. Ne jouez pas avec ça."
RECIPE.model = "models/willardnetworks/skills/explosive_material.mdl"
RECIPE.category = "Raffiné"
RECIPE.station = "tool_refinery"
RECIPE.ingredients = {["comp_redcompound"] = 2, ["comp_yellowcompound"] = 1, ["comp_bluecompound"] = 1, ["comp_greencompound"] = 2}
RECIPE.result = {["comp_explosive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 150}, -- full xp
	{level = 50, exp = 0}
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ref_grenadecase"
RECIPE.name = "Grenade vide"
RECIPE.description = "Un objet métallique en forme de grenade, vide."
RECIPE.model = "models/weapons/tfa_mmod/w_grenade_thrown.mdl"
RECIPE.category = "Raffiné"
RECIPE.station = "tool_refinery"
RECIPE.ingredients = {["comp_refined_metal"] = 2, ["comp_strong_adhesive"] = 2}
RECIPE.result = {["comp_grenadecase"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 100}, -- full xp
	{level = 50, exp = 0}
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_ref_nails_screws"
RECIPE.name = "Boîte de clous"
RECIPE.description = "Une boîte contenant des clous légèrement rouillés."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Raffiné"
RECIPE.station = "tool_refinery"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_metal"] = 2, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_nails_screws"] = 3}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full XP
	{level = 40, exp = 50}, -- half XP
	{level = 50, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_ref_improved_nails_screws"
RECIPE.name = "Boîte de vis"
RECIPE.description = "Une boîte contenant des vis, pouvant être utilisés par des artisans compétents."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Raffiné"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_refinery"
RECIPE.ingredients = {["comp_nails_screws"] = 6, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_improved_nails_screws"] = 2}
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 80}, -- full XP
	{level = 50, exp = 0}
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_ref_refined_plastic"
RECIPE.name = "Feuilles de plastique"
RECIPE.description = "Des feuilles de plastique créées à partir de détritus en plastique."
RECIPE.model = "models/props_junk/garbage_bag001a.mdl"
RECIPE.category = "Raffiné"
RECIPE.station = "tool_refinery"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_plastic"] = 6, ["comp_adhesive"] = 2}
RECIPE.result = {["comp_refined_plastic"] = 2}
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 100}, -- full XP
	{level = 50, exp = 0}
}
RECIPE:Register()
