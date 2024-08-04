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
RECIPE.uniqueID = "cooking_ing_bread_dough"
RECIPE.name = "Ekmek Hamuru"
RECIPE.category = "Malzemeler"
RECIPE.description = "Lezzetli ekmek elde etmek için ilk bileşen."
RECIPE.model = "models/willardnetworks/food/dough.mdl"
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_flour"] = 1, ["drink_milk"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["ing_dough"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 200}, -- full xp
	{level = 10, exp = 100}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_pastry_dough"
RECIPE.name = "Pasta Hamuru"
RECIPE.category = "Malzemeler"
RECIPE.description = "Pastacılık ürünleri için daha uygun bir hamur."
RECIPE.model = "models/willardnetworks/props/dough.mdl"
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_flour"] = 1, ["drink_milk"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["ing_pastry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 15
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sweet_dough"
RECIPE.name = "Şekerli Pasta Hamuru"
RECIPE.category = "Malzemeler"
RECIPE.description = "Tatlı hamur işleri için uygun meyvelerle tatlandırılmış hamur işi."
RECIPE.model = "models/willardnetworks/props/sweetdough.mdl"
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_sweet"] = 1, ["fruit_berries"] = 2}
RECIPE.result = {["ing_sweetpastry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 15
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sauce"
RECIPE.name = "Sos Temeli"
RECIPE.category = "Malzemeler"
RECIPE.description = "Bir sosun temellerini şekillendirmek için bir araya getirilen malzemelerin karışımı."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_flour"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["ing_sauce"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 25
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 35, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sauce_makeshift"
RECIPE.name = "El Yapımı Sos Tabanı"
RECIPE.category = "Malzemeler"
RECIPE.description = "Bir sosun temellerini şekillendirmek için bir araya getirilen malzemelerin karışımı."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_flour"] = 1, ["comp_chemcomp"] = 1}
RECIPE.result = {["ing_sauce"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 25
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 35, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()