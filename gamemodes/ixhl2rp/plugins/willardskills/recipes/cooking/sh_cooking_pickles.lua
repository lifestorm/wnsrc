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
RECIPE.uniqueID = "cooking_pickled_vegetables"
RECIPE.name = "Warzywa marynowane"
RECIPE.category = "Marynowane"
RECIPE.description = "Warzywa marynowane to kolorowe i smaczne dodatki do każdego posiłku, które można znaleźć w ekwipunku. Wzbogacone w intensywny smak i aromat, doskonale sprawdzą się jako przekąska lub dodatek do sałatek czy dań głównych."
RECIPE.model = "models/willardnetworks/foods/pickled.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_vegetable_pack"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_vegetables"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_egg"
RECIPE.name = "Jajko marynowane"
RECIPE.category = "Marynowane"
RECIPE.description = "Jajko marynowane to delikatne i jednocześnie intensywnie smakujące jajko, które poddano procesowi marynowania w roztworze z octu, cukru i przypraw. Jest to idealny dodatek do kanapek czy sałatek, a także ciekawa przekąska na przyjęcia. Jest to popularny posiłek w Mieście 2."
RECIPE.model = "models/willardnetworks/food/egg2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["ing_egg"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_egg"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full xp
	{level = 10, exp = 50}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_eggmush"
RECIPE.name = "Kiszone jajka"
RECIPE.category = "Marynowane"
RECIPE.description = "Kiszone jajka to oryginalny przepis na jajka, które po moczeniu w soli i przyprawach nabierają wyjątkowego, intensywnego smaku. W sam raz dla miłośników kwaśnych i pikantnych smaków."
RECIPE.model = "models/willardnetworks/food/eggmix.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_vinegar"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["pickled_eggmush"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pickled_leech"
RECIPE.name = "Kiszona pijawka"
RECIPE.category = "Marynowane"
RECIPE.description = "Kiszona pijawka to nietypowa przekąska z pewnymi wątpliwymi walorami smakowymi. Jednak, dla odważnych poszukiwaczy nowych doznań kulinarnych, może stanowić wyjątkowe doświadczenie."
RECIPE.model = "models/willardnetworks/food/cooked_leech.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["leech_roast"] = 1, ["ing_vinegar"] = 1}
RECIPE.result = {["pickled_leech"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()