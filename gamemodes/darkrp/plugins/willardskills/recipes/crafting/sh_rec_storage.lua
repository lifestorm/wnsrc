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
RECIPE.uniqueID = "rec_craft_suitcase"
RECIPE.name = "Valise"
RECIPE.description = "Une petite valise, parfaite pour transporter des petites choses."
RECIPE.model = "models/weapons/w_suitcase_passenger.mdl"
RECIPE.category = "Stockage"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_cloth"] = 3, ["comp_plastic"] = 2, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["suitcase"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full XP
	{level = 15, exp = 40}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_small_bag"
RECIPE.name = "Petite sacoche"
RECIPE.description = "Une petite sacoche qui repose sur votre hanche."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Stockage"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 3, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["smallbag"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full XP
	{level = 15, exp = 40}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_large_bag"
RECIPE.name = "Grand sac"
RECIPE.description = "Un sac à dos avec l'insigne de l'Union dessus."
RECIPE.model = "models/willardnetworks/clothingitems/backpack.mdl"
RECIPE.category = "Stockage"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_fabric"] = 2, ["comp_strong_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["largebag"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 25, exp = 50}, -- half XP
	{level = 30, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_lock"
RECIPE.name = "Cadenas"
RECIPE.description = "Définit un mot de passe sur un conteneur lorsqu'il est utilisé. Peut être cassé mais seulement si le propriétaire est en ligne."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Stockage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_reshaped_metal"] = 2, ["comp_adhesive"] = 2, ["comp_plastic"] = 2}
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_small"
RECIPE.name = "Petite armoire"
RECIPE.description = "Armoire de taille 3x3. Contactez un administrateur pour configurer cette armoire lorsque vous aurez fabriqué cet objet. Nécessite un cadenas pour définir un mot de passe."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Stockage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_reshaped_metal"] = 2, ["comp_refined_plastic"] = 2, ["comp_strong_adhesive"] = 1, ["comp_improved_nails_screws"] = 3}
RECIPE.result = {["container_small_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 25, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_medium"
RECIPE.name = "Armoire Moyenne"
RECIPE.description = "Armoire de taille 6x3. Contactez un administrateur pour configurer cette armoire lorsque vous aurez fabriqué cet objet. Nécessite un cadenas pour définir un mot de passe."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Stockage"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["container_small_dummy"] = 2, ["comp_improved_nails_screws"] = 2}
RECIPE.result = {["container_medium_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 125}, -- full xp
	{level = 35, exp = 60}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_large"
RECIPE.name = "Grande Armoire"
RECIPE.description = "Nécessite un groupe de 5 membres et plus - Armoire de taille 8x5. Contactez un administrateur pour configurer cette armoire lorsque vous aurez fabriqué cet objet. Nécessite un cadenas pour définir un mot de passe."
RECIPE.model = "models/props_wasteland/controlroom_storagecloset001a.mdl"
RECIPE.category = "Stockage"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["container_medium_dummy"] = 2, ["comp_improved_nails_screws"] = 2}
RECIPE.result = {["container_large_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 200}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_scrate"
RECIPE.name = "Caisse standard"
RECIPE.description = "Caisse de taille 6x6. Contactez un administrateur pour configurer cette caisse lorsque vous aurez fabriqué cet objet. Nécessite un cadenas pour définir un mot de passe."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Stockage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["container_medium_dummy"] = 1, ["comp_craftwork_wood"] = 2}
RECIPE.result = {["container_scrate_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 25, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_lcrate"
RECIPE.name = "Grande Caisse"
RECIPE.description = "Nécessite un groupe de 5 membres et plus - Caisse de taille 9x9. Contactez un administrateur pour configurer cette caisse. Nécessite un cadenas pour définir un mot de passe."
RECIPE.model = "models/props_junk/wood_crate002a.mdl"
RECIPE.category = "Stockage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["container_large_dummy"] = 1, ["comp_craftwork_wood"] = 3}
RECIPE.result = {["container_lcrate_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 200}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_safe"
RECIPE.name = "Coffre"
RECIPE.description = "Un coffre-fort incassable pour garder vos objets. (Vous pouvez avoir 2 coffres-forts en plus de la limite du conteneur.)"
RECIPE.model = "models/willardnetworks/safe.mdl"
RECIPE.category = "Stockage"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_refined_metal"] = 4, ["comp_refined_plastic"] = 3, ["comp_electronics"] = 1, ["comp_improved_nails_screws"] = 2}
RECIPE.result = {["container_safe"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full xp
	{level = 50, exp = 0},
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_grouplock"
RECIPE.name = "Verrouillage de groupe"
RECIPE.description = "Un appareil métallique appliqué aux portes. Nécessite un groupe pour fonctionner."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Stockage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["trash_biolock"] = 1, ["comp_electronics"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["grouplock"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()