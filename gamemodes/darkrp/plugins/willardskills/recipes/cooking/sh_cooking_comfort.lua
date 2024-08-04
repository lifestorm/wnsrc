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
RECIPE.name = "Kızarmış Erişte"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "İşgal sırasında bile... Erişte popüler bir yemek seçeneği olmaya devam ediyor."
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
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Çıtır çıtır, aile ile kahvaltı anılarını geri getiriyor."
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
RECIPE.name = "Sandviç"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Şehir İki'de çok popüler, yapay et ve peynirden oluşan bir sandviç."
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
RECIPE.name = "Çırpılmış Yumurta"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Mükemmel şekilde çırpılmış gerçek yumurta, toz yumurtadan daha üstün bir dokuya sahiptir."
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
RECIPE.name = "Çırpılmış Toz Yumurta"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Yapay peynirle çırpılmış yumurta tozu. Sadece hafif bir metalik tat."
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
RECIPE.name = "Kızarmış Tavuk"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Uzak diyarlarda kolektifleştirilmiş, kötü koşullarda ve fabrikalarda et üretmek için kurulmuş bir endüstri."
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
RECIPE.name = "Haşlanmış Yumurta"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Bu günlerde güzel ama makul nadir bir kahvaltı."
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
RECIPE.name = "Krep"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Kreplere hayır diyemezsin."
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
RECIPE.name = "Sebze Çorbası"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Sıcak bir kase sağlıklı sebze çorbası, zihni sabit tutmak için iyi bir yol."
RECIPE.model = "models/willardnetworks/food/vegetablesoup.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_cookingpot", "tool_spoon"}
RECIPE.ingredients = {["ing_vegetable_pack"] = 2, ["ing_herbs"] = 1, ["crafting_water"] = 2}
RECIPE.result = {["comfort_soup"] = 2}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 25
RECIPE.experience = {
	{level = 30, exp = 160}, -- full xp
	{level = 40, exp = 80}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_fish"
RECIPE.name = "Somon Biftek"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Lezzetli bir yemek olarak pişirilen nadir bir balık türü. Genellikle prestijli kişiler için ayrılmıştır."
RECIPE.model = "models/willardnetworks/food/fishsteak.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_fish"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_fish"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 35
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "cooking_beef"
RECIPE.name = "Kavrulmuş Sığır Eti"
RECIPE.category = "Konforlu Yemek"
RECIPE.description = "Bunu en son ne zaman gördünüz? Bir zamanlar evcilleştirilmiş ya da yabani bir yaratıktan kavrulmuş yerli bir hayvanın eti."
RECIPE.model = "models/willardnetworks/food/meat4.mdl"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.tools = {"tool_fryingpan"}
RECIPE.ingredients = {["ing_beef"] = 1, ["ing_margarine"] = 1, ["ing_salt"] = 1, ["ing_herbs"] = 1}
RECIPE.result = {["comfort_beef"] = 1}
RECIPE.hidden = false
RECIPE.skill = "cooking"
RECIPE.level = 35
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 150}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()