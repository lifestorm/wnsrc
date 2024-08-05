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
RECIPE.uniqueID = "cooking_bird_skewer"
RECIPE.name = "Şişte Kuş"
RECIPE.category = "Kuş"	
RECIPE.description = "Bir çubuğa sıkıca tutturulmuş şişlenmiş kuş parçaları, yenilebilir görünüyorlar."
RECIPE.model = "models/willardnetworks/food/meatskewer.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_bird_meat"] = 2}
RECIPE.result = {["bird_skewer"] = 1}
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
RECIPE.uniqueID = "cooking_bird_fillet"
RECIPE.name = "Kavrulmuş Kuş Fileto"
RECIPE.category = "Kuş"
RECIPE.description = "Sert kavrulmuş kuş eti."
RECIPE.model = "models/willardnetworks/food/meat6.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_bird_meat"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["bird_fillet"] = 1}
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
RECIPE.uniqueID = "cooking_bird_potluck"
RECIPE.name = "Kuş Yemeği"
RECIPE.category = "Kuş"
RECIPE.description = "Farklı baharatlar ve sebzelerle karıştırılmış pişmiş kuş."
RECIPE.model = "models/willardnetworks/food/canned_food3.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["bird_fillet"] = 1, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["bird_potluck"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 29, exp = 125}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()