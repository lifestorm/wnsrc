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
RECIPE.name = "5rnd Sniper Şarjörü"
RECIPE.description = "5 mermi alabilen bir sniper şarjörü."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "17rnd USP Şarjörü"
RECIPE.description = "USP için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "20rnd Glock Şarjörü"
RECIPE.description = "Glock için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "30rnd AKM Şarjörü"
RECIPE.description = "AKM'ye ait bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "30rnd Hurda Şarjör"
RECIPE.description = "Hurda silahlar için bir şajör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "30rnd M16A2 Şarjörü"
RECIPE.description = "M16A2 için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "30rnd MP Şarjörü"
RECIPE.description = "MP varyantı hafif makineli tüfekler için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "6rnd Revolver Şarjörü"
RECIPE.description = "Revolver için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "20rnd VSK Şarjörü"
RECIPE.description = "VSK için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "12rnd M1911 Şarjörü"
RECIPE.description = "M1911 için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "8rnd Shotgun Şarjörü"
RECIPE.description = "Shotgun için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.category = "Şarjörler"
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
RECIPE.name = "5rnd Shotgun Şarjörü"
RECIPE.description = "Shotgun için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "15rnd Tikhar Şarjörü"
RECIPE.description = "Tikhar için Bir Top Şarjörü"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "8rnd Helsing Şarjörü"
RECIPE.description = "Helsing için bir sürgü şarjörü."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "30rnd AKSU Şarjörü"
RECIPE.description = "AKSU için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "20rnd G3 Şarjörü"
RECIPE.description = "G3 için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "20rnd DMR Şarjörü"
RECIPE.description = "DMR için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "50rnd P90 Şarjörü"
RECIPE.description = "P90 için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "35rnd PPSH Şarjörü"
RECIPE.description = "PPSH için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "60rnd Tac Şarjörü"
RECIPE.description = "Taktiksel Tüfek için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.name = "30rnd Uzi Şarjör"
RECIPE.description = "Uzi için bir şarjör."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Şarjörler"
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
RECIPE.category = "Şarjörler"
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