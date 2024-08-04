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
RECIPE.name = "Şişlenmiş Sülük"
RECIPE.category = "Sülük"	
RECIPE.description = "Sulu görünen şişlenmiş parazit bir sülük."
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
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_leech_roast"
RECIPE.name = "Kızartılmış Sülük"
RECIPE.category = "Sülük"	
RECIPE.description = "Bir zamanların korkunç paraziti şimdi kavrulmuş ve yemeye hazır."
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
	{level = 10, exp = 200}, -- full xp
	{level = 20, exp = 100}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_leech_goulash"
RECIPE.name = "Sülük Goulash"
RECIPE.category = "Sülük"	
RECIPE.description = "Bir tencerede tuzlanmış ve içine dalınmaya hazır otlarla kızartılmış çeşitli parazit sülükler."
RECIPE.model = "models/willardnetworks/food/canned_food1.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["leech_roast"] = 2, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["leech_goulash"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 15
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 29, exp = 80}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_leech_stew"
RECIPE.name = "Kremalı Sülük Yahnisi"
RECIPE.category = "Sülük"	
RECIPE.description = "Çeşitli sülükler kaynatılır, karıştırılır ve kremalı bir sosun içine konur. Çok sıcak."
RECIPE.model = "models/willardnetworks/food/whitesoup.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_raw_leech"] = 2, ["ing_sauce"] = 1, ["drink_milk"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["leech_stew"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 30, exp = 160}, -- full xp
	{level = 40, exp = 80}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()