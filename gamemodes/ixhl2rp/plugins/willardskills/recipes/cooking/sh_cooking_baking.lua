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
RECIPE.name = "Chleb"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Świeżo wypieczony, chrupiący i pięknie pachnący bochen chleba. Po prostu najzwyklejszy chlieb."
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
RECIPE.name = "Syntetyczny ser"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Wygląda i pachnie jak normalny ser, ale zdecydowanie smakuje inaczej. Nic dziwnego, trudno w tych czasach o prawdziwą krowę."
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
RECIPE.name = "Bajgiel"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Nigdy nie wiadomo gdzie zaczynają się, a gdzie kończą bajgle, ale zawsze smakują dobrze, zwłaszcza z dodatkiem kremowego masła lub słodkiego dżemu."
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
RECIPE.name = "Precel"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Trzeba uważać, żeby nie zaplątać się w jego skomplikowane kształty, ale nagroda w postaci jego chrupkości jest tego warta."
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
RECIPE.category = "Piekarstwo"
RECIPE.description = "Croissant to taki francuski przysmak, który jest w stanie rozwiązać każdy problem - wystarczy tylko go spróbować, a cały świat wydaje się już dużo piękniejszy i łatwiejszy do przetrwania."
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
RECIPE.name = "Donut"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Po zjedzeniu jednego z tych kolorowych kółek, trudno się powstrzymać przed zjedzeniem kolejnego, aż do momentu, gdy nie zostaje już nic poza wyrzutami sumienia i pełnym żołądkiem."
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
RECIPE.name = "Drożdżówka"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Uwielbiana przez wszystkich łasuchów drożdżówka z budyniem."
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
RECIPE.name = "Szarlotka"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Nie ma nic lepszego niż smak cynamonu i jabłek, które rozgrzewają duszę i wprowadzają nas w stan błogiej nirwany."
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
RECIPE.name = "Słodka bułka"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Słodka bułka z lukrową polewą, idealna jako dodatek do herbaty."
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
RECIPE.name = "Ceglasty sernik"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Solidny sernik, często po prostu nazywany cegłą. Niedobór podstawowych składników do pieczenia doprowadził do dość nietuzinkowych rozwiązań."
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
RECIPE.name = "Ciasto Xen"
RECIPE.category = "Piekarstwo"
RECIPE.description = "Przygoda z Ciastem Xen to jak wchodzenie na nieznany szczyt - nigdy nie wiesz, co cię tam czeka, ale zawsze warto spróbować. Trzeba mieć w sobie odrobinę odwagi, żeby go spróbować."
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