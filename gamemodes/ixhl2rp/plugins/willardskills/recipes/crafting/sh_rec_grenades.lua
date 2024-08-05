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
RECIPE.name = "Frag Grenade"
RECIPE.description = "MK3A2 offensive frag grenade."
RECIPE.model = "models/weapons/tfa_mmod/w_grenade_thrown.mdl"
RECIPE.category = "Grenades"
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
RECIPE.name = "Flash Grenade"
RECIPE.description = "M84 stun grenade also known as 'Flashbang'. Emits blinding flash and deafening blast upon detonation."
RECIPE.model = "models/weapons/tfa_csgo/w_flash.mdl"
RECIPE.category = "Grenades"
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
RECIPE.name = "Smoke Grenade"
RECIPE.description = "Model 5210 smoke grenade. Produces a gray smoke screen."
RECIPE.model = "models/weapons/tfa_csgo/w_smoke.mdl"
RECIPE.category = "Grenades"
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
RECIPE.name = "Incendiary Grenade"
RECIPE.description = "AN-M14 incendiary grenade filled with thermate mixture, which burns at 4,000 degrees Fahrenheit."
RECIPE.model = "models/weapons/tfa_csgo/wm/w_incend.mdl"
RECIPE.category = "Grenades"
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