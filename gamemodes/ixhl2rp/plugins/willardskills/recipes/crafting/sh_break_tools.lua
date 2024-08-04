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
RECIPE.name = "Rozłóż łyżkę"
RECIPE.description = "Rozłóż łyżkę pozyskując z niej materiały."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
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
RECIPE.name = "Rozłóż walizkę"
RECIPE.description = "Rozłóż walizkę pozyskując z niej materiały."
RECIPE.model = "models/weapons/w_suitcase_passenger.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
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
RECIPE.name = "Rozłóż patelnię"
RECIPE.description = "Rozłóż patelnię pozyskując z niej materiały."
RECIPE.model = "models/props_c17/metalPot002a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_fryingpan"] = 1}
RECIPE.result = {["comp_scrap"] = 1}
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
RECIPE.name = "Rozłóż nóż kuchenny"
RECIPE.description = "Rozłóż nóż kuchenny pozyskując z niego materiały."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_knife"] = 1}
RECIPE.result = {["comp_scrap"] = 1}
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
RECIPE.name = "Rozłóż latarkę"
RECIPE.description = "Rozłóż latarkę pozyskując z niej materiały."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
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
RECIPE.name = "Rozłóż urządzenie zgłaszające"
RECIPE.description = "Rozbij urządzenie zgłaszające wydane przez kombinat."
RECIPE.model = "models/gibs/shield_scanner_gib1.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
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
RECIPE.name = "Rozłóż nożyczki"
RECIPE.description = "Rozłóż nożyczki pozyskując z nich materiały."
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
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
RECIPE.name = "Rozłóż garnek"
RECIPE.description = "Rozłóż garnek pozyskując z niego materiały."
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_cookingpot"] = 1}
RECIPE.result = {["comp_scrap"] = 1}
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
RECIPE.name = "Rozłóż czajnik"
RECIPE.description = "Rozłóż czajnik pozyskując z niego materiały."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Narzędzia"
RECIPE.tool = "tool_wrench"
RECIPE.ingredients = {["tool_kettle"] = 1}
RECIPE.result = {["comp_scrap"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

