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
RECIPE.name = "Pain"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Un pain rond croustillant avec une croûte dorée et une mie moelleuse à l'intérieur."
RECIPE.model = "models/willardnetworks/food/bread_loaf.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_dough"] = 1}
RECIPE.result = {["baking_bread"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artcheese"
RECIPE.name = "Fromage artificiel"
RECIPE.category = "Ingrédients"
RECIPE.description = "Un bloc de fromage synthétique, imitant le goût et la texture du fromage naturel."
RECIPE.model = "models/willardnetworks/food/cheesewheel2c.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["drink_milk"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["artificial_cheese"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_bagel"
RECIPE.name = "Beignet"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Un beignet moelleux recouvert de sucre en poudre."
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
	{level = 10, exp = 150}, -- full xp
	{level = 20, exp = 75}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pretzel"
RECIPE.name = "Bretzel"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Un gros bretzel salé, torsadé en forme de nœud."
RECIPE.model = "models/willardnetworks/food/pretzel.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["baking_pretzel"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_croissant"
RECIPE.name = "Croissant"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Un croissant doré et feuilleté, parfait pour un petit-déjeuner gourmand."
RECIPE.model = "models/willardnetworks/food/croissant.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["baking_croissant"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_doughnut"
RECIPE.name = "Donut"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Un petit beignet rond avec un trou au milieu, recouvert d'un glaçage coloré et sucré."
RECIPE.model = "models/willardnetworks/food/bagel1.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1}
RECIPE.result = {["baking_doughnut"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 40, exp = 75}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pizza"
RECIPE.name = "Cheese Pizza"
RECIPE.category = "Baking"
RECIPE.description = "A classic from times past, the pizza remains much of the same except for a few improvised ingredients here and there."
RECIPE.model = "models/props_junk/garbage_pizzabox01a_fullsheet.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_pastry"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["luxury_norpizza"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 40, exp = 75}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_creamtreat"
RECIPE.name = "Gâterie à la crème"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Un beignet moelleux fourré d'une crème douce et sucrée."
RECIPE.model = "models/willardnetworks/food/creamtreat.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1}
RECIPE.result = {["baking_treat"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 40, exp = 75}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_applepie"
RECIPE.name = "Tarte aux pommes"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Une tarte sucrée et croustillante remplie de pommes fraîches et parfumées."
RECIPE.model = "models/willardnetworks/food/pie.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["fruit_apple"] = 3}
RECIPE.result = {["baking_apple_pie"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sweetroll"
RECIPE.name = "Roulés à la canelle"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Des petits pains sucrés en forme de spirale, avec un glaçage crémeux à la cannelle."
RECIPE.model = "models/willardnetworks/food/sweetroll.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["fruit_berries"] = 3}
RECIPE.result = {["baking_sweetroll"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cheesecake"
RECIPE.name = "Cheesecake"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Patisserie"
RECIPE.description = "Un dessert crémeux et riche, garni de fruits frais ou de coulis."
RECIPE.model = "models/willardnetworks/food/cake.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["artificial_cheese"] = 1, ["fruit_berries"] = 2}
RECIPE.result = {["baking_cheesecake"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()