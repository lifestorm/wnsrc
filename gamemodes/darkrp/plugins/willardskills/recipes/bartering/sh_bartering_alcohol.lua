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
RECIPE.name = "Paquet de cigarettes"
RECIPE.description = "Un paquet de cigarettes fabriqué par l'Union contenant 8 cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_whiskey"
RECIPE.name = "Whisky Artificiel"
RECIPE.description = "L'étiquette le décrit comme une sorte de whisky... Mais cela n'a pas le goût du whisky."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alcool Artificiel"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_whiskey"] = 1}
RECIPE.buyAmount = 1 -- amount TEX
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_whiskey"
RECIPE.name = "Whisky"
RECIPE.description = "Un véritable Whisky raffiné, une rareté de nos jours."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_whiskey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_vodka"
RECIPE.name = "Vodka Artificiel"
RECIPE.description = "C'est assez difficile de dire quel goût la bouteille est censée avoir... L'étiquette le décrit comme une sorte de vodka."
RECIPE.model = "models/willardnetworks/food/vodka.mdl"
RECIPE.category = "Alcool Artificiel"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_vodka"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_vodka"
RECIPE.name = "Vodka"
RECIPE.description = "Une des nombreuses liqueurs des profondeurs de la Patrie. Est-ce pour vous ?"
RECIPE.model = "models/willardnetworks/food/vodka.mdl"
RECIPE.category = "Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_vodka"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_beer"
RECIPE.name = "Bière artificielle"
RECIPE.description = "Une boisson rafraîchissante fermentée."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alcool Artificiel"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["drink_proc_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_beer"
RECIPE.name = "Bière"
RECIPE.description = "Boisson alcoolisée à base de céréales fermentées."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_lager_siemens"
RECIPE.name = "Siemens Premium Lager Pils"
RECIPE.description = "A brown glass bottle with a fancy gold Siemens signature logo on the front, surrounded by small interlocking Union symbols. Within it holds a gleaming, golden-yellow liquid. Under the logo, it reads: German Premium Lager Pils. On the back, it reads: Brewed after German tradition, in City-24 with naturally soft Genevian alp water."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.skin = 1
RECIPE.category = "Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 23
RECIPE.result = {["drink_lager_siemens"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_bourbon"
RECIPE.name = "Bourbon Artificiel"
RECIPE.description = "Une version synthétique du bourbon."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alcool Artificiel"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_bourbon"
RECIPE.name = "Bourbon"
RECIPE.description = "Ce n'est pas du whisky, mais c'est du whisky. Est-ce à votre goût ?"
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alcool"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()