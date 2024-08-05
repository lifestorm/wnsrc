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
RECIPE.name = "Pickled Vegetables"
RECIPE.category = "Pickled"
RECIPE.description = "A bottle of pickled vegetables, it looks somewhat appetizing."
RECIPE.model = "models/willardnetworks/foods/pickled.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_vegetable_pack"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_vegetables"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_egg"
RECIPE.name = "Pickled Egg"
RECIPE.category = "Pickled"
RECIPE.description = "Pickled egg, used to be quite a common sight around City Two."
RECIPE.model = "models/willardnetworks/food/egg2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["ing_egg"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_egg"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_eggmush"
RECIPE.name = "Pickled Eggmush"
RECIPE.category = "Pickled"
RECIPE.description = "A weird contraption of pickled egg paste mushed together into a somewhat edible form."
RECIPE.model = "models/willardnetworks/food/eggmix.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_vinegar"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["pickled_eggmush"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_leech"
RECIPE.name = "Pickled Leech"
RECIPE.category = "Pickled"
RECIPE.description = "You have to admit, it's a tad disgusting.. However it is edible."
RECIPE.model = "models/willardnetworks/food/cooked_leech.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["leech_roast"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_leech"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()