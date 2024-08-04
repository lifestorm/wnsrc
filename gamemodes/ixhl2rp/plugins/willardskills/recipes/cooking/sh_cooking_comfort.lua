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
RECIPE.uniqueID = "cooking_noodles"
RECIPE.name = "Gotowany makaron"
RECIPE.category = "Comfort Food"
RECIPE.description = "Gotowany makaron, niezależnie od czasów jest bardzo popularnym wyborem kulinarnym."
RECIPE.model = "models/willardnetworks/food/noodles.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["ing_noodles"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_noodles"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 75}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_toast"
RECIPE.name = "Tost"
RECIPE.category = "Comfort Food"
RECIPE.description = "Chrupiący, smaczny i idealny na każdą porę dnia."
RECIPE.model = "models/willardnetworks/food/toast.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["baking_bread_slice"] = 1}
RECIPE.result = {["comfort_toast"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 90}, -- full xp
	{level = 10, exp = 45}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_sandwich"
RECIPE.name = "Kanapka"
RECIPE.category = "Comfort Food"
RECIPE.description = "Bardzo popularna w Mieście 2, prosta kanapka z syntetycznego mięsa z serem. Idealna na szybki posiłek w podróży i w pracy."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.tools = {"tool_knife"}
RECIPE.ingredients = {["baking_bread_slice"] = 1, ["artificial_meat"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["comfort_sandwich"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 0
RECIPE.experience = {
	{level = 10, exp = 150}, -- full xp
	{level = 20, exp = 75}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_scrambled"
RECIPE.name = "Jajecznica"
RECIPE.category = "Comfort Food"
RECIPE.description = "Najprostsza w świecie jajecznica, kto nie jadł jajecznicy?..."
RECIPE.model = "models/willardnetworks/food/eggmix.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_egg"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["comfort_scrambled"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking__powder_scrambled"
RECIPE.name = "Jajecznica w proszku"
RECIPE.category = "Comfort Food"
RECIPE.description = "Jajecznica w proszku to coś w rodzaju czarnej magii kulinarnych technologii, pozwalająca uzyskać jajeczną masę z proszku i wody. O tym, czy jest smaczna to już inna kwestia."
RECIPE.model = "models/willardnetworks/food/eggmix.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["artificial_cheese"] = 1}
RECIPE.result = {["comfort_scrambled"] = 1}
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
RECIPE.uniqueID = "cooking_comfort_chicken"
RECIPE.name = "Pieczony kurczak"
RECIPE.category = "Comfort Food"
RECIPE.description = "Pieczony kurczak to idealna potrawa dla tych, którzy lubią czuć się jak drapieżny ptak, a jednocześnie nie chcą ryzykować złapania ptasiej grypy..."
RECIPE.model = "models/willardnetworks/food/meat4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.canUseCampfire = true
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_chicken"] = 1, ["ing_salt"] = 1}
RECIPE.result = {["comfort_roastedchicken"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_boiledegg"
RECIPE.name = "Gotowane jajko"
RECIPE.category = "Comfort Food"
RECIPE.description = "Można je zjeść na twardo, na miękko lub zapakować do kieszonki na później, a do tego dostarcza naprawdę dużo białka."
RECIPE.model = "models/willardnetworks/food/egg2.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot"}
RECIPE.ingredients = {["ing_egg"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["luxury_boiled_egg"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 160}, -- full xp
	{level = 20, exp = 80}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_pancakes"
RECIPE.name = "Naleśniki"
RECIPE.category = "Comfort Food"
RECIPE.description = "Naleśniki to taka kulinarna góra lodowa: wydają się proste, ale kryją w sobie ogromną ilość możliwości i smaków. Można je podawać z dżemem, serem, owocami lub nawet mięsem - tylko nie mówcie o tym babci."
RECIPE.model = "models/willardnetworks/food/pancake.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_protein"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["drink_milk"] = 1}
RECIPE.result = {["comfort_pancake"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_vegsoup"
RECIPE.name = "Zupa jarzynowa"
RECIPE.category = "Comfort Food"
RECIPE.description = "Zupa jarzynowa to taki mały ogródek na talerzu, pełen warzyw, które się znudziły, ale dalej chcą dawać życie i energię. Miejmy nadzieje, że nie będzie za słona."
RECIPE.model = "models/willardnetworks/food/vegetablesoup.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_vegetable_pack"] = 2, ["ing_herbs"] = 1, ["crafting_water"] = 2}
RECIPE.result = {["comfort_soup"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 160}, -- full xp
	{level = 40, exp = 80}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_fish"
RECIPE.name = "Stek z łososia"
RECIPE.category = "Comfort Food"
RECIPE.description = "Stek z łososia, jednej z ekskluzywniejszych na te czasy ryby. Idealny dla tych, którzy chcą spróbować czegoś nowego i zaskoczyć swoje kubki smakowe."
RECIPE.model = "models/willardnetworks/food/fishsteak.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_fish"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_fish"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_beef"
RECIPE.name = "Pieczona wołowina"
RECIPE.category = "Comfort Food"
RECIPE.description = "Pieczona wołowina to taki kulinarny skarb, który trzeba szanować i doceniać, jak wina z dobrego rocznika. Krucha skórka i soczyste wnętrze sprawiają, że ta potrawa jest idealna na elegancką kolację."
RECIPE.model = "models/willardnetworks/food/meat4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_beef"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_beef"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 150}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()