--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Worn Shoes
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_worn_dark"
RECIPE.name = "Yıpranmış Koyu Renkli Ayakkabılar"
RECIPE.description = "Bir çift koyu, yıpranmış ve yorgun ayakkabı... Çok fazla şey gördüler."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_military.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["shoes_worn_dark"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_worn_brown"
RECIPE.name = "Yıpranmış Kahverengi Ayakkabılar"
RECIPE.description = "Bir çift kahverengi, yıpranmış ve yorgun ayakkabı... Çok fazla şey gördüler."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_military.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["shoes_worn_brown"] = 1}
RECIPE:Register()


-- Civ Shoes
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_black"
RECIPE.name = "Siyah Ayakkabılar"
RECIPE.description = "Yollar ve patikalar için bir çift sağlam ayakkabı."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_black_shoes"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_bloke"
RECIPE.name = "Bloke Ayakkabılar"
RECIPE.description = "Yollar ve patikalar için bir çift siyah sağlam Bloke ayakkabısı. Uzun süredir bakımı yapılmıyor gibi."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_bloke"] = 1}
RECIPE:Register()


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_darkblue"
RECIPE.name = "Koyu Mavi Ayakkabılar"
RECIPE.description = "Yollar ve patikalar için bir çift sağlam ayakkabı."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_blue_shoes"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_grey"
RECIPE.name = "Gri Ayakkabılar"
RECIPE.description = "Yollar ve patikalar için bir çift sağlam ayakkabı."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_grey"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_brown"
RECIPE.name = "Kahverengi Ayakkabılar"
RECIPE.description = "Yollar ve patikalar için bir çift sağlam ayakkabı."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_brown_shoes"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_red"
RECIPE.name = "Koyu Kırmızı Ayakkabılar"
RECIPE.description = "Yollar ve patikalar için bir çift sağlam ayakkabı."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_universal.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_red"] = 1}
RECIPE:Register()

-- Leather Shoes
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_leather_dark"
RECIPE.name = "Koyu Deri Botlar"
RECIPE.description = "Önümüzdeki uzun yolculuğa hazır bir çift koyu renkli dayanıklı deri bot."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_boots.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_leather_dark"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_leather_brown"
RECIPE.name = "Kahverengi Deri Botlar"
RECIPE.description = "Bir çift kahverengi dayanıklı deri bot, önümüzdeki uzun yolculuğa hazır."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_boots.mdl"
RECIPE.category = "Giyim"
RECIPE.subcategory = "Ayakkabı"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["shoes_leather_brown"] = 1}
RECIPE:Register()