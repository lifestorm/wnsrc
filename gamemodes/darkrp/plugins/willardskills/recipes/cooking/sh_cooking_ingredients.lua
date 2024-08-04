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
RECIPE.uniqueID = "cooking_ing_bread_dough"
RECIPE.name = "Pâte à pain"
RECIPE.category = "Ingrédients"
RECIPE.description = "Une boule de pâte levée, prête à être pétrie et cuite."
RECIPE.model = "models/willardnetworks/food/dough.mdl"
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_flour"] = 1, ["drink_milk"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["ing_dough"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_pastry_dough"
RECIPE.name = "Pâte à Pâtisserie"
RECIPE.category = "Ingrédients"
RECIPE.description = "Une boule de pâte brisée, prête à être étalée et garnir selon vos envies."
RECIPE.model = "models/willardnetworks/props/dough.mdl"
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_flour"] = 1, ["drink_milk"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["ing_pastry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sweet_dough"
RECIPE.name = "Pâte à Pâtisserie Sucrée"
RECIPE.category = "Ingrédients"
RECIPE.description = "Une boule de pâte sucrée, prête à être étalée et transformée en délicieux desserts."
RECIPE.model = "models/willardnetworks/props/sweetdough.mdl"
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_sweet"] = 1, ["fruit_berries"] = 2}
RECIPE.result = {["ing_sweetpastry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sauce"
RECIPE.name = "Fond de sauce"
RECIPE.category = "Ingrédients"
RECIPE.description = "Une base liquide pour donner du goût aux plats."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_flour"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["ing_sauce"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 35, exp = 50}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sauce_makeshift"
RECIPE.name = "Base de sauce"
RECIPE.category = "Ingrédients"
RECIPE.description = "Une sauce de base, prête à être personnalisée avec vos ingrédients préférés pour accompagner vos plats."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_flour"] = 1, ["comp_refinedchemical"] = 1}
RECIPE.result = {["ing_sauce"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 35, exp = 50}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_vanilia_extract"
RECIPE.name = "Artifical Vanillia Extract"
RECIPE.category = "Ingredients"
RECIPE.description = "An artifical re-creation of Vanilia Extract... it tastes sort of sour on its own."
RECIPE.model = "models/labware/bottle1.mdl"
RECIPE.station = {"tool_mixer", "tool_oven"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["comp_refinedchemical"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["ing_vanilia_extract"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_base"
RECIPE.name = "Base de Crême Glacée"
RECIPE.category = "Ingredients"
RECIPE.description = "Une base pour faire de la glace - bien que vous puissiez la manger, quelque chose vous dit que vous préféreriez en faire quelque chose d'autre en premier."
RECIPE.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
RECIPE.station = {"tool_oven_rusty", "tool_oven"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["drink_milk"] = 1, ["ing_vanilia_extract"] = 1, ["ing_spices"] = 1, ["ing_protein"] = 1}
RECIPE.result = {["ice_cream_base"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 120}, -- full xp
	{level = 15, exp = 60}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()