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
RECIPE.uniqueID = "bartering_tool_spoon"
RECIPE.name = "Łyżka kuchenna"
RECIPE.description = "Przydatne do gotowania potraw."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["tool_spoon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_kettle"
RECIPE.name = "Czajnik"
RECIPE.description = "Czajnik w którym możesz ugotować wodę."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["tool_kettle"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_lighter"
RECIPE.name = "Zapalniczka plastikowa"
RECIPE.description = "Tania plastikowa zapalniczka, przydatna do zapalania papierosów."
RECIPE.model = "models/willardnetworks/cigarettes/lighter.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["lighter"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_knife"
RECIPE.name = "Nóż kuchenny"
RECIPE.description = "Gruby, mocno stępiony nóż. Używany do krojenia żywności."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["tool_knife"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_scissors"
RECIPE.name = "Nożyczki"
RECIPE.description = "Ciach!, Ciach!, Ciach!."
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["tool_scissors"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_syringe"
RECIPE.name = "Strzykawka"
RECIPE.description = "Strzykawka w której możesz trzymać płyn, przydatna do zabiegów medycznych."
RECIPE.model = "models/willardnetworks/skills/syringeammo.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["comp_syringe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_cookingpot"
RECIPE.name = "Garnek do gotowania"
RECIPE.description = "Czarny, żelazny garnek do gotowania. Postaw go na kuchence!"
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_cookingpot"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_fryingpan"
RECIPE.name = "Patelnia"
RECIPE.description = "Czarna, żeliwna patelnia. Połóż ją na kuchence!"
RECIPE.model = "models/props_c17/metalPot002a.mdl" -- This model is wrong. Use the hl2 frying pan model plz
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["tool_fryingpan"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_razor"
RECIPE.name = "Przybory fryzjerskie"
RECIPE.description = "Narzędzia dla kreatywnych dusz w tym przygnębiającym otoczeniu."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["beard_razor"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_wrench"
RECIPE.name = "Klucz"
RECIPE.description = "Stary klucz, można go użyć do tworzenia."
RECIPE.model = "models/props_c17/tools_wrench01a.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_wrench"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_toolkit"
RECIPE.name = "Skrzynka z narzędziami"
RECIPE.description = "Mała metalowa skrzynka zawierające narzędzia dzieki którym wytworzysz przedmioty."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["tool_toolkit"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_coffeemachine"
RECIPE.name = "Ekspres do kawy"
RECIPE.description = "Ekspres do kawy pozwala na zaczęcie dnia z mocniejszym kopem niż kopałby Czarny Koń Zorro. Dzięki niemu Twoje oczy będą tak rozszerzone, że będziesz wyglądać jak sowa w dzień."
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 45
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_oven_assembly"
RECIPE.name = "Zestaw montażowy piekarnika"
RECIPE.description = "Wraz z zestawem instrukcji. Drewniany pakiet zawiera dużą ilość różnych elementów składowych dla aparatury kulinarnej."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 80
RECIPE.result = {["tool_oven_assembly"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_grouplock"
RECIPE.name = "Zamek grupowy"
RECIPE.description = "Metalowe urządzenie montowane na drzwiach, potrzebujesz grupy aby działał."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 80
RECIPE.result = {["grouplock"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Storage

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_lock"
RECIPE.name = "Zamek do pojemnika"
RECIPE.description = "Ustawia hasło na pojemnik."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_satchel"
RECIPE.name = "Nerka"
RECIPE.description = "Mała nerka, która spoczywa na biodrze."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 70
RECIPE.result = {["smallbag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_suitcase"
RECIPE.name = "Walizka"
RECIPE.description = "Mała walizka gotowa pomieścić wszystko, czego nie chciałbyś nosić normalnie."
RECIPE.model = "models/weapons/w_suitcase_passenger.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 70
RECIPE.result = {["suitcase"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_container_small"
RECIPE.name = "Mały pojemnik"
RECIPE.description = "Pojemnik o rozmiarze 5x3, skontaktuj się z adminem aby ustawić ten pojemnik, potrzebny jest zamek na pojemnik aby go zamknąć."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 90
RECIPE.result = {["container_small_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_mixer"
RECIPE.name = "Mikser do chemii"
RECIPE.description = "Wydaje się przydatny do mieszania ze sobą płynów lub chemikaliów. Na jego etykiecie ostrzegawczej czytamy: 'Nie otwierać podczas pracy'"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 180
RECIPE.result = {["tool_mixer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_backpack"
RECIPE.name = "Plecak"
RECIPE.description = "Mały plecak ze znaczkiem Kombinatu."
RECIPE.model = "models/willardnetworks/clothingitems/backpack.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["largebag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_safe"
RECIPE.name = "Sejf"
RECIPE.description = "Niezniszczalny sejf w którym możesz przechowywać przedmioty. (Możesz mieć 2 sejfy w ramach limitu pojemników)."
RECIPE.model = "models/willardnetworks/safe.mdl"
RECIPE.category = "Narzędzia i magazynowanie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 850
RECIPE.result = {["container_safe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()