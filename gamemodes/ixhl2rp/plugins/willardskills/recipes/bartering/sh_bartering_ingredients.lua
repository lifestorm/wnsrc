--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Meats
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_leeches"
RECIPE.name = "Tinned Leeches"
RECIPE.description = "Tinned leech. Used for cooking and is certainly not ready for consumption, yet. Contains three raw leeches."
RECIPE.model = "models/willardnetworks/food/cmb_food2.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["ing_tinned_leeches"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_artificial_meat"
RECIPE.name = "Raw Artificial Meat"
RECIPE.description = "Meat substances compressed into a protein block. It's raw and unrefined."
RECIPE.model = "models/willardnetworks/food/steak1.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_artificial_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_artificial_chicken"
RECIPE.name = "Raw Chicken"
RECIPE.description = "An industry collectivized in distant lands, set in foul conditions and factories to produce meat."
RECIPE.model = "models/willardnetworks/food/meat3.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["ing_chicken"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Baking
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_margarine"
RECIPE.name = "Margarine Product"
RECIPE.description = "A tinned can of factory produced margarine. Melts under heat."
RECIPE.model = "models/willardnetworks/food/cmb_food5.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_margarine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_flour"
RECIPE.name = "Saturated Flour"
RECIPE.description = "The paper bag is somewhat padded making it look as if it contains more flour than it actually does. Appears and smells like ordinary flour with a few odd black spots here and there."
RECIPE.model = "models/willardnetworks/food/cmb_food6.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["ing_flour"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_protein"
RECIPE.name = "Egg Protein Package"
RECIPE.description = "A package of powdered protein."
RECIPE.model = "models/willardnetworks/food/cmb_food1.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_protein"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_sweetbar"
RECIPE.name = "Granulated Sweet-Bar"
RECIPE.description = "A crunchy chocolate bar. It actually tastes alright!"
RECIPE.model = "models/willardnetworks/food/cmb_food3.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_sweet"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_milk"
RECIPE.name = "Milk Substitute"
RECIPE.description = "A carton of milk substitute. Certainly looks like milk but is somewhat thinner."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["drink_milk"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Flavourings
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_spices"
RECIPE.name = "Dried Spice Flavouring"
RECIPE.description = "Strange smells emit from the packaging."
RECIPE.model = "models/willardnetworks/food/cmb_food8.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_spices"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_herbs"
RECIPE.name = "Dried Cooking Herbs"
RECIPE.description = "Various dried herbs for cooking."
RECIPE.model = "models/willardnetworks/food/cmb_food7.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_herbs"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_salt"
RECIPE.name = "Salt Pot"
RECIPE.description = "Seemingly a pot of salt with a somewhat odd acidic smell to it…"
RECIPE.model = "models/willardnetworks/foods/salt.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_salt"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_vinegar"
RECIPE.name = "Vinegar"
RECIPE.description = "An aqueous bottle of acidic liquid, smells like a chip shop. Sniffing makes your mouth and eyes water."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_i.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["ing_vinegar"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Vegetables / fruit
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_carrot"
RECIPE.name = "Vegetable Package"
RECIPE.description = "The label reads this package contains a set of vegetables ready to be used for cooking purposes."
RECIPE.model = "models/willardnetworks/foods/vege.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_vegetable_pack"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

-- Misc
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_noodles"
RECIPE.name = "Dried Noodles"
RECIPE.description = "Noodles that are dry and unappettizing. How is this possible?"
RECIPE.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_noodles"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_cheese"
RECIPE.name = "Artificial Cheese Slice"
RECIPE.description = "A slice of Artificial cheese made in a factory somewhere."
RECIPE.model = "models/willardnetworks/food/cheesewheel2c.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["artificial_cheese"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_coffeepowder"
RECIPE.name = "Coffee Powder"
RECIPE.description = "A slightly worn can of coffee powder."
RECIPE.model = "models/willardnetworks/food/wn_food_can.mdl"
RECIPE.skin = 5
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["ing_coffee_powder"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_empty_coffee"
RECIPE.name = "Empty Coffee Cup"
RECIPE.description = "A empty coffee cup."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["junk_coffeecup"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_raw_antlion_meat"
RECIPE.name = "Raw Antlion Meat"
RECIPE.description = "Somewhat slimy alien meat chopped off an antlion. It smells and looks strange."
RECIPE.model = "models/willardnetworks/food/raw_alienmeat.mdl"
RECIPE.category = "Restaurant"
RECIPE.subcategory = "Ingredients"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_antlion_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()