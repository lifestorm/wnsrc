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
RECIPE.uniqueID = "break_artwhiskey_alcohol"
RECIPE.name = "Extract Artificial Whiskey"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_whiskey"] = 1}
RECIPE.result = {["comp_alcohol"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artvodka_alcohol"
RECIPE.name = "Extract Artificial Vodka"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_vodka"] = 1}
RECIPE.result = {["comp_alcohol"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artbourbon_alcohol"
RECIPE.name = "Extract Artificial Bourbon"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_bourbon"] = 1}
RECIPE.result = {["comp_alcohol"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artbeer_alcohol"
RECIPE.name = "Extract Artificial Beer"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_beer"] = 1}
RECIPE.result = {["comp_alcohol"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_whiskey_alcohol"
RECIPE.name = "Extract Whiskey"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["bottle_whiskey"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 75}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_vodka_alcohol"
RECIPE.name = "Extract Vodka"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["bottle_vodka"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 75}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_bourbon_alcohol"
RECIPE.name = "Extract Bourbon"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["bottle_bourbon"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 75}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_beer_alcohol"
RECIPE.name = "Extract Beer"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_beer"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 75}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_sake_alcohol"
RECIPE.name = "Extract Sake"
RECIPE.description = "Extract the alcohol content from this beverage."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alcohol/chemical extraction"
RECIPE.subcategory = "Alcohol"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["bottle_sake"] = 1}
RECIPE.result = {["comp_alcohol"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 75}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()