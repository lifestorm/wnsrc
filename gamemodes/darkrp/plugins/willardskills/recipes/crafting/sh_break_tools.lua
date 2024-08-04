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
RECIPE.uniqueID = "break_kitchenspoon"
RECIPE.name = "Cuillère à soupe"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_spoon"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
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
RECIPE.uniqueID = "break_suitcase"
RECIPE.name = "Valise"
RECIPE.description = "Vous donne : 1 tissu"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["suitcase"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
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
RECIPE.uniqueID = "break_fryingpan"
RECIPE.name = "Poêle à frire"
RECIPE.description = "Vous donne : 1 métal"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_fryingpan"] = 1}
RECIPE.result = {["comp_metal"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_kitchenknife"
RECIPE.name = "Couteau de cuisine"
RECIPE.description = "Vous donne : 1 métal"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_knife"] = 1}
RECIPE.result = {["comp_metal"] = 1}
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
RECIPE.uniqueID = "break_flashlight"
RECIPE.name = "Lampe de poche"
RECIPE.description = "Vous donne : 1 électronique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["flashlight"] = 1}
RECIPE.result = {["comp_electronics"] = 1}
RECIPE.hidden = true
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_requestdevice"
RECIPE.name = "Dispositif de demande d'aide"
RECIPE.description = "Vous donne : 1 électronique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["request_device"] = 1}
RECIPE.result = {["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_scissors"
RECIPE.name = "Ciseaux"
RECIPE.description = "Vous donne : 1 plastique"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_scissors"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_cookingpot"
RECIPE.name = "Casserole"
RECIPE.description = "Vous donne : 1 métal"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_cookingpot"] = 1}
RECIPE.result = {["comp_metal"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_kettle"
RECIPE.name = "Bouilloire"
RECIPE.description = "Vous donne : 1 métal"
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Recyclage"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_kettle"] = 1}
RECIPE.result = {["comp_metal"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

