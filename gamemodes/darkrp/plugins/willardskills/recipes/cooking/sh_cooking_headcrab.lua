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
RECIPE.uniqueID = "cooking_headcrab_sandwich"
RECIPE.name = "Headcrab Sandviçi"
RECIPE.category = "Headcrab"
RECIPE.description = "İki parça ekmeği, arasına bir parça headcrab koyarak birbirine yapıştırın ve işte size bir sandviç."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["baking_bread_slice"] = 1, ["headcrab_fillet"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["headcrab_sandwich"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 350}, -- full xp
	{level = 10, exp = 150}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_skewer"
RECIPE.name = "Şişte Headcrab"
RECIPE.category = "Headcrab"	
RECIPE.description = "Bir çubuğa sıkıca tutturulmuş şişlenmiş headcrab, yenilebilir görünüyor."
RECIPE.model = "models/willardnetworks/food/meatskewer.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 2}
RECIPE.result = {["headcrab_skewer"] = 6}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 350}, -- full xp
	{level = 10, exp = 150}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_fillet"
RECIPE.name = "Kavrulmuş Headcrab Fileto"
RECIPE.category = "Headcrab"
RECIPE.description = "Bir dilim sert kavrulmuş headcrab eti."
RECIPE.model = "models/willardnetworks/food/meat6.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["headcrab_fillet"] = 1}
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
RECIPE.uniqueID = "cooking_headcrab_potluck"
RECIPE.name = "Headcrab Yemeği"
RECIPE.category = "Headcrab"
RECIPE.description = "Farklı baharatlar ve sebzelerle karıştırılmış pişmiş headcrab."
RECIPE.model = "models/willardnetworks/food/canned_food3.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["headcrab_fillet"] = 1, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["headcrab_potluck"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 300}, -- full xp
	{level = 29, exp = 150}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_jambalaya"
RECIPE.name = "Headcrab Jambalaya"
RECIPE.category = "Headcrab"
RECIPE.description = "Baharatlı sos, sebze ve diğer malzemelerle karıştırılmış haşlanmış headcrab."
RECIPE.model = "models/willardnetworks/food/stew1.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 1, ["ing_sauce"] = 1, ["ing_spices"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["headcrab_jambalaya"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 25
RECIPE.experience = {
	{level = 30, exp = 300}, -- full xp
	{level = 40, exp = 150}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()