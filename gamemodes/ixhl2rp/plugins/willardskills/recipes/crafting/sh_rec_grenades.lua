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
RECIPE.name = "Granat odłamkowy"
RECIPE.description = "Ofensywny granat odłamkowy M3A2."
RECIPE.model = "models/weapons/tfa_mmod/w_grenade_thrown.mdl"
RECIPE.category = "Granaty"
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
RECIPE.name = "Granat błyskowo-hukowy"
RECIPE.description = "Granat błyskowo-hukowy M84 znany jako 'flashbang'. Po wybuchu oślepia oraz ogłusza przeciwnika."
RECIPE.model = "models/weapons/tfa_csgo/w_flash.mdl"
RECIPE.category = "Granaty"
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
RECIPE.name = "Granat dymny"
RECIPE.description = "Granat dymny modelu 5210, po wybuchu rozkłębia chmure dymu."
RECIPE.model = "models/weapons/tfa_csgo/w_smoke.mdl"
RECIPE.category = "Granaty"
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
RECIPE.name = "Granat zapalający"
RECIPE.description = "Granat zapalający AN-M14 wypełniony mieszanką termitu która pali się w temperaturze 2200 stopni celsjusza."
RECIPE.model = "models/weapons/tfa_csgo/wm/w_incend.mdl"
RECIPE.category = "Granaty"
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