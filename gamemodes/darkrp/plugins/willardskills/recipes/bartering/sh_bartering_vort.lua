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
RECIPE.uniqueID = "bartering_vort_bandanna"
RECIPE.name = "Vortigaunt Bandana"
RECIPE.description = "Bir vortigaunt için uygun büyük bir bandana."
RECIPE.model = "models/willardnetworks/clothingitems/head_facewrap.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_bandana"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_chef"
RECIPE.name = "Vortigaunt Şef Şapkası"
RECIPE.description = "Vortigauntlar, Vortessence ile olan bağlantıları nedeniyle mutfak sanatlarındaki katıksız yetenekleriyle tanınırlar. Bir Vortigaunt'un geçici olarak uzman bir şef gibi davranması için geriye kalan tek adım, bu aptal şapkalardan birini takmaktır."
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_head_chefhat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_hardhat"
RECIPE.name = "Vortigaunt İnşaat Şapkası"
RECIPE.description = "Arkasında Combine işareti bulunan bu inşaat şapkaları genellikle Sivil İşçi Birliği tarafından giyilir."
RECIPE.model = "models/willardnetworks/clothingitems/workercap_item.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_head_hardhat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_hardhat"
RECIPE.name = "Vortigaunt Düz Şapka"
RECIPE.description = "Kafada düz olan şık bir eski tarz şapka. Bazı vortların kendine özgü bir tarzı vardır."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat2.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_head_flatcap"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_fedora"
RECIPE.name = "Vortigaunt Fedora"
RECIPE.description = "Geçmiş zamanları anımsatan nadir ve şık bir şapka, kesinlikle hiçbir canlı varlık bunlardan birine sahip bir vortigaunt görmeyi beklemez."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat2.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 40
RECIPE.result = {["vortigaunt_head_fedora"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_boonie"
RECIPE.name = "Vortigaunt Boonie"
RECIPE.description = "Geniş çerçeveli bir şapka. Güneşi vort kafanızdan uzak tutar."
RECIPE.model = "models/willardnetworks/clothingitems/head_boonie.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_head_boonie"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_hoodie"
RECIPE.name = "Vortigaunt Kapüşonlu"
RECIPE.description = "Daha uzun bir boyun için uzun bir kapüşonlu. En zorlu koşullarda bile bir vortigaunt'u sıcak tutmak için mükemmeldir."
RECIPE.model = "models/willardnetworks/vort_clothingitems/vort_sweater.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_torso_hoodie"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_sweater"
RECIPE.name = "Vortigaunt Kazak"
RECIPE.description = "Normalde insanlar için yapılmış bir kazak. En zorlu koşullarda bile bir vortigaunt'ı sıcak tutmak için mükemmeldir."
RECIPE.model = "models/willardnetworks/vort_clothingitems/vort_sweater.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_torso_sweater"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_poncho"
RECIPE.name = "Zarif Vortigaunt Panço"
RECIPE.description = "A reliable and solid covering, It's composition derived from typical human garments. Loose fitting design and convenient cutouts allow for comfort and freedom of movement."
RECIPE.model = "models/props_c17/BriefCase001a.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_torso_light"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_covering"
RECIPE.name = "El Yapımı Vortigaunt Kaplaması"
RECIPE.description = "Basit, sade bir kaplama. Soğuk bir gecede sizi rahat tutmak için iyi, başka bir şey değil."
RECIPE.model = "models/n7/vorti_outfit/light02.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_torso_light2"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_bandages"
RECIPE.name = "Vortigaunt Bandajları"
RECIPE.description = "Yaralı ya da başka türlü, bu bandajlar amacına hizmet edecektir."
RECIPE.model = "models/willardnetworks/vort_clothingitems/vort_bandage.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_bandages"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_belt"
RECIPE.name = "Vortigaunt Kemeri"
RECIPE.description = "İnsan kullanımı için yapılmış bir kemer, ancak meraklı bir vortigaunt bunu deneyebilir."
RECIPE.model = "models/willardnetworks/vort_clothingitems/vort_belt.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_belt"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()