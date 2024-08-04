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

RECIPE.uniqueID = "rec_dummy_emp"
RECIPE.name = "Geliştirilmiş EMP Cihazı"
RECIPE.description = "Elektronikleri devre dışı bırakmak için kullanılan tek kullanımlık küçük bir EMP cihazı. Artık Combine teknolojisinde de kullanılabilir - güç alanlarını 5 dakika, taretleri 10 dakika boyunca devre dışı bırakabilir ve tarayıcıları tamamen devre dışı bırakabilir."
RECIPE.model = "models/Items/car_battery01.mdl"
RECIPE.category = "RP Eşyaları"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_steel"] = 3, ["comp_screws"] = 2, ["comp_refined_plastic"] = 2, ["comp_electronics"] = 6}
RECIPE.result = {["dummy_emp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 45, exp = 75}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()