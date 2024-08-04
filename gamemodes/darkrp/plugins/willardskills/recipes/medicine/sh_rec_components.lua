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
RECIPE.uniqueID = "rec_comp_adhesive"
RECIPE.name = "Adhésif"
RECIPE.description = "Un adhésif pour coller des objets ensemble, utilisé dans l'artisanat."
RECIPE.model = "models/willardnetworks/props/glue.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["ing_flour"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["comp_adhesive"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_strong_adhesive"
RECIPE.name = "Adhésif fort"
RECIPE.description = "Un adhésif plus fort pour coller des objets ensemble, utilisé dans l'artisanat."
RECIPE.model = "models/willardnetworks/props/spicyglue.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_adhesive"] = 4, ["crafting_water"] = 1}
RECIPE.result = {["comp_strong_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full xp
	{level = 20, exp = 40}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_makeshift_strong_adhesive"
RECIPE.name = "Adhésif fort de fortune"
RECIPE.description = "Un adhésif de fortune plus fort pour coller des objets ensemble, utilisé dans l'artisanat."
RECIPE.model = "models/willardnetworks/props/spicyglue.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_adhesive"] = 4, ["comp_refinedchemical"] = 2}
RECIPE.result = {["comp_strong_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full xp
	{level = 20, exp = 40}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_refinedchemicals"
RECIPE.name = "Produits chimiques raffinés"
RECIPE.description = "Une substance dangereuse et toxique éliminée pour émission radioactive. Faire attention."
RECIPE.model = "models/willardnetworks/skills/medjar.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_unrefinedchemical"] = 1, ["comp_alcohol"] = 1}
RECIPE.result = {["comp_refinedchemical"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_purifier"
RECIPE.name = "Purificateur"
RECIPE.description = "Poussière étrange qui peut purifier n'importe quel mélange ou substance de n'importe quel composé toxique"
RECIPE.model = "models/willardnetworks/skills/pill_bottle.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_yellowcompound"] = 1, ["comp_unrefinedchemical"] = 1}
RECIPE.result = {["comp_purifier"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_greencompound"
RECIPE.name = "Composé Vert"
RECIPE.description = "Un flacon de composé vert, utilisé à des fins médicinales."
RECIPE.model = "models/willardnetworks/skills/medjar1.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_refinedchemical"] = 1}
RECIPE.result = {["comp_greencompound"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_yellowcompound"
RECIPE.name = "Composé Jaune"
RECIPE.description = "Un flacon de composé jaune, utilisé à des fins médicinales."
RECIPE.model = "models/willardnetworks/skills/medjar2.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_refinedchemical"] = 1}
RECIPE.result = {["comp_yellowcompound"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_redcompound"
RECIPE.name = "Composé Rouge"
RECIPE.description = "Un flacon de composé rouge, utilisé à des fins médicinales."
RECIPE.model = "models/willardnetworks/skills/medjar3.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_refinedchemical"] = 1}
RECIPE.result = {["comp_redcompound"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_bluecompound"
RECIPE.name = "Composé Bleu"
RECIPE.description = "Un flacon de composé bleu, utilisé à des fins médicinales."
RECIPE.model = "models/willardnetworks/skills/medjar4.mdl"
RECIPE.category = "Médecine"
RECIPE.subcategory = "Ingrédients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_refinedchemical"] = 1}
RECIPE.result = {["comp_bluecompound"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()