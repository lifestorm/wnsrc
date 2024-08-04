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
RECIPE.name = "Chargeur de sniper 5RND"
RECIPE.description = "Un chargeur de sniper pouvant contenir 5 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur d'USP 17RND"
RECIPE.description = "Un chargeur d'USP pouvant contenir 17 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de Glock 20RND"
RECIPE.description = "Un chargeur de Glock pouvant contenir 20 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur d'AKM 30RND"
RECIPE.description = "Un chargeur d'AKM pouvant contenir 30 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur d'armes artisanales 30RND"
RECIPE.description = "Un chargeur pour armes artisanales pouvant contenir 30 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de M16A2 30RND"
RECIPE.description = "Un chargeur de M16A2 pouvant contenir 30 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de MP 30RND"
RECIPE.description = "Un chargeur de MP pouvant contenir 30 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de Revolver 6RND"
RECIPE.description = "Un chargeur de Revolver pouvant contenir 6 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de VSK 20RND"
RECIPE.description = "Un chargeur de VSK pouvant contenir 20 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de M1911 12RND"
RECIPE.description = "Un chargeur de M1911 pouvant contenir 12 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de Fusil-à-pompe 8RND"
RECIPE.description = "Un chargeur de Fusil-à-pompe pouvant contenir 8 cartouches."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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

RECIPE.uniqueID = "rec_mag_shotgun5"
RECIPE.name = "Chargeur de Fusil-à-pompe 5RND"
RECIPE.description = "Un chargeur de Fusil-à-pompe pouvant contenir 5 cartouches."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur Tikhar"
RECIPE.description = "Un chargeur pour le fusil Tikhar"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 1}
RECIPE.result = {["magazine_makeshift_15rnd"] = 1}
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
RECIPE.name = "Chargeur Helsing"
RECIPE.description = "Un chargeur pour le fusil Helsing"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur d'AKSU 30RND"
RECIPE.description = "Un chargeur d'AKSU pouvant contenir 30 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de G3 20RND"
RECIPE.description = "Un chargeur de G3 pouvant contenir 20 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de DMR 20RND"
RECIPE.description = "Un chargeur de DMR pouvant contenir 20 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de P90 50RND"
RECIPE.description = "Un chargeur de P90 pouvant contenir 50 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de PPSH 35RND"
RECIPE.description = "Un chargeur de PPSH pouvant contenir 35 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur de TAC 60RND"
RECIPE.description = "Un chargeur de TAC pouvant contenir 60 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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
RECIPE.name = "Chargeur d'UZI 30RND"
RECIPE.description = "Un chargeur d'UZI pouvant contenir 30 balles."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
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

RECIPE.uniqueID = "rec_mag_20_azbats"
RECIPE.name = "Chargeur Azbats"
RECIPE.description = "Un chargeur pour le fusil Azbats"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_metal"] = 2}
RECIPE.result = {["magazine_azbats_20rnd"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_2_duplet"
RECIPE.name = "Chargeur Duplet"
RECIPE.description = "Un chargeur pour le fusil Tikhar"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Chargeurs"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_metal"] = 2}
RECIPE.result = {["magazine_duplet_2rnd"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_mag_30_bastard"
RECIPE.name = "Chargeur bâtard"
RECIPE.description = "Un chargeur pour la mitrailleuse bâtarde"
RECIPE.model = "models/metro2033/bastardgunclip.mdl"
RECIPE.category = "Chargeurs"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_metal"] = 2}
RECIPE.result = {["magazine_bastard_30rnd"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()