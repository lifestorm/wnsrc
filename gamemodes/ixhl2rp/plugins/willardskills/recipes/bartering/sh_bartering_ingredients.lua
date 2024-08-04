--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Meats
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_leeches"
RECIPE.name = "Pijawki w puszce"
RECIPE.description = "Pijawka w puszce. Zawiera trzy surowe pijawki."
RECIPE.model = "models/willardnetworks/food/cmb_food2.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["ing_tinned_leeches"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_artificial_meat"
RECIPE.name = "Surowe syntetyczne mięso"
RECIPE.description = "Substancje mięsne sprasowane w blok białkowy. Mięso jest surowe i nierafinowane."
RECIPE.model = "models/willardnetworks/food/steak1.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_artificial_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_artificial_chicken"
RECIPE.name = "Surowy kurczak"
RECIPE.description = "Przemysł skolektywizowany w odległych krainach, osadzony w felernych warunkach i fabrykach do produkcji mięsa."
RECIPE.model = "models/willardnetworks/food/meat3.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["ing_chicken"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Baking
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_margarine"
RECIPE.name = "Margaryna"
RECIPE.description = "Puszka po margarynie. Topi się pod wpływem ciepła."
RECIPE.model = "models/willardnetworks/food/cmb_food5.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_margarine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_flour"
RECIPE.name = "Mąka nasycona"
RECIPE.description = "Papierowa torba jest nieco wyściełana, co sprawia, że wygląda, jakby zawierała więcej mąki niż w rzeczywistości. Wygląda i pachnie jak zwykła mąka z kilkoma dziwnymi czarnymi plamami tu i tam."
RECIPE.model = "models/willardnetworks/food/cmb_food6.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["ing_flour"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_protein"
RECIPE.name = "Opakowanie białka jajecznego"
RECIPE.description = "Opakowanie białka w proszku."
RECIPE.model = "models/willardnetworks/food/cmb_food1.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_protein"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_sweetbar"
RECIPE.name = "Granulowany słodki baton"
RECIPE.description = "Chrupiący batonik czekoladowy. Jest całkiem smaczny!"
RECIPE.model = "models/willardnetworks/food/cmb_food3.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_sweet"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_milk"
RECIPE.name = "Substytut mleka"
RECIPE.description = "Kartonik substytutu mleka. Z pewnością wygląda jak mleko, ale jest nieco rzadsze w swoim składzie."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["drink_milk"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Flavourings
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_spices"
RECIPE.name = "Suszone aromatyczne przyprawy"
RECIPE.description = "Dodają smaku i aromatu potrawom nawet w trudnych warunkach."
RECIPE.model = "models/willardnetworks/food/cmb_food8.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_spices"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_herbs"
RECIPE.name = "Suszone zioła do gotowania"
RECIPE.description = "Różne suszone zioła do gotowania."
RECIPE.model = "models/willardnetworks/food/cmb_food7.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_herbs"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_salt"
RECIPE.name = "Sól"
RECIPE.description = "Na pozór zwykła solniczą z solą o nieco dziwnym, kwaśnym zapachu..."
RECIPE.model = "models/willardnetworks/foods/salt.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_salt"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_vinegar"
RECIPE.name = "Ocet"
RECIPE.description = "Kwasowy płyn, który może być użyty do marynowania, gotowania i czyszczenia."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_i.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["ing_vinegar"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Vegetables / fruit
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_carrot"
RECIPE.name = "Paczka warzyw"
RECIPE.description = "Mieszanka kolorowych, chrupiących warzyw gotowych do spożycia i wzbogacenia twojej diety."
RECIPE.model = "models/willardnetworks/foods/vege.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_vegetable_pack"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

-- Misc
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_noodles"
RECIPE.name = "Suchy makaron"
RECIPE.description = "Suchy i nieapetyczny."
RECIPE.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 1
RECIPE.result = {["ing_noodles"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_cheese"
RECIPE.name = "Plasterek syntetycznego sera"
RECIPE.description = "Pachnie i wygląda jak zwykły ser, ale napewno nie smakuje jak ser."
RECIPE.model = "models/willardnetworks/food/cheesewheel2c.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["artificial_cheese"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_coffeepowder"
RECIPE.name = "Kawa w proszku"
RECIPE.description = "Przetarta puszka z kawą w proszku."
RECIPE.model = "models/willardnetworks/food/wn_food_can.mdl"
RECIPE.skin = 5
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["ing_coffee_powder"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_empty_coffee"
RECIPE.name = "Pusty kubek po kawie"
RECIPE.description = "Spodziewasz się tutaj niespodzianki? Pusty. Nic więcej."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["junk_coffeecup"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "ingredients_raw_antlion_meat"
RECIPE.name = "Surowe mięso z Antliona"
RECIPE.description = "Gumiasty, odcięty kawałek mięsa Antliona. Pachnie i wygląda nieco dziwnie."
RECIPE.model = "models/willardnetworks/food/raw_alienmeat.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Składniki"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["ing_antlion_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()