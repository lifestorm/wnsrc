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
RECIPE.name = "Sebze Turşusu"
RECIPE.category = "Turşu"
RECIPE.description = "Bir şişe sebze turşusu, biraz iştah açıcı görünüyor."
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
RECIPE.name = "Yumurta Turşusu"
RECIPE.category = "Turşu"
RECIPE.description = "Yumurta turşusu, eskiden Şehir İki çevresinde oldukça yaygın bir manzaraydı."
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
RECIPE.name = "Yumurta Ezmesi Turşusu"
RECIPE.category = "Turşu"
RECIPE.description = "Turşu haline getirilmiş yumurta hamurunun bir araya getirilerek yenilebilir bir forma sokulmasından oluşan tuhaf bir mekanizma."
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
RECIPE.name = "Sülük Turşusu"
RECIPE.category = "Turşu"
RECIPE.description = "İtiraf etmelisin ki, biraz iğrenç. Ama yenilebilir."
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