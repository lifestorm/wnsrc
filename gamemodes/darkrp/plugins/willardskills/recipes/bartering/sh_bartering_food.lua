--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Snacks

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_berries"
RECIPE.name = "Meyveler"
RECIPE.description = "Bir demet tatlı meyve."
RECIPE.model = "models/willardnetworks/food/berries01.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["fruit_berries"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_peanuts"
RECIPE.name = "Tuzlu Fıstık"
RECIPE.description = "Hafif bir atıştırmalık, alkol ile iyi gider."
RECIPE.model = "models/willardnetworks/food/peats.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["food_peanuts"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_biscuits"
RECIPE.name = "Bisküvi Konservesi"
RECIPE.description = "Issız, metalik bir teneke kutu içinde yer alan bu kuru bisküviler, kemer tadı sunuyor. Her ısırık, nemden yoksun, kavrulmuş bir gevreklik açığa çıkarır."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["food_biscuits"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_crisps"
RECIPE.name = "Patates Cipsi"
RECIPE.description = "Hafif bir atıştırmalık, bu yeşil süslemeli plastik torba tuzlu cipsler içeriyor."
RECIPE.model = "models/willardnetworks/food/snack01.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["food_crisps"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()
local RECIPE = ix.recipe:New()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_crackers"
RECIPE.name = "Patates Krakerleri"
RECIPE.description = "Hafif bir atıştırmalık, bu kırmızı süslemeli plastik torba kraker içeriyor."
RECIPE.model = "models/willardnetworks/food/snack02.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["food_crackers"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_apple"
RECIPE.name = "Elma"
RECIPE.description = "Sağlık görevlilerini bütün bir gün boyunca uzak tutuyor."
RECIPE.model = "models/willardnetworks/food/apple.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["fruit_apple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_banana"
RECIPE.name = "Muz"
RECIPE.description = "Soy ve ye."
RECIPE.model = "models/willardnetworks/food/bananna.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["fruit_banana"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_orange"
RECIPE.name = "Portakal"
RECIPE.description = "Engebeli, keskin bir portakal."
RECIPE.model = "models/willardnetworks/food/orange.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["fruit_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_sandwich"
RECIPE.name = "Sandviç"
RECIPE.description = "Şehir İki'de çok popüler, yapay et ve peynirden oluşan bir sandviç."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 22
RECIPE.result = {["comfort_sandwich"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Foods
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_artskewer"
RECIPE.name = "Şiş Yapay Et"
RECIPE.description = "Bir protein et bloğu çarpıtıldı ve yemeye hazır olarak üretildi."
RECIPE.model = "models/willardnetworks/food/meatskewer2.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["artificial_skewer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_breadslice"
RECIPE.name = "Ekmek Dilimi"
RECIPE.description = "Bir dilim taze ekmek. Seni kendi başına çok fazla doldurmuyor ama yapacak."
RECIPE.model = "models/willardnetworks/food/bread_slice.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["baking_bread_slice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_halfbread"
RECIPE.name = "Yarım Ekmek"
RECIPE.description = "Yarım somun ekmek tüketilmeye hazır."
RECIPE.model = "models/willardnetworks/food/bread_half.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["baking_bread_half"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_cookednoodles"
RECIPE.name = "Pişmiş Erişte"
RECIPE.description = "İşgal sırasında bile.. Erişte, yemek için popüler bir seçim olmaya devam ediyor."
RECIPE.model = "models/willardnetworks/food/noodles.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["comfort_noodles"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_bagel"
RECIPE.name = "Simit"
RECIPE.description = "Yaratıcı araçlar sayesinde ekmek hamurundan simit temin edebiliyorsunuz, biraz kuru ama güzel."
RECIPE.model = "models/willardnetworks/food/bagel2.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["baking_bagel"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_roastedartmeat"
RECIPE.name = "Kavrulmuş Suni Et"
RECIPE.description = "Kolay tüketim için yapay etin bir protein bloğu."
RECIPE.model = "models/willardnetworks/food/steak2.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["artificial_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_vegsoup"
RECIPE.name = "Sebze Çorbası"
RECIPE.description = "Sıcak bir kase sağlıklı sebze çorbası, sabit bir zihin tutmanın iyi bir yolu."
RECIPE.model = "models/willardnetworks/food/vegetablesoup.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["comfort_soup"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_watermelon"
RECIPE.name = "Karpuz"
RECIPE.description = "Büyük, yuvarlak, yeşil bir meyve. İçi oldukça pembe!"
RECIPE.model = "models/willardnetworks/food/watermelon_unbreakable.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["fruit_watermelon"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_cookedantlionmeat"
RECIPE.name = "Kavrulmuş Antlion Eti"
RECIPE.description = "Kavrulmuş bir antlion eti, sizi istediğiniz kadar doyurmaz, garip bir dokusu var."
RECIPE.model = "models/willardnetworks/food/cooked_alienmeat.mdl"
RECIPE.category = "Yemek"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["antlion_roast"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()