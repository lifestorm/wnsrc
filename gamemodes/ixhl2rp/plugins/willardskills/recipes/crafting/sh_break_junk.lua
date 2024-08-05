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

RECIPE.uniqueID = "rec_junk_tv"
RECIPE.name = "Breakdown TV Monitor"
RECIPE.description = "A broken monitor from an old television. It's worthless, but memories aren't."
RECIPE.model = "models/props_wasteland/controlroom_monitor001a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_tv"] = 1}
RECIPE.result = {["comp_electronics"] = 1, ["comp_plastic"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 55}, -- full xp
	{level = 20, exp = 27}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_toy"
RECIPE.name = "Breakdown Toy"
RECIPE.description = "Don't see these too often these days. It's made out of wood."
RECIPE.model = "models/props_c17/playgroundTick-tack-toe_block01a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_toy"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tire"
RECIPE.name = "Breakdown Tire"
RECIPE.description = "Reminds you of old times, back when cars used to be a thing."
RECIPE.model = "models/props_vehicles/carparts_tire01a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["junk_tire"] = 1}
RECIPE.result = {["comp_plastic"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tincan"
RECIPE.name = "Breakdown Tincan"
RECIPE.description = "A small tin can that ultimately held food. It's useless to you."
RECIPE.model = "models/props_junk/garbage_metalcan002a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_tincan"] = 1}
RECIPE.result = {["comp_scrap"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_takeaway"
RECIPE.name = "Breakdown Takeaway"
RECIPE.description = "Found in a pile of trash, probably contained noodles at some point."
RECIPE.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_takeaway"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_sm_cardboard"
RECIPE.name = "Breakdown Small Cardboard Box"
RECIPE.description = "A small cardboard box for carrying consumer products. It's empty."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_sm_cardboard"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_shoe"
RECIPE.name = "Breakdown Shoe"
RECIPE.description = "A brown shoe, probably belonged to someone before."
RECIPE.model = "models/props_junk/Shoe001a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_shoe"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_receiver"
RECIPE.name = "Breakdown Broken Receiever"
RECIPE.description = "A broken piece of electronic equipment. It doesn't work anymore."
RECIPE.model = "models/props_lab/reciever01c.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_receiver"] = 1}
RECIPE.result = {["comp_screws"] = 1, ["comp_electronics"] = 1, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plastic_bucket"
RECIPE.name = "Breakdown Plastic Bucket"
RECIPE.description = "A grimey plastic bucket, probably used to store chemicals."
RECIPE.model = "models/props_junk/plasticbucket001a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_plastic_bucket"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plasticcrate"
RECIPE.name = "Breakdown Plastic Crate"
RECIPE.description = "A plastic container. It's not much worth to you."
RECIPE.model = "models/props_junk/PlasticCrate01a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_plasticcrate"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plantpot"
RECIPE.name = "Breakdown Plantpot"
RECIPE.description = "A pot used for planting and gardening. It has no use."
RECIPE.model = "models/props_junk/terracotta01.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_plantpot"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_pipe"
RECIPE.name = "Breakdown Flimsy Metal Pipe"
RECIPE.description = "A flimsy metal pipe. It's not very useful as a weapon."
RECIPE.model = "models/props_canal/mattpipe.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_pipe"] = 1}
RECIPE.result = {["comp_scrap"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_paintcan"
RECIPE.name = "Breakdown Empty Paintcan"
RECIPE.description = "An empty can of paint. It's useless to you."
RECIPE.model = "models/props_junk/metal_paintcan001b.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_paintcan"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_mug"
RECIPE.name = "Breakdown Mug"
RECIPE.description = "A plastic mug with nothing in it."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_mug"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_pc_monitor"
RECIPE.name = "Breakdown PC Monitor"
RECIPE.description = "There were many plans for this device, alas it never came to be."
RECIPE.model = "models/props_lab/monitor01a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_pc_monitor"] = 1}
RECIPE.result = {["comp_plastic"] = 2, ["comp_electronics"] = 1, ["comp_scrap"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_lamp"
RECIPE.name = "Breakdown Lamp"
RECIPE.description = "Broke and useless, this lamp doesn't serve much of a purpose anymore."
RECIPE.model = "models/props_lab/desklamp01.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_lamp"] = 1}
RECIPE.result = {["comp_plastic"] = 2, ["comp_screws"] = 1, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_keyboard"
RECIPE.name = "Breakdown Trash Keyboard"
RECIPE.description = "A broken keyboard with next to no value."
RECIPE.model = "models/props_c17/computer01_keyboard.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_keyboard"] = 1}
RECIPE.result = {["comp_electronics"] = 1, ["comp_plastic"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_jug"
RECIPE.name = "Breakdown Empty Jug"
RECIPE.description = "Empty plastic jug, needs a good cleaning."
RECIPE.model = "models/props_junk/garbage_milkcarton001a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_jug"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_jar"
RECIPE.name = "Breakdown Empty Jar"
RECIPE.description = "An empty jar, suitable for containing jam or something similar. It's useless."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_jar"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_empty_bottle"
RECIPE.name = "Breakdown Empty Bottle"
RECIPE.description = "Breakdown an empty bottle."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_empty_bottle"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_fruitjuice"
RECIPE.name = "Empty Juice Carton"
RECIPE.description = "Breakdown an empty plastic juice carton."
RECIPE.model = "models/props_junk/garbage_plasticbottle003a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_empty_fruitjuice"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_emptyvial"
RECIPE.name = "Breakdown Empty Health Vial"
RECIPE.description = "Breakdown an empty health vial."
RECIPE.model = "models/willardnetworks/syringeemptyy.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_emptyvial"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_gear"
RECIPE.name = "Breakdown Metal Gear"
RECIPE.description = "Piece of metallic equipment once suitable for something worthwhile. It's worthless, now."
RECIPE.model = "models/props_wasteland/gear02.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_gear"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 40}, -- full xp
	{level = 20, exp = 20}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_gascan"
RECIPE.name = "Breakdown Empty Gascan"
RECIPE.description = "An empty gas canister used for carrying fuel or something similar. It's empty."
RECIPE.model = "models/props_junk/metalgascan.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_gascan"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_fridge_door"
RECIPE.name = "Breakdown Refrigerator Door"
RECIPE.description = "A broken door that was once attached to a fridge. It's heavy and cold."
RECIPE.model = "models/props_interiors/refrigeratordoor02a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_fridgedoor"] = 1}
RECIPE.result = {["comp_scrap"] = 4, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 40, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_frame"
RECIPE.name = "Breakdown Frame"
RECIPE.description = "Wooden frames. Probably used for fitting a window. It's useless."
RECIPE.model = "models/props_c17/frame002a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_frame"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tattered_drawer"
RECIPE.name = "Breakdown Tattered Drawer"
RECIPE.description = "Belonged to someone's home not too long ago."
RECIPE.model = "models/props_c17/FurnitureDrawer001a_Chunk01.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_tattered_drawer"] = 1}
RECIPE.result = {["comp_wood"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_doll"
RECIPE.name = "Breakdown Doll"
RECIPE.description = "An old, ruined doll from a bygone generation long forgotten."
RECIPE.model = "models/props_c17/doll01.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_doll"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_coffeecup"
RECIPE.name = "Breakdown Empty Coffee Cup"
RECIPE.description = "An empty plastic coffee cup."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_coffeecup"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_computerparts"
RECIPE.name = "Breakdown Computer Parts"
RECIPE.description = "Old pre-war parts for early early 2000s era computers. Rather unimpressive."
RECIPE.model = "models/props_lab/harddrive01.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_computerparts"] = 1}
RECIPE.result = {["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 70}, -- full xp
	{level = 10, exp = 35}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_computer_tower"
RECIPE.name = "Breakdown Computer Tower"
RECIPE.description = "Should be possible to get working again or be dismantled for resources."
RECIPE.model = "models/props_lab/harddrive01.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_computer_tower"] = 1}
RECIPE.result = {["comp_electronics"] = 2, ["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_clock"
RECIPE.name = "Breakdown Clock"
RECIPE.description = "...Time, is it really that time again?"
RECIPE.model = "models/props_combine/breenclock.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_clock"] = 1}
RECIPE.result = {["comp_wood"] = 2, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_carton"
RECIPE.name = "Breakdown Empty Milk Carton"
RECIPE.description = "A small plastic carton. It probably carried something of liquid form."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_carton"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_cardboard"
RECIPE.name = "Breakdown Cardboard Box"
RECIPE.description = "A cardboard box for carrying consumer products. It's empty."
RECIPE.model = "models/props_junk/cardboard_box003a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_cardboard"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_bucket"
RECIPE.name = "Breakdown Metal Bucket"
RECIPE.description = "A metal bucket used for carrying small items within."
RECIPE.model = "models/props_junk/MetalBucket01a.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_bucket"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_empty_can"
RECIPE.name = "Breakdown Empty Metal Can"
RECIPE.description = "Recycle a metal can."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_empty_can"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_biolock"
RECIPE.name = "Breakdown Broken Biolock"
RECIPE.description = "Biolock but its broken. What a shame."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["trash_biolock"] = 1}
RECIPE.result = {["comp_scrap"] = 4, ["comp_electronics"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_cigarettepack"
RECIPE.name = "Breakdown Cigarette Pack"
RECIPE.description = "Crumble and tear the cigarette pack into its basic component."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["ciggie_pack"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_plushie"
RECIPE.name = "Breakdown Turtle Plushie"
RECIPE.description = "A soft Turtle Plushie, it serves no purpose yet it’s presence is known. A small label is attached with the name 'Mullin'.... How odd."
RECIPE.model = "models/willardnetworks/skills/turtle.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.ingredients = {["junk_turtle"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_battery"
RECIPE.name = "Breakdown Car Battery"
RECIPE.description = "An old Car battery from the old world."
RECIPE.model = "models/Items/car_battery01.mdl"
RECIPE.category = "Breakdown"
RECIPE.subcategory = "Junk"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_battery"] = 1}
RECIPE.result = {["comp_scrap"] = 2, ["comp_chemicals"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()
