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
RECIPE.uniqueID = "cooking_noodles"
RECIPE.name = "Fried Noodles"
RECIPE.category = "Comfort Food"
RECIPE.description = "Even during the occupation.. Noodles remain a popular choice for food."
RECIPE.model = "models/willardnetworks/food/noodles.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_noodles"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_noodles"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 75}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_toast"
RECIPE.name = "Toast"
RECIPE.category = "Comfort Food"
RECIPE.description = "It's crunchy, brings back memories of breakfast with the family."
RECIPE.model = "models/willardnetworks/food/toast.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["baking_bread_slice"] = 1}
RECIPE.result = {["comfort_toast"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 90}, -- full xp
	{level = 10, exp = 45}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sandwich"
RECIPE.name = "Sandwich"
RECIPE.category = "Comfort Food"
RECIPE.description = "Very popular in City Two, a sandwich of artificial meat and cheese."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["baking_bread_slice"] = 1, ["artificial_meat"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["comfort_sandwich"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 10, exp = 150}, -- full xp
	{level = 20, exp = 75}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_scrambled"
RECIPE.name = "Scrambled Eggs"
RECIPE.category = "Comfort Food"
RECIPE.description = "Real eggs scrambled to perfection, its texture superior to powdered eggs."
RECIPE.model = "models/willardnetworks/food/eggmix.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_egg"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["comfort_scrambled"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking__powder_scrambled"
RECIPE.name = "Scrambled Powdered Eggs"
RECIPE.category = "Comfort Food"
RECIPE.description = "Powdered eggs scrambled with artificial cheese.. Only a slight metalic aftertaste."
RECIPE.model = "models/willardnetworks/food/eggmix.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["comfort_scrambled"] = 1}
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
RECIPE.uniqueID = "cooking_comfort_chicken"
RECIPE.name = "Roasted Chicken"
RECIPE.category = "Comfort Food"
RECIPE.description = "An industry collectivized in distant lands, set in foul conditions and factories to produce meat."
RECIPE.model = "models/willardnetworks/food/meat4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_chicken"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["comfort_roastedchicken"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_boiledegg"
RECIPE.name = "Boiled Egg"
RECIPE.category = "Comfort Food"
RECIPE.description = "A lovely but reasonable rare breakfast these days."
RECIPE.model = "models/willardnetworks/food/egg2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["ing_egg"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["luxury_boiled_egg"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pancakes"
RECIPE.name = "Pancakes"
RECIPE.category = "Comfort Food"
RECIPE.description = "You just can't say no to pancakes."
RECIPE.model = "models/willardnetworks/food/pancake.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["drink_milk"] = 1}
RECIPE.result = {["comfort_pancake"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_vegsoup"
RECIPE.name = "Vegetable Soup"
RECIPE.category = "Comfort Food"
RECIPE.description = "A warm bowl of healthy vegetable soup, a good way to keep a steady mind."
RECIPE.model = "models/willardnetworks/food/vegetablesoup.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_vegetable_pack"] = 2, ["ing_herbs"] = 1, ["crafting_water"] = 2}
RECIPE.result = {["comfort_soup"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 160}, -- full xp
	{level = 40, exp = 80}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_fish"
RECIPE.name = "Salmon Steak"
RECIPE.category = "Comfort Food"
RECIPE.description = "A rare species of fish cooked as a delicious meal. Usually reserved for prestigious figures."
RECIPE.model = "models/willardnetworks/food/fishsteak.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_fish"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_fish"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_beef"
RECIPE.name = "Roasted Beef"
RECIPE.category = "Comfort Food"
RECIPE.description = "When was the last time you've seen this? Meat from a native animal roasted from a creature once either domesticated, or feral."
RECIPE.model = "models/willardnetworks/food/meat4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_beef"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_beef"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 150}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()