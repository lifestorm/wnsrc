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
RECIPE.uniqueID = "cooking_potato"
RECIPE.name = "Baked Potato"
RECIPE.category = "Farming"
RECIPE.description = "A baked potato."
RECIPE.model = "models/mosi/fnv/props/potato.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["veg_potato"] = 1}
RECIPE.result = {["baking_potato"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_tomato"
RECIPE.name = "Fresh Tomato"
RECIPE.category = "Farming"
RECIPE.description = "A Tomato freshly picked and then cleaned off with water."
RECIPE.model = "models/a31/fallout4/props/plants/tato_item.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["veg_tomato"] = 1}
RECIPE.result = {["baking_tomato"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()