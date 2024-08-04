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
RECIPE.name = "Ekmek"
RECIPE.category = "Pişirme"
RECIPE.description = "Böyle zamanlarda bile ev yapımı ekmek büyük fark yaratabilir."
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
RECIPE.name = "Yapay Peynir"
RECIPE.category = "Pişirme"
RECIPE.description = "Bugünlerde ikame olmayan süt ürünleri bulmak zor, inekler dünyanın dört bir yanına yayılmış fabrikalarda tutuluyor ve bulmak kolay değil."
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
RECIPE.name = "Simit"
RECIPE.category = "Pişirme"
RECIPE.description = "Yaratıcı yöntemlerle ekmek hamurundan simit elde edebilirsiniz, biraz kuru ama işinizi görecektir."
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
RECIPE.category = "Pişirme"
RECIPE.description = "İçi yumuşak, dışı biraz daha sert ve çiğnenebilir. Tuzlu iyilik."
RECIPE.model = "models/willardnetworks/food/pretzel.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["baking_pretzel"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 15
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 30, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_croissant"
RECIPE.name = "Kruvasan"
RECIPE.category = "Pişirme"
RECIPE.description = "Fransızlar işgalden önce çok büyük uzmanlardı."
RECIPE.model = "models/willardnetworks/food/croissant.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["baking_croissant"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 15
RECIPE.experience = {
	{level = 20, exp = 250}, -- full xp
	{level = 30, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_doughnut"
RECIPE.name = "Donut"
RECIPE.category = "Pişirme"
RECIPE.description = "Kesinlikle şekerli bir lüks. Hepsini kim yedi biliyor musun?"
RECIPE.model = "models/willardnetworks/food/bagel1.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1}
RECIPE.result = {["baking_doughnut"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 25
RECIPE.experience = {
	{level = 30, exp = 250}, -- full xp
	{level = 40, exp = 125}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_creamtreat"
RECIPE.name = "Kremalı İkram"
RECIPE.category = "Pişirme"
RECIPE.description = "Lezzetli bir tatlı krema ikramı!"
RECIPE.model = "models/willardnetworks/food/creamtreat.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1}
RECIPE.result = {["baking_treat"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 25
RECIPE.experience = {
	{level = 30, exp = 300}, -- full xp
	{level = 40, exp = 150}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_applepie"
RECIPE.name = "Elmalı Turta"
RECIPE.category = "Pişirme"
RECIPE.description = "Elmalarla karışık bir turta. Ne kadar tatlı."
RECIPE.model = "models/willardnetworks/food/pie.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["fruit_apple"] = 3}
RECIPE.result = {["baking_apple_pie"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 40, exp = 350}, -- full xp
	{level = 45, exp = 175}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sweetroll"
RECIPE.name = "Tatlı Rulo"
RECIPE.category = "Pişirme"
RECIPE.description = "Yetenekli bir aşçı bu tatlı ve lezzetli tatlı ruloyu yaptı."
RECIPE.model = "models/willardnetworks/food/sweetroll.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["fruit_berries"] = 3}
RECIPE.result = {["baking_sweetroll"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 40, exp = 350}, -- full xp
	{level = 45, exp = 175}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_cheesecake"
RECIPE.name = "Cheesecake"
RECIPE.category = "Pişirme"
RECIPE.description = "Birkaç çilekle karıştırılmış bir cheesecake. Gerçekten de oldukça tatlı ve yapımı biraz beceri gerektiriyor."
RECIPE.model = "models/willardnetworks/food/cake.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["artificial_cheese"] = 1, ["fruit_berries"] = 2}
RECIPE.result = {["baking_cheesecake"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 40, exp = 350}, -- full xp
	{level = 45, exp = 175}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_xenpie"
RECIPE.name = "Xen Turtası"
RECIPE.category = "Pişirme"
RECIPE.description = "Başka dünyalara ait malzemeler sıcak bir turtaya dönüşmek için karıştırıldı. Bunu ancak usta bir şef başarabilir."
RECIPE.model = "models/willardnetworks/food/xen_pie.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_sweetpastry"] = 1, ["ing_xen_herb"] = 2, ["ing_xenberries"] = 4}
RECIPE.result = {["xen_pie"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 0}, -- full xp
	{level = 40, exp = 0}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()