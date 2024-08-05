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
RECIPE.uniqueID = "rec_elec_computer"
RECIPE.name = "Computer"
RECIPE.description = "A restored computer with access to notes, utilizing a dodgy regime OS, useful tool for stores."
RECIPE.model = "models/willardnetworks/props/willard_computer.mdl"
RECIPE.category = "Electronics"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_plastic"] = 2, ["comp_electronics"] = 4, ["comp_screws"] = 2}
RECIPE.result = {["cit_computer"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 400}, -- full xp
	{level = 40, exp = 200}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()


RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_elec_cmb_tuner"
RECIPE.name = "Combine Approved Radio Tuner"
RECIPE.description = "A radio tuner which can be used to modify the frequencies a radio can tune to."
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Electronics"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_electronics"] = 10, ["comp_screws"] = 2, ["comp_adhesive"] = 2}
RECIPE.result = {["tuner_cmb"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 400}, -- full xp
	{level = 40, exp = 200}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_elec_reb_tuner"
RECIPE.name = "Resistance Radio Tuner"
RECIPE.description = "A radio tuner which can be used to modify the frequencies a radio can tune to. This is a higher range tuner which can reach distant broadcast frequencies."
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Electronics"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_electronics"] = 12, ["comp_rivbolts"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tuner_reb"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 500}, -- full xp
	{level = 46, exp = 250}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_elec_handheld"
RECIPE.name = "Handheld Radio"
RECIPE.description = "A properly made handheld radio supporting analog and digital frequencies."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Electronics"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_electronics"] = 2, ["comp_rivbolts"] = 1, ["comp_refined_plastic"] = 1}
RECIPE.result = {["handheld_radio"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 40, exp = 75}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_elec_old_handheld"
RECIPE.name = "Old Handheld Radio"
RECIPE.description = "Makeshift radio that only supports analog frequencies."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Electronics"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_electronics"] = 1, ["comp_screws"] = 2, ["comp_plastic"] = 2}
RECIPE.result = {["old_radio"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_elec_repair_broken_radio"
RECIPE.name = "Repair Broken Radio"
RECIPE.description = "Repairs your broken radio."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Electronics"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_electronics"] = 4, ["broken_radio"] = 1}
RECIPE.result = {["handheld_radio"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "craft_writing_crackedprinter"
RECIPE.name = "Cracked Printer"
RECIPE.description = "A cracked printer no longer requiring a valid permit. Requires paper and black ink."
RECIPE.model = "models/willardnetworks/plotter.mdl"
RECIPE.category = "Electronics"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["newspaper_printer"] = 1, ["comp_electronics"] = 4}
RECIPE.result = {["newspaper_printer_cracked"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 40, exp = 50}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()
