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
RECIPE.name = "Rękawiczki"
RECIPE.description = "Rękawice to niezbędny element ekwipunku dla każdego, kto chce zabezpieczyć swoje dłonie przed uszkodzeniami czy utratą ciepła."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Dłonie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["hands_gloves"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tipless_gloves"
RECIPE.name = "Mitenki"
RECIPE.description = "Mitenki to rodzaj rękawiczek bez palców, idealny wybór dla tych, którzy chcą zachować dłonie ciepłe, ale wolą swobodę ruchów."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove_fingerless.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Dłonie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["hands_tipless_gloves"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()