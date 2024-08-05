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
RECIPE.uniqueID = "rec_craft_waterbottle"
RECIPE.name = "Water Bottle"
RECIPE.description = "A refillable plastic bottle. You can fill it up with water."
RECIPE.model = "models/props_junk/garbage_plasticbottle002a.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["comp_plastic"] = 4}
RECIPE.result = {["waterbottle"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_watervalve"
RECIPE.name = "Water Valve"
RECIPE.description = "Used to tap water from pipes."
RECIPE.model = "models/props/de_nuke/hr_nuke/metal_pipe_001/metal_pipe_001_gauge_valve_low.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["comp_scrap"] = 2, ["comp_plastic"] = 2}
RECIPE.result = {["watervalve"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_flashlight"
RECIPE.name = "Handcrafted Flashlight"
RECIPE.description = "Handcrafted flashlight, incredibly useful when exploring the unknown dark."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_electronics"] = 1}
RECIPE.result = {["flashlight"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_scissors"
RECIPE.name = "Scissors"
RECIPE.description = "Snip, snip, snip!"
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Tools"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_plastic"] = 1}
RECIPE.result = {["tool_scissors"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_cooking_pot"
RECIPE.name = "Cooking Pot"
RECIPE.description = "A black, iron cooking pot. Put it on a stove!"
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Tools"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 2, ["comp_plastic"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_cookingpot"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_razor"
RECIPE.name = "Hairdresser tools"
RECIPE.description = "A tool for creative souls in an otherwise depressing landscape."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_adhesive"] = 1, ["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beard_razor"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_kitchen_spoon"
RECIPE.name = "Kitchen Spoon"
RECIPE.description = "Useful for making stews."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_spoon"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_tool_kitchen_knife"
RECIPE.name = "Kitchen Knife"
RECIPE.description = "A thick, semi-blunt knife. Used to cut food on cutting board or surface."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_wood"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_knife"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_frying_pan"
RECIPE.name = "Frying Pan"
RECIPE.description = "A black, iron frying pan. Good for cooking food."
RECIPE.model = "models/props_c17/metalPot002a.mdl"
RECIPE.category = "Tools"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_fryingpan"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_kettle"
RECIPE.name = "Kettle"
RECIPE.description = "A kettle that can drip perfect boiling water."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Tools"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_kettle"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_toolkit"
RECIPE.name = "Toolkit"
RECIPE.description = "A small metal crate containing various construction tools for assembling items."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["comp_scrap"] = 6, ["comp_adhesive"] = 3, ["comp_plastic"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["tool_toolkit"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_tool_tinderbox"
RECIPE.name = "Tinderbox"
RECIPE.description = "A tinderbox to light a campfire."
RECIPE.model = "models/willardnetworks/props/tinderbox.mdl"
RECIPE.category = "Tools"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_cloth"] = 3, ["comp_adhesive"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["tinderbox"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_mixer"
RECIPE.name = "Chemical Mixer"
RECIPE.description = "This seems to be useful for mixing liquids or chemicals together. Its warning label reads: Do not open when in operation"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Workbenches"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_screws"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_mixer"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 200}, -- full xp
	{level = 20, exp = 100}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_wrench"
RECIPE.name = "Wrench"
RECIPE.description = "An old wrench. Could use this for crating."
RECIPE.model = "models/props_c17/tools_wrench01a.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_rivbolts"] = 1}
RECIPE.result = {["tool_wrench"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 70}, -- full xp
	{level = 30, exp = 35}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_chembench"
RECIPE.name = "Chemistry Workbench Kit"
RECIPE.description = "This workbench is specifically designed to maintain the successful mixing of chemical components."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/chemistrystation02.mdl"
RECIPE.category = "Workbenches"
RECIPE.ingredients = {["comp_steel"] = 3, ["comp_wood"] = 4, ["comp_refined_plastic"] = 2}
RECIPE.result = {["tool_chembench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 300}, -- full xp
	{level = 30, exp = 150}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_oven_rusty"
RECIPE.name = "Rusty Oven Assembly Kit"
RECIPE.description = "Looks terrible, is terrible, but will satisfy you in any baking necessities for a time."
RECIPE.model = "models/willardnetworks/skills/oven_shit.mdl"
RECIPE.category = "Workbenches"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_steel"] = 2, ["comp_plastic"] = 4, ["comp_screws"] = 4, ["comp_electronics"] = 2}
RECIPE.result = {["tool_oven_rusty_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_craftingbench"
RECIPE.name = "Crafting Bench Kit"
RECIPE.description = "This workbench is specifically designed to maintain the successful crafting of apparel objects."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/weaponworkbench02.mdl"
RECIPE.category = "Workbenches"
RECIPE.ingredients = {["comp_wood"] = 3, ["comp_iron"] = 1, ["comp_refined_plastic"] = 2, ["comp_rivbolts"] = 3}
RECIPE.result = {["tool_craftingbench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 180}, -- full xp
	{level = 30, exp = 90}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_metalbench"
RECIPE.name = "Metal Workbench Kit"
RECIPE.description = "This workbench is specifically designed to maintain the successful fabrication of weapons or anything similar."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl"
RECIPE.category = "Workbenches"
RECIPE.ingredients = {["comp_steel"] = 4, ["comp_wood"] = 4, ["comp_refined_plastic"] = 4, ["tool_craftingbench_assembly"] = 1}
RECIPE.result = {["tool_metalbench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 600}, -- full xp
	{level = 40, exp = 300}, -- half xp
	{level = 50, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_repair"
RECIPE.name = "Repair Plating"
RECIPE.description = "Handcrafted repair plating, used to repair damaged armor on various clothing."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Tools"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_repair"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full XP
	{level = 40, exp = 50}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_breacher"
RECIPE.name = "Combine Lock Breacher"
RECIPE.description = "A handcrafted device that is placed on combine locks to breach them."
RECIPE.model = "models/transmissions_element120/charger_attachment.mdl"
RECIPE.category = "Tools"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_refined_plastic"] = 1, ["comp_screws"] = 1, ["comp_electronics"] = 2}
RECIPE.result = {["lockbreacher"] = 1}
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full XP
	{level = 50, exp = 0}, -- half XP
	{level = 55, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_refill_zippo_lighter"
RECIPE.name = "Refill Zippo Lighter"
RECIPE.description = "A quality metal lighter made to light up cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/zippo.mdl"
RECIPE.category = "Tools"
RECIPE.ingredients = {["zippolighter"] = 1, ["comp_alcohol"] = 1}
RECIPE.result = {["zippolighter"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()
