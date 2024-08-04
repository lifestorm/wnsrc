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
RECIPE.name = "Paquet de cigarettes"
RECIPE.description = "Un paquet de cigarettes fabriqué par l'Union contenant 8 cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "luxury_zippo"
RECIPE.name = "Zippo Lighter"
RECIPE.description = "Briquet Zippo"
RECIPE.model = "models/willardnetworks/cigarettes/zippo.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["zippolighter"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cheddar"
RECIPE.name = "Tranche de cheddar"
RECIPE.description = "Une tranche de fromage cheddar"
RECIPE.model = "models/willardnetworks/food/cheesewheel1c.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["luxury_cheddar"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_raw_fish"
RECIPE.name = "Poisson cru"
RECIPE.description = "Vue rarement de nos jours"
RECIPE.model = "models/willardnetworks/food/fishgolden.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["ing_fish"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_raw_beef"
RECIPE.name = "Bœuf cru"
RECIPE.description = "Une tranche de bœuf cru, une denrée plutôt rare de nos jours."
RECIPE.model = "models/willardnetworks/food/meat3.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["ing_beef"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_egg"
RECIPE.name = "Œuf"
RECIPE.description = "Usually replaced with the Egg Protein Package these days."
RECIPE.model = "models/willardnetworks/food/egg1.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["ing_egg"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_choc"
RECIPE.name = "Union Choco"
RECIPE.description = "Précieux, immaculé et indulgent - cette tablette de chocolat fait paraître l'oppression mondiale comme une générosité inoffensive à vivre dans le luxe"
RECIPE.model = "models/willardnetworks/props/unionchoco.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["luxury_choc"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cream_pineapple"
RECIPE.name = "Glace à l'ananas"
RECIPE.description = "De la vraie glace à la crème, servie avec du jus d'ananas et des morceaux d'ananas à l'intérieur. Le mélange parfait entre le sucré et l'acide."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 26
RECIPE.result = {["cream_pineapple"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cream_mint"
RECIPE.name = "Glace à la menthe et aux pépites de chocolat"
RECIPE.description = "Le chef-d'œuvre des glaces : des morceaux de chocolat mélangés dans une portion de glace, parfaitement mariés avec une touche de menthe. La couleur verte avec des motifs en chocolat vous attire ; cette saveur est certainement une rareté.."
RECIPE.model = "models/willardnetworks/food/cproids.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["cream_mint"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_fruit_pineapple"
RECIPE.name = "Ananas"
RECIPE.description = "Assez rare de nos jours"
RECIPE.model = "models/willardnetworks/food/pineapple.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 40
RECIPE.result = {["fruit_pineapple"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_pizza_normal"
RECIPE.name = "Pizza au fromage"
RECIPE.description = "Un classique d'autrefois, la pizza reste largement inchangée, à l'exception de quelques ingrédients improvisés ici et là."
RECIPE.model = "models/props_junk/garbage_pizzabox01a_fullsheet.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 40
RECIPE.result = {["luxury_norpizza"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_white_wine"
RECIPE.name = "Vin blanc"
RECIPE.description = "Une denrée rare et coûteuse."
RECIPE.model = "models/willardnetworks/food/white_wine.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["drink_white_wine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_red_wine"
RECIPE.name = "Vin rouge"
RECIPE.description = "Une denrée rare et coûteuse."
RECIPE.model = "models/willardnetworks/food/red_wine.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["drink_red_wine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_champagne"
RECIPE.name = "Bouteille de champagne pétillant"
RECIPE.description = "On raconte qu'il est toujours présent dans les cercles élevés, le champagne est une friandise hautement prestigieuse et rare à découvrir de nos jours."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_a.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["drink_champagne"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_chess"
RECIPE.name = "Kit d'assemblage de table d'échecs"
RECIPE.description = "Un kit d'assemblage pour assembler une table d'échecs."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["chess_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_checkers"
RECIPE.name = "Kit d'assemblage de table de dames"
RECIPE.description = "Un kit d'assemblage pour assembler une table de dame."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["checkers_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_arcade"
RECIPE.name = "Kit d'assemblage de machine d'arcade"
RECIPE.description = "Un kit d'assemblage pour assembler une machine d'arcade.."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["arcade_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_ciggie_goodfella"
RECIPE.name = "Goodfella Cigars"
RECIPE.description = "Un paquet de cigarillos de grande qualité et élégants, enveloppés dans du papier à tabac de haute densité, contenant jusqu'à 8 cigarillos, fabriqués par Tenzhen Industries."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["ciggie_goodfella"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_red_wine_kofman"
RECIPE.name = "Vin rouge : Château Kofman"
RECIPE.description = "Un Vin rouge qui se boit facilement, les amateurs de vin vous dirons que c'est un bon vin mais sans plus."
RECIPE.model = "models/willardnetworks/food/red_wine.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 60
RECIPE.result = {["drink_red_wine_kofman"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_red_wine_deluxe_kofman"
RECIPE.name = "Vin Rouge : Château Deluxe Kofman"
RECIPE.description = "Une excellente cuvé à fournir à vos meilleurs amis ou à un rendez-vous très important, ce vin rouge semble être authentique."
RECIPE.model = "models/willardnetworks/food/red_wine.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 75
RECIPE.result = {["drink_red_wine_deluxe_kofman"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_white_wine_kofman"
RECIPE.name = "Vin Blanc : Domaine Kofman"
RECIPE.description = "Ce Vin blanc sort d'une usine de production et sa se sent quand on là en bouche."
RECIPE.model = "models/willardnetworks/food/red_wine.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 60
RECIPE.result = {["drink_white_wine_kofman"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_white_wine_premium_kofman"
RECIPE.name = "Vin Blanc : Domaine Premium Kofman"
RECIPE.description = "Ce Vin blanc sort d'une usine de production et sa se sent quand on là en bouche."
RECIPE.model = "models/willardnetworks/food/red_wine.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 75
RECIPE.result = {["drink_white_wine_premium_kofman"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_beer_kofman"
RECIPE.name = "Bière blonde Kofman"
RECIPE.description = "Cette bière à plus de gouts que les autres de l'union"
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl"
RECIPE.category = "Luxe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["drink_beer_kofman"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()