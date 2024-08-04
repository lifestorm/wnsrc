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
RECIPE.uniqueID = "cooking_artificial_skewer"
RECIPE.name = "Brochette de viande artificielle"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Artificielle"
RECIPE.description = "Des morceaux de viande artificielle piqués sur un bâton pour une présentation pratique."
RECIPE.model = "models/willardnetworks/food/meatskewer2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_artificial_meat"] = 2}
RECIPE.result = {["artificial_skewer"] = 5}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 120}, -- full xp
	{level = 10, exp = 80}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_meatpaste"
RECIPE.name = "Pâte de viande artificielle"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Artificielle"
RECIPE.description = "Une pâte à base de viande artificielle pour cuisiner divers plats."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.ingredients = {["proc_paste"] = 1, ["artificial_meat"] = 1}
RECIPE.result = {["artificial_meatpaste"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 120}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_cheesepaste"
RECIPE.name = "Pâte de fromage artificielle"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Artificielle"
RECIPE.description = "Pot blanc de pâte artificielle gluante, complétée par du fromage pour une texture et un remplissage légèrement amélioré."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.ingredients = {["proc_paste"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["artificial_cheesepaste"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 120}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_meat"
RECIPE.name = "Viande artificielle rôtie"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Artificielle"
RECIPE.description = "De la viande artificielle cuite à la rôtissoire pour une saveur grillée."
RECIPE.model = "models/willardnetworks/food/steak2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_artificial_meat"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["artificial_meat"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 120}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_stirfry"
RECIPE.name = "Sauté de viande artificielle"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Artificielle"
RECIPE.description = "De la viande artificielle sautée dans une poêle avec d'autres ingrédients pour un plat savoureux."
RECIPE.model = "models/willardnetworks/food/canned_food2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["artificial_meat"] = 1, ["ing_spices"] = 1, ["ing_noodles"] = 1}
RECIPE.result = {["artificial_stirfry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 29, exp = 80}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_artificial_stew"
RECIPE.name = "Ragoût de viande artificielle"
RECIPE.category = "Nourriture"
RECIPE.subcategory = "Artificielle"
RECIPE.description = "Un plat en sauce à base de viande artificielle et d'autres ingrédients cuits lentement."
RECIPE.model = "models/willardnetworks/food/meatysoup2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_artificial_meat"] = 1, ["ing_sauce"] = 1, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["artificial_stew"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 120}, -- full xp
	{level = 40, exp = 80}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()