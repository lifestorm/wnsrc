--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Beanie
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_brown"
RECIPE.name = "Brązowa czapka"
RECIPE.description = "Brązowa, lekko zaniedbana, wełniana czapka."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_brown"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_grey"
RECIPE.name = "Szara czapka"
RECIPE.description = "Szara, lekko zaniedbana, wełniana czapka. "
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_grey"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_red"
RECIPE.name = "Czerwona czapka"
RECIPE.description = "Czerwona, lekko zaniedbana, wełniana czapka."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["beanie_red"] = 1}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_blue"
RECIPE.name = "Niebieska czapka"
RECIPE.description = "Niebieska, lekko zaniedbana, wełniana czapka."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["head_blue_beanie"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_beanie_green"
RECIPE.name = "Zielona czapka"
RECIPE.description = "Zielona, lekko zaniedbana, wełniana czapka."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 20
RECIPE.result = {["head_green_beanie"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

-- Non-colorable
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_boonie"
RECIPE.name = "Kapelusz typu 'Boonie'"
RECIPE.description = "Kapelusz z szerokim rondem."
RECIPE.model = "models/willardnetworks/clothingitems/head_boonie.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["head_boonie_hat"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_chef"
RECIPE.name = "Kapelusz szefa kuchni"
RECIPE.description = "Wysoki, biały kapelusz. Noszony przez tych, którzy są świetni w gotowaniu albo przez takich którzy tylko udają, że potrafią gotować."
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_chef_hat"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_cap"
RECIPE.name = "Kaszkiet"
RECIPE.description = "Stylowy, oldschoolowy kaszkiet, który płasko układa się na głowie."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat2.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_flat_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_head_visor"
RECIPE.name = "Czapka z daszkiem"
RECIPE.description = "Kapelusz z daszkiem. Dzięki niemu słońce nie będzie raziło Ci w oczy."
RECIPE.model = "models/willardnetworks/clothingitems/head_hat.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["head_visor_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "head_military_cap"
RECIPE.name = "Czapka wojskowa"
RECIPE.description = "Czapka z wytartymi insygniami wojskowymi."
RECIPE.model = "models/willardnetworks/clothingitems/head_confederatehat.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["head_military_cap"] = 1} -- Old ID name, to let players keep item on update
RECIPE:Register()

-- Glasses
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_glasses"
RECIPE.name = "Okulary"
RECIPE.description = "Para czarnych okularów o kwadratowych oprawkach."
RECIPE.model = "models/willardnetworks/clothingitems/glasses.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["glasses"] = 1}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_aviators"
RECIPE.name = "Okulary lotnicze"
RECIPE.description = "Para stylowych okularów, inaczej zwanych 'aviatorami'. Przypominają o przeszłości."
RECIPE.model = "models/willardnetworks/clothingitems/head_aviators.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["aviators"] = 1}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_70s"
RECIPE.name = "Okulary z lat 70."
RECIPE.description = "Para okularów vintage z lat 70-tych z brązową oprawką."
RECIPE.model = "models/willardnetworks/clothingitems/head_glasses_70s.mdl"
RECIPE.category = "Odzież"
RECIPE.subcategory = "Nakrycia głowy"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["70sglasses"] = 1}
RECIPE:Register()