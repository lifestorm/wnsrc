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
RECIPE.uniqueID = "rec_makeshift"
RECIPE.name = "Rouleau de bandage de fortune"
RECIPE.description = "Un rouleau de bandage en tissu en lambeaux. Arrête le saignement mais pas grand-chose d'autre..."
RECIPE.model = "models/stuff/bandages_dirty.mdl"
RECIPE.category = "Médicale"
RECIPE.ingredients = {["comp_cloth"] = 2}
RECIPE.result = {["makeshift_bandage"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()