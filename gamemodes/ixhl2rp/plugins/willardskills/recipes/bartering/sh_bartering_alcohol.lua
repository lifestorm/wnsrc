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
RECIPE.name = "Cigarette Pack"
RECIPE.description = "A combine issued cigarette pack that packs 8 cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Artificial
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_bourbon"
RECIPE.name = "Artificial Bourbon"
RECIPE.description = "Crafted from synthetic origins, this bourbon presents an unnervingly smooth, artificial sweetness with notes of lab-generated oak and caramel."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_whiskey"
RECIPE.name = "Artificial Whiskey"
RECIPE.description = "Concocted from lab-engineered compounds, this hyper-processed whiskey offers a sharp, synthetic tang with hints of plastic and chrome."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_proc_whiskey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_beer"
RECIPE.name = "Artificial Beer"
RECIPE.description = "Fermented from synthetic ingredients in sterile vats, this dystopian beer offers a stark, metallic flavor with a touch of artificial hops."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_vodka"
RECIPE.name = "Artificial Vodka"
RECIPE.description = "Engineered from artificial compounds, this ultra-processed vodka delivers a crisp, synthetic bite with faint hints of rubber and circuitry."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_proc_vodka"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Bottled drinks

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_whiskey"
RECIPE.name = "Whiskey"
RECIPE.description = "Crafted from mysterious substances, this whiskey exudes an eerie, industrial flavor with hauntingly unfamiliar notes."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_whiskey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_vodka"
RECIPE.name = "Vodka"
RECIPE.description = "Forged through ruthless processing, this vodka offers a harsh, chemically-infused kick, devoid of any natural essence."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_vodka"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_beer"
RECIPE.name = "Beer"
RECIPE.description = "Brewed in sterile chambers, this beer lacks the rustic charm of traditional brewing, offering a cold, clinical taste with metallic undertones."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["drink_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_lager_siemens"
RECIPE.name = "Siemens Premium Lager Pils"
RECIPE.description = "A brown glass bottle with a fancy gold Siemens signature logo on the front, surrounded by small interlocking Union symbols. Within it holds a gleaming, golden-yellow liquid. Under the logo, it reads: German Premium Lager Pils. On the back, it reads: Brewed after German tradition, in City-24 with naturally soft Genevian alp water."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.skin = 1
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 23
RECIPE.result = {["drink_siemens_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_sake"
RECIPE.name = "City Eight Sake"
RECIPE.description = "An enigmatic brew of unknown origins, this sake delivers a chillingly synthetic flavor, with elusive notes that defy description."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["bottle_sake"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_bourbon"
RECIPE.name = "Bourbon"
RECIPE.description = "This bourbon lacks the soulful richness of its predecessors, delivering a sterile, flavorless experience with a faint hint of manufactured woodiness."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_moonshine"
RECIPE.name = "Moonshine"
RECIPE.description = "A slightly sweet-smelling liquor in an old soviet vodka bottle. It kicks like a mule. You could probably strip paint with it."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alcohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_moonshine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()