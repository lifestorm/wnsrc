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
RECIPE.uniqueID = "bartering_comp_adhesive"
RECIPE.name = "Adhesive"
RECIPE.description = "An Adhesive for sticking objects together. Very sticky."
RECIPE.model = "models/willardnetworks/props/glue.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["comp_adhesive"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_wood"
RECIPE.name = "Scrap Wood"
RECIPE.description = "Bars of wood that appear broken, but useful."
RECIPE.model = "models/Gibs/wood_gib01a.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["comp_wood"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_screws"
RECIPE.name = "Box of Nails"
RECIPE.description = "A box containing nails. They look a bit rusty."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["comp_screws"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_scraps"
RECIPE.name = "Metal Scraps"
RECIPE.description = "Bits of metal scraps, useful for crafting."
RECIPE.model = "models/gibs/manhack_gib01.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["comp_scrap"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_electronics"
RECIPE.name = "Electronic parts"
RECIPE.description = "Scrapped electronic parts. Wonder what these were used for?"
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["comp_electronics"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_cloth"
RECIPE.name = "Cloth Rags"
RECIPE.description = "A piece of filthy cloth rags, can be used for crafting."
RECIPE.model = "models/willardnetworks/skills/cloth.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_plastic"
RECIPE.name = "Plastic"
RECIPE.description = "Elements of plastic waste. Who knows what it was, before."
RECIPE.model = "models/props_junk/garbage_bag001a.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_chemicals"
RECIPE.name = "Bottle of Cleaning Fluid"
RECIPE.description = "A union branded bottle of chemicals used for 'cleaning'."
RECIPE.model = "models/willardnetworks/skills/medjar.mdl"
RECIPE.category = "Components"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["comp_chemicals"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()