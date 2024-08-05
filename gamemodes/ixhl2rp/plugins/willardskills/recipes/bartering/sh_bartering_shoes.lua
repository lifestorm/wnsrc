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
RECIPE.name = "Worn Dark Shoes"
RECIPE.description = "A pair of dark, worn and tired shoes... They have seen too much."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_military.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["shoes_worn_dark"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_worn_brown"
RECIPE.name = "Worn Brown Shoes"
RECIPE.description = "A pair of brown, worn and tired shoes... They have seen too much."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_military.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["shoes_worn_brown"] = 1}
RECIPE:Register()


-- Civ Shoes
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_black"
RECIPE.name = "Black Shoes"
RECIPE.description = "A pair of sturdy shoes for roads and paths no longer kept maintained."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_black_shoes"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_bloke"
RECIPE.name = "Bloke Shoes"
RECIPE.description = "A pair black of sturdy bloke shoes for roads and paths no longer kept maintained."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_bloke"] = 1}
RECIPE:Register()


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_darkblue"
RECIPE.name = "Dark Blue Shoes"
RECIPE.description = "A pair of sturdy shoes for roads and paths no longer kept maintained."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_blue_shoes"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_grey"
RECIPE.name = "Grey Shoes"
RECIPE.description = "A pair of sturdy shoes for roads and paths no longer kept maintained."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_grey"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_brown"
RECIPE.name = "Brown Shoes"
RECIPE.description = "A pair of sturdy shoes for roads and paths no longer kept maintained."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_brown_shoes"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_red"
RECIPE.name = "Dark Red Shoes"
RECIPE.description = "A pair of sturdy shoes for roads and paths no longer kept maintained."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_red"] = 1}
RECIPE:Register()

-- Leather Shoes
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_leather_dark"
RECIPE.name = "Dark Leather Boots"
RECIPE.description = "A pair of dark durable leather boots, ready for the long journey ahead."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_boots.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_leather_dark"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_leather_brown"
RECIPE.name = "Brown Leather Boots"
RECIPE.description = "A pair of brown durable leather boots, ready for the long journey ahead."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_boots.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_leather_brown"] = 1}
RECIPE:Register()