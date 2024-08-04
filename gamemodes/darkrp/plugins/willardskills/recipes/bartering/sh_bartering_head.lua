--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Beanie
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_brown"
RECIPE.name = "Kahverengi Beanie"
RECIPE.description = "Kahverengi, yünlü bir bere. Sıcak ve rahat."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_brown"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_grey"
RECIPE.name = "Gri Beanie"
RECIPE.description = "Gri, yünlü bir bere. Sıcak ve rahat."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_grey"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_red"
RECIPE.name = "Kırmızı Beanie"
RECIPE.description = "Kırmızı, biraz ihmal edilmese de, yünlü bir bere. Sıcak ve rahat."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_red"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_blue"
RECIPE.name = "Mavi Beanie"
RECIPE.description = "Biraz ihmal edilmemiş olsa da mavi, yünlü bir bere. Sıcak ve rahat."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["head_blue_beanie"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_green"
RECIPE.name = "Yeşil Bere"
RECIPE.description = "Yeşil, biraz ihmal edilmese de, yünlü bir bere. Sıcak ve rahat."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["head_green_beanie"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

-- Non-colorable
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_boonie"
RECIPE.name = "Boonie Şapkası"
RECIPE.description = "Geniş kenarlı bir şapka. Güneşi kafandan uzak tutar."
RECIPE.model = "models/willardnetworks/clothingitems/head_boonie.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["head_boonie_hat"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_chef"
RECIPE.name = "Şef Şapkası"
RECIPE.description = "Uzun boylu, beyaz bir şapka. Yemek pişirmede iyi olması gerekenler tarafından giyilir."
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_chef_hat"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_cap"
RECIPE.name = "Düz Başlık"
RECIPE.description = "Kafasında düz olan şık bir eski okul şapkası."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat2.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_flat_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_visor"
RECIPE.name = "Siperli Şapka"
RECIPE.description = "Siperlikli bir şapka. Güneşi gözlerinizden uzak tutar."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_visor_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_military_cap"
RECIPE.name = "Askeri Şapka"
RECIPE.description = "Yıpranmış askeri amblemli bir şapka."
RECIPE.model = "models/willardnetworks/clothingitems/head_confederatehat.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["head_military_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

-- Glasses
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_glasses"
RECIPE.name = "Gözlükler"
RECIPE.description = "Bir çift siyah, kare çerçeveli gözlük. Görmenize yardımcı olur."
RECIPE.model = "models/willardnetworks/clothingitems/glasses.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["glasses"] = 1}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_aviators"
RECIPE.name = "Havacı Gözlükleri"
RECIPE.description = "Geçmişi anımsatan bir çift şık havacı gözlüğü."
RECIPE.model = "models/willardnetworks/clothingitems/head_aviators.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["aviators"] = 1}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_70s"
RECIPE.name = "70'ler Gözlükleri"
RECIPE.description = "Kahverengi çerçeveli bir çift vintage 70'ler gözlüğü."
RECIPE.model = "models/willardnetworks/clothingitems/head_glasses_70s.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Şapka"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["70sglasses"] = 1}
RECIPE:Register()