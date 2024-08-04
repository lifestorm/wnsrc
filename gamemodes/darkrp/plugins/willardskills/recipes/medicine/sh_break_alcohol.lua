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
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_whiskey_alcohol"
RECIPE.name = "Alcool - Whisky"
RECIPE.description = "Extraire la teneur en alcool du whisky."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Alcool"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_whiskey"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_vodka_alcohol"
RECIPE.name = "Alcool - Vodka"
RECIPE.description = "Extraire la teneur en alcool de la vodka."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Alcool"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_vodka"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_bourbon_alcohol"
RECIPE.name = "Alcool - Bourbon"
RECIPE.description = "Extraire la teneur en alcool du bourbon."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Alcool"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_bourbon"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_beer_alcohol"
RECIPE.name = "Alcool - Bière"
RECIPE.description = "Extraire la teneur en alcool de la bière."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Alcool"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_beer"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()
