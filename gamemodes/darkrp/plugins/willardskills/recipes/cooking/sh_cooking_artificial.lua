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
RECIPE.name = "Şişte Yapay Et"
RECIPE.category = "Yapay"
RECIPE.description = "Eğrilmiş ve yemeye hazır olarak üretilmiş bir protein bloğu."
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
RECIPE.name = "Yapay Et Ezmesi"
RECIPE.category = "Yapay"
RECIPE.description = "Daha iyi dolum ve tat için yapay et parçaları ile desteklenmiş beyaz kavanoz yapışkan yapay bulamaç."
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
RECIPE.name = "Yapay Peynir Ezmesi"
RECIPE.category = "Yapay"
RECIPE.description = "Biraz daha iyi bir doku ve dolgu için peynirle desteklenmiş beyaz kavanoz yapışkan yapay slop."
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
RECIPE.name = "Kavrulmuş Yapay Et"
RECIPE.category = "Yapay"
RECIPE.description = "Kolay tüketim için yapay etten oluşan bir protein bloğu."
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
RECIPE.name = "Vogda Kızartılmış Yapay Et"
RECIPE.category = "Yapay"
RECIPE.description = "Kızartılmış yapay et, tuz ve erişte ile karıştırılır."
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
RECIPE.name = "Yapay Et Yahnisi"
RECIPE.category = "Yapay"
RECIPE.description = "Sos ve çeşitli sebze parçalarıyla karıştırılmış yapay et dilimleri."
RECIPE.model = "models/willardnetworks/food/meatysoup2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_artificial_meat"] = 1, ["ing_sauce"] = 1, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["artificial_stew"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 25
RECIPE.experience = {
	{level = 30, exp = 180}, -- full xp
	{level = 40, exp = 120}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()