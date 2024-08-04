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
RECIPE.name = "Protein Katili"
RECIPE.description = "Toz protein, ağrı kesiciler ve Breen's Water ile karıştırılmış."
RECIPE.model = "models/willardnetworks/food/cmb_food1.mdl"
RECIPE.category = "Uyuşturuculu Yemek"
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
RECIPE.name = "Çivili Fincan Kahve"
RECIPE.description = "Sıcak bir fincan kahve, bu garip zamanlarda sizi uyanık ve tetikte tutmaya yardımcı olur, görünüşe göre bu seferki her zamankinden daha da fazla..."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Uyuşturuculu Yemek"
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
RECIPE.name = "Çivili Fincan Çay"
RECIPE.description = "Dokunulduğunda rahatlatıcı ve sıcak ama ağızda ekşi bir tat bırakıyor."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Uyuşturuculu Yemek"
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
RECIPE.name = "Enjekte Edilmiş Elma"
RECIPE.description = "Tadı biraz garip olsa da diğer elmalara benziyor."
RECIPE.model = "models/willardnetworks/food/apple.mdl"
RECIPE.category = "Uyuşturuculu Yemek"
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
RECIPE.name = "Günışığı Votka"
RECIPE.description = "Yapay güneş ışığı ve gökkuşağı gibi bir tat!"
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Uyuşturuculu Yemek"
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
RECIPE.name = "Samanyolu"
RECIPE.description = "Evrenle bir olmak için. En azından bir süreliğine."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Uyuşturuculu Yemek"
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
RECIPE.name = "Mutlu Turta"
RECIPE.description = "Sizi kesinlikle mutlu edecek lezzetli bir elmalı turta."
RECIPE.model = "models/willardnetworks/food/pie.mdl"
RECIPE.category = "Uyuşturuculu Yemek"
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