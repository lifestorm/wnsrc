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
RECIPE.name = "Makeshift Bandage Roll"
RECIPE.description = "A ragged cloth bandage roll. Stops the bleeding but not much else..."
RECIPE.model = "models/stuff/bandages_dirty.mdl"
RECIPE.category = "Medical"
RECIPE.ingredients = {["comp_cloth"] = 3}
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