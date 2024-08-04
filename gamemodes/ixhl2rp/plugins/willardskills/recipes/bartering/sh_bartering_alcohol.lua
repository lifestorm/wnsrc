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
RECIPE.name = "Paczka papierosów"
RECIPE.description = "Wydana przez Kombinat paczka papierosów, w której mieści się 8 papierosów."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Artificial
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_bourbon"
RECIPE.name = "Syntetyczny burbon"
RECIPE.description = "Stworzony z syntetycznych składników, bourbon ten prezentuje niepokojąco gładką, sztuczną słodycz z nutami laboratoryjnie wytworzonego dębu i karmelu."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_whiskey"
RECIPE.name = "Syntetyczna whiskey"
RECIPE.description = "Butelka opisuje to jako pewnego rodzaju whiskey... Ale na pewno nie smakuje jak whiskey. Może to wcale nie whiskey?"
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_proc_whiskey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_beer"
RECIPE.name = "Syntetyczne piwo"
RECIPE.description = "Fermentowane z syntetycznych składników w sterylnych kadziach, to dystopijne piwo oferuje surowy, metaliczny smak z nutą sztucznego chmielu."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_proc_vodka"
RECIPE.name = "Syntetyczna wódka"
RECIPE.description = "Trudno opisać jak to smakuje. Niby wódka, a smakuje bardzo metalicznie."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alkohol"
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
RECIPE.description = "Whisky ta, wytworzona z nieznanych substancji, emanuje niesamowitym, przemysłowym smakiem z niepokojącymi, nieznanymi nutami."
RECIPE.model = "models/willardnetworks/food/whiskey.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_whiskey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_vodka"
RECIPE.name = "Wódka"
RECIPE.description = "Wódka ta, powstała w wyniku bezwzględnej obróbki, oferuje ostry, chemicznie wzmocniony smak, pozbawiony jakiejkolwiek naturalnej nuty."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_vodka"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_beer"
RECIPE.name = "Piwo"
RECIPE.description = "Piwo to napój alkoholowy o intensywnym smaku i zapachu, który czasami sprawia, że mówienie staje się trudniejsze niż rozwiązywanie równań matematycznych."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["drink_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_lager_siemens"
RECIPE.name = "Siemens Premium Lager Pils"
RECIPE.description = "Brązowa szklana butelka z fantazyjnym złotym logo Siemensa z przodu, otoczona małymi, zazębiającymi się symbolami Kombinatu. Wewnątrz znajduje się błyszczący, złoto-żółty płyn. Pod logo widnieje napis: German Premium Lager Pils. Z tyłu napis: Warzone zgodnie z niemiecką tradycją, w Mieście-24 z naturalnie miękką genewską wodą alp."
RECIPE.model = "models/willardnetworks/food/beer.mdl"
RECIPE.skin = 1
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 23
RECIPE.result = {["drink_siemens_beer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_sake"
RECIPE.name = "Sake Miasta Ósmego"
RECIPE.description = "Enigmatyczny napar o nieznanym pochodzeniu, ta sake zapewnia przyprawiający o dreszcze syntetyczny smak, z nieuchwytnymi nutami, które trudno opisać."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["bottle_sake"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_bourbon"
RECIPE.name = "Burbon"
RECIPE.description = "Bourbon to trunek zrobiony z kukurydzy, który sprawia, że robisz rzeczy, o których potem żałujesz, ale jednocześnie zapominasz o nich po wypiciu kolejnej szklanki. "
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_bourbon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "alcohol_moonshine"
RECIPE.name = "Księżycówka"
RECIPE.description = "Lekko słodko pachnący likier w starej radzieckiej butelce po wódce. Kopie jak muł. Prawdopodobnie można nim usunąć farbę."
RECIPE.model = "models/willardnetworks/food/alcohol_bottle.mdl"
RECIPE.category = "Alkohol"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["bottle_moonshine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()