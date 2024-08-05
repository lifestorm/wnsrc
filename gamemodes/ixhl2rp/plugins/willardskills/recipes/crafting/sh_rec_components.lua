--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Metal
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_iron"
RECIPE.name = "Iron"
RECIPE.description = "Iron made from recycled metal. It is stronger and heavier than before."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 4, ["comp_screws"] = 1}
RECIPE.result = {["comp_iron"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full XP
	{level = 30, exp = 40}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_steel"
RECIPE.name = "Steel"
RECIPE.description = "Reinforced metal sheet made out of iron. Extremely strong and well made."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Components"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 4, ["comp_rivbolts"] = 1}
RECIPE.result = {["comp_steel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 40, exp = 50}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

-- Plastic
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_refined_plastic"
RECIPE.name = "Plastic Sheets"
RECIPE.description = "Plastic sheets. Made from plastic garbage."
RECIPE.model = "models/props_junk/garbage_bag001a.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_plastic"] = 4, ["comp_screws"] = 1}
RECIPE.result = {["comp_refined_plastic"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

-- Nails
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_screws"
RECIPE.name = "Box of Screws"
RECIPE.description = "A box containing nails. They look a bit rusty."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Components"
RECIPE.tool = "tool_toolkit"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_screws"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_rivbolts"
RECIPE.name = "Box of Screws"
RECIPE.description = "A box of sturdy screws, useful for experienced crafters."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_screws"] = 4, ["comp_iron"] = 1}
RECIPE.result = {["comp_rivbolts"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full XP
	{level = 30, exp = 40}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

-- Cloth
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_stitched_cloth"
RECIPE.name = "Stitched Cloth"
RECIPE.description = "A piece of stitched cloth. It's tougher than before."
RECIPE.model = "models/willardnetworks/skills/stitched_cloth.mdl"
RECIPE.category = "Components"
RECIPE.tool = "tool_scissors"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_cloth"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_stitched_cloth"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_fabric"
RECIPE.name = "Fabric"
RECIPE.description = "A piece of fabric. It's quite soft."
RECIPE.model = "models/willardnetworks/skills/fabric.mdl"
RECIPE.category = "Components"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_stitched_cloth"] = 4, ["comp_adhesive"] = 2}
RECIPE.result = {["comp_fabric"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

-- Weapons

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_explosive_material"
RECIPE.name = "Explosive Compound"
RECIPE.description = "Some soft explosive compound. Don't go playing with explosives now."
RECIPE.model = "models/willardnetworks/skills/explosive_material.mdl"
RECIPE.category = "Components"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_chemcomp"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_explosive"] = 1}
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
RECIPE.uniqueID = "rec_comp_weapon_parts"
RECIPE.name = "Weapon Parts"
RECIPE.description = "Metal parts for a weapon."
RECIPE.model = "models/willardnetworks/skills/weaponparts.mdl"
RECIPE.category = "Components"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 2, ["comp_rivbolts"] = 2, ["comp_refined_plastic"] = 1}
RECIPE.result = {["comp_weapon_parts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

-- charcoal
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_charcoal"
RECIPE.name = "Block of Charcoal"
RECIPE.description = "Turn wood into charcoal using some chemical additive and heat."
RECIPE.model = "models/willardnetworks/props/charcoal.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["comp_wood"] = 2, ["comp_chemcomp"] = 1}
RECIPE.result = {["comp_charcoal"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 40}, -- full XP
	{level = 30, exp = 20}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_adhesive"
RECIPE.name = "Handmade Adhesive"
RECIPE.description = "An Adhesive for sticking objects together. Very sticky."
RECIPE.model = "models/willardnetworks/props/glue.mdl"
RECIPE.category = "Components"
RECIPE.ingredients = {["ing_flour"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 120}, -- full xp
	{level = 10, exp = 60}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()