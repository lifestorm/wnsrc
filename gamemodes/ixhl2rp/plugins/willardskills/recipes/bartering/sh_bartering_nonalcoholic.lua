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
RECIPE.description = "A can of water symbolic to the global regime, comes with a strange mmetalic taste to it."
RECIPE.model = "models/props_junk/PopCan01a.mdl"
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["drink_breen_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_boboriginal"
RECIPE.name = "Bob Water Original"
RECIPE.description = "The label jokingly reads: The soft welcoming and mild original taste of Bob Water. Warning: May cause severe intestinal bleeding and mild eye strain."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 4
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_boboriginal"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda_pink"
RECIPE.name = "Bank Soda Lite"
RECIPE.description = "A red maroon can adorned with the Bank Soda emblem. Inside the carbonated beverage is a caramel liquid with a light, breezy texture exhibiting a more bitter and slightly less sweet and acidic flavour than its predecessor, containing zero caffeine and sugar."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 1
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_banksoda_pink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda"
RECIPE.name = "Bank Soda"
RECIPE.description = "A grey-and-black checkered can adorned with the Bank Soda emblem. Inside the carbonated beverage is a caramel liquid with a light, breezy texture and mildly acidic caffeine with a distinctive sweet and syrupy flavour."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 2
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_banksoda_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_c24"
RECIPE.name = "Bank Soda Red"
RECIPE.description = "A red can adorned with the City Twenty-Four ensign and Bank Soda label. Inside the carbonated beverage is an eye-watering yellowish-brown caffeine-esque liquid, tasting bitterly sharp and servile. Evokes a profound sense of patriotism."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 3
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_c24"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_ocean"
RECIPE.name = "Bank Soda Blue"
RECIPE.description = "A blue can with a wavy design evoking the ocean torrent adorned with the Bank Soda emblem. Inside the carbonated beverage is a clear liquid with a faint bluish hue and tart sugariness, reminiscent of flavours like blue raspberry and pineapple."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 7
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_ocean"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_lager"
RECIPE.name = "Bank Soda Lager"
RECIPE.description = "A white-and-brown can adorned with the Bank Soda emblem. Inside the carbonated beverage is a glistening caramel liquid with a creamy-rich texture, tasting bitter-sweet like sarsaparilla, vanilla, and wintergreen."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 5
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_lager"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_licorice"
RECIPE.name = "Bank Soda Licorice"
RECIPE.description = "A pink, confetti-and-bubblegum-covered can adorn with the Bank Soda emblem. Inside the carbonated beverage is a fluorescent green liquid of unknown origins, tasting of a vanilla mousse-like dessert for a smooth and piquantly sweet syrupy pop-like bubblegum flavour."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 6
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_licorice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_c8"
RECIPE.name = "Bank Soda Grape"
RECIPE.description = "A purple can with two wavy lines adorned with the Bank Soda emblem and images of grapes. Inside the carbonated beverage is a grape liquid with an artificially sweet, mildly sour, sugary flavour similar to grape."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 4
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_c8"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda_red"
RECIPE.name = "Bank Soda Oriental"
RECIPE.description = "A red-purple can adorned with the Bank Soda emblem and Combine insignia. Inside the carbonated beverage is a fluorescent green liquid of unknown origins, and instead of unique flavours, it exhibits an acute taste, pungent smell, and unusual acidity. Contains lead."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 0
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_proc_lemonade"
RECIPE.name = "Artificial Lemonade"
RECIPE.description = "Not exactly the most refreshing drink.. There's a slight hint of metallic aftertaste."
RECIPE.model = "models/props_junk/GlassBottle01a.mdl"
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_proc_fruit_juice"
RECIPE.name = "Artificial Fruit Juice"
RECIPE.description = "A artificial liquid resembling some kind of fruit juice."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Non-alcoholic"
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
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_sparkling_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_coffee"
RECIPE.name = "Coffee"
RECIPE.description = "Warm cup of coffee, helps keep you alert and awake for these strange times."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Non-alcoholic"
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
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_premium_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_lemonade"
RECIPE.name = "Lemonade"
RECIPE.description = "A glass of refreshing Lemonade. Reminds you of the past."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_b.mdl"
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_fruit_juice"
RECIPE.name = "Fruit Juice"
RECIPE.description = "Refreshing fruit juice, tastes somewhat authentic."
RECIPE.model = "models/props_junk/garbage_plasticbottle003a.mdl"
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_fruit_juice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_wi_coffee"
RECIPE.name = "Willard Industries Coffee"
RECIPE.description = "Overdose may result in insomnia, diarrhea, fatigue, depression, nightmares, vomitting, headaches, anxiety or death. Consult a Willard Industries approved medical professional if death occurs upon consumption."
RECIPE.model = "models/willardnetworks/food/wi_coffee.mdl"
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["drink_wi_coffee"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobgrape"
RECIPE.name = "Soda Bob Grape"
RECIPE.description = "The label reads: Smooth fruity taste! Made from real artificial grapes and infused with a grimy sandy mud-like paste!"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 0
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["drink_bobgrape"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobsurprise"
RECIPE.name = "Soda Bob Surprise"
RECIPE.description = "The label jokingly reads: The strong and striking taste of cherry soda. Flavourful, with a guaranteed unique taste in every can! Enjoy a random infusion of a countless variety of ingredients, including artificial deer meat and pencil shavings!"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 3
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_bobsurprise"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobfizz"
RECIPE.name = "Soda Bob Fizz"
RECIPE.description = "The label reads: Lemon, lime, sublime, containing no slime! A fresh zingy taste to blow your taste buds into orbit!"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 2
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_bobfizz"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobdark"
RECIPE.name = "Soda Bob Dark"
RECIPE.description = "The label reads: The subtle and sultry taste of our 'dark' edition will chip away a piece of your mortal soul with every sip! Warning: Please consult your local Willard Industries professionals if demonic hallucinations occur."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 1
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_bobdark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobenergy"
RECIPE.name = "Soda Bob Energy"
RECIPE.description = "The label reads: Guzzle down this sugary treat in a single swig to phase between realms and become pure energy, at one with both yourself and the universe."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 6
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_bobenergy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()


-- non-drinks

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_ciggie_pack"
RECIPE.name = "Cigarette Pack"
RECIPE.description = "A combine issued cigarette pack that packs 8 cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_carddeck"
RECIPE.name = "52-Card Deck"
RECIPE.description = "A traditional 52-card deck of French-suited playing cards."
RECIPE.model = "models/cards/stack.mdl"
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 31
RECIPE.result = {["card_deck"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_tea"
RECIPE.name = "Cup of Tea"
RECIPE.description = "Comforting and warm to the touch."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Non-alcoholic"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_tea"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()