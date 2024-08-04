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
RECIPE.uniqueID = "break_battery_chemical"
RECIPE.name = "Batterie de voiture"
RECIPE.description = "Extrayez des composés chimiques non raffinés d'une vieille batterie de voiture."
RECIPE.model = "models/props_junk/garbage_plasticbottle001a.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Non Raffinés"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["junk_battery"] = 1}
RECIPE.result = {["comp_unrefinedchemical"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artwhiskey_chemical"
RECIPE.name = "Whisky Artificiel"
RECIPE.description = "Extraire les composés chimiques non raffinés de cette boisson artificielle."
RECIPE.model = "models/props_junk/garbage_plasticbottle001a.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Non Raffinés"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_whiskey"] = 1}
RECIPE.result = {["comp_unrefinedchemical"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artvodka_chemical"
RECIPE.name = "Vodka Artificielle"
RECIPE.description = "Extraire les composés chimiques non raffinés de cette boisson artificielle."
RECIPE.model = "models/props_junk/garbage_plasticbottle001a.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Non Raffinés"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_vodka"] = 1}
RECIPE.result = {["comp_unrefinedchemical"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artbourbon_chemical"
RECIPE.name = "Bourbon Artificiel"
RECIPE.description = "Une version synthétique du bourbon."
RECIPE.model = "models/props_junk/garbage_plasticbottle001a.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Non Raffinés"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_bourbon"] = 1}
RECIPE.result = {["comp_unrefinedchemical"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artbeer_chemical"
RECIPE.name = "Bière artificielle"
RECIPE.description = "Une boisson rafraîchissante fermentée."
RECIPE.model = "models/props_junk/garbage_plasticbottle001a.mdl"
RECIPE.category = "Susbtances liquides"
RECIPE.subcategory = "Non Raffinés"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_beer"] = 1}
RECIPE.result = {["comp_unrefinedchemical"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()
