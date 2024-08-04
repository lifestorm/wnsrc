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
RECIPE.name = "Klej"
RECIPE.description = "Klej do sklejania przedmiotów. Bardzo klejący."
RECIPE.model = "models/willardnetworks/props/glue.mdl"
RECIPE.category = "Komponenty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["comp_adhesive"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_wood"
RECIPE.name = "Odłamki drewna"
RECIPE.description = "Sztacheta drewna, która wydaje się złamana, ale użyteczna."
RECIPE.model = "models/Gibs/wood_gib01a.mdl"
RECIPE.category = "Komponenty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["comp_wood"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_nails_screws"
RECIPE.name = "Pudełko z wkrętami"
RECIPE.description = "Pudełko z wkrętami. Lekko zardzewiałe."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Komponenty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["comp_screws"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_metal_scraps"
RECIPE.name = "Złom"
RECIPE.description = "Kawałki złomu, przydatne przy wytwarzaniu."
RECIPE.model = "models/gibs/manhack_gib01.mdl"
RECIPE.category = "Komponenty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["comp_scrap"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_electronics"
RECIPE.name = "Przewody"
RECIPE.description = "Stare pocięte przewody. Ciekawe do czego służyły..."
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Komponenty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["comp_electronics"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_cloth"
RECIPE.name = "Szmaty z tkaniny"
RECIPE.description = "Kawałki brudnych szmat, można coś z nich wytworzyć."
RECIPE.model = "models/willardnetworks/skills/cloth.mdl"
RECIPE.category = "Komponenty"
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
RECIPE.category = "Komponenty"
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
RECIPE.category = "Komponenty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["comp_chemicals"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()