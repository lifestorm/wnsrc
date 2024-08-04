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
RECIPE.name = "Pieczony ziemniak"
RECIPE.category = "Rolnictwo"
RECIPE.description = "Pieczona grula."
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
RECIPE.name = "Świeży pomidor"
RECIPE.category = "Rolnictwo"
RECIPE.description = "Pomidor świeżo zerwany, a następnie oczyszczony wodą."
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