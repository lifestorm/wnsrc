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
RECIPE.uniqueID = "rec_craft_suitcase"
RECIPE.name = "Suitcase"
RECIPE.description = "A small suitcase ready to carry everything you'd rather not be."
RECIPE.model = "models/weapons/w_suitcase_passenger.mdl"
RECIPE.category = "Storage"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_cloth"] = 2, ["comp_plastic"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["suitcase"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full XP
	{level = 15, exp = 40}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_small_bag"
RECIPE.name = "Small Bag"
RECIPE.description = "A small satchel that rests on your hip."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Storage"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 3, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["smallbag"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full XP
	{level = 15, exp = 40}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_large_bag"
RECIPE.name = "Large Bag"
RECIPE.description = "A backpack with the Combine insignia upon it."
RECIPE.model = "models/willardnetworks/clothingitems/backpack.mdl"
RECIPE.category = "Storage"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["largebag"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 25, exp = 50}, -- half XP
	{level = 30, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_lock"
RECIPE.name = "Padlock"
RECIPE.description = "Sets a password on a container/door when used. Can be shot off but only if the owner is online."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Storage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_screws"] = 1, ["comp_plastic"] = 1}
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_small"
RECIPE.name = "Small Container"
RECIPE.description = "5x3 sized container. Contact an admin to setup this container when you've crafted this item. Needs a container lock item to set a password."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Storage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_refined_plastic"] = 1, ["comp_adhesive"] = 1, ["comp_rivbolts"] = 1}
RECIPE.result = {["container_small_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 25, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_medium"
RECIPE.name = "Medium Container"
RECIPE.description = "5x8 sized container. Contact an admin to setup this container when you've crafted this item. Needs a container lock item to set a password."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Storage"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["container_small_dummy"] = 2, ["comp_rivbolts"] = 2}
RECIPE.result = {["container_medium_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 125}, -- full xp
	{level = 35, exp = 60}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_large"
RECIPE.name = "Large Container"
RECIPE.description = "Requires a 5+ member group - 9x9 sized container. Contact an admin to setup this container. Needs a container lock to set a password."
RECIPE.model = "models/props_wasteland/controlroom_storagecloset001a.mdl"
RECIPE.category = "Storage"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["container_medium_dummy"] = 2, ["comp_rivbolts"] = 2}
RECIPE.result = {["container_large_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 200}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_scrate"
RECIPE.name = "Standard Crate"
RECIPE.description = "6x6 sized container. Contact an admin to setup this container. Needs a container lock to set a password."
RECIPE.model = "models/props_wasteland/controlroom_storagecloset001a.mdl"
RECIPE.category = "Storage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["container_medium_dummy"] = 1, ["comp_wood"] = 2}
RECIPE.result = {["container_scrate_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 25, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_lcrate"
RECIPE.name = "Large Crate"
RECIPE.description = "Requires a 5+ member group - 9x9 sized container. Contact an admin to setup this container. Needs a container lock to set a password."
RECIPE.model = "models/props_wasteland/controlroom_storagecloset001a.mdl"
RECIPE.category = "Storage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["container_large_dummy"] = 1, ["comp_wood"] = 4}
RECIPE.result = {["container_lcrate_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 200}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_safe"
RECIPE.name = "Safe"
RECIPE.description = "An unbreakable safe to keep your items in. (You may have 2 safes on top of the container limit.)"
RECIPE.model = "models/willardnetworks/safe.mdl"
RECIPE.category = "Storage"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 4, ["comp_refined_plastic"] = 3, ["comp_electronics"] = 1, ["comp_rivbolts"] = 2}
RECIPE.result = {["container_safe"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full xp
	{level = 50, exp = 0},
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_grouplock"
RECIPE.name = "Group Lock"
RECIPE.description = "A metal apparatus applied to doors. Requires a group to function."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Storage"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["trash_biolock"] = 1, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.result = {["grouplock"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()