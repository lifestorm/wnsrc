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
RECIPE.name = "Proteinowy Zabójca"
RECIPE.description = "Sproszkowane białko zmieszane z lekami przeciwbólowymi i Wodą Breena."
RECIPE.model = "models/willardnetworks/food/cmb_food1.mdl"
RECIPE.category = "Narkotyzowana żywność"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["ing_protein"] = 1, ["painkillers"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["drug_proteinkiller"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 400}, -- full xp
	{level = 15, exp = 250}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_spikedcoffee"
RECIPE.name = "Zaprawiony kubek kawy"
RECIPE.description = "Ciepła kubek kawy pomaga zachować czujność i przytomność w tych dziwnych czasach, ta wydaje się nawet bardziej niż zwykle."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Narkotyzowana żywność"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_coffee"] = 1, ["basic_green"] = 1}
RECIPE.result = {["drug_spikedcoffee"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full xp
	{level = 15, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_spikedtea"
RECIPE.name = "Zaprawiony kubek herbaty"
RECIPE.description = "Komfortowa i ciepła w dotyku, ale z cierpkim posmakiem."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Narkotyzowana żywność"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_tea"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["drug_spikedtea"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full xp
	{level = 15, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_injectedapple"
RECIPE.name = "Jabłuszko"
RECIPE.description = "Wygląda jak każde inne jabłko, choć z nieco zabawnym posmakiem..."
RECIPE.model = "models/willardnetworks/food/apple.mdl"
RECIPE.category = "Narkotyzowana żywność"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["fruit_apple"] = 1, ["comp_syringe"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["drug_injectedapple"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full xp
	{level = 15, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sunshinevodka"
RECIPE.name = "Wódka 'Sunshine'"
RECIPE.description = "Wódka 'Sunshine' to napój, który nieraz potrafi rozgrzać i ożywić nawet najbardziej zmarznięte ciała. To idealny wybór dla tych, którzy lubią czyste i mocne alkohole."
RECIPE.model = "models/willardnetworks/food/vodka.mdl"
RECIPE.category = "Narkotyzowana żywność"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_proc_vodka"] = 1, ["ing_coffee_powder"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["drug_sunshinevodka"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 350}, -- full xp
	{level = 20, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_milkyway"
RECIPE.name = "Milky Way"
RECIPE.description = "Nareszcie możesz połączyć się z wszechświatem w całość... Przynajmniej przez chwilę..."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Narkotyzowana żywność"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drink_milk"] = 1, ["drink_bobenergy"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["drug_milkyway"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 300}, -- full xp
	{level = 20, exp = 150}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_happypie"
RECIPE.name = "Szczęśliwy placuszek"
RECIPE.description = "Pyszna szarlotka, która z pewnością sprawi Ci radość."
RECIPE.model = "models/willardnetworks/food/pie.mdl"
RECIPE.category = "Narkotyzowana żywność"
RECIPE.ingredients = {["baking_apple_pie"] = 1, ["basic_red"] = 1, ["basic_green"] = 1}
RECIPE.result = {["drug_happypie"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 300}, -- full xp
	{level = 25, exp = 150}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()