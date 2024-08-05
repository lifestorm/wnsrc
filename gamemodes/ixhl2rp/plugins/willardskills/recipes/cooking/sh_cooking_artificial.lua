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
RECIPE.uniqueID = "cooking_artificial_skewer"
RECIPE.name = "Skewered Artificial Meat"
RECIPE.category = "Artificial"
RECIPE.description = "A protein block of meat skewed and produced as ready to eat."
RECIPE.model = "models/willardnetworks/food/meatskewer2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_artificial_meat"] = 2}
RECIPE.result = {["artificial_skewer"] = 5}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 180}, -- full xp
	{level = 10, exp = 120}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_meatpaste"
RECIPE.name = "Artificial Meat Paste"
RECIPE.category = "Artificial"
RECIPE.description = "White jar of gooey artificial slop, supplemented with bits of artificial meat for improved fill and taste."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.ingredients = {["proc_paste"] = 1, ["artificial_meat"] = 1}
RECIPE.result = {["artificial_meatpaste"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 180}, -- full xp
	{level = 20, exp = 120}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_cheesepaste"
RECIPE.name = "Artificial Cheese Paste"
RECIPE.category = "Artificial"
RECIPE.description = "White jar of gooey artificial slop, supplemented with cheese for a slightly improved texture and fill."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.ingredients = {["proc_paste"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["artificial_cheesepaste"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 180}, -- full xp
	{level = 20, exp = 120}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_meat"
RECIPE.name = "Roasted Artificial Meat"
RECIPE.category = "Artificial"
RECIPE.description = "A protein block of Artificial meat for easy consumption."
RECIPE.model = "models/willardnetworks/food/steak2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_artificial_meat"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["artificial_meat"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 180}, -- full xp
	{level = 20, exp = 120}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_stirfry"
RECIPE.name = "Artificial Meat Stir Fry"
RECIPE.category = "Artificial"
RECIPE.description = "Stir fried artificial meat, mixed with salt and noodles."
RECIPE.model = "models/willardnetworks/food/canned_food2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["artificial_meat"] = 1, ["ing_spices"] = 1, ["ing_noodles"] = 1}
RECIPE.result = {["artificial_stirfry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 180}, -- full xp
	{level = 29, exp = 120}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_stew"
RECIPE.name = "Artificial Meat Stew"
RECIPE.category = "Artificial"
RECIPE.description = "Artificial meat slabs mixed with gravy and an assortment of vegetable chunks."
RECIPE.model = "models/willardnetworks/food/meatysoup2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_artificial_meat"] = 1, ["ing_sauce"] = 1, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["artificial_stew"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 180}, -- full xp
	{level = 40, exp = 120}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()