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

RECIPE.uniqueID = "rec_att_trirmr"
RECIPE.name = "Trijicon RMR Red Dot"
RECIPE.description = "A standard red dot sight. Designed to be small to fit on most if not all weapons."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_plastic"] = 2, ["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["scope_eft_rmrlow"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_holosunrds"
RECIPE.name = "Holosun Red Dot"
RECIPE.description = "A standard red dot sight. Designed to be small to fit on most if not all weapons."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_plastic"] = 2, ["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["uc_optic_holosun2"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_holosunrise"
RECIPE.name = "Holosun Red Dot (Riser)"
RECIPE.description = "A standard red dot sight. Designed to be small to fit on most if not all weapons. This version is raised."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_plastic"] = 2, ["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["uc_optic_holosun2"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_eotech552"
RECIPE.name = "Eotech 552"
RECIPE.description = "The Eotech 552 is a small but decent sight for close and medium ranges."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 3, ["comp_plastic"] = 3, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["uc_optic_eotech552"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_eotech553"
RECIPE.name = "Eotech 553"
RECIPE.description = "The Eotech 553 is slightly more raised compared to its 552 cousin."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 3, ["comp_plastic"] = 3, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["uc_optic_eotech553"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_ekp"
RECIPE.name = "Cobra EKP"
RECIPE.description = "A standard sight good for close and medium range."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_plastic"] = 2, ["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["scope_eft_ekp"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_acog"
RECIPE.name = "ACOG TA10NSN (3.5x)"
RECIPE.description = "A classic scope known by many. The ACOG is a decent choice for medium to long range fights."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 4, ["comp_plastic"] = 4, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["scope_eft_acog4x32"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_compactprism"
RECIPE.name = "Compact Prism Scope (2.5x)"
RECIPE.description = "A basic scope that has a decent amount of maginfication. May not be the best due to its small size, but gets the job done at range."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 3, ["comp_plastic"] = 3, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["scope_eft_compactprism"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_mark4"
RECIPE.name = "Mark 4 (4x)"
RECIPE.description = "The Mark 4 scope has 4 times the maginification and is great for long distance fights."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_plastic"] = 3, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["scope_eft_hamr"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_att_mark4back"
RECIPE.name = "Mark 4 w/ Backup (4x)"
RECIPE.description = "The Mark 4 scope has 4 times the maginification and is great for long distance fights. Its backup allows you to switch to a more close range sight at short notice."
RECIPE.model = "models/props_lab/box01a.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_iron"] = 1, ["comp_plastic"] = 4, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["scope_eft_hamr_backup"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()