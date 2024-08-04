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
RECIPE.uniqueID = "rec_wep_frag"
RECIPE.name = "Parça Tesirli El Bombası"
RECIPE.description = "MK3A2 taarruz tipi parça tesirli el bombası."
RECIPE.model = "models/weapons/tfa_mmod/w_grenade_thrown.mdl"
RECIPE.category = "Bombalar"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_explosive"] = 1, ["comp_chemcomp"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["frag_grenade"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100},
	{level = 40, exp = 50},
	{level = 45, exp = 0}
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_wep_flash"
RECIPE.name = "Flaş Bombası"
RECIPE.description = "'Flashbang' olarak da bilinen M84 şok bombası. Patladığında kör edici bir flaş ve sağır edici bir patlama yayar."
RECIPE.model = "models/weapons/tfa_csgo/w_flash.mdl"
RECIPE.category = "Bombalar"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_chemcomp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["flash_grenade"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 80},
	{level = 40, exp = 40},
	{level = 45, exp = 0}
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_wep_smoke"
RECIPE.name = "Duman Bombası"
RECIPE.description = "Model 5210 sis bombası. Gri bir duman perdesi üretir."
RECIPE.model = "models/weapons/tfa_csgo/w_smoke.mdl"
RECIPE.category = "Bombalar"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_chemcomp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["smoke_grenade"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 80},
	{level = 40, exp = 40},
	{level = 45, exp = 0}
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_wep_incendiary"
RECIPE.name = "Yangın Çıkarıcı El Bombası"
RECIPE.description = "4.000 Fahrenheit derecede yanan termat karışımı ile doldurulmuş AN-M14 yangın bombası."
RECIPE.model = "models/weapons/tfa_csgo/wm/w_incend.mdl"
RECIPE.category = "Bombalar"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_explosive"] = 1, ["comp_chemcomp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["incendiary_grenade"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100},
	{level = 40, exp = 50},
	{level = 45, exp = 0}
}
RECIPE:Register()