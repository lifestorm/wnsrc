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
RECIPE.uniqueID = "rec_artfun"
RECIPE.name = "Artificial Fun"
RECIPE.description = "Mushed up artificial paste with a bit of car battery acid for good measure."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["proc_paste"] = 1, ["ing_protein"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["drug_artificialfun"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 210}, -- full xp
	{level = 20, exp = 105}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_blueberry"
RECIPE.name = "Blue Berry"
RECIPE.description = "A strange vial filled with blue liquid, it tastes like a berry juice but smells disgustingly."
RECIPE.model = "models/willardnetworks/skills/chemical_flask4.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["comp_charcoal"] = 1, ["fruit_berries"] = 1}
RECIPE.result = {["drug_blueberry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 210}, -- full xp
	{level = 20, exp = 105}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ozz"
RECIPE.name = "Ozz's Potion"
RECIPE.description = "Strange liquid in a glass jar, upon opening it has a strong and strange smell. It tastes like gasoline but makes you feel clever and perceptive."
RECIPE.model = "models/props_junk/glassjug01.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["disinfectant_bottle"] = 1}
RECIPE.result = {["drug_ozz"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 210}, -- full xp
	{level = 20, exp = 105}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bobmix"
RECIPE.name = "Bob's Trail Mix"
RECIPE.description = "What would happen if you took the distillate of every bob drink (publicly) available, mixed them together and injected the resulting product right into your arm? Scientists said 'Nothing Good', while the Crackhead down in the slums said 'you ascend'. Go prove one or the other right."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_bobfizz"] = 1, ["drink_bobgrape"] = 1, ["drink_boboriginal"] = 1}
RECIPE.result = {["drug_bobmix"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 210}, -- full xp
	{level = 20, exp = 105}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_darkshot"
RECIPE.name = "Dark Shot"
RECIPE.description = "Blood mixed with various medications, upon consuming it you can feel a burning sensation in your throat."
RECIPE.model = "models/willardnetworks/skills/medjar.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_bloodsyringe"] = 1, ["basic_red"] = 1, ["comp_chemicals"] = 1, ["drink_proc_whiskey"] = 1}
RECIPE.result = {["drug_darkshot"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 240}, -- full xp
	{level = 30, exp = 150}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_demon"
RECIPE.name = "Demon's Bees"
RECIPE.description = "A syringe filled with dark red liquid inside, upon injection you can feel extreme burning sensation in the location of injection."
RECIPE.model = "models/willardnetworks/skills/medx.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_syringe"] = 1, ["painkillers"] = 1, ["comp_chemcomp"] = 1}
RECIPE.result = {["drug_demon"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 240}, -- full xp
	{level = 30, exp = 120}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_speed"
RECIPE.name = "Speed"
RECIPE.description = "A crushed pack of pills mixed in a can. Gives you feeling of being fast."
RECIPE.model = "models/props_junk/popcan01a.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["crafting_water"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["drug_speed"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 240}, -- full xp
	{level = 30, exp = 120}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_thirdeye"
RECIPE.name = "The Third Eye"
RECIPE.description = "A white liquid inside of the syringe, after usage someone could feel increased awareness of the surroundings."
RECIPE.model = "models/willardnetworks/skills/pyscho.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_syringe"] = 1, ["ing_coffee_powder"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["drug_thirdeye"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 240}, -- full xp
	{level = 30, exp = 120}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_transhumano"
RECIPE.name = "Transhumano"
RECIPE.description = "A refined pill that makes you feel ultra-strong, some believe this is what transhumans use."
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["bloodstabilizer"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["drug_transhumano"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_xp"
RECIPE.name = "XP"
RECIPE.description = "Brown liquid in an old bottle, upon smelling to it you can feel really light. It tastes like old cough syrup."
RECIPE.model = "models/willardnetworks/food/wine4.mdl"
RECIPE.category = "Drugs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["morphine"] = 2, ["bottle_wine_white"] = 1, ["orange_pill"] = 1}
RECIPE.result = {["drug_xp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()