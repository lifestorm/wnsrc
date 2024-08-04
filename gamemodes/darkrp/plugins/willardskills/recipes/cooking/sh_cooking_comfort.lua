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
RECIPE.uniqueID = "cooking_noodles"
RECIPE.name = "Nouilles"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Citoyenne"
RECIPE.description = "Le plat traditionnel de Cité 8."
RECIPE.model = "models/willardnetworks/food/noodles.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_noodles"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_noodles"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 25}, -- full xp
	{level = 20, exp = 13}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_toast"
RECIPE.name = "Toast"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Rapide"
RECIPE.description = "Une tranche de pain grillé, croustillante et dorée."
RECIPE.model = "models/willardnetworks/food/toast.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["baking_bread_slice"] = 1}
RECIPE.result = {["comfort_toast"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sandwich"
RECIPE.name = "Sandwich"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Rapide"
RECIPE.description = "Deux tranches de pain garnies de viande, de légumes et de fromage, parfait pour un déjeuner rapide."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["baking_bread_slice"] = 1, ["artificial_meat"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["comfort_sandwich"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_scrambled"
RECIPE.name = "Oeufs brouillés"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Rapide"
RECIPE.description = "Mélange crémeux et coloré d'oeufs."
RECIPE.model = "models/willardnetworks/food/eggmix.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_egg"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["comfort_scrambled"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full xp
	{level = 20, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_comfort_chicken"
RECIPE.name = "Poulet grillé"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Citoyenne"
RECIPE.description = "Du poulet cuit à la grillade pour une saveur fumée et délicieuse."
RECIPE.model = "models/willardnetworks/food/meat4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_chicken"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["comfort_roastedchicken"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full xp
	{level = 20, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_boiledegg"
RECIPE.name = "Oeuf dur"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Rapide"
RECIPE.description = "Un oeuf cuit dans de l'eau bouillante jusqu'à ce que le jaune soit dur et la blanche soit ferme."
RECIPE.model = "models/willardnetworks/food/egg2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["ing_egg"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["luxury_boiled_egg"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full xp
	{level = 20, exp = 40}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pancakes"
RECIPE.name = "Crêpes"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Citoyenne"
RECIPE.description = "Une pile de crêpes moelleuses empilées les unes sur les autres."
RECIPE.model = "models/willardnetworks/food/pancake.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["drink_milk"] = 1}
RECIPE.result = {["comfort_pancake"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full xp
	{level = 30, exp = 40}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_vegsoup"
RECIPE.name = "Soupe aux légumes"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Citoyenne"
RECIPE.description = "Un bol de soupe chaude rempli de légumes flottants dans un bouillon savoureux."
RECIPE.model = "models/willardnetworks/food/vegetablesoup.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_vegetable_pack"] = 2, ["ing_herbs"] = 1, ["crafting_water"] = 2}
RECIPE.result = {["comfort_soup"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 80}, -- full xp
	{level = 40, exp = 40}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_fish"
RECIPE.name = "Steak de saumon"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Citoyenne"
RECIPE.description = "Un morceau de saumon grillé et doré, prêt à être dégusté."
RECIPE.model = "models/willardnetworks/food/fishsteak.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_fish"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_fish"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 150}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_beef"
RECIPE.name = "Rôti de boeuf"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Citoyenne"
RECIPE.description = "Un gros morceau de viande rôti à la perfection, prêt à être découpé en tranches."
RECIPE.model = "models/willardnetworks/food/meat4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_beef"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_beef"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 150}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_apple"
RECIPE.name = "Apple Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "Bitter but sweet apple-flavored artificial ice cream."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["fruit_apple"] = 1}
RECIPE.result = {["cream_apple"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_orange"
RECIPE.name = "Orange Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "A citrus-coated serving of orange-flavored artificial ice cream."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["fruit_orange"] = 1}
RECIPE.result = {["cream_orange"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_banana"
RECIPE.name = "Banana Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "Banana-flavored artificial ice cream filled with your daily dose of calcium… probably."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["fruit_banana"] = 1}
RECIPE.result = {["cream_banana"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_berry"
RECIPE.name = "Berry Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "A concoction of different berry flavors inside a serving of artificial ice cream."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["fruit_berries"] = 1}
RECIPE.result = {["cream_berry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_caramel"
RECIPE.name = "Salted Caramel Peanuts Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "Artificial ice cream infused with salted raw peanuts and chunks of something made to taste like caramel."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["food_peanuts"] = 1, ["ing_sweet"] = 1}
RECIPE.result = {["cream_caramel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_bourbon"
RECIPE.name = "Bourbon Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "A portion of artificial vanilla ice cream with a dash of bourbon poured inside and out."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["drink_bourbon"] = 1}
RECIPE.result = {["cream_bourbon"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_Lemonade"
RECIPE.name = "Lemonade Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "A terribly sour serving of ice cream flavored to taste like lemonade."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["drink_lemonade"] = 1}
RECIPE.result = {["cream_lemonade"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_coffee"
RECIPE.name = "Coffee Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "Dark coffee, but mixed into a faux ice cream form."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["ing_coffee_powder"] = 1}
RECIPE.result = {["cream_coffee"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_pineapple"
RECIPE.name = "Pineapple Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "Real, fresh ice cream served with pineapple juice and chunks within. The perfect mix of sweet and sour."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["fruit_pineapple"] = 1}
RECIPE.result = {["cream_pineapple"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cream_mint"
RECIPE.name = "Mint Chocolate Chip Ice Cream"
RECIPE.category = "Comfort Food"
RECIPE.description = "The magnum opus of ice cream: chocolate bits mixed within a portion of ice cream, perfectly blended with the brush of peppermint inside. The green color with chocolate patterns entice you; this flavor is a rarity, for sure."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.station = {"tool_creammachine"}
RECIPE.ingredients = {["ice_cream_base"] = 1, ["ing_herbs"] = 1, ["luxury_choc"] = 1}
RECIPE.result = {["cream_mint"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()