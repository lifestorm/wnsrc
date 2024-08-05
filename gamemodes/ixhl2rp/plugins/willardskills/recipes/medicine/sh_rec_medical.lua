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
RECIPE.uniqueID = "rec_disinfectant"
RECIPE.name = "Bottle of Disinfectant"
RECIPE.description = "A bottle of disinfectant, used to cleanse wounds of bacteria."
RECIPE.model = "models/willardnetworks/props/disinfectant.mdl"
RECIPE.category = "Medical"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_alcohol"] = 1, ["comp_purifier"] = 1}
RECIPE.result = {["disinfectant_bottle"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bandage"
RECIPE.name = "Bandage Roll"
RECIPE.description = "A roll of sanitary bandages. Used to stop bleeding."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Medical"
RECIPE.ingredients = {["comp_cloth"] = 4, ["comp_alcohol"] = 1}
RECIPE.result = {["bandage"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_makeshift_into_bandage"
RECIPE.name = "Bandage Roll"
RECIPE.description = "A cloth bandage roll doused in alcohol."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Medical"
RECIPE.ingredients = {["makeshift_bandage"] = 6, ["comp_alcohol"] = 1}
RECIPE.result = {["bandage"] = 6}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_disinfected_bandage"
RECIPE.name = "Disinfected Bandage"
RECIPE.description = "A roll of disinfected sanitary bandages. Used to stop bleeding and clean wounds."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Medical"
RECIPE.ingredients = {["bandage"] = 4, ["disinfectant_bottle"] = 3}
RECIPE.result = {["disinfected_bandage"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_painkillers"
RECIPE.name = "Painkillers"
RECIPE.description = "A package of painkillers. It provides temporary relief from minor pains."
RECIPE.model = "models/willardnetworks/skills/pills1.mdl"
RECIPE.category = "Medical"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1}
RECIPE.result = {["painkillers"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 180}, -- full xp
	{level = 10, exp = 90}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bloodstabilizer"
RECIPE.name = "Blood Stabilizer"
RECIPE.description = "A syringe filled with red compound and painkiller, good to ease pain build recovery."
RECIPE.model = "models/willardnetworks/skills/stimpak.mdl"
RECIPE.category = "Medical"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_bloodsyringe"] = 4, ["comp_chemcomp"] = 2, ["painkillers"] = 1}
RECIPE.result = {["bloodstabilizer"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full xp
	{level = 20, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bloodbag"
RECIPE.name = "Bloodbag"
RECIPE.description = "A plastic bag with a hose and needle attached. It seems to have blood in it."
RECIPE.model = "models/willardnetworks/skills/bloodbag.mdl"
RECIPE.category = "Medical"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_bloodsyringe"] = 4, ["disinfectant_bottle"] = 2, ["comp_plastic"] = 4}
RECIPE.result = {["bloodbag"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 260}, -- full xp
	{level = 20, exp = 130}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_firstaid"
RECIPE.name = "First Aid Kit"
RECIPE.description = "A small red bag with a decent and immediate response to health issues."
RECIPE.model = "models/willardnetworks/skills/medkit.mdl"
RECIPE.category = "Medical"
RECIPE.ingredients = {["bandage"] = 3, ["disinfectant_bottle"] = 3, ["bloodstabilizer"] = 3, ["comp_stitched_cloth"] = 1}
RECIPE.result = {["firstaid"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 260}, -- full xp
	{level = 30, exp = 130}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_adrenaline"
RECIPE.name = "Adrenaline"
RECIPE.description = "A syringe filled with adrenaline. It provides temporary relief from harsh pains."
RECIPE.model = "models/willardnetworks/skills/adrenaline.mdl"
RECIPE.category = "Medical"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_green"] = 1, ["comp_syringe"] = 1}
RECIPE.result = {["adrenaline"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 260}, -- full xp
	{level = 30, exp = 130}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_morphine"
RECIPE.name = "Morphine"
RECIPE.description = "A syringe filled with morphine. It provides relief from severe pain."
RECIPE.model = "models/willardnetworks/skills/adrenaline.mdl"
RECIPE.category = "Medical"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 2, ["basic_red"] = 1, ["comp_syringe"] = 1}
RECIPE.result = {["morphine"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 300}, -- full xp
	{level = 45, exp = 150}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_med_surgerykit"
RECIPE.name = "Surgery Kit"
RECIPE.description = "A red pouch that unfolds to reveal an assortment of surgical tools. Used by medical professionals for immediate aid."
RECIPE.model = "models/willardnetworks/skills/surgicalkit.mdl"
RECIPE.category = "Medical"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["firstaid"] = 1, ["morphine"] = 3, ["bloodbag"] = 3, ["adrenaline"] = 1}
RECIPE.result = {["surgerykit"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 320}, -- full xp
	{level = 45, exp = 160}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_med_xenpotion"
RECIPE.name = "Xen Potion"
RECIPE.description = "Highly exotic alien substance concocted through rare Xen ingredients, bringing incredible organic regeneration."
RECIPE.model = "models/willardnetworks/props/xenpotion3.mdl"
RECIPE.category = "Medical"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["ing_xen_herb"] = 4, ["ing_xenberries"] = 4, ["bottle_vodka"] = 1}
RECIPE.result = {["xen_potion"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full xp
	{level = 50, exp = 0}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()
