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

RECIPE.uniqueID = "rec_legs_padded_blue"
RECIPE.name = "Blue Padded Pants"
RECIPE.description = "A pair of padded blue pants, often worn by resistance figures."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel2.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_blue_pants"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_blue_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_legs_padded_black"
RECIPE.name = "Black Padded Pants"
RECIPE.description = "A pair of padded black pants, often worn by resistance figures."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel3.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_civilian_black"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_black_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_legs_padded_green"
RECIPE.name = "Green Padded Pants"
RECIPE.description = "A pair of padded green pants, often worn by resistance figures."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel1.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_civilian_green"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_green_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_green"
RECIPE.name = "Green Resistance Uniform"
RECIPE.description = "A green top with straps. Also has an armplate, perfect for insignias. Provides a small amount of armor."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel02.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["denim_green"] = 1, ["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_iron"] = 1}
RECIPE.result = {["torso_green_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_blue"
RECIPE.name = "Blue Resistance Uniform"
RECIPE.description = "A blue top with straps. Also has an armplate, perfect for insignias. Provides a small amount of armor."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel01.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["denim_blue"] = 1, ["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_iron"] = 1}
RECIPE.result = {["torso_blue_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_medic"
RECIPE.name = "Medical Resistance Uniform"
RECIPE.description = "A medical top with straps. Also has an armplate, perfect for insignias. Provides a small amount of armor."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebelmedic.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["torso_medic_shirt"] = 1, ["comp_adhesive"] = 2, ["comp_iron"] = 1}
RECIPE.result = {["torso_medical_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_helmet"
RECIPE.name = "Helmet"
RECIPE.description = "A metal helmet. It keeps your head safe from falling objects and shrapnel."
RECIPE.model = "models/willardnetworks/clothingitems/head_helmet.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.result = {["head_helmet"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_medichelmet"
RECIPE.name = "Medic Helmet"
RECIPE.description = "A metal medic helmet. It keeps your head safe from falling objects and shrapnel."
RECIPE.model = "models/willardnetworks/clothingitems/head_helmet_med.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.result = {["helmet_medic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_blue"
RECIPE.name = "Blue Beanie"
RECIPE.description = "A blue beanie. Keeps your head warm in the cold."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["head_blue_beanie"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_green"
RECIPE.name = "Green Beanie"
RECIPE.description = "A green beanie. Keeps your head warm in the cold."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["head_green_beanie"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_red"
RECIPE.name = "Red Beanie"
RECIPE.description = "A red beanie. Keeps your head warm in the cold."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_red"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_brown"
RECIPE.name = "Brown Beanie"
RECIPE.description = "A brown beanie. Keeps your head warm in the cold."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_brown"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_grey"
RECIPE.name = "Grey Beanie"
RECIPE.description = "A grey beanie. Keeps your head warm in the cold."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_grey"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_bandana"
RECIPE.name = "Bandana"
RECIPE.description = "A red bandana that wraps around the lower half of the head. Offers slight protection against spores."
RECIPE.model = "models/willardnetworks/clothingitems/head_facewrap.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["face_bandana"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_hands_tipless"
RECIPE.name = "Tipless Gloves"
RECIPE.description = "A pair of black gloves without the fingertips. Keeps your fingers free."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove_fingerless.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["hands_gloves"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["hands_tipless_gloves"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 60}, -- full XP
	{level = 10, exp = 30}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_trenchcoat"
RECIPE.name = "Brown Trench Coat (Unarmoured)"
RECIPE.description = "A brown, worn trench coat. Keeps the rain off, somewhat..."
RECIPE.model = "models/willardnetworks/clothingitems/torso_refugee_coat.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["buttoned_white"] = 1, ["comp_fabric"] = 2, ["comp_adhesive"] = 1, ["comp_iron"] = 2}
RECIPE.result = {["overcoat_trench"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_medic"
RECIPE.name = "Medic Shirt"
RECIPE.description = "A white button down top with a red cross band sewn on."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen_medic.mdl"
RECIPE.category = "Resistance Attire"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["buttoned_white"] = 1, ["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["torso_medic_shirt"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

