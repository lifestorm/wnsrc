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
RECIPE.uniqueID = "cooking_pickled_vegetables"
RECIPE.name = "Légumes marinés"
RECIPE.category = "Marinée"
RECIPE.description = "Des légumes trempés dans une marinade pour une saveur plus intense."
RECIPE.model = "models/willardnetworks/foods/pickled.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_vegetable_pack"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_vegetables"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_egg"
RECIPE.name = "Oeuf mariné"
RECIPE.category = "Marinée"
RECIPE.description = "Un oeuf trempé dans une marinade pour un goût unique."
RECIPE.model = "models/willardnetworks/food/egg2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["ing_egg"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_egg"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_eggmush"
RECIPE.name = "Bouillie d'oeufs marinés"
RECIPE.category = "Marinée"
RECIPE.description = "Une bouillie faite à partir d'œufs marinés pour un plat savoureux et original."
RECIPE.model = "models/willardnetworks/food/eggmix.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_vinegar"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["pickled_eggmush"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full xp
	{level = 20, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_leech"
RECIPE.name = "Sangsues marinées"
RECIPE.category = "Marinée"
RECIPE.description = "Des sangsues trempées dans une marinade pour une texture et un goût particuliers."
RECIPE.model = "models/willardnetworks/food/cooked_leech.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["leech_roast"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_leech"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full xp
	{level = 20, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()