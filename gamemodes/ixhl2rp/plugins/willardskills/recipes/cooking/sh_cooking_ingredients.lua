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
RECIPE.name = "Ciasto na chleb"
RECIPE.category = "Składniki"
RECIPE.description = "Ciasto na chleb czekające na wypieczenie w piecu."
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
RECIPE.name = "Ciasto cukiernicze"
RECIPE.category = "Składniki"
RECIPE.description = "Ciasto cukiernicze składające się z jajek, mleka, mąki i margaryny to idealny składnik do przygotowania pysznych wypieków jak croissanty czy bajgle."
RECIPE.model = "models/willardnetworks/props/dough.mdl"
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_flour"] = 1, ["drink_milk"] = 1, ["ing_margarine"] = 1}
RECIPE.result = {["ing_pastry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sweet_dough"
RECIPE.name = "Słodzone ciasto cukiernicze"
RECIPE.category = "Składniki"
RECIPE.description = "Słodzone ciasto cukiernicze to składnik, który pozwala na uzyskanie pysznego i słodkiego w smaku ciasta. Jest to połączenie mąki, cukru, jajek, masła i innych aromatycznych dodatków, które sprawiają, że ciasto smakuje wyjątkowo słodko i aromatycznie."
RECIPE.model = "models/willardnetworks/props/sweetdough.mdl"
RECIPE.ingredients = {["ing_pastry"] = 1, ["ing_sweet"] = 1, ["fruit_berries"] = 2}
RECIPE.result = {["ing_sweetpastry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200}, -- full xp
	{level = 30, exp = 100}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sauce"
RECIPE.name = "Baza sosów"
RECIPE.category = "Składniki"
RECIPE.description = "Baza sosów to składnik, który stanowi podstawę dla wielu różnych rodzajów sosów. Jest to zazwyczaj mieszanka różnych aromatycznych warzyw i przypraw, która może być użyta do przygotowania sosów mięsnych, warzywnych, czy też owocowych. Dzięki niej każdy kucharz może stworzyć własny unikalny sos, który idealnie dopasuje się do swojego dania."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_flour"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["ing_sauce"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 35, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_ing_sauce_makeshift"
RECIPE.name = "Prowizoryczna baza do sosów"
RECIPE.category = "Składniki"
RECIPE.description = "Prowizoryczna baza sosów to zestaw przypadkowych składników, które można wykorzystać do stworzenia kreatywnych sosów. W skład mogą wchodzić m.in. ketchup, musztarda, majonez, keczup pikantny, jogurt, ocet balsamiczny, czosnek i wiele innych."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_flour"] = 1, ["comp_chemcomp"] = 1}
RECIPE.result = {["ing_sauce"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 35, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()