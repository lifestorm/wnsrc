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
RECIPE.name = "Ekstrakcja akumulatora samochodowego"
RECIPE.description = "Wyciągnij nierafinowane związki chemiczne ze starego akumulatora samochodowego."
RECIPE.model = "models/Items/car_battery01.mdl"
RECIPE.category = "Ekstrakcja alkoholowa/chemiczna"
RECIPE.subcategory = "Nierafinowane substancje chemiczne"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["junk_battery"] = 1}
RECIPE.result = {["comp_chemicals"] = 2}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artwhiskey_chemical"
RECIPE.name = "Ekstrakcja syntetycznej whiskey"
RECIPE.description = "Wyciągnij nierafinowane związki chemiczne z syntetycznej whiskey."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Ekstrakcja alkoholowa/chemiczna"
RECIPE.subcategory = "Nierafinowane substancje chemiczne"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_whiskey"] = 1}
RECIPE.result = {["comp_chemicals"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artvodka_chemical"
RECIPE.name = "Ekstrakcja syntetycznej wódki"
RECIPE.description = "Wyciągnij nierafinowane związki chemiczne z syntetycznej wódki."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Ekstrakcja alkoholowa/chemiczna"
RECIPE.subcategory = "Nierafinowane substancje chemiczne"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_vodka"] = 1}
RECIPE.result = {["comp_chemicals"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artbourbon_chemical"
RECIPE.name = "Ekstrakcja syntetycznego bourbonu"
RECIPE.description = "Wyciągnij nierafinowane związki chemiczne z syntetycznego bourbonu."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Ekstrakcja alkoholowa/chemiczna"
RECIPE.subcategory = "Nierafinowane substancje chemiczne"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_bourbon"] = 1}
RECIPE.result = {["comp_chemicals"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_artbeer_chemical"
RECIPE.name = "Ekstrakcja syntetycznego piwa"
RECIPE.description = "Wyciągnij nierafinowane związki chemiczne z syntetycznego piwa."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Ekstrakcja alkoholowa/chemiczna"
RECIPE.subcategory = "Nierafinowane substancje chemiczne"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_proc_beer"] = 1}
RECIPE.result = {["comp_chemicals"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()