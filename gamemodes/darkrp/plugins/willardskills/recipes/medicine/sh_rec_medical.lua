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
RECIPE.uniqueID = "rec_disinfectant"
RECIPE.name = "Bouteille de désinfectant"
RECIPE.description = "Une bouteille de désinfectant, utilisée pour nettoyer les plaies des bactéries."
RECIPE.model = "models/props_junk/glassjug01.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_alcohol"] = 1, ["comp_purifier"] = 1}
RECIPE.result = {["disinfectant_bottle"] = 6}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bandage"
RECIPE.name = "Rouleau de bandage"
RECIPE.description = "Un rouleau de pansements hygiéniques. Utilisé pour arrêter le saignement."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.ingredients = {["comp_cloth"] = 4, ["comp_alcohol"] = 1}
RECIPE.result = {["bandage"] = 6}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_disinfected_bandage"
RECIPE.name = "Bandage Désinfecté"
RECIPE.description = "Un rouleau de pansements sanitaires désinfectés. Utilisé pour arrêter les saignements et nettoyer les plaies."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.ingredients = {["bandage"] = 4, ["disinfectant_bottle"] = 3}
RECIPE.result = {["disinfected_bandage"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_painkillers"
RECIPE.name = "Analgésiques"
RECIPE.description = "Un paquet d'analgésiques. Il procure un soulagement temporaire des douleurs mineures."
RECIPE.model = "models/willardnetworks/skills/pills1.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_refinedchemical"] = 1, ["comp_bluecompound"] = 1}
RECIPE.result = {["painkillers"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 60}, -- full xp
	{level = 10, exp = 30}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bloodstabilizer"
RECIPE.name = "Stabilisateur"
RECIPE.description = "Une seringue remplie de composé rouge et d'analgésique, bonne pour faciliter la récupération suite à des douleurs."
RECIPE.model = "models/willardnetworks/skills/stimpak.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_bloodsyringe"] = 4, ["comp_redcompound"] = 2, ["painkillers"] = 1}
RECIPE.result = {["bloodstabilizer"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bloodbag"
RECIPE.name = "Poche de sang"
RECIPE.description = "Un sac en plastique avec un tuyau et une aiguille attachés. Il semble y avoir du sang dedans."
RECIPE.model = "models/willardnetworks/skills/bloodbag.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_bloodsyringe"] = 4, ["disinfectant_bottle"] = 2, ["comp_plastic"] = 4}
RECIPE.result = {["bloodbag"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 120}, -- full xp
	{level = 20, exp = 60}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_firstaid"
RECIPE.name = "Trousse de premiers secours"
RECIPE.description = "Un petit sac rouge avec des objets pour une réponse immédiate aux premiers secours."
RECIPE.model = "models/willardnetworks/skills/medkit.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.ingredients = {["bandage"] = 3, ["disinfectant_bottle"] = 3, ["bloodstabilizer"] = 3, ["comp_stitched_cloth"] = 1}
RECIPE.result = {["firstaid"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_adrenaline"
RECIPE.name = "Adrénaline"
RECIPE.description = "Une seringue d'adrénaline. Elle procure un soulagement temporaire des douleurs intenses."
RECIPE.model = "models/willardnetworks/skills/adrenaline.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_greencompound"] = 1, ["basic_green"] = 1, ["comp_syringe"] = 1}
RECIPE.result = {["adrenaline"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_morphine"
RECIPE.name = "Morphine"
RECIPE.description = "Une seringue de morphine. Elle procure un soulagement des douleurs intenses."
RECIPE.model = "models/willardnetworks/skills/adrenaline.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_redcompound"] = 2, ["basic_red"] = 1, ["comp_syringe"] = 1}
RECIPE.result = {["morphine"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 150}, -- full xp
	{level = 45, exp = 75}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_med_surgerykit"
RECIPE.name = "Trousse de Chirurgie"
RECIPE.description = "Une pochette rouge qui se déplie pour révéler un assortiment d'outils chirurgicaux. Utilisé par les professionnels de la santé pour une aide immédiate."
RECIPE.model = "models/willardnetworks/skills/surgicalkit.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["firstaid"] = 1, ["morphine"] = 3, ["bloodbag"] = 3, ["adrenaline"] = 1}
RECIPE.result = {["surgerykit"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 160}, -- full xp
	{level = 45, exp = 80}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_med_xenpotion"
RECIPE.name = "Potion Xen"
RECIPE.description = "Substance extraterrestre hautement exotique concoctée à partir d'ingrédients Xen rares, apportant une incroyable régénération organique."
RECIPE.model = "models/willardnetworks/props/xenpotion3.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Soins"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["ing_xen_herb"] = 4, ["ing_xenberries"] = 4, ["drink_vodka"] = 1}
RECIPE.result = {["xen_potion"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full xp
	{level = 50, exp = 0}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()
