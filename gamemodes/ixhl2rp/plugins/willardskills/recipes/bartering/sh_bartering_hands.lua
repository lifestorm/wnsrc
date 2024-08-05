--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_gloves"
RECIPE.name = "Gloves"
RECIPE.description = "A pair of black gloves. Good for work, weather, and more."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Hands"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["hands_gloves"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tipless_gloves"
RECIPE.name = "Tipless Gloves"
RECIPE.description = "A pair of black gloves without the fingertips. Keeps your fingers free."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove_fingerless.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Hands"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["hands_tipless_gloves"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()