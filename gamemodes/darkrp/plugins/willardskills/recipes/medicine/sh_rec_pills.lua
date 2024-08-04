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
RECIPE.uniqueID = "rec_basicgreen"
RECIPE.name = "Basic Green Pills"
RECIPE.description = "A basic and small green pill. It makes you feel... somewhat faster."
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_green"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_basicblue"
RECIPE.name = "Basic Blue Pills"
RECIPE.description = "A basic and small blue pill. It makes you feel... somewhat more intelligent."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_blue"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_basicred"
RECIPE.name = "Basic Red Pills"
RECIPE.description = "A basic and small red pill. It makes you feel... somewhat stronger."
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_red"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_basicyellow"
RECIPE.name = "Basic Yellow Pills"
RECIPE.description = "A basic and small yellow pill. Your vision seems to have improved slightly."
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_yellow"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_improvedred"
RECIPE.name = "Improved Red Pills"
RECIPE.description = "A small red pill. It makes you feel stronger."
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_red"] = 1}
RECIPE.result = {["improved_red"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_improvedgreen"
RECIPE.name = "Improved Green Pills"
RECIPE.description = "A small green pill. It makes you feel faster."
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_green"] = 1}
RECIPE.result = {["improved_green"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_improvedblue"
RECIPE.name = "Improved Blue Pills"
RECIPE.description = "A small blue pill. It makes you feel more intelligent."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["improved_blue"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_improvedyellow"
RECIPE.name = "Improved Yellow Pills"
RECIPE.description = "A small yellow pill. You can suddenly see a lot more clearly."
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["improved_yellow"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualityred"
RECIPE.name = "Quality Red Pills"
RECIPE.description = "An interesting red pill, its taste much more refined than before. It makes you feel super strong."
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_red"] = 1}
RECIPE.result = {["quality_red"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualitygreen"
RECIPE.name = "Quality Green Pill"
RECIPE.description = "An interesting green pill, its taste much more refined than before. It makes you feel super fast."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_green"] = 1}
RECIPE.result = {["quality_green"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualityblue"
RECIPE.name = "Quality Blue Pills"
RECIPE.description = "An interesting blue pill, its taste much more refined than before. It makes you feel super smart... knowledge is just rushing through the mind."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_blue"] = 1}
RECIPE.result = {["quality_blue"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualityyellow"
RECIPE.name = "Quality Yellow Pills"
RECIPE.description = "An interesting yellow pill, its taste much more refined than before. It improves your vision a lot... is that a spider on my wall?"
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_yellow"] = 1}
RECIPE.result = {["quality_yellow"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_orangepill"
RECIPE.name = "Orange Pills"
RECIPE.description = "This pill seemingly makes you feel a tad stronger and your vision more crisp."
RECIPE.model = "models/willardnetworks/skills/pills7.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["basic_red"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["orange_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 180}, -- full xp
	{level = 30, exp = 90}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_purplepill"
RECIPE.name = "Purple Pills"
RECIPE.description = "This pill seemingly makes you think and run quicker."
RECIPE.model = "models/willardnetworks/skills/pills6.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["basic_green"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["purple_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 180}, -- full xp
	{level = 30, exp = 90}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "medpill_dark"
RECIPE.name = "Dark Pills"
RECIPE.description = "This odd pill made via a complex route of chemistry seemingly boosts all your senses. There's a sort of adrenalina rush to it.."
RECIPE.model = "models/willardnetworks/skills/pills8.mdl"
RECIPE.category = "Boosters"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["orange_pill"] = 1, ["purple_pill"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["dark_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 300}, -- full xp
	{level = 45, exp = 150}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()