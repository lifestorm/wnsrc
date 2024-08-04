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
RECIPE.name = "5-nabojowy magazynek do snajperki"
RECIPE.description = "Magazynek do snajperki"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "17-nabojowy magazynek do USP"
RECIPE.description = "Magazynek do USP"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "20-nabojowy magazynek do Glocka"
RECIPE.description = "Magazynek do Glocka"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "30-nabojowy magazynek do AKM"
RECIPE.description = "Magazynek do AKM"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "30-nabojowy magazynek do broni improwizowanej"
RECIPE.description = "Magazynek do broni improwizowanej"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "30-nabojowy magazynek do M16A2"
RECIPE.description = "Magazynek do M16A2"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "30-nabojowy magazynek do MP"
RECIPE.description = "Magazynek do wariantów pistoletów maszynowych MP."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "6-nabojowy magazynek do Rewolwera"
RECIPE.description = "Magazynek do Rewolwera"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "20-nabojowy magazynek do VSK"
RECIPE.description = "Magazynek do VSK"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "12-nabojowy magazynek do M1911"
RECIPE.description = "Magazynek do M1911"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "8-nabojowy magazynek do Shotguna"
RECIPE.description = "Magazynek do Shotguna"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "2-nabojowy magazynek do Dupleta"
RECIPE.description = "Magazynek do Dupleta"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "5-nabojowy magazynek do Shotguna"
RECIPE.description = "Magazynek do Shotguna"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "15-kulowy magazynek do Tichara"
RECIPE.description = "Magazynek do Tichara"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "8-nabojowy magazynek do Helsinga"
RECIPE.description = "Magazynek do Helsinga"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "30-nabojowy magazynek do AKSU"
RECIPE.description = "Magazynek do AKSU"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "20-nabojowy magazynek do G3"
RECIPE.description = "Magazynek do G3"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "20-nabojowy magazynek do DMR"
RECIPE.description = "Magazynek do DMR"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "50-nabojowy magazynek do P90"
RECIPE.description = "Magazynek do P90"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "35-nabojowy magazynek do PPSH"
RECIPE.description = "Magazynek do PPSH"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "45-nabojowy magazynek do Karabinu Taktycznego"
RECIPE.description = "Magazynek do Karabinu Taktycznego"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "30-nabojowy magazynek do Uzi"
RECIPE.description = "Magazynek do Uzi"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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
RECIPE.name = "7-nabojowy magazynek do Deagle'a"
RECIPE.description = "Magazynek do Deagle'a"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Magazynki"
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