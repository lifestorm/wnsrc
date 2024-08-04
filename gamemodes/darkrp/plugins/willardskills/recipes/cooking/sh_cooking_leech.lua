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
RECIPE.uniqueID = "cooking_skewered_leech"
RECIPE.name = "Sangsue en brochette"
RECIPE.category = "Sangsues"	
RECIPE.description = "Brochette de sangsues délicatement grillées, pour un repas exotique et unique."
RECIPE.model = "models/willardnetworks/food/meatskewer2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_raw_leech"] = 5}
RECIPE.result = {["leech_skewer"] = 5}
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
RECIPE.uniqueID = "cooking_leech_roast"
RECIPE.name = "Sangsue rôtie"
RECIPE.category = "Sangsues"	
RECIPE.description = "Un parasite autrefois redouté maintenant rôti et prêt à manger."
RECIPE.model = "models/willardnetworks/food/cooked_leech.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_raw_leech"] = 2, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["leech_roast"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_leech_goulash"
RECIPE.name = "Goulache de sangsue"
RECIPE.category = "Sangsues"	
RECIPE.description = "Un plat en sauce à base de sangsue."
RECIPE.model = "models/willardnetworks/food/canned_food1.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["leech_roast"] = 2, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["leech_goulash"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full xp
	{level = 29, exp = 40}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_leech_stew"
RECIPE.name = "Ragoût de sangsue crémeux"
RECIPE.category = "Sangsues"	
RECIPE.description = "Diverses sangsues bouillies, mélangées et placées dans une sauce crémeuse. c'est chaud."
RECIPE.model = "models/willardnetworks/food/whitesoup.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_raw_leech"] = 2, ["ing_sauce"] = 1, ["drink_milk"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["leech_stew"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 80}, -- full xp
	{level = 40, exp = 40}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()