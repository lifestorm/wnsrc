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

RECIPE.uniqueID = "rec_mag_sniper"
RECIPE.name = "5rnd Sniper Magazine"
RECIPE.description = "A Magazine for a sniper that can hold 5rnd."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_sniper"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_usp"
RECIPE.name = "17rnd USP Magazine"
RECIPE.description = "A Magazine for the USP."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_usp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_glock"
RECIPE.name = "20rnd Glock Magazine"
RECIPE.description = "A magazine for the Glock."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_glock"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_akm"
RECIPE.name = "30rnd AKM Magazine"
RECIPE.description = "A magazine for the AKM."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_akm"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_jnk"
RECIPE.name = "30rnd Junk Magazine"
RECIPE.description = "A magazine for the Junk weapons."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_junk30"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_m16"
RECIPE.name = "30rnd M16A2 Magazine"
RECIPE.description = "A magazine for the M16A2."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_m16"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_30_mp"
RECIPE.name = "30rnd MP Magazine"
RECIPE.description = "A magazine for the MP variant Sub-machine guns."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_mp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_popper"
RECIPE.name = "6rnd Revolver Magazine"
RECIPE.description = "A magazine for the Revolver."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_revolver"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_vsv"
RECIPE.name = "20rnd VSK Magazine"
RECIPE.description = "A magazine for the VSK."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_vsv"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_1911"
RECIPE.name = "12rnd M1911 Magazine"
RECIPE.description = "A magazine for the M1911."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_1911"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_shotgun8"
RECIPE.name = "8rnd Shotgun Magazine"
RECIPE.description = "A magazine for the 8rnd Shotguns."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_shotgun"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_shotgun2"
RECIPE.name = "2rnd Duplet Magazine"
RECIPE.description = "A magazine for the 2rnd Duplet Shotgun."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_duplet"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_shotgun5"
RECIPE.name = "5rnd Shotgun Magazine"
RECIPE.description = "A magazine for the 5rnd Shotguns."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_shotgun5"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_15_tikhar"
RECIPE.name = "15rnd Tikhar Magazine"
RECIPE.description = "A Ball Magazine for the Tikhar"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_tikhar_15rnd"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_8_helsing"
RECIPE.name = "8rnd Helsing Magazine"
RECIPE.description = "A bolt magazine for the Helsing."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_helsing"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_aksu"
RECIPE.name = "30rnd AKSU Magazine"
RECIPE.description = "A magazine for the AKSU."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_aksu"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_g3"
RECIPE.name = "20rnd G3 Magazine"
RECIPE.description = "A magazine for the G3."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_g3"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_dmr"
RECIPE.name = "20rnd DMR Magazine"
RECIPE.description = "A magazine for the DMR."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_mini14"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_p90"
RECIPE.name = "50rnd P90 Magazine"
RECIPE.description = "A magazine for the P90."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_p90"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_ppsh"
RECIPE.name = "35rnd PPSH Magazine"
RECIPE.description = "A magazine for the PPSH."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_ppsh"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_tac"
RECIPE.name = "60rnd Tac Magazine"
RECIPE.description = "A magazine for the Tactical Rifle."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_tac60"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_uzi"
RECIPE.name = "30rnd Uzi Magazine"
RECIPE.description = "A magazine for the Uzi."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_uzi"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_deagle"
RECIPE.name = "7rnd Deagle Magazine"
RECIPE.description = "A magazine for the Deagle."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazine"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_deagle"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()