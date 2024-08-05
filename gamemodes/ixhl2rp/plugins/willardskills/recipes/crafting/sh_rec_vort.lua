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

RECIPE.uniqueID = "rec_craft_vort_shackles_fake"
RECIPE.name = "Vortigaunt Shackles (fake)"
RECIPE.description = "Metal binds and braces that constrict the limbs and make it painful to move. They are locked in place and cannot be removed once applied."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1, ["comp_refined_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_shackles_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_collar_fake"
RECIPE.name = "Vortigaunt Collar (fake)"
RECIPE.description = "A heavy, metallic collar with borderline alien technology inside. Completely neutralizes a vortigaunt's ability to manipulate energies around them. Once worn, it cannot be removed without the proper tools."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_collar_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 70}, -- full XP
	{level = 30, exp = 35}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_hooks_fake"
RECIPE.name = "Vortigaunt Hooks (fake)"
RECIPE.description = "The base component of both shackles and collars. They fit very tight around the legs. Locked in place, they cannot be removed once applied."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_hooks_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 30}, -- full XP
	{level = 30, exp = 15}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_meat01"
RECIPE.name = "Sustenance Belt"
RECIPE.description = "A collection of delicious, mouth watering headcrab hides, gathered from any and all corners."
RECIPE.model = "models/n7/vorti_outfit/meat01.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["headcrab_skewer"] = 3, ["comp_rivbolts"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_meat01"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 200}, -- full XP
	{level = 10, exp = 100}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_meat02"
RECIPE.name = "Outlands Meat Belt"
RECIPE.description = "A difficult commodity to come by within the veil of the combine, and a welcome delicacy whenever found."
RECIPE.model = "models/n7/vorti_outfit/meat02.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["antlion_skewer"] = 3, ["comp_rivbolts"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_meat02"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full XP
	{level = 10, exp = 150}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_bandanna"
RECIPE.name = "Vortigaunt Bandanna"
RECIPE.description = "Discretion is of the utmost importance. Wouldn't want anyone to know a Vortigaunt was here."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_bandana"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_helmet"
RECIPE.name = "Vortigaunt Helmet"
RECIPE.description = "Protection before practicality. With any luck, the enemy may try to aim a bit higher."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 3, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_head_helmet"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_kevlar"
RECIPE.name = "Vortigaunt Kevlar"
RECIPE.description = "There is no fear for the interval of darkness, but neither is there a hurry to embrace it. A standard set of human kevlar, roughly fitted for vortigaunt use."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 1, ["comp_steel"] = 3, ["comp_rivbolts"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_vest"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full XP
	{level = 40, exp = 75}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_labcoat2"
RECIPE.name = "Vortigaunt Labcoat"
RECIPE.description = "A scientific uniform for vortigaunts seeking a more scientific lifestyle."
RECIPE.model = "models/willardnetworks/clothingitems/torso_labcoat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_doc2"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_labcoat"
RECIPE.name = "Vortigaunt Labcoat with Badge"
RECIPE.description = "A scientific uniform for vortigaunts seeking a more scientific lifestyle. This variant comes complete with a badge."
RECIPE.model = "models/willardnetworks/clothingitems/torso_labcoat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_doc"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_chef_hat"
RECIPE.name = "Vortigaunt Chef Hat"
RECIPE.description = "Vortigaunts are well known for their sheer capability in the culinary arts due to their connection to the Vortessence. The only remaining step for a Vortigaunt to temporarily act like a expert chef is to wear one of these silly hats."
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_head_chefhat"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_hoodie"
RECIPE.name = "Vortigaunt Hoodie"
RECIPE.description = "An elongated hoodie for a longer neck. Perfect for keeping a vortigaunt warm in even the toughest conditions."
RECIPE.model = "models/n7/vorti_outfit/hoodie.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 3, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_hoodie"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 70}, -- full XP
	{level = 20, exp = 35}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_trench_coat"
RECIPE.name = "Vortigaunt Brown Trench Coat"
RECIPE.description = "A sunburned, refurbished trench coat. Ensures that the body is warm and somewhat dry. Doesn't hurt to blend in either."
RECIPE.model = "models/willardnetworks/clothingitems/torso_refugee_coat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_stitched_cloth"] = 4, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light3_tc"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_poncho"
RECIPE.name = "Refined Vortigaunt Poncho"
RECIPE.description = "A reliable and solid covering, It's composition derived from typical human garments. Loose fitting design and convenient cutouts allow for comfort and freedom of movement."
RECIPE.model = "models/n7/vorti_outfit/light01.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 2, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full XP
	{level = 20, exp = 25}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_covering"
RECIPE.name = "Makeshift Vortigaunt Covering"
RECIPE.description = "A simple, plain covering. Good for keeping you snug on a chilly night, and not much else."
RECIPE.model = "models/n7/vorti_outfit/light02.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 2, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light2"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_armour"
RECIPE.name = "Vortigaunt Antlion Guard Plate"
RECIPE.description = "Fashioned from the thick armored hides of fallen Antlion guards, this armor is not only sturdy, but the mark of a seasoned warrior.."
RECIPE.model = "models/n7/vorti_outfit/armor.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["ing_antlion_meat"] = 8, ["comp_steel"] = 3, ["comp_rivbolts"] = 2, ["comp_fabric"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_armor"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 300}, -- full XP
	{level = 40, exp = 150}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}

RECIPE:Register()