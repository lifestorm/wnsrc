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
RECIPE.uniqueID = "cooking_bread"
RECIPE.name = "Bread"
RECIPE.category = "Baking"
RECIPE.description = "Even in times such as these, homemade bread can make all the difference."
RECIPE.model = "models/willardnetworks/food/bread_loaf.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_dough"] = 1}
RECIPE.result = {["baking_bread"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 10, exp = 125}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artcheese"
RECIPE.name = "Artificial Cheese"
RECIPE.category = "Baking"
RECIPE.description = "Non-substitute dairy is hard to come by these days, cows are kept around in factories spread throughout the world and aren’t easy to come by."
RECIPE.model = "models/willardnetworks/food/cheesewheel2c.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["drink_milk"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["artificial_cheese"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 10, exp = 125}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_bagel"
RECIPE.name = "Bagel"
RECIPE.category = "Baking"
RECIPE.description = "Through inventive means you're able to procure bagels from bread dough, it's somewhat dry but it'll do nicely."
RECIPE.model = "models/willardnetworks/food/bagel2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_dough"] = 1}
RECIPE.result = {["baking_bagel"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full xp
	{level = 20, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pretzel"
RECIPE.name = "Pretzel"
RECIPE.category = "Baking"
RECIPE.description = "Soft on the inside, with a slightly tougher, chewy exterior. Salty goodness."
RECIPE.model = "models/willardnetworks/food/pretzel.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["baking_pretzel"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 30, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_croissant"
RECIPE.name = "Croissant"
RECIPE.category = "Baking"
RECIPE.description = "The French were very great connoisseurs... before the invasion."
RECIPE.model = "models/willardnetworks/food/croissant.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["baking_croissant"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 30, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_doughnut"
RECIPE.name = "Doughnut"
RECIPE.category = "Baking"
RECIPE.description = "Definitely a sugary deluxe. Do you know who ate them all?"
RECIPE.model = "models/willardnetworks/food/bagel1.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1}
RECIPE.result = {["baking_doughnut"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 250}, -- full xp
	{level = 40, exp = 125}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_creamtreat"
RECIPE.name = "Cream Treat"
RECIPE.category = "Baking"
RECIPE.description = "A delicious sweet cream treat!"
RECIPE.model = "models/willardnetworks/food/creamtreat.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1}
RECIPE.result = {["baking_treat"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 300}, -- full xp
	{level = 40, exp = 150}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_applepie"
RECIPE.name = "Apple Pie"
RECIPE.category = "Baking"
RECIPE.description = "A pie mixed in with apples. How sweet."
RECIPE.model = "models/willardnetworks/food/pie.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["fruit_apple"] = 3}
RECIPE.result = {["baking_apple_pie"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 350}, -- full xp
	{level = 45, exp = 175}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sweetroll"
RECIPE.name = "Sweetroll"
RECIPE.category = "Baking"
RECIPE.description = "A skilled cook has made this sweet and tasteful sweetroll."
RECIPE.model = "models/willardnetworks/food/sweetroll.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["fruit_berries"] = 3}
RECIPE.result = {["baking_sweetroll"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 350}, -- full xp
	{level = 45, exp = 175}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cheesecake"
RECIPE.name = "Brick Cheesecake"
RECIPE.category = "Baking"
RECIPE.description = "A firm cheesecake, often called the Brick Cheesecake. The scarcity of everyday baking ingredients has led to some rather unconventional outcomes."
RECIPE.model = "models/willardnetworks/food/wn_food_cheesecake.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["artificial_cheese"] = 1, ["fruit_berries"] = 2}
RECIPE.result = {["baking_cheesecake"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 350}, -- full xp
	{level = 45, exp = 175}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_xenpie"
RECIPE.name = "Xen Pie"
RECIPE.category = "Baking"
RECIPE.description = "Otherworldly ingredients mixed to become a warm pie. Only a master chef could pull this off."
RECIPE.model = "models/willardnetworks/food/xen_pie.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["ing_xen_herb"] = 2, ["ing_xenberries"] = 4}
RECIPE.result = {["xen_pie"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full xp
	{level = 50, exp = 0}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()