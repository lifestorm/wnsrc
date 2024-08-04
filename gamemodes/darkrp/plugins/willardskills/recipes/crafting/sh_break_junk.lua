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

RECIPE.uniqueID = "rec_junk_tv"
RECIPE.name = "Parçala: Kırık TV Monitörü"
RECIPE.description = "Eski bir televizyonun kırık monitörü. Değersiz ama anılar öyle değil."
RECIPE.model = "models/props_wasteland/controlroom_monitor001a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_tv"] = 1}
RECIPE.result = {["comp_electronics"] = 1, ["comp_plastic"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 55}, -- full xp
	{level = 20, exp = 27}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_toy"
RECIPE.name = "Parçala: Oyun Parkı Oyuncağı"
RECIPE.description = "Bugünlerde bunları çok sık göremiyoruz. Tahtadan yapılmış."
RECIPE.model = "models/props_c17/playgroundTick-tack-toe_block01a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_toy"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tire"
RECIPE.name = "Parçala: Eski Lastik"
RECIPE.description = "Size eski zamanları hatırlatıyor, arabaların bir şey olduğu zamanları."
RECIPE.model = "models/props_vehicles/carparts_tire01a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["junk_tire"] = 1}
RECIPE.result = {["comp_plastic"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tincan"
RECIPE.name = "Parçala: Teneke Kutu"
RECIPE.description = "Sonunda içinde yiyecek olan küçük bir teneke kutu. Senin için işe yaramaz."
RECIPE.model = "models/props_junk/garbage_metalcan002a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_tincan"] = 1}
RECIPE.result = {["comp_scrap"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_takeaway"
RECIPE.name = "Parçala: Boş Paket Servis"
RECIPE.description = "Bir çöp yığınının içinde bulundu, muhtemelen bir zamanlar içinde erişte vardı."
RECIPE.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_takeaway"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_sm_cardboard"
RECIPE.name = "Parçala: Küçük Karton Kutu"
RECIPE.description = "Tüketici ürünlerini taşımak için küçük bir karton kutu,Boş."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_sm_cardboard"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_shoe"
RECIPE.name = "Parçala: Kahverengi Ayakkabı"
RECIPE.description = "Kahverengi bir ayakkabı, muhtemelen daha önce birine aitti."
RECIPE.model = "models/props_junk/Shoe001a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_shoe"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_receiver"
RECIPE.name = "Parçala: Kırık Alıcı"
RECIPE.description = "Bozuk bir elektronik ekipman parçası. Artık çalışmıyor."
RECIPE.model = "models/props_lab/reciever01c.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_receiver"] = 1}
RECIPE.result = {["comp_screws"] = 1, ["comp_electronics"] = 1, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plastic_bucket"
RECIPE.name = "Parçala: Plastik Kova"
RECIPE.description = "Muhtemelen kimyasal madde depolamak için kullanılan kirli plastik bir kova."
RECIPE.model = "models/props_junk/plasticbucket001a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_plastic_bucket"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plasticcrate"
RECIPE.name = "Parçala: Plastik Kap"
RECIPE.description = "Plastik bir kap. Senin için pek bir değeri yok."
RECIPE.model = "models/props_junk/PlasticCrate01a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_plasticcrate"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plantpot"
RECIPE.name = "Parçala: Bitki Saksısı"
RECIPE.description = "Dikim ve bahçe işleri için kullanılan bir saksı. Hiçbir faydası yok."
RECIPE.model = "models/props_junk/terracotta01.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_plantpot"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_pipe"
RECIPE.name = "Parçala: Dayanıksız Metal Boru"
RECIPE.description = "Çürük bir metal boru. Silah olarak pek kullanışlı değil."
RECIPE.model = "models/props_canal/mattpipe.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_pipe"] = 1}
RECIPE.result = {["comp_scrap"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_paintcan"
RECIPE.name = "Parçala: Boş Boya Kutusu"
RECIPE.description = "Boş bir boya kutusu. Senin için işe yaramaz."
RECIPE.model = "models/props_junk/metal_paintcan001b.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_paintcan"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_mug"
RECIPE.name = "Parçala: Boş Kupa"
RECIPE.description = "İçinde hiçbir şey olmayan plastik bir kupa."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_mug"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_pc_monitor"
RECIPE.name = "Parçala: Bilgisayar Monitörü"
RECIPE.description = "Bu cihaz için birçok plan vardı, ne yazık ki hiçbir zaman gerçekleşmedi."
RECIPE.model = "models/props_lab/monitor01a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_pc_monitor"] = 1}
RECIPE.result = {["comp_plastic"] = 2, ["comp_electronics"] = 1, ["comp_scrap"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_lamp"
RECIPE.name = "Parçala: Kırık Lamba"
RECIPE.description = "Kırık ve işe yaramaz olan bu lamba artık pek bir amaca hizmet etmiyor."
RECIPE.model = "models/props_lab/desklamp01.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_lamp"] = 1}
RECIPE.result = {["comp_plastic"] = 2, ["comp_screws"] = 1, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_keyboard"
RECIPE.name = "Parçala: Kırık Klavye"
RECIPE.description = "Neredeyse hiçbir değeri olmayan kırık bir klavye."
RECIPE.model = "models/props_c17/computer01_keyboard.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_keyboard"] = 1}
RECIPE.result = {["comp_electronics"] = 1, ["comp_plastic"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_jug"
RECIPE.name = "Parçala: Boş Plastik Sürahi"
RECIPE.description = "Boş plastik sürahi, iyi bir temizliğe ihtiyacı var."
RECIPE.model = "models/props_junk/garbage_milkcarton001a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_jug"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_jar"
RECIPE.name = "Parçala: Boş Kavanoz"
RECIPE.description = "Reçel ya da benzeri bir şey koymak için uygun boş bir kavanoz. İşe yaramaz."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_jar"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_empty_bottle"
RECIPE.name = "Parçala: Boş Şişe"
RECIPE.description = "Boş bir şişeyi parçalayın."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_empty_bottle"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_fruitjuice"
RECIPE.name = "Parçala: Boş Meyve Suyu Kartonu"
RECIPE.description = "Boş bir plastik meyve suyu kutusunu parçalayın."
RECIPE.model = "models/props_junk/garbage_plasticbottle003a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_empty_fruitjuice"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_emptyvial"
RECIPE.name = "Parçala: Boş Sağlık Şişesi"
RECIPE.description = "Boş bir sağlık şişesini parçalayın."
RECIPE.model = "models/willardnetworks/syringeemptyy.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_emptyvial"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_gear"
RECIPE.name = "Parçala: Metal Dişli"
RECIPE.description = "Bir zamanlar değerli bir şey için uygun olan metalik ekipman parçası. Artık değersiz."
RECIPE.model = "models/props_wasteland/gear02.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_gear"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 40}, -- full xp
	{level = 20, exp = 20}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_gascan"
RECIPE.name = "Parçala: Boş Benzin Bidonu"
RECIPE.description = "Yakıt veya benzeri bir şey taşımak için kullanılan boş bir gaz kutusu. Boş."
RECIPE.model = "models/props_junk/metalgascan.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_gascan"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_fridge_door"
RECIPE.name = "Parçala: Buzdolabı Kapağı"
RECIPE.description = "Bir zamanlar buzdolabına takılı olan kırık bir kapı. Ağır ve soğuk."
RECIPE.model = "models/props_interiors/refrigeratordoor02a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_fridgedoor"] = 1}
RECIPE.result = {["comp_scrap"] = 4, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 40, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_frame"
RECIPE.name = "Parçala: Ahşap Çerçeve"
RECIPE.description = "Ahşap çerçeveler. Muhtemelen pencere takmak için kullanılmış. İşe yaramaz."
RECIPE.model = "models/props_c17/frame002a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_frame"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tattered_drawer"
RECIPE.name = "Parçala: Parçalanmış Çekmece"
RECIPE.description = "Kısa bir süre önce birinin evine aitti."
RECIPE.model = "models/props_c17/FurnitureDrawer001a_Chunk01.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_tattered_drawer"] = 1}
RECIPE.result = {["comp_wood"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_doll"
RECIPE.name = "Parçala: Eskimiş Oyuncak Bebek"
RECIPE.description = "Çoktan unutulmuş bir nesilden kalma eski, harap bir oyuncak bebek."
RECIPE.model = "models/props_c17/doll01.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_doll"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_coffeecup"
RECIPE.name = "Parçala: Boş Kahve Fincanı"
RECIPE.description = "Boş bir plastik kahve fincanı."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_coffeecup"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_computerparts"
RECIPE.name = "Parçala: Bilgisayar Parçaları"
RECIPE.description = "2000'lerin başındaki bilgisayarlar için eski savaş öncesi parçalar. Pek etkileyici değil."
RECIPE.model = "models/props_lab/harddrive01.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_computerparts"] = 1}
RECIPE.result = {["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 70}, -- full xp
	{level = 10, exp = 35}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_computer_tower"
RECIPE.name = "Parçala: Kırık Bilgisayar"
RECIPE.description = "Tekrar çalıştırılması veya kaynaklar için sökülmesi mümkün olmalıdır."
RECIPE.model = "models/props_lab/harddrive01.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_computer_tower"] = 1}
RECIPE.result = {["comp_electronics"] = 2, ["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_clock"
RECIPE.name = "Parçala: Eski Masa Saati"
RECIPE.description = "...Zaman, gerçekten yine o zaman mı?"
RECIPE.model = "models/props_combine/breenclock.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_clock"] = 1}
RECIPE.result = {["comp_wood"] = 2, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_carton"
RECIPE.name = "Parçala: Boş Süt Kartonu"
RECIPE.description = "Küçük plastik bir karton. Muhtemelen sıvı formda bir şey taşıyordu."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_carton"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_cardboard"
RECIPE.name = "Parçala: Karton Kutu"
RECIPE.description = "Tüketici ürünlerini taşımak için kullanılan bir karton kutu. Boş."
RECIPE.model = "models/props_junk/cardboard_box003a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_cardboard"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_bucket"
RECIPE.name = "Parçala: Kova"
RECIPE.description = "İçinde küçük eşyalar taşımak için kullanılan metal bir kova."
RECIPE.model = "models/props_junk/MetalBucket01a.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_bucket"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_empty_can"
RECIPE.name = "Parçala: Boş Metal Kutu"
RECIPE.description = "Metal bir kutuyu geri dönüştürün."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_empty_can"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_biolock"
RECIPE.name = "Parçala: Kırık Biyokilit"
RECIPE.description = "Kırılmış bir biyokilit. Ne utanç verici."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["trash_biolock"] = 1}
RECIPE.result = {["comp_scrap"] = 4, ["comp_electronics"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_cigarettepack"
RECIPE.name = "Parçala: Sigara Paketi"
RECIPE.description = "Sigara paketini parçalayın ve temel bileşenlerine ayırın."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["ciggie_pack"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_plushie"
RECIPE.name = "Parçala: Kaplumbağa Peluş"
RECIPE.description = "Yumuşak bir Peluş Kaplumbağa, hiçbir amaca hizmet etmiyor ama varlığı biliniyor. Üzerinde 'Mullin'.... yazan küçük bir etiket iliştirilmiş. Ne kadar tuhaf."
RECIPE.model = "models/willardnetworks/skills/turtle.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.ingredients = {["junk_turtle"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_battery"
RECIPE.name = "Parçala: Araba Aküsü"
RECIPE.description = "Eski dünyadan eski bir araba aküsü."
RECIPE.model = "models/Items/car_battery01.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Çöp"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_battery"] = 1}
RECIPE.result = {["comp_scrap"] = 2, ["comp_chemicals"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()
