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
RECIPE.uniqueID = "alcohol_ciggie_pack"
RECIPE.name = "Sigara Paketi"
RECIPE.description = "Combine tarafından verilen, içinde 8 adet sigara bulunan bir sigara paketi."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Artificial
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_bourbon"
RECIPE.name = "Yapay Bourbon"
RECIPE.description = "Sentetik kökenlerden üretilen bu burbon, laboratuvarda üretilen meşe ve karamel notaları ile sinir bozucu derecede pürüzsüz, yapay bir tatlılık sunar."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_whiskey"
RECIPE.name = "Yapay Viski"
RECIPE.description = "Laboratuvarda tasarlanmış bileşiklerden yapılan bu hiper işlenmiş viski, plastik ve krom ipuçlarıyla keskin, sentetik bir keskinlik sunar."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_proc_whiskey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_beer"
RECIPE.name = "Yapay Bira"
RECIPE.description = "Steril fıçılarda sentetik bileşenlerden fermente edilen bu distopik bira, yapay şerbetçiotu dokunuşuyla sade, metalik bir tat sunuyor."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_vodka"
RECIPE.name = "Yapay Votka"
RECIPE.description = "Yapay bileşiklerden tasarlanan bu ultra işlenmiş votka, hafif kauçuk ve devre ipuçlarıyla gevrek, sentetik bir tat sunar."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_proc_vodka"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Bottled drinks

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_whiskey"
RECIPE.name = "Viski"
RECIPE.description = "Gizemli maddelerden üretilen bu viski, akıldan çıkmayacak kadar alışılmadık şekilde ürkütücü, endüstriyel bir tat yayıyor."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_whiskey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_vodka"
RECIPE.name = "Vodka"
RECIPE.description = "Acımasız işlemlerle dövülen bu votka, herhangi bir doğal özden yoksun, sert, kimyasal olarak aşılanmış bir tekme sunar."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_vodka"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_beer"
RECIPE.name = "Bira"
RECIPE.description = "Steril odalarda demlenen bu bira, geleneksel bira yapımının rustik cazibesinden yoksundur ve metalik alt tonlu soğuk, klinik bir tat sunar."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["drink_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_lager_siemens"
RECIPE.name = "Siemens Premium Alman Birası"
RECIPE.description = "Önünde süslü altın Siemens imza logosu bulunan, birbirine kenetlenen küçük Birlik sembolleriyle çevrili kahverengi bir cam şişe. İçinde pırıl pırıl, altın sarısı bir sıvı bulunur."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.skin = 1
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 23
RECIPE.result = {["drink_siemens_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_sake"
RECIPE.name = "Şehir Sekiz Aşkına"
RECIPE.description = "Kökeni bilinmeyen esrarengiz bir bira olan bu sake, açıklamaya meydan okuyan zor bir tanımla tüyler ürpertici sentetik bir tat sunar."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["bottle_sake"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_bourbon"
RECIPE.name = "Bourbon"
RECIPE.description = "Bu bourbon, seleflerinin duygusal zenginliğinden yoksundur ve hafif bir üretilmiş odunsuluk ipucu ile steril, tatsız bir deneyim sunar."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_moonshine"
RECIPE.name = "Kaçak İçki"
RECIPE.description = "Eski bir sovyet votka şişesinde hafif tatlı kokulu bir likör. Bir katır gibi tekmeliyor. Muhtemelen onunla boyayı sıyırabilirsin."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alkol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_moonshine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()