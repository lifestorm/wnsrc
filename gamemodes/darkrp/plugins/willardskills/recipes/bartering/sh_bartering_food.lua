--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Snacks

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_berries"
RECIPE.name = "Berries"
RECIPE.description = "A bunch of sweet berries."
RECIPE.model = "models/willardnetworks/food/berries01.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["fruit_berries"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_peanuts"
RECIPE.name = "Salted Peanuts"
RECIPE.description = "A light snack, this combine embellished box contains salted peanuts."
RECIPE.model = "models/willardnetworks/food/peats.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["food_peanuts"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_crisps"
RECIPE.name = "Potato Crisps"
RECIPE.description = "A light snack, this green embellished plastic bag contains salted crisps."
RECIPE.model = "models/willardnetworks/food/snack01.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["food_crisps"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()
local RECIPE = ix.recipe:New()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_crackers"
RECIPE.name = "Potato Crackers"
RECIPE.description = "A light snack, this red embellished plastic bag contains crackers."
RECIPE.model = "models/willardnetworks/food/snack02.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["food_crackers"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_apple"
RECIPE.name = "Apple"
RECIPE.description = "It keeps the medics away for an entire day."
RECIPE.model = "models/willardnetworks/food/apple.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["fruit_apple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_banana"
RECIPE.name = "Banana"
RECIPE.description = "Peel away and eat."
RECIPE.model = "models/willardnetworks/food/bananna.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["fruit_banana"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_orange"
RECIPE.name = "Orange"
RECIPE.description = "A bumpy, tangy orange."
RECIPE.model = "models/willardnetworks/food/orange.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["fruit_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bar_cream_apple"
RECIPE.name = "Apple Ice Cream"
RECIPE.description = "Bitter but sweet apple-flavored artificial ice cream."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["cream_apple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bar_cream_orange"
RECIPE.name = "Orange Ice Cream"
RECIPE.description = "A citrus-coated serving of orange-flavored artificial ice cream."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["cream_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bar_cream_banana"
RECIPE.name = "Banana Ice Cream"
RECIPE.description = "Banana-flavored artificial ice cream filled with your daily dose of calcium… probably."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["cream_banana"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bar_cream_berry"
RECIPE.name = "Berry Ice Cream"
RECIPE.description = "A concoction of different berry flavors inside a serving of artificial ice cream."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["cream_berry"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bar_cream_lemonade"
RECIPE.name = "Lemonade Ice Cream"
RECIPE.description = "A terribly sour serving of ice cream flavored to taste like lemonade."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["cream_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bar_cream_bourbon"
RECIPE.name = "Bourbon Ice Cream"
RECIPE.description = "A portion of artificial vanilla ice cream with a dash of bourbon poured inside and out."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["cream_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bar_cream_coffee"
RECIPE.name = "Coffee Ice Cream"
RECIPE.description = "Dark coffee, but mixed into a faux ice cream form."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 18
RECIPE.result = {["cream_coffee"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bar_cream_caramel"
RECIPE.name = "Salted Caramel Peanuts Ice Cream"
RECIPE.description = "Artificial ice cream infused with salted raw peanuts and chunks of something made to taste like caramel."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 18
RECIPE.result = {["cream_caramel"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_sandwich"
RECIPE.name = "Sandwich"
RECIPE.description = "Very popular in City Two, a sandwich of artificial meat and cheese."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 22
RECIPE.result = {["comfort_sandwich"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Foods
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_artskewer"
RECIPE.name = "Skewered Artificial Meat"
RECIPE.description = "A protein block of meat skewed and produced as ready to eat."
RECIPE.model = "models/willardnetworks/food/meatskewer2.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["artificial_skewer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_breadslice"
RECIPE.name = "Bread Slice"
RECIPE.description = "A slice of fresh bread. Doesn't fill you up much on its own but it'll do."
RECIPE.model = "models/willardnetworks/food/bread_slice.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["baking_bread_slice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_halfbread"
RECIPE.name = "Halved Bread"
RECIPE.description = "Half a loaf of bread ready to be consumed."
RECIPE.model = "models/willardnetworks/food/bread_half.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["baking_bread_half"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_cookednoodles"
RECIPE.name = "Cooked Noodles"
RECIPE.description = "Even during the occupation.. Noodles remain a popular choice for food."
RECIPE.model = "models/willardnetworks/food/noodles.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["comfort_noodles"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_bagel"
RECIPE.name = "Bagel"
RECIPE.description = "Through inventive means you're able to procure bagels from bread dough, it's somewhat dry but it'll do nicely."
RECIPE.model = "models/willardnetworks/food/bagel2.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["baking_bagel"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_roastedartmeat"
RECIPE.name = "Roasted Artificial Meat"
RECIPE.description = "A protein block of Artificial meat for easy consumption."
RECIPE.model = "models/willardnetworks/food/steak2.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["artificial_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_vegsoup"
RECIPE.name = "Vegetable Soup"
RECIPE.description = "A warm bowl of healthy vegetable soup, a good way to keep a steady mind."
RECIPE.model = "models/willardnetworks/food/vegetablesoup.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["comfort_soup"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_watermelon"
RECIPE.name = "Watermelon"
RECIPE.description = "A large, round, green fruit. Rather pink inside!"
RECIPE.model = "models/willardnetworks/food/watermelon_unbreakable.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["fruit_watermelon"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_cookedantlionmeat"
RECIPE.name = "Roasted Antlion Meat"
RECIPE.description = "A roasted slab of antlion meat, doesn't fill you up as much as you'd like it to, it's quite stringy and carries an odd texture."
RECIPE.model = "models/willardnetworks/food/cooked_alienmeat.mdl"
RECIPE.category = "Food"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["antlion_roast"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()