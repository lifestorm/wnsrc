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
RECIPE.uniqueID = "cooking_antlion_sandwich"
RECIPE.name = "Kanapka z Antliona"
RECIPE.category = "Antliony"
RECIPE.description = "Może i nie jest daniem najwyższych lotów, ale jest w miarę zjadalne."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["baking_bread_slice"] = 1, ["antlion_roast"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["antlion_sandwich"] = 1}
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
RECIPE.uniqueID = "cooking_antlion_skewer"
RECIPE.name = "Mięso z Antliona na szaszłyku"
RECIPE.category = "Antliony"
RECIPE.description = "Całkiem smaczne, żylaste mięso z Antliona nabite na szaszłyk. Najważniejsze że nie jest ono syntetyczne jak większość jedzenia w tym świecie."
RECIPE.model = "models/willardnetworks/food/meatskewer.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_antlion_meat"] = 2}
RECIPE.result = {["antlion_skewer"] = 5}
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
RECIPE.uniqueID = "cooking_antlion_roast"
RECIPE.name = "Pieczone mięso z Antliona"
RECIPE.category = "Antliony"
RECIPE.description = "Ciepłe, żylaste mięso z Antliona."
RECIPE.model = "models/willardnetworks/food/cooked_alienmeat.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_antlion_meat"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["antlion_roast"] = 1}
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
RECIPE.uniqueID = "cooking_antlion_dish"
RECIPE.name = "Przyprawione mięso Antliona"
RECIPE.category = "Antliony"
RECIPE.description = "Po dodaniu kilku przypraw, smakuje o niebo lepiej."
RECIPE.model = "models/willardnetworks/food/canned_food4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["antlion_roast"] = 1, ["ing_spices"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["antlion_dish"] = 1}
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
RECIPE.uniqueID = "cooking_antlion_stew"
RECIPE.name = "Gulasz z Antliona"
RECIPE.category = "Antliony"
RECIPE.description = "Czemu nie? Pora poeksperymentować! Jak wrażenia?..."
RECIPE.model = "models/willardnetworks/food/meatysoup.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_antlion_meat"] = 1, ["ing_sauce"] = 1, ["ing_spices"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["antlion_stew"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 250}, -- full xp
	{level = 40, exp = 125}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()