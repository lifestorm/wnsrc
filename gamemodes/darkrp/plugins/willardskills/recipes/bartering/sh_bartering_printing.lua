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
RECIPE.uniqueID = "bartering_printing_paper"
RECIPE.name = "Kağıt"
RECIPE.description = "Üzerine yazılacak bir kağıt."
RECIPE.model = "models/props_c17/paper01.mdl"
RECIPE.category = "Baskı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["paper"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_black_ink"
RECIPE.name = "Siyah Mürekkep"
RECIPE.description = "Siyah mürekkep yazıcı kartuşu."
RECIPE.model = "models/gibs/metal_gib2.mdl"
RECIPE.category = "Baskı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["black_ink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_newspaper_printer"
RECIPE.name = "Gazete Yazıcısı"
RECIPE.description = "Gazete yazdırır, kağıt, siyah mürekkep ve iş izni gerektirir."
RECIPE.model = "models/willardnetworks/plotter.mdl"
RECIPE.category = "Baskı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["newspaper_printer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()