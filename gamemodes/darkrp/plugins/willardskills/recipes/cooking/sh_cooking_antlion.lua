--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_antlion_sandwich"
RECIPE.name = "Antlion Sandviçi"
RECIPE.category = "Antlion"
RECIPE.description = "İki parça ekmeği bir araya getirip arasına bir parça Antlion eti koyun ve işte size bir sandviç."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["baking_bread_slice"] = 1, ["antlion_roast"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["antlion_sandwich"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 10, exp = 125}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_antlion_skewer"
RECIPE.name = "Şişte Antlion Eti"
RECIPE.category = "Antlion"	
RECIPE.description = "Diğer dünya tazeliği uygun şekilde çarpıtılmış ve yemeye hazır."
RECIPE.model = "models/willardnetworks/food/meatskewer.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_antlion_meat"] = 2}
RECIPE.result = {["antlion_skewer"] = 5}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 10, exp = 125}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_antlion_roast"
RECIPE.name = "Kavrulmuş Antlion Eti"
RECIPE.category = "Antlion"
RECIPE.description = "Kavrulmuş bir parça antilop eti, sizi istediğiniz kadar doyurmuyor, oldukça lifli ve garip bir dokuya sahip."
RECIPE.model = "models/willardnetworks/food/cooked_alienmeat.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_antlion_meat"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["antlion_roast"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full xp
	{level = 20, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_antlion_dish"
RECIPE.name = "Baharatlı Antlion Eti Yemeği"
RECIPE.category = "Antlion"
RECIPE.description = "Malzemelerin dünya dışı karışımlarından oluşan bu yemek garip bir şekilde oldukça iştah açıcı görünüyor."
RECIPE.model = "models/willardnetworks/food/canned_food4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["antlion_roast"] = 1, ["ing_spices"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["antlion_dish"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 29, exp = 125}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_antlion_stew"
RECIPE.name = "Antlion Yahnisi"
RECIPE.category = "Antlion"
RECIPE.description = "Et parçaları, sebzeler ve baharatın bir araya gelmesiyle ortaya çıkan iştah açıcı bir güveç."
RECIPE.model = "models/willardnetworks/food/meatysoup.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_antlion_meat"] = 1, ["ing_sauce"] = 1, ["ing_spices"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["antlion_stew"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 25
RECIPE.experience = {
	{level = 25, exp = 250}, -- full xp
	{level = 35, exp = 125}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()