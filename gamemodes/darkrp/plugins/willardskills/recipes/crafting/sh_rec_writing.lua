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
RECIPE.uniqueID = "craft_writing_pin"
RECIPE.name = "Toplu iğne"
RECIPE.description = "Bir iğne. Duvarlara kağıt vb. asmak için kullanılır."
RECIPE.model = "models/items/crossbowrounds.mdl"
RECIPE.category = "Yazma"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["pin"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "craft_writing_notepad"
RECIPE.name = "Not Defteri"
RECIPE.description = "Yazmak için bir not defteri."
RECIPE.model = "models/props_lab/clipboard.mdl"
RECIPE.category = "Yazma"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["paper"] = 1, ["comp_wood"] = 1, ["comp_scrap"] = 1}
RECIPE.result = {["notepad"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "craft_writing_ink"
RECIPE.name = "Siyah Mürekkep"
RECIPE.description = "Siyah mürekkep kartuşu."
RECIPE.model = "models/gibs/metal_gib2.mdl"
RECIPE.category = "Yazma"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["comp_charcoal"] = 1, ["comp_plastic"] = 1}
RECIPE.result = {["black_ink"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 70}, -- full xp
	{level = 30, exp = 35}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()