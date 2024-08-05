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
RECIPE.uniqueID = "cooking_proteinkiller"
RECIPE.name = "Protein Killer"
RECIPE.description = "Powdered protein mushed up with painkillers and Breen's Water."
RECIPE.model = "models/willardnetworks/food/cmb_food1.mdl"
RECIPE.category = "Drugged Food"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["ing_protein"] = 1, ["painkillers"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["drug_proteinkiller"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 400}, -- full xp
	{level = 15, exp = 250}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_spikedcoffee"
RECIPE.name = "Spiked Cup of Coffee"
RECIPE.description = "Warm cup of coffee, helps keep you alert and awake for these strange times, this one seemingly even more so than usual.."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Drugged Food"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_coffee"] = 1, ["basic_green"] = 1}
RECIPE.result = {["drug_spikedcoffee"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full xp
	{level = 15, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_spikedtea"
RECIPE.name = "Spiked Cup of Tea"
RECIPE.description = "Comforting and warm to the touch but with a sour aftertaste."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Drugged Food"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_tea"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["drug_spikedtea"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full xp
	{level = 15, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_injectedapple"
RECIPE.name = "Injected Apple"
RECIPE.description = "It looks like any other apple, although with a somewhat funny aftertaste.."
RECIPE.model = "models/willardnetworks/food/apple.mdl"
RECIPE.category = "Drugged Food"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["fruit_apple"] = 1, ["comp_syringe"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["drug_injectedapple"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full xp
	{level = 15, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sunshinevodka"
RECIPE.name = "Sunshine Vodka"
RECIPE.description = "Tastes like artificial sunshine and rainbows!"
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Drugged Food"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_proc_vodka"] = 1, ["ing_coffee_powder"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["drug_sunshinevodka"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 350}, -- full xp
	{level = 20, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_milkyway"
RECIPE.name = "The Milky Way"
RECIPE.description = "To become one with the universe.. At least for a little bit."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Drugged Food"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_milk"] = 1, ["drink_bobenergy"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["drug_milkyway"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 300}, -- full xp
	{level = 20, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_happypie"
RECIPE.name = "Happy Pie"
RECIPE.description = "A delicious apple pie that will certainly make you happy."
RECIPE.model = "models/willardnetworks/food/pie.mdl"
RECIPE.category = "Drugged Food"
RECIPE.ingredients = {["baking_apple_pie"] = 1, ["basic_red"] = 1, ["basic_green"] = 1}
RECIPE.result = {["drug_happypie"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 300}, -- full xp
	{level = 25, exp = 150}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()