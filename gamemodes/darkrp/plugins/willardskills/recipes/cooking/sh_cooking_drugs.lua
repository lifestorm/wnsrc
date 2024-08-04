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
RECIPE.uniqueID = "cooking_proteinkiller"
RECIPE.name = "Protéines modifiées"
RECIPE.description = "Substance protéique modifiée, emballée et prête à consommer."
RECIPE.model = "models/willardnetworks/food/cmb_food1.mdl"
RECIPE.category = "Nourriture droguée"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["ing_protein"] = 1, ["painkillers"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["drug_proteinkiller"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 15, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_spikedcoffee"
RECIPE.name = "Café modifié"
RECIPE.description = "Boisson chaude à l'arôme prononcé, modifiée pour un effet stimulant."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Nourriture droguée"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_coffee"] = 1, ["basic_green"] = 1}
RECIPE.result = {["drug_spikedcoffee"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 15, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_spikedtea"
RECIPE.name = "Spiked Cup of Tea"
RECIPE.description = "Comforting and warm to the touch but with a sour aftertaste."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Drugged Food"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_tea"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["drug_spikedtea"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 15, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_injectedapple"

RECIPE.name = "Pomme injectée"

RECIPE.name = "Pomme modifiée"

RECIPE.description = "Pomme juteuse et croquante, modifiée pour des “bienfaits améliorés”."
RECIPE.model = "models/willardnetworks/food/apple.mdl"
RECIPE.category = "Nourriture droguée"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["fruit_apple"] = 1, ["comp_syringe"] = 1, ["comp_unrefinedchemical"] = 1}
RECIPE.result = {["drug_injectedapple"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 250}, -- full xp
	{level = 15, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sunshinevodka"
RECIPE.name = "Vodka modifiée"
RECIPE.description = "Alcool distillé modifié pour une saveur unique."
RECIPE.model = "models/willardnetworks/food/vodka.mdl"
RECIPE.category = "Nourriture droguée"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_proc_vodka"] = 1, ["ing_coffee_powder"] = 1, ["comp_unrefinedchemical"] = 1}
RECIPE.result = {["drug_sunshinevodka"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full xp
	{level = 20, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_milkyway"
RECIPE.name = "Milky Way"
RECIPE.description = "Friandise moelleuse et fondante en bouche, légèrement sucrée."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Nourriture droguée"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_milk"] = 1, ["drink_bobenergy"] = 1, ["comp_unrefinedchemical"] = 1}
RECIPE.result = {["drug_milkyway"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full xp
	{level = 20, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_happypie"
RECIPE.name = "Tarte au pomme modifiée"
RECIPE.description = "Pâtisserie aux pommes modifiée pour une texture et un goût exceptionnels."
RECIPE.model = "models/willardnetworks/food/pie.mdl"
RECIPE.category = "Nourriture droguée"
RECIPE.ingredients = {["baking_apple_pie"] = 1, ["basic_red"] = 1, ["basic_green"] = 1}
RECIPE.result = {["drug_happypie"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 25, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()