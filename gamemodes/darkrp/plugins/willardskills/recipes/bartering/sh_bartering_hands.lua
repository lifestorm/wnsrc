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
RECIPE.name = "Eldivenler"
RECIPE.description = "Bir çift siyah eldiven. İş, hava durumu ve daha fazlası için iyi."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Eller"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["hands_gloves"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tipless_gloves"
RECIPE.name = "Parmaksız Eldivenler"
RECIPE.description = "Parmak uçları olmayan bir çift siyah eldiven. Parmaklarınızı serbest tutar."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove_fingerless.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Eller"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["hands_tipless_gloves"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()