--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_bandanna"
RECIPE.name = "Bandana dla Vortigaunta"
RECIPE.description = "Dyskrecja to podstawa, nikt nie chciałby wiedzieć, że napada Cię Vortigaunt."
RECIPE.model = "models/willardnetworks/clothingitems/head_facewrap.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_bandana"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_chef"
RECIPE.name = "Czapka szefa kuchni dla Vortigaunta"
RECIPE.description = "Vortigaunty znane są z ich zamiłowania do gotowania, tym razem może to nawet pokazać przez swój ubiór."
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_head_chefhat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_hardhat"
RECIPE.name = "Czapka budowlana dla Vortigaunta"
RECIPE.description = "Oznaczona znakiem Kombinatu z tyłu, te czapki budowlane są często noszone przez Civil Worker's Union."
RECIPE.model = "models/willardnetworks/clothingitems/workercap_item.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_head_hardhat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_flatcap"
RECIPE.name = "Kaszkiet dla Vortigaunta"
RECIPE.description = "Stylowy oldschoolowy kaszkiet, który płasko leży na głowie... Niektóre Vortigaunty mają wysublimowany gust."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat2.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_head_flatcap"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_fedora"
RECIPE.name = "Fedora dla Vortigaunta"
RECIPE.description = "Rzadko spotykany stylowy kapelusz przywodzący na myśl minione czasy, z pewnością żadna żywa istota nie spodziewałaby się zobaczyć Vortigaunta z taką dripuwą."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat2.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 40
RECIPE.result = {["vortigaunt_head_fedora"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_boonie"
RECIPE.name = "Kapelusz typu 'Boonie' dla Vortigaunta"
RECIPE.description = "Kapelusz z szerokim rondem. Utrzymuje słońce z dala od głowy Vortigaunta."
RECIPE.model = "models/willardnetworks/clothingitems/head_boonie.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_head_boonie"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_hoodie"
RECIPE.name = "Bluza dla Vortigaunta"
RECIPE.description = "Specjalnie zrobiona bluza z dłuższą szyją tak aby pasowała na Vortigaunta, utrzyma go przy cieple nawet w najtrudniejszych warunkach."
RECIPE.model = "models/willardnetworks/vort_clothingitems/vort_sweater.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_torso_hoodie"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_sweater"
RECIPE.name = "Sweter dla Vortigaunta"
RECIPE.description = "Sweter stworzony dla ludzi... Ciekawski Vortigaunt może go podstępnie założyć. Idealny, aby utrzymać ciepło w nawet najtrudniejszych warunkach."
RECIPE.model = "models/willardnetworks/vort_clothingitems/vort_sweater.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_torso_sweater"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_poncho"
RECIPE.name = "Ponczo dla Vortigaunta"
RECIPE.description = "Ponczo stworzone ze znalezionych kawałków materiału pozszywanego razem ze sobą. Luźny design i wygodne wycięcia pozwalają na komfort i swobodę ruchów."
RECIPE.model = "models/props_c17/BriefCase001a.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_torso_light"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_covering"
RECIPE.name = "Prowizoryczne okrycie dla Vortigaunta"
RECIPE.description = "Proste, zwykłe okrycie. Dobre do tego, by zapewnić ci przytulność w chłodną noc i niewiele więcej."
RECIPE.model = "models/n7/vorti_outfit/light02.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_torso_light2"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_bandages"
RECIPE.name = "Bandaże dla Vortigaunta"
RECIPE.description = "Dla rannego lub nie - bandaże spełnią swoją rolę."
RECIPE.model = "models/willardnetworks/vort_clothingitems/vort_bandage.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_bandages"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_vort_belt"
RECIPE.name = "Pas dla Vortigaunta"
RECIPE.description = "Pas stworzony do użytku przez ludzi, ale ciekawski Vortigaunt może go przymierzyć."
RECIPE.model = "models/willardnetworks/vort_clothingitems/vort_belt.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Vortigaunt"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["vortigaunt_belt"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()