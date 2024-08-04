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
RECIPE.uniqueID = "luxury_ciggie_pack"
RECIPE.name = "Sigara Paketi"
RECIPE.description = "Combine tarafından verilen, içinde 8 adet sigara bulunan bir sigara paketi."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "luxury_zippo"
RECIPE.name = "Zippo Çakmak"
RECIPE.description = "Kaliteli bir metal çakmak, sigarayı yakmak için yapılmış."
RECIPE.model = "models/willardnetworks/cigarettes/zippo.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["zippolighter"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cheddar"
RECIPE.name = "Cheddar Peyniri Dilimi"
RECIPE.description = "Bir dilim cheddar peyniri."
RECIPE.model = "models/willardnetworks/food/cheesewheel1c.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["luxury_cheddar"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_raw_fish"
RECIPE.name = "Çiğ Balık"
RECIPE.description = "Bugünlerde oldukça nadir bir görüntü."
RECIPE.model = "models/willardnetworks/food/fishgolden.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["ing_fish"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_raw_beef"
RECIPE.name = "Çiğ Dana Eti"
RECIPE.description = "Çiğ dana eti dilimi, bugünlerde oldukça nadir bulunan bir mal."
RECIPE.model = "models/willardnetworks/food/meat3.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["ing_beef"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_egg"
RECIPE.name = "Yumurta"
RECIPE.description = "Bugünlerde genellikle Yumurta Protein Paketi ile değiştiriliyor."
RECIPE.model = "models/willardnetworks/food/egg1.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["ing_egg"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_choc"
RECIPE.name = "Birlik Çikolatası"
RECIPE.description = "Saf, lekesiz ve keyifli - bu çikolata kalıcı dünya çapında baskıyı zararsız bir cömertlik gibi gösteriyor."
RECIPE.model = "models/willardnetworks/props/unionchoco.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["luxury_choc"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_fruit_pineapple"
RECIPE.name = "Ananas"
RECIPE.description = "Bugünlerde oldukça nadir bir görüntü."
RECIPE.model = "models/willardnetworks/food/pineapple.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 40
RECIPE.result = {["fruit_pineapple"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_wine_white"
RECIPE.name = "Beyaz Şarap"
RECIPE.description = "Nadir ve pahalı bir ürün."
RECIPE.model = "models/willardnetworks/food/white_wine.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["bottle_wine_white"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_red_wine"
RECIPE.name = "Kırmızı Şarap"
RECIPE.description = "Nadir ve pahalı bir mal."
RECIPE.model = "models/willardnetworks/food/red_wine.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["bottle_wine_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_champagne"
RECIPE.name = "Köpüklü Şampanya Şişesi"
RECIPE.description = "Hala yüksek çevrelerde olduğuna dair söylentiler var, şampanya günümüzde oldukça prestijli ve nadir bir lezzet haline geldi."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_a.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["bottle_champagne"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_chess"
RECIPE.name = "Satranç Masası Kurulum Kiti"
RECIPE.description = "Bir satranç masasını bir araya getirmek için bir kurulum kiti."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["chess_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_checkers"
RECIPE.name = "Dama Masası Kurulum Kiti"
RECIPE.description = "Bir dama masasını bir araya getirmek için bir kurulum kiti."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["checkers_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_arcade"
RECIPE.name = "Atari Makinesi Kurulum Kiti"
RECIPE.description = "Bir atari makinesini bir araya getirmek için bir kurulum kiti."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["arcade_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_ciggie_goodfella"
RECIPE.name = "Goodfella Puroları"
RECIPE.description = "Tenzhen Industries tarafından üretilen, yüksek kaliteli debonair puroların bulunduğu paket. Yüksek gramajlı tütün kağıdına sarılmış 8 adet puro içerir."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl"
RECIPE.category = "Lüx"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["ciggie_goodfella"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Collaborator attires
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_ice"
RECIPE.name = "Ice"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_ice"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_creme"
RECIPE.name = "Créme"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_creme"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_salmon"
RECIPE.name = "Salmon"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_salmon"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_white"
RECIPE.name = "White Powder"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_white"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_idealist"
RECIPE.name = "Idealist"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_idealist"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_simple"
RECIPE.name = "Simple Folk"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_simple"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_follower"
RECIPE.name = "The Pharaoh's Follower"
RECIPE.description = "Bir otorite figürünü desteklemek için işbirlikçiler için bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_follower"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_twin"
RECIPE.name = "Twin Brown"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_twin"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bloke"
RECIPE.name = "Bloke Black"
RECIPE.description = "Belirli bir kişinin adını taşıyan bir işbirlikçi ceketi."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bloke"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_afternoon"
RECIPE.name = "Afternoon"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_afternoon"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bistre"
RECIPE.name = "Bistre"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bistre"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bluedelight"
RECIPE.name = "Blue Delight"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bluedelight"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_burgundy"
RECIPE.name = "Burgundian Collaborator"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_burgundy"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_cadet"
RECIPE.name = "Cadet Blue"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_cadet"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_carnelian"
RECIPE.name = "Carnelian Red"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_carneliant"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_coral"
RECIPE.name = "Black Coral"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_coral"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_fixer"
RECIPE.name = "Fixer"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_fixer"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_foreigner"
RECIPE.name = "Foreigner"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_foreigner"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_kingpin"
RECIPE.name = "The Kingpin"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_kingpin"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_midnight"
RECIPE.name = "Midnight Black"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_midnight"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_midnightred"
RECIPE.name = "Midnight Red"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_midnightred"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_office"
RECIPE.name = "The Office"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_office"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_onyx"
RECIPE.name = "Onyx Shirt"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_onyx"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_orangedawn"
RECIPE.name = "Orange Dawn"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_orangedawn"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_redhaven"
RECIPE.name = "Red Haven"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_redhaven"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_reed"
RECIPE.name = "Reed Green"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_reed"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_sap"
RECIPE.name = "Sap Green"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_sap"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_taupe"
RECIPE.name = "The Taupe"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_taupe"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_walkster"
RECIPE.name = "Walkster"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_walkster"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_yonder"
RECIPE.name = "Blue Yonder"
RECIPE.description = "Rejimi destekleyen işbirlikçiler için rahat bir ceket."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "İşbirlikçi Kıyafetleri"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_yonder"] = 1}
RECIPE:Register()

-- Fedora
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_fedora_brown"
RECIPE.name = "Kahverengi Fedora"
RECIPE.description = "Geçmiş zamanları anımsatan nadir kahverengi şık bir şapka."
RECIPE.model = "models/willardnetworks/luxuryitems/head_fedora_recolorable.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "Şapkalar"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["fedora_brown"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_fedora_black"
RECIPE.name = "Siyah Fedora"
RECIPE.description = "Geçmiş zamanları anımsatan nadir siyah şık bir şapka."
RECIPE.model = "models/willardnetworks/luxuryitems/fedora_item.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "Şapkalar"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["head_fedora"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_fedora_white"
RECIPE.name = "Beyaz Fedora"
RECIPE.description = "Geçmiş zamanları anımsatan nadir beyaz şık bir şapka."
RECIPE.model = "models/willardnetworks/luxuryitems/head_fedora_recolorable.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "Şapkalar"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["fedora_white"] = 1}
RECIPE:Register()

-- Formal
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_shoes_dress"
RECIPE.name = "Elbise Ayakkabıları"
RECIPE.description = "Günümüz pazarında, sivillerin yalnızca küçük bir alt kümesi bu resmi ayakkabı türlerini karşılayabilir."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_formal.mdl"
RECIPE.category = "Lüx"
RECIPE.subcategory = "Ayakkabılar"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 500
RECIPE.result = {["shoes_dress_shoes"] = 1}
RECIPE:Register()
