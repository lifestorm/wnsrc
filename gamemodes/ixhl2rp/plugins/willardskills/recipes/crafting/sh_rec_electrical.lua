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
RECIPE.name = "Komputer"
RECIPE.description = "Odnowiony komputer z dostępem do notatek, chodzi na systemie zmodyfikowanym przez Uniwersalną Unię. Przydatny w sklepach."
RECIPE.model = "models/willardnetworks/props/willard_computer.mdl"
RECIPE.category = "Elektronika"
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
RECIPE.name = "Tuner radiowy zatwierdzony przez Kombinat"
RECIPE.description = "Tuner radiowy, za pomocą którego można zmieniać częstotliwości odbieranych przez radio, na które można się dostroić."
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Elektronika"
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
RECIPE.name = "Tuner radiowy ruchu oporu"
RECIPE.description = "Tuner radiowy, za pomocą którego można dowolnie zmieniać częstotliwości odbieranych przez radio."
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Elektronika"
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
RECIPE.name = "Krótkofalówka"
RECIPE.description = "Prawidłowo stworzona krótkofalówka która obsługuje częstotliwość analogową oraz cyfrową."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Elektronika"
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
RECIPE.name = "Stara krótkofalówka"
RECIPE.description = "Własnoręcznie stworzona krótkofalówka, odbiera tylko częstotliwość analogową."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Elektronika"
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
RECIPE.name = "Napraw uszkodzone radio"
RECIPE.description = "Naprawia uszkodzone radio."
RECIPE.model = "models/willardnetworks/skills/handheld_radio.mdl"
RECIPE.category = "Elektronika"
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
RECIPE.name = "Przerobiona drukarka"
RECIPE.description = "Przerobiona drukarka tak aby można było ją używać bez pozwolenia, potrzebuje papieru oraz tuszu."
RECIPE.model = "models/willardnetworks/plotter.mdl"
RECIPE.category = "Elektronika"
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
