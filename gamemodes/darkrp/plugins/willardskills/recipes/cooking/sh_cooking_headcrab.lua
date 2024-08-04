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
RECIPE.uniqueID = "cooking_headcrab_sandwich"
RECIPE.name = "Sandwich au crabe de tête"
RECIPE.category = "Exogène"
RECIPE.subcategory = "Crabe de tête"
RECIPE.description = "Du crabe de tête frais et croquant, agrémenté de légumes, entre deux tranches de pain."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["baking_bread_slice"] = 1, ["headcrab_fillet"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["headcrab_sandwich"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 10, exp = 125}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_skewer"
RECIPE.name = "Brochette de crabe de tête"
RECIPE.category = "Exogène"
RECIPE.subcategory = "Crabe de tête"	
RECIPE.description = "Des morceaux juteux de crabe de tête grillés sur une brochette."
RECIPE.model = "models/willardnetworks/food/meatskewer.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 2}
RECIPE.result = {["headcrab_skewer"] = 6}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 10, exp = 125}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_fillet"
RECIPE.name = "Viande de crabe de tête rôtie"
RECIPE.category = "Exogène"
RECIPE.subcategory = "Crabe de tête"
RECIPE.description = "Des morceaux de viande de crabe de tête rôtis à point, prêts à être dégustés."
RECIPE.model = "models/willardnetworks/food/meat6.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["headcrab_fillet"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full xp
	{level = 20, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_potluck"
RECIPE.name = "Ragoût de crabe de tête"
RECIPE.category = "Exogène"
RECIPE.subcategory = "Crabe de tête"
RECIPE.description = "Un plat fumant rempli de viande de crabe de tête mijotée."
RECIPE.model = "models/willardnetworks/food/canned_food3.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["headcrab_fillet"] = 1, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["headcrab_potluck"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 29, exp = 125}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_jambalaya"
RECIPE.name = "Bouillie de crabe de tête"
RECIPE.category = "Exogène"
RECIPE.subcategory = "Crabe de tête"
RECIPE.description = "Un bol de bouillie crémeuse à base de crabe de tête."
RECIPE.model = "models/willardnetworks/food/stew1.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 1, ["ing_sauce"] = 1, ["ing_spices"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["headcrab_jambalaya"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 250}, -- full xp
	{level = 40, exp = 125}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()