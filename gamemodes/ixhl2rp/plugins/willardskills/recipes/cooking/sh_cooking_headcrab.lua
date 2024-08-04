--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_sandwich"
RECIPE.name = "Kanapka z Headcraba"
RECIPE.category = "Headcraby"
RECIPE.description = "Kanapka z headcraba to pyszny przysmak, idealny wybór dla miłośników egzotycznych smaków i niebanalnych doznań kulinaranych."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["baking_bread_slice"] = 1, ["headcrab_fillet"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["headcrab_sandwich"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 350}, -- full xp
	{level = 10, exp = 150}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_skewer"
RECIPE.name = "Headcrab na szaszłyku"
RECIPE.category = "Headcraby"
RECIPE.description = "Niezwykły skorupiak - stwór z kosmosu, uchwycony na kiju. Jest to wspaniała okazja, by spróbować czegoś nowego i zaskoczyć swoje podniebienie niezwykłym smakiem pozaziemskiej egzotyki i mniej lub bardziej prawdopodobnego rozwolnienia."
RECIPE.model = "models/willardnetworks/food/meatskewer.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 2}
RECIPE.result = {["headcrab_skewer"] = 6}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 350}, -- full xp
	{level = 10, exp = 150}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_fillet"
RECIPE.name = "Pieczony filet z Headcraba"
RECIPE.category = "Headcraby"
RECIPE.description = "Filet z Headcraba, delikatnie upieczony, będzie idealnym dodatkiem do twojego ekwipunku, gdy chcesz poczuć się jak prawdziwy gourmet na wyprawie w dzikie tereny."
RECIPE.model = "models/willardnetworks/food/meat6.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["headcrab_fillet"] = 1}
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
RECIPE.uniqueID = "cooking_headcrab_potluck"
RECIPE.name = "Gulasz z Headcraba"
RECIPE.category = "Headcraby"
RECIPE.description = "Gulasz z Headcraba to idealny przysmak dla miłośników kuchni pozaziemskiej, każda kolejna porcja zaskakuje smakiem i konsystencją."
RECIPE.model = "models/willardnetworks/food/canned_food3.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["headcrab_fillet"] = 1, ["ing_herbs"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["headcrab_potluck"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 300}, -- full xp
	{level = 29, exp = 150}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_headcrab_jambalaya"
RECIPE.name = "Jambalaya z Headcraba"
RECIPE.category = "Headcraby"
RECIPE.description = "Jambalaya z Headcraba to potrawa, która z połączeniem pikantnego ryżu, aromatycznych przypraw i mięsa z pewnością zaspokoi Twoje smakowe pragnienia i sprawi, że poczujesz się jak prawdziwy kucharz kuchni Cajun."
RECIPE.model = "models/willardnetworks/food/stew1.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_headcrab_meat"] = 1, ["ing_sauce"] = 1, ["ing_spices"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["headcrab_jambalaya"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 300}, -- full xp
	{level = 40, exp = 150}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()