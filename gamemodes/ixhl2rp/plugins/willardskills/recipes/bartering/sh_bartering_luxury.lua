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
RECIPE.name = "Cigarette Pack"
RECIPE.description = "A combine issued cigarette pack that packs 8 cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "luxury_zippo"
RECIPE.name = "Zippo Lighter"
RECIPE.description = "A quality metal lighter made to light up cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/zippo.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["zippolighter"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cheddar"
RECIPE.name = "Cheddar Cheese Slice"
RECIPE.description = "A slice of chedder cheese."
RECIPE.model = "models/willardnetworks/food/cheesewheel1c.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["luxury_cheddar"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_raw_fish"
RECIPE.name = "Raw Fish"
RECIPE.description = "A quite rare sight these days."
RECIPE.model = "models/willardnetworks/food/fishgolden.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["ing_fish"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_raw_beef"
RECIPE.name = "Raw Beef"
RECIPE.description = "A raw slab of beef, a rather rare commodity these days."
RECIPE.model = "models/willardnetworks/food/meat3.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["ing_beef"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_egg"
RECIPE.name = "Egg"
RECIPE.description = "Usually replaced with the Egg Protein Package these days."
RECIPE.model = "models/willardnetworks/food/egg1.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["ing_egg"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_choc"
RECIPE.name = "Union Choco"
RECIPE.description = "Prestine, immaculate and indulging - this bar of chocolate makes world-wide oppression seem but a harmless generosity to be lived in luxury."
RECIPE.model = "models/willardnetworks/props/unionchoco.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["luxury_choc"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_fruit_pineapple"
RECIPE.name = "Pineapple"
RECIPE.description = "A rare sight these days."
RECIPE.model = "models/willardnetworks/food/pineapple.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 40
RECIPE.result = {["fruit_pineapple"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_wine_white"
RECIPE.name = "White Wine"
RECIPE.description = "A rare are and expensive commodity."
RECIPE.model = "models/willardnetworks/food/white_wine.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["bottle_wine_white"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_red_wine"
RECIPE.name = "Red Wine"
RECIPE.description = "A rare and expensive commodity."
RECIPE.model = "models/willardnetworks/food/red_wine.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["bottle_wine_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_champagne"
RECIPE.name = "Bottle of Sparkling Champagne"
RECIPE.description = "Rumored to still be around in high circles, champagne is a highly prestigious and rare treat to discover these days."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_a.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["bottle_champagne"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_chess"
RECIPE.name = "Chess Table Assembly Kit"
RECIPE.description = "An assembly kit to put together a chess table."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["chess_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_checkers"
RECIPE.name = "Checkers Table Assembly Kit"
RECIPE.description = "An assembly kit to put together a checkers table."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["checkers_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_arcade"
RECIPE.name = "Arcade Machine Assembly Kit"
RECIPE.description = "An assembly kit to put together an arcade machine."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luxury"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["arcade_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_ciggie_goodfella"
RECIPE.name = "Goodfella Cigars"
RECIPE.description = "A pack of high-quality debonair cigarillos wrapped in high-grammage tobacco paper containing up to 8 cigarillos manufactured by Tenzhen Industries."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl"
RECIPE.category = "Luxury"
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
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_ice"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_creme"
RECIPE.name = "Créme"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_creme"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_salmon"
RECIPE.name = "Salmon"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_salmon"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_white"
RECIPE.name = "White Powder"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_white"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_idealist"
RECIPE.name = "Idealist"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_idealist"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_simple"
RECIPE.name = "Simple Folk"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_simple"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_follower"
RECIPE.name = "The Pharaoh's Follower"
RECIPE.description = "A jacket for collaborators in support of an authority figure."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_follower"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_twin"
RECIPE.name = "Twin Brown"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_twin"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bloke"
RECIPE.name = "Bloke Black"
RECIPE.description = "A collaborators jacket named after a certain individual."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bloke"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_afternoon"
RECIPE.name = "Afternoon"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_afternoon"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bistre"
RECIPE.name = "Bistre"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bistre"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bluedelight"
RECIPE.name = "Blue Delight"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bluedelight"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_burgundy"
RECIPE.name = "Burgundian Collaborator"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_burgundy"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_cadet"
RECIPE.name = "Cadet Blue"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_cadet"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_carnelian"
RECIPE.name = "Carnelian Red"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_carneliant"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_coral"
RECIPE.name = "Black Coral"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_coral"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_fixer"
RECIPE.name = "Fixer"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_fixer"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_foreigner"
RECIPE.name = "Foreigner"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_foreigner"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_kingpin"
RECIPE.name = "The Kingpin"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_kingpin"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_midnight"
RECIPE.name = "Midnight Black"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_midnight"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_midnightred"
RECIPE.name = "Midnight Red"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_midnightred"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_office"
RECIPE.name = "The Office"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_office"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_onyx"
RECIPE.name = "Onyx Shirt"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_onyx"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_orangedawn"
RECIPE.name = "Orange Dawn"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_orangedawn"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_redhaven"
RECIPE.name = "Red Haven"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_redhaven"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_reed"
RECIPE.name = "Reed Green"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_reed"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_sap"
RECIPE.name = "Sap Green"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_sap"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_taupe"
RECIPE.name = "The Taupe"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_taupe"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_walkster"
RECIPE.name = "Walkster"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_walkster"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_yonder"
RECIPE.name = "Blue Yonder"
RECIPE.description = "A comfortable jacket for collaborators in support of the regime."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Collaborator Attires"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_yonder"] = 1}
RECIPE:Register()

-- Fedora
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_fedora_brown"
RECIPE.name = "Brown Fedora"
RECIPE.description = "A rare brown stylish hat reminiscent of bygone times."
RECIPE.model = "models/willardnetworks/luxuryitems/head_fedora_recolorable.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["fedora_brown"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_fedora_black"
RECIPE.name = "Black Fedora"
RECIPE.description = "A rare black stylish hat reminiscent of bygone times."
RECIPE.model = "models/willardnetworks/luxuryitems/fedora_item.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["head_fedora"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_fedora_white"
RECIPE.name = "White Fedora"
RECIPE.description = "A rare white stylish hat reminiscent of bygone times."
RECIPE.model = "models/willardnetworks/luxuryitems/head_fedora_recolorable.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Headwear"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["fedora_white"] = 1}
RECIPE:Register()

-- Formal
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_shoes_dress"
RECIPE.name = "Dress Shoes"
RECIPE.description = "In todays market, only a small subset of civilians can afford these formal kinds of shoes."
RECIPE.model = "models/willardnetworks/clothingitems/shoes_formal.mdl"
RECIPE.category = "Luxury"
RECIPE.subcategory = "Shoes"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 500
RECIPE.result = {["shoes_dress_shoes"] = 1}
RECIPE:Register()