--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Beanie
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_brown"
RECIPE.name = "Brown Beanie"
RECIPE.description = "A brown, if not slightly neglected, woolen beanie. Warm and comfortable to sit on your head."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_brown"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_grey"
RECIPE.name = "Grey Beanie"
RECIPE.description = "A grey, if not slightly neglected, woolen beanie. Warm and comfortable to sit on your head."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_grey"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_red"
RECIPE.name = "Red Beanie"
RECIPE.description = "A red, if not slightly neglected, woolen beanie. Warm and comfortable to sit on your head."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_red"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_blue"
RECIPE.name = "Blue Beanie"
RECIPE.description = "A blue, if not slightly neglected, woolen beanie. Warm and comfortable to sit on your head."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["head_blue_beanie"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_green"
RECIPE.name = "Green Beanie"
RECIPE.description = "A green, if not slightly neglected, woolen beanie. Warm and comfortable to sit on your head."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["head_green_beanie"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

-- Non-colorable
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_boonie"
RECIPE.name = "Boonie Hat"
RECIPE.description = "A wide rimmed hat. Keeps the sun off your head."
RECIPE.model = "models/willardnetworks/clothingitems/head_boonie.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["head_boonie_hat"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_chef"
RECIPE.name = "Chef Hat"
RECIPE.description = "A tall, white hat. Worn by those who are supposed to be good at cooking."
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_chef_hat"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_cap"
RECIPE.name = "Flat Cap"
RECIPE.description = "A stylish old-school cap that is flat on the head."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat2.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_flat_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_visor"
RECIPE.name = "Visor Cap"
RECIPE.description = "A hat with a visor. It keeps the sun out of your eyes."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_visor_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_military_cap"
RECIPE.name = "Military Cap"
RECIPE.description = "A cap with worn out military insignia."
RECIPE.model = "models/willardnetworks/clothingitems/head_confederatehat.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["head_military_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

-- Glasses
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_glasses"
RECIPE.name = "Glasses"
RECIPE.description = "A pair of black, square rimmed glasses. Helps you see."
RECIPE.model = "models/willardnetworks/clothingitems/glasses.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["glasses"] = 1}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_aviators"
RECIPE.name = "Aviator Glasses"
RECIPE.description = "A pair of stylish aviator glasses, reminiscent of the past."
RECIPE.model = "models/willardnetworks/clothingitems/head_aviators.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["aviators"] = 1}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_70s"
RECIPE.name = "70s Glasses"
RECIPE.description = "A pair of vintage 70s glasses with a brown frame."
RECIPE.model = "models/willardnetworks/clothingitems/head_glasses_70s.mdl"
RECIPE.category = "Clothing"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["70sglasses"] = 1}
RECIPE:Register()