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
RECIPE.name = "Bread Dough"
RECIPE.category = "Ingredients"
RECIPE.description = "The first ingredient to attaining delicious bread."
RECIPE.model = "models/willardnetworks/food/dough.mdl"
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_flour"] = 1, ["drink_milk"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["ing_dough"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 200}, -- full xp
	{level = 10, exp = 100}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_pastry_dough"
RECIPE.name = "Pastry Dough"
RECIPE.category = "Ingredients"
RECIPE.description = "A dough more suitable for pastry products."
RECIPE.model = "models/willardnetworks/props/dough.mdl"
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_flour"] = 1, ["drink_milk"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["ing_pastry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sweet_dough"
RECIPE.name = "Sweetened Pastry Dough"
RECIPE.category = "Ingredients"
RECIPE.description = "Pastry sweetened up with berries suitable for dessert pastries."
RECIPE.model = "models/willardnetworks/props/sweetdough.mdl"
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_sweet"] = 1, ["fruit_berries"] = 2}
RECIPE.result = {["ing_sweetpastry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sauce"
RECIPE.name = "Sauce Base"
RECIPE.category = "Ingredients"
RECIPE.description = "A mixture of ingredients mixed together to shape the foundations of a sauce."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_flour"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["ing_sauce"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 35, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sauce_makeshift"
RECIPE.name = "Makeshift Sauce Base"
RECIPE.category = "Ingredients"
RECIPE.description = "A mixture of ingredients mixed together to shape the foundations of a sauce."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_flour"] = 1, ["comp_chemcomp"] = 1}
RECIPE.result = {["ing_sauce"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 35, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()