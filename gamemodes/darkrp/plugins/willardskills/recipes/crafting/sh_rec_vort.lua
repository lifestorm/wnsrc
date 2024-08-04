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

RECIPE.uniqueID = "rec_craft_vort_meat01"
RECIPE.name = "Ceinture de soutien"
RECIPE.description = "Une collection de peaux de crabe de tête délicieuses et appétissantes, rassemblées de tous les coins."
RECIPE.model = "models/n7/vorti_outfit/meat01.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["headcrab_skewer"] = 3, ["comp_improved_nails_screws"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_meat01"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 200}, -- full XP
	{level = 10, exp = 100}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_meat02"
RECIPE.name = "Ceinture à viande des Terres Lointaines"
RECIPE.description = "Une denrée difficile à trouver sous le voile du Cartel, et d'une délicatesse chaque fois qu'elle est trouvée."
RECIPE.model = "models/n7/vorti_outfit/meat02.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["antlion_skewer"] = 3, ["comp_improved_nails_screws"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_meat02"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full XP
	{level = 10, exp = 150}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_bandanna"
RECIPE.name = "Bandana vortigaunt"
RECIPE.description = "La discrétion est de la plus haute importance. Je ne voudrais pas que quiconque sache qu'un Vortigaunt était ici."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_bandana"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_helmet"
RECIPE.name = "Casque vortigaunt"
RECIPE.description = "La protection avant l'aspect pratique. Avec un peu de chance, l'ennemi peut essayer de viser un peu plus haut."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_reshaped_metal"] = 3, ["comp_improved_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_head_helmet"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_kevlar"
RECIPE.name = "Kevlar vortigaunt"
RECIPE.description = "Il n'y a pas de peur pour l'intervalle d'obscurité, mais il n'y a pas non plus de hâte à l'embrasser. Un ensemble standard de kevlar humain, à peu près adapté pour une utilisation vortigaunt."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_strong_adhesive"] = 1, ["comp_refined_metal"] = 3, ["comp_improved_nails_screws"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_vest"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full XP
	{level = 40, exp = 75}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_labcoat2"
RECIPE.name = "Blouse Vortigaunt"
RECIPE.description = "Un uniforme scientifique pour les vortigaunts à la recherche d'un style de vie plus scientifique."
RECIPE.model = "models/willardnetworks/clothingitems/torso_labcoat.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_doc2"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_labcoat"
RECIPE.name = "Blouse de laboratoire Vortigaunt (Avec Badge)"
RECIPE.description = "Un uniforme scientifique pour les vortigaunts à la recherche d'un style de vie plus scientifique. Cette variante est livrée avec un badge."
RECIPE.model = "models/willardnetworks/clothingitems/torso_labcoat.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_metal"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_doc"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_chef_hat"
RECIPE.name = "Chapeau de chef Vortigaunt"
RECIPE.description = "Les Vortigaunts sont bien connus pour leurs capacités dans les arts culinaires en raison de leur lien avec la Vortessence. La seule étape restante pour qu'un Vortigaunt agisse temporairement comme un chef expert est de porter l'un de ces chapeaux idiots"
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_head_chefhat"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_hoodie"
RECIPE.name = "Sweat à capuche Vortigaunt"
RECIPE.description = "Un sweat à capuche allongé pour un cou plus long. Parfait pour garder un vortigaunt au chaud même dans les conditions les plus difficiles."
RECIPE.model = "models/n7/vorti_outfit/hoodie.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 3, ["comp_strong_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_hoodie"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 70}, -- full XP
	{level = 20, exp = 35}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_trench_coat"
RECIPE.name = "Manteau marron Vortigaunt"
RECIPE.description = "Un manteau remis à neuf. Assure que le corps est chaud et un peu sec. Ça ne fait pas de mal de se fondre non plus."
RECIPE.model = "models/willardnetworks/clothingitems/torso_refugee_coat.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_stitched_cloth"] = 4, ["comp_strong_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light3_tc"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_poncho"
RECIPE.name = "Poncho Vortigaunt raffiné"
RECIPE.description = "Un revêtement fiable et solide. Sa composition est dérivée de vêtements humains typiques. La conception ample et les découpes pratiques permettent le confort et la liberté de mouvement."
RECIPE.model = "models/n7/vorti_outfit/light01.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 2, ["comp_strong_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full XP
	{level = 20, exp = 25}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_covering"
RECIPE.name = "Couverture improvisée de Vortigaunt"
RECIPE.description = "Un revêtement simple et uni. Bon pour vous garder bien au chaud par une nuit fraîche, et pas grand-chose d'autre."
RECIPE.model = "models/n7/vorti_outfit/light02.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 2, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light2"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_armour"
RECIPE.name = "Plaque de garde de fourmilion"
RECIPE.description = "Fabriquée à partir des peaux blindées épaisses des gardes Antlion tombés au combat, cette armure n'est pas seulement robuste, mais la marque d'un guerrier chevronné."
RECIPE.model = "models/n7/vorti_outfit/armor.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["ing_antlion_meat"] = 8, ["comp_refined_metal"] = 3, ["comp_improved_nails_screws"] = 2, ["comp_fabric"] = 1, ["comp_strong_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_armor"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 300}, -- full XP
	{level = 40, exp = 150}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}

RECIPE:Register()