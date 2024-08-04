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
RECIPE.name = "Woda Breena"
RECIPE.description = "Puszka wody o dziwnym smaku. Wydaje się orzeźwiająca. Reklamuje ją sam Breen, musi być naprawdę zdrowa."
RECIPE.model = "models/props_junk/PopCan01a.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["drink_breen_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_boboriginal"
RECIPE.name = "Bob Water Original"
RECIPE.description = "Smaczna i delikatna w smaku woda. Uwaga: Może powodować rozległe krwotoki wewnętrzne."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 4
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_boboriginal"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda_pink"
RECIPE.name = "Bank Soda Lite (dietetyczny)"
RECIPE.description = "Niskosłodzony napój, stanowi alternatywę dla Bank Soda produkowanego przez Tenzhen Soda Drinks."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 1
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_banksoda_pink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda"
RECIPE.name = "Bank Soda"
RECIPE.description = "Wysokiej jakości napój gazowany produkowany przez Tenzhen Soda Drinks."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 2
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_banksoda_grey"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_c24"
RECIPE.name = "Bank Soda C24"
RECIPE.description = "Pamiątkowy napój gazowany wyprodukowany przez Tenzhen Industries Drinks celebruje fascynującą historię Miasta 24. Ten inspirowany historią napój smakuje jak wiśnia, ołówek i poszatkowane książki historyczne."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 3
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_c24"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_ocean"
RECIPE.name = "Bank Soda Ocean Blue"
RECIPE.description = "Słodko-kwaśny napój gazowany produkowany przez Tenzhen Industries Drinks.  Rozkoszuj się smakiem Bank Soda dzięki temu pysznemu, słodko-gorzkiemu napojowi o smaku gumy balonowej i limonki; plotki głoszą, że świetnie łączy się z alkoholem."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 7
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_ocean"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_lager"
RECIPE.name = "Bank Soda Piwo Lager"
RECIPE.description = "Karmelowy napój gazowany produkowany przez Tenzhen Industries Drinks. Rozkoszuj się pysznością napoju Bank Soda dzięki temu aromatycznemu piwu korzennemu o smaku karmelu, czarnej wiśni, lukrecji i ołowiu."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 5
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_lager"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_licorice"
RECIPE.name = "Bank Soda Lukrecja"
RECIPE.description = "Różowo-wiśniowy napój gazowany produkowany przez Tenzhen Industries Drinks. Rozkoszuj się pysznością napoju Bank Soda dzięki temu jedynemu w swoim rodzaju wyskokowemu napojowi boba."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 6
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_banksoda_licorice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_c8"
RECIPE.name = "Bank Soda C8"
RECIPE.description = "Egzotyczny napój gazowany produkowany przez Tenzhen Industries Drinks. Rozkoszuj się pysznością napoju Bank Soda o słodyczy stu wschodzących słońc; smakuje jak arbuz i słońce."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 4
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_c8"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_banksoda_red"
RECIPE.name = "Bank Soda Orient"
RECIPE.description = "Wschodni, oryginalny napój gazowany i poprzednik Bank Soda produkowany przez Tenzhen Soda Drinks."
RECIPE.model = "models/willardnetworks/food/bobdrinks_goodfella.mdl"
RECIPE.skin = 0
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["drink_banksoda_red"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_proc_lemonade"
RECIPE.name = "Syntetyczna Lemoniada"
RECIPE.description = "Nie należy do najbardziej orzeźwiających napojów. Ma lekki posmak metaliczny."
RECIPE.model = "models/props_junk/GlassBottle01a.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_proc_fruit_juice"
RECIPE.name = "Syntetyczny sok owocowy"
RECIPE.description = "Sztuczny płyn przypominający jakiś sok owocowy."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["drink_proc_fruit_juice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_sparkling_water"
RECIPE.name = "Woda gazowana Breen'a"
RECIPE.description = "Czerwona puszka wody z bąbelkami. Jest całkiem słodka."
RECIPE.model = "models/willardnetworks/food/breencan1.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_sparkling_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_coffee"
RECIPE.name = "Kawa"
RECIPE.description = "Ciepła kubek kawy, pomaga utrzymać czujność."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_coffee"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_premium_water"
RECIPE.name = "Woda Breena 'Premium'"
RECIPE.description = "Bardzo wymyślna puszka wody o bardzo słodkim smaku."
RECIPE.model = "models/willardnetworks/food/breencan2.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_premium_water"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_lemonade"
RECIPE.name = "Lemoniada"
RECIPE.description = "Szklanka orzeźwiającej Lemoniady. Smak dzieciństwa, co nie?."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_b.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["drink_lemonade"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_fruit_juice"
RECIPE.name = "Sok owocowy"
RECIPE.description = "Orzeźwiający sok owocowy, smakuje jak prawdziwe owoce."
RECIPE.model = "models/props_junk/garbage_plasticbottle003a.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_fruit_juice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_wi_coffee"
RECIPE.name = "Kawa 'Willard Industries'"
RECIPE.description = "Przedawkowanie może spowodować bezsenność, biegunkę, zmęczenie, depresję, koszmary, wymioty, bóle głowy, niepokój lub śmierć. Skonsultuj się z zatwierdzonym przez Willard Industries specjalistą medycznym, jeśli po spożyciu nastąpi śmierć."
RECIPE.model = "models/willardnetworks/food/wi_coffee.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["drink_wi_coffee"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobgrape"
RECIPE.name = "Soda Bob Grape"
RECIPE.description = "Na etykiecie czytamy: 'Gładki owocowy smak! Wyprodukowany z prawdziwych, sztucznych winogron i nasączony pastą przypominającą gęsty kisiel pełen grudek!'"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 0
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["drink_bobgrape"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobsurprise"
RECIPE.name = "Soda Bob Surprise"
RECIPE.description = "Mocny i uderzający smak gazowanego napoju wiśniowego. Aromatyczny, z gwarancją niepowtarzalnego smaku w każdej puszce! Ciesz się tym przypadkowym smakiem z niezliczonej ilości składników, w tym sztucznego mięsa jelenia i wiórków ołówka!"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 3
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["drink_bobsurprise"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobfizz"
RECIPE.name = "Soda Bob Fizz"
RECIPE.description = "Na etykiecie czytamy: 'Cytryna, limonka, napój wysublimowany, nie zawierający śluzu! Świeży, orzeźwiający smak, który wyniesie Twoje kubki smakowe na orbitę!'"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 2
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_bobfizz"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobdark"
RECIPE.name = "Soda Bob Dark"
RECIPE.description = "Na etykiecie czytamy: 'Subtelny i duszny smak naszej 'ciemnej' edycji wyszczerbi kawałek twojej śmiertelnej duszy z każdym łykiem! Ostrzeżenie: W przypadku wystąpienia demonicznych halucynacji należy skonsultować się z lokalnymi specjalistami z Willard Industries.'"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 1
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_bobdark"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_bobenergy"
RECIPE.name = "Soda Bob Energy"
RECIPE.description = "Na etykiecie czytamy: 'Wypij jednym haustem, aby wejść w fazę między sferami i stać się czystą energią, w jedności ze sobą i wszechświatem.'"
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.skin = 6
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["drink_bobenergy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()


-- non-drinks

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_ciggie_pack"
RECIPE.name = "Paczka papierosów"
RECIPE.description = "Wydana przez Kombinat paczka papierosów, w której mieści się 8 papierosów."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_carddeck"
RECIPE.name = "52-kartowa talia"
RECIPE.description = "Tradycyjna 52-kartowa talia kart do gry w stylu francuskim."
RECIPE.model = "models/cards/stack.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 31
RECIPE.result = {["card_deck"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "nonalcoholic_tea"
RECIPE.name = "Herbata"
RECIPE.description = "Zazwyczaj herbata ma gorzko-słodki smak, jak samo życie, ale ta napewno nie jest ani trochę słodka."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Bezalkoholowe"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["drink_tea"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()