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
RECIPE.uniqueID = "rec_elec_computer"
RECIPE.name = "Ordinateur"
RECIPE.description = "Un ordinateur restauré avec accès aux notes, utilisant un système d'exploitation douteux. Outil utile pour les magasins."
RECIPE.model = "models/willardnetworks/props/willard_computer.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Électronique"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 2, ["comp_electronics"] = 4, ["comp_nails_screws"] = 2}
RECIPE.result = {["cit_computer"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 400}, -- full xp
	{level = 40, exp = 200}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()


RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_elec_cmb_tuner"
RECIPE.name = "Syntoniseur radio approuvé le cartel"
RECIPE.description = "Un syntoniseur radio qui peut être utilisé pour modifier les fréquences qu'une radio peut capter."
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Électronique"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_reshaped_metal"] = 2, ["comp_electronics"] = 10, ["comp_nails_screws"] = 2, ["comp_glass"] = 2, ["comp_adhesive"] = 2}
RECIPE.result = {["tuner_cmb"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 400}, -- full xp
	{level = 40, exp = 200}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_elec_reb_tuner"
RECIPE.name = "Syntoniseur radio de la Résistance"
RECIPE.description = "Un syntoniseur radio capable de modifier les fréquences qu'une radio peut capter. Il s'agit d'un syntoniseur de gamme supérieure capable d'atteindre des fréquences de diffusion lointaines."
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Électronique"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_metal"] = 1, ["comp_electronics"] = 12, ["comp_improved_nails_screws"] = 1, ["comp_glass"] = 2, ["comp_strong_adhesive"] = 1, ["comp_military_electronics"] = 1}
RECIPE.result = {["tuner_reb"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 500}, -- full xp
	{level = 46, exp = 250}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_elec_handheld"
RECIPE.name = "Radio"
RECIPE.description = "Une radio portable correctement conçue prenant en charge les fréquences analogiques et numériques."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Électronique"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_refined_metal"] = 1, ["comp_electronics"] = 2, ["comp_improved_nails_screws"] = 1, ["comp_refined_plastic"] = 1}
RECIPE.result = {["handheld_radio"] = 1}
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
RECIPE.uniqueID = "rec_elec_old_handheld"
RECIPE.name = "Ancienne radio portable"
RECIPE.description = "Radio de fortune qui ne prend en charge que les fréquences analogiques."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Électronique"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_reshaped_metal"] = 1, ["comp_electronics"] = 1, ["comp_nails_screws"] = 2, ["comp_glass"] = 1, ["comp_plastic"] = 2}
RECIPE.result = {["old_radio"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "craft_writing_crackedprinter"
RECIPE.name = "Imprimante crackée"
RECIPE.description = "Une imprimante fissurée ne nécessitant plus de permis valide. Nécessite du papier et de l'encre noire."
RECIPE.model = "models/willardnetworks/plotter.mdl"
RECIPE.category = "Anti-Citoyen"
RECIPE.subcategory = "Électronique"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["newspaper_printer"] = 1, ["comp_electronics"] = 4, ["comp_strong_adhesive"] = 1}
RECIPE.result = {["newspaper_printer_cracked"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 40, exp = 50}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()
