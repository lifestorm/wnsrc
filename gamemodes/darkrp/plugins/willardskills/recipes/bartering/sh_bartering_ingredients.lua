--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Meats
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_leeches"
RECIPE.name = "Kalaylı Sülükler"
RECIPE.description = "Kalaylanmış sülük. Yemek pişirmek için kullanılır ve henüz tüketime hazır değildir. Üç ham sülük içerir."
RECIPE.model = "models/willardnetworks/food/cmb_food2.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["ing_tinned_leeches"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_artificial_meat"
RECIPE.name = "Çiğ Yapay Et"
RECIPE.description = "Bir protein bloğuna sıkıştırılmış et maddeleri. Ham ve rafine edilmemiş."
RECIPE.model = "models/willardnetworks/food/steak1.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_artificial_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_artificial_chicken"
RECIPE.name = "Çiğ Tavuk"
RECIPE.description = "Uzak diyarlarda kolektifleştirilmiş, et üretmek için kötü koşullarda ve fabrikalarda kurulmuş bir endüstri."
RECIPE.model = "models/willardnetworks/food/meat3.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["ing_chicken"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Baking
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_margarine"
RECIPE.name = "Margarin"
RECIPE.description = "Fabrikada üretilen konserve bir kutu margarin. Isı altında erir."
RECIPE.model = "models/willardnetworks/food/cmb_food5.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_margarine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_flour"
RECIPE.name = "Doymuş Un"
RECIPE.description = "Kağıt torba biraz dolgulu, bu da gerçekte olduğundan daha fazla un içeriyormuş gibi görünmesini sağlıyor. Görünür, sıradan un gibi kokuyor, burada ve orada birkaç garip siyah nokta var."
RECIPE.model = "models/willardnetworks/food/cmb_food6.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["ing_flour"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_protein"
RECIPE.name = "Yumurta Protein Paketi"
RECIPE.description = "Bir paket toz protein."
RECIPE.model = "models/willardnetworks/food/cmb_food1.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_protein"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_sweetbar"
RECIPE.name = "Granül Tatlı Bar"
RECIPE.description = "Gevrek bir çikolata. Aslında tadı iyi!"
RECIPE.model = "models/willardnetworks/food/cmb_food3.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_sweet"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_milk"
RECIPE.name = "Süt İkamesi"
RECIPE.description = "Bir kutu süt yerine geçiyor. Kesinlikle süte benziyor ama biraz daha ince."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["drink_milk"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Flavourings
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_spices"
RECIPE.name = "Kurutulmuş Baharat Aroması"
RECIPE.description = "Ambalajdan garip kokular yayılıyor."
RECIPE.model = "models/willardnetworks/food/cmb_food8.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_spices"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_herbs"
RECIPE.name = "Kurutulmuş Pişirme Otları"
RECIPE.description = "Yemek pişirmek için çeşitli kurutulmuş otlar."
RECIPE.model = "models/willardnetworks/food/cmb_food7.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_herbs"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_salt"
RECIPE.name = "Tuzluk"
RECIPE.description = "Garip asidik bir kokuya sahip bir tuz kabı..."
RECIPE.model = "models/willardnetworks/foods/salt.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_salt"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_vinegar"
RECIPE.name = "Sirke"
RECIPE.description = "Sulu bir şişe asitli sıvı. Koklamak ağzınızı ve gözlerinizi sulandırır."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_i.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["ing_vinegar"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Vegetables / fruit
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_carrot"
RECIPE.name = "Sebze Paketi"
RECIPE.description = "Etiket, bu paketin pişirme amacıyla kullanılmaya hazır bir dizi sebze içerdiğini yazıyor."
RECIPE.model = "models/willardnetworks/foods/vege.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_vegetable_pack"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

-- Misc
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_noodles"
RECIPE.name = "Kurutulmuş Erişte"
RECIPE.description = "Kuru ve iştah açıcı olmayan erişteler. Bu nasıl mümkün olabilir?"
RECIPE.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_noodles"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_cheese"
RECIPE.name = "Suni Peynir Dilimi"
RECIPE.description = "Bir yerde bir fabrikada yapılan bir dilim yapay peynir."
RECIPE.model = "models/willardnetworks/food/cheesewheel2c.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["artificial_cheese"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_coffeepowder"
RECIPE.name = "Kahve Tozu"
RECIPE.description = "Bir kap kahve tozu."
RECIPE.model = "models/willardnetworks/food/coffee_nescafe.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["ing_coffee_powder"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_empty_coffee"
RECIPE.name = "Boş Kahve Fincanı"
RECIPE.description = "Boş bir kahve fincanı."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["junk_coffeecup"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_raw_antlion_meat"
RECIPE.name = "Çiğ Antlion Eti"
RECIPE.description = "Biraz sümüksü uzaylı eti. Kokuyor ve garip görünüyor."
RECIPE.model = "models/willardnetworks/food/raw_alienmeat.mdl"
RECIPE.category = "Malzemeler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_antlion_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()