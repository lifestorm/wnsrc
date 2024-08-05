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
RECIPE.uniqueID = "rec_comp_adhesive"
RECIPE.name = "Adhesive"
RECIPE.description = "An Adhesive for sticking objects together. Very sticky."
RECIPE.model = "models/willardnetworks/props/glue.mdl"
RECIPE.category = "Ingredients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["ing_flour"] = 1, ["ing_vinegar"] = 1, ["comp_alcohol"] = 1}
RECIPE.result = {["comp_adhesive"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_chemcomp"
RECIPE.name = "Refined Chemicals"
RECIPE.description = "A dangerous, toxic substance disposed for radioactive emittance. Be careful."
RECIPE.model = "models/willardnetworks/skills/medjar.mdl"
RECIPE.category = "Ingredients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemicals"] = 1, ["comp_alcohol"] = 1}
RECIPE.result = {["comp_chemcomp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_purifier"
RECIPE.name = "Purifier"
RECIPE.description = "Strange dust which can purify any mixture or substance of any toxic compounds"
RECIPE.model = "models/willardnetworks/skills/pill_bottle.mdl"
RECIPE.category = "Ingredients"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["comp_chemicals"] = 2}
RECIPE.result = {["comp_purifier"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()