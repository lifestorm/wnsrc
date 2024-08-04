--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Worn Shoes
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_worn_dark"
RECIPE.name = "Używane czarne buty"
RECIPE.description = "Para ciemnych, zużytych i zmęczonych butów... Widziały już zbyt wiele."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_military.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["shoes_worn_dark"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_worn_brown"
RECIPE.name = "Używane brązowe buty"
RECIPE.description = "Para brązowych, zużytych i zmęczonych butów... Widziały już zbyt wiele."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_military.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["shoes_worn_brown"] = 1}
RECIPE:Register()


-- Civ Shoes
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_black"
RECIPE.name = "Czarne buty"
RECIPE.description = "Para solidnych butów."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_black_shoes"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_bloke"
RECIPE.name = "Ciemne buty"
RECIPE.description = "Para solidnych butów."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_bloke"] = 1}
RECIPE:Register()


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_darkblue"
RECIPE.name = "Granatowe buty"
RECIPE.description = "Para solidnych butów."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_blue_shoes"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_grey"
RECIPE.name = "Szare buty"
RECIPE.description = "Para solidnych butów."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_grey"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_brown"
RECIPE.name = "Brązowe Buty"
RECIPE.description = "Para solidnych butów."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_brown_shoes"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_red"
RECIPE.name = "Ciemnoczerwone buty"
RECIPE.description = "Para solidnych butów."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_red"] = 1}
RECIPE:Register()

-- Leather Shoes
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_leather_dark"
RECIPE.name = "Buty z czarnej skóry"
RECIPE.description = "Para solidnych butów."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_boots.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_leather_dark"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_leather_brown"
RECIPE.name = "Buty z brązowej skóry"
RECIPE.description = "Para solidnych butów."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_boots.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_leather_brown"] = 1}
RECIPE:Register()