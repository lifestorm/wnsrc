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
RECIPE.uniqueID = "nonalcoholic_breen_water"
RECIPE.name = "Breen's Water"
RECIPE.description = "Küresel rejimi simgeleyen bir su kabı, tuhaf bir metalik tat ile geliyor."
RECIPE.model = "models/props_junk/PopCan01a.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_breen_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_boboriginal"
RECIPE.name = "Bob Water Orijinal"
RECIPE.description = "Bob Water'ın yumuşak karşılaması ve hafif orijinal tadı. Uyarı: Şiddetli bağırsak kanamasına ve hafif göz yorgunluğuna neden olabilir."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 4
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_boboriginal"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda_pink"
RECIPE.name = "Bank Soda Lite"
RECIPE.description = "Bank Soda amblemi ile süslenmiş kırmızı kestane rengi bir kutu. Gazlı içeceğin içinde, sıfır kafein ve şeker içeren, öncekinden daha acı ve biraz daha az tatlı, asidik bir tat sergileyen, hafif, esintili bir dokuya sahip karamelli bir sıvı bulunur."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 1
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_banksoda_pink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda"
RECIPE.name = "Bank Soda"
RECIPE.description = "Bank Soda amblemiyle süslenmiş gri-siyah kareli bir kutu. Gazlı içeceğin içinde hafif, havadar bir dokuya sahip karamelli bir sıvı ve kendine özgü tatlı ve şuruplu bir tada sahip hafif asidik kafein bulunur."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 2
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_c24"
RECIPE.name = "Bank Soda Kırmızı"
RECIPE.description = "Şehir Yirmi-Dört bayrağı ve Bank Soda etiketiyle süslenmiş kırmızı bir kutu. Gazlı içeceğin içinde göz sulandıran, sarımsı kahverengi, kafein benzeri bir sıvı var, tadı acı derecede keskin ve iğrenç. Derin bir vatanseverlik duygusu uyandırır."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 3
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_c24"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_ocean"
RECIPE.name = "Bank Soda Mavi"
RECIPE.description = "Bank Soda amblemiyle süslenmiş, okyanus akıntısını çağrıştıran dalgalı tasarıma sahip mavi bir kutu. Gazlı içeceğin içinde, mavi ahududu ve ananas gibi tatları anımsatan, hafif mavimsi bir renk tonu ve ekşi şekerli berrak bir sıvı bulunur."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 7
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_ocean"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_lager"
RECIPE.name = "Bank Soda Lager"
RECIPE.description = "Bank Soda amblemiyle süslenmiş beyaz-kahverengi bir kutu. Gazlı içeceğin içinde kremsi-zengin dokulu, sarsaparilla, vanilya ve kış yeşili gibi acı-tatlı bir tada sahip parlak karamelli bir sıvı bulunur."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 5
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_lager"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_licorice"
RECIPE.name = "Bank Soda Meyankökü"
RECIPE.description = "Pembe, konfeti ve sakızla kaplı bir kutu Bank Soda amblemiyle süslenebilir. Gazlı içeceğin içinde, kaynağı bilinmeyen, floresan yeşil bir sıvı bulunur; tadı pürüzsüz ve keskin tatlı şuruplu pop benzeri balonlu sakız tadı için vanilya köpüğü benzeri bir tatlıdır."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 6
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_licorice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_c8"
RECIPE.name = "Bank Soda Üzüm"
RECIPE.description = "Bank Soda amblemi ve üzüm resimleriyle süslenmiş, iki dalgalı çizgiye sahip mor bir kutu. Gazlı içeceğin içinde üzüme benzer, yapay olarak tatlı, hafif ekşi, şekerli bir tada sahip bir üzüm sıvısı bulunur."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 4
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_c8"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda_red"
RECIPE.name = "Bank Soda Oryantal"
RECIPE.description = "Bank Soda amblemi ve Combine amblemiyle süslenmiş kırmızı-mor bir kutu. Gazlı içeceğin içinde kaynağı bilinmeyen floresan yeşil bir sıvı var ve benzersiz tatlar yerine keskin bir tat, keskin bir koku ve alışılmadık bir asit sergiliyor. Kurşun içerir."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 0
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_proc_lemonade"
RECIPE.name = "Yapay Limonata"
RECIPE.description = "Tam olarak en ferahlatıcı içecek değil.. Hafif metalimsi bir tat bırakıyor."
RECIPE.model = "models/props_junk/GlassBottle01a.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_proc_fruit_juice"
RECIPE.name = "Yapay Meyve Suyu"
RECIPE.description = "Bir çeşit meyve suyuna benzeyen yapay bir sıvı."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_fruit_juice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_sparkling_water"
RECIPE.name = "Sparkling Breen's Water"
RECIPE.description = "A red can of water symbolic to the global regime, comes with a bit of a fiz to it and an artificial saccharine taste."
RECIPE.model = "models/willardnetworks/food/breencan1.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_sparkling_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_coffee"
RECIPE.name = "Kahve"
RECIPE.description = "Sıcak bir fincan kahve, bu garip zamanlarda sizi uyanık tutmaya yardımcı olur."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_coffee"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_premium_water"
RECIPE.name = "Premium Breen's Water"
RECIPE.description = "A premium can symbolic to the global regime with a shimmering yellow allure, its contents promise an enigmatic purity."
RECIPE.model = "models/willardnetworks/food/breencan2.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_premium_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_lemonade"
RECIPE.name = "Limonata"
RECIPE.description = "Serinletici bir bardak limonata. Sizi geçmişe götürüyor."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_b.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_fruit_juice"
RECIPE.name = "Meyve Suyu"
RECIPE.description = "Ferahlatıcı meyve suyu, tadı biraz otantik."
RECIPE.model = "models/props_junk/garbage_plasticbottle003a.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_fruit_juice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_wi_coffee"
RECIPE.name = "Willard Endüstrileri Kahvesi"
RECIPE.description = "Aşırı doz, uykusuzluk, ishal, yorgunluk, depresyon, kabuslar, kusma, baş ağrısı, anksiyete veya ölümle sonuçlanabilir. Tüketim sonucunda ölüm meydana gelirse, bir Willard Endüstrileri onaylı tıbbi uzmana danışın."
RECIPE.model = "models/willardnetworks/food/wi_coffee.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["drink_wi_coffee"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobgrape"
RECIPE.name = "Soda Bob Üzümlü"
RECIPE.description = "Etikette şöyle yazıyor: Pürüzsüz meyvemsi tat! Gerçek yapay üzümlerden yapılmış ve kirli kumlu çamur benzeri bir macunla aşılanmıştır!"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 0
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["drink_bobgrape"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobsurprise"
RECIPE.name = "Soda Bob Sürpriz"
RECIPE.description = "Etiket şaka ile şöyle diyor: Vişne sodasının güçlü ve çarpıcı tadı. Lezzetli, her kutuda garantili benzersiz bir tat keyfi! Rastgele yapay geyik eti ve kurşun kalem talaşı gibi sayısız çeşit malzemenin enfüzyonunun tadını çıkarın!"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 3
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_bobsurprise"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobfizz"
RECIPE.name = "Soda Bob Fizz"
RECIPE.description = "Etikette şöyle yazıyor: Limon, misket limonu, yüce, balçık içermez! Tat alma tomurcuklarınızı yörüngeye oturtacak taze bir lezzet!"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 2
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_bobfizz"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobdark"
RECIPE.name = "Soda Bob Dark"
RECIPE.description = "'Karanlık' sürümümüzün ince ve boğucu tadı, her yudumda ölümlü ruhunuzdan bir parça koparacak! Uyarı: Şeytani halüsinasyonlar görmeniz durumunda lütfen yerel Willard Endüstrileri uzmanlarına danışın."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 1
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_bobdark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobenergy"
RECIPE.name = "Soda Bob Enerji"
RECIPE.description = "Etiket şöyle diyor: Bu şekerli lezzet şölenini tek bir yudumda hızla içerek boyutlar arasında geçiş yapın ve hem kendinizle hem de evrenle bütünleşin."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 6
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_bobenergy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()


-- alkolsüz içecekler dışında

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_ciggie_pack"
RECIPE.name = "Sigara Paketi"
RECIPE.description = "Tam olarak 8 sigarayı içerebilen bir sigara paketi."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_carddeck"
RECIPE.name = "52'lik Kart Destesi"
RECIPE.description = "Fransız destesi tarzında 52 kartlık geleneksel bir kart destesi."
RECIPE.model = "models/cards/stack.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 31
RECIPE.result = {["card_deck"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_tea"
RECIPE.name = "Çay"
RECIPE.description = "Rahatlatıcı ve sıcak bir dokunuş."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Alkolsüz"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_tea"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()