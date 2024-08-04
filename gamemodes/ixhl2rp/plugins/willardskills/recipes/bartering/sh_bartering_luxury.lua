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
RECIPE.name = "Paczka papierosów"
RECIPE.description = "Wydana przez Kombinat paczka papierosów, w której mieści się 8 papierosów."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "luxury_zippo"
RECIPE.name = "Zapalniczka Zippo"
RECIPE.description = "Zapalniczka Zippo to klasyczny model zapalniczki na benzynę z charakterystycznym metalowym etui i mechanizmem zapalającym na iskry."
RECIPE.model = "models/willardnetworks/cigarettes/zippo.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["zippolighter"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cheddar"
RECIPE.name = "Plaster sera cheddar"
RECIPE.description = "Plasterek sera cheddar."
RECIPE.model = "models/willardnetworks/food/cheesewheel1c.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["luxury_cheddar"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_raw_fish"
RECIPE.name = "Surowa ryba"
RECIPE.description = "To dość rzadki widok w dzisiejszych czasach."
RECIPE.model = "models/willardnetworks/food/fishgolden.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["ing_fish"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_raw_beef"
RECIPE.name = "Surowa wołowina"
RECIPE.description = "Mięso pochodzące z krowy, które nie zostało poddane procesom obróbki termicznej czy też innym przetworzeniom."
RECIPE.model = "models/willardnetworks/food/meat3.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["ing_beef"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_egg"
RECIPE.name = "Jajko"
RECIPE.description = "Zazwyczaj zastępowane w dzisiejszych czasach pakietem proteinowym z jajek."
RECIPE.model = "models/willardnetworks/food/egg1.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["ing_egg"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_choc"
RECIPE.name = "Choco Unia"
RECIPE.description = "Słodka przekąska w postaci płaskiej płytki wykonanej z rozpuszczonego kakao, cukru i innych składników, często podzielona na mniejsze kawałki."
RECIPE.model = "models/willardnetworks/props/unionchoco.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["luxury_choc"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_fruit_pineapple"
RECIPE.name = "Ananas"
RECIPE.description = "Rzadki widok w dzisiejszych czasach. Oznaka luksusu od dawnych lat."
RECIPE.model = "models/willardnetworks/food/pineapple.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 40
RECIPE.result = {["fruit_pineapple"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_white_wine"
RECIPE.name = "Białe wino"
RECIPE.description = "Stare wino i młoda kobieta to najlepsza dieta."
RECIPE.model = "models/willardnetworks/food/white_wine.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["bottle_wine_white"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_red_wine"
RECIPE.name = "Czerwone wino"
RECIPE.description = "Idealne na zimne, samotne wieczory. Na te ciepłe też."
RECIPE.model = "models/willardnetworks/food/red_wine.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["bottle_wine_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_drink_champagne"
RECIPE.name = "Butelka szampana musującego"
RECIPE.description = "Szampan musujący, świetnie nadaje się na huczne przyjęcia, a do tego jest pełen bąbelków! Kto nie kocha bąbelków?"
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_a.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["bottle_champagne"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_chess"
RECIPE.name = "Zestaw do montażu stołu szachowego"
RECIPE.description = "Zestaw montażowy do złożenia stolika szachowego."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["chess_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_checkers"
RECIPE.name = "Zestaw montażowy stołu do gry w warcaby"
RECIPE.description = "Zestaw montażowy do złożenia stołu do gry w warcaby."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["checkers_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_arcade"
RECIPE.name = "Zestaw montażowy do maszyny do gier typu 'Arcade'"
RECIPE.description = "Zestaw montażowy do złożenia maszyny zręcznościowej."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 100
RECIPE.result = {["arcade_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_ciggie_goodfella"
RECIPE.name = "Cygaretki Goodfella"
RECIPE.description = "Paczka cygaretek wysokiej jakości, w której mieści się ich 8 sztuk."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack_goodfella.mdl"
RECIPE.category = "Luksusowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["ciggie_goodfella"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Odzież kolaborantów
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_ice"
RECIPE.name = "Lód"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_ice"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_creme"
RECIPE.name = "Créme"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_creme"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_salmon"
RECIPE.name = "Łosoś"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_salmon"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_white"
RECIPE.name = "Biały Pył"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_white"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_idealist"
RECIPE.name = "Idealista"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_idealist"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_simple"
RECIPE.name = "Swój Chłop"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_simple"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_follower"
RECIPE.name = "Wyznawca Faraona"
RECIPE.description = "A jacket for collaborators in support of an authority figure."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_follower"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_twin"
RECIPE.name = "Twin Brown"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_twin"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bloke"
RECIPE.name = "Ciemna Czerń"
RECIPE.description = "A collaborators jacket named after a certain individual."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bloke"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_afternoon"
RECIPE.name = "Popołudnie"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_afternoon"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bistre"
RECIPE.name = "Bistr"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bistre"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_bluedelight"
RECIPE.name = "Niebiańska rozkosz"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_bluedelight"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_burgundy"
RECIPE.name = "Burgundowy kolaborant"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_burgundy"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_cadet"
RECIPE.name = "Niebieski Kadet"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_cadet"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_carnelian"
RECIPE.name = "Czerwony Karneol"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_carneliant"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_coral"
RECIPE.name = "Czarny Koralowiec"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_coral"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_fixer"
RECIPE.name = "Rzemieślnik"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_fixer"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_foreigner"
RECIPE.name = "Obcy"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_foreigner"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_kingpin"
RECIPE.name = "Kingpin"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_kingpin"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_midnight"
RECIPE.name = "Północ"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_midnight"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_midnightred"
RECIPE.name = "Krwawy księżyc"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_midnightred"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_office"
RECIPE.name = "The Office"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_office"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_onyx"
RECIPE.name = "Onyx"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_onyx"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_orangedawn"
RECIPE.name = "Zachód słońca"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_orangedawn"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_redhaven"
RECIPE.name = "Czerwone niebo"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_redhaven"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_reed"
RECIPE.name = "Oliwka"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_reed"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_sap"
RECIPE.name = "Zieleń"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_sap"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_taupe"
RECIPE.name = "Kret"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_taupe"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_walkster"
RECIPE.name = "Podróżnik"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_walkster"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_lux_collab_yonder"
RECIPE.name = "Niebieska Otchłań"
RECIPE.description = "Wygodna marynarka uszyta specjalnie dla kolaborantów w zamian za wsparcie reżimu."
RECIPE.model = "models/willardnetworks/luxuryitems/torso_alyxcoat7_blue.mdl"
RECIPE.category = "Luksusowe"
RECIPE.subcategory = "Odzież kolaborantów"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["collab_yonder"] = 1}
RECIPE:Register()

-- Fedora
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_fedora_brown"
RECIPE.name = "Brązowa Fedora"
RECIPE.description = "Rzadko spotykany brązowy, stylowy kapelusz przypominający minione czasy."
RECIPE.model = "models/willardnetworks/clothingitems/head_fedora_recolorable.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["fedora_brown"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_fedora_black"
RECIPE.name = "Czarna Fedora"
RECIPE.description = "Rzadko spotykany czarny, stylowy kapelusz przypominający minione czasy."
RECIPE.model = "models/willardnetworks/clothingitems/fedora_item.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["head_fedora"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_fedora_white"
RECIPE.name = "Biała Fedora"
RECIPE.description = "Rzadko spotykany biały, stylowy kapelusz przypominający minione czasy."
RECIPE.model = "models/willardnetworks/clothingitems/head_fedora_recolorable.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["fedora_white"] = 1}
RECIPE:Register()

-- Formal
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_shoes_dress"
RECIPE.name = "Eleganckie buty"
RECIPE.description = "Na dzisiejszym rynku tylko niewielki podzbiór cywilów może sobie pozwolić na takie formalne rodzaje butów"
RECIPE.model = "models/willardnetworks/clothingitems/shoes_formal.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Buty"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 500
RECIPE.result = {["shoes_dress_shoes"] = 1}
RECIPE:Register()