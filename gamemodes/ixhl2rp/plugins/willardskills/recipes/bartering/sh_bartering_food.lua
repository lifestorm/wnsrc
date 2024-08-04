--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Snacks

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_berries"
RECIPE.name = "Jagody"
RECIPE.description = "Garść słodkich jagód."
RECIPE.model = "models/willardnetworks/food/berries01.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["fruit_berries"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_peanuts"
RECIPE.name = "Solone orzeszki ziemne"
RECIPE.description = "Solone orzeszki ziemne dostarczą Ci więcej soli niż jest w całym oceanie, ale przynajmniej nie musisz się martwić o nadmiar jodu."
RECIPE.model = "models/willardnetworks/food/peats.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["food_peanuts"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_biscuits"
RECIPE.name = "Puszka herbatników"
RECIPE.description = "Zamknięte w ponurej, metalicznym puszce, te suche herbatniki oferują smak srogości. Każdy kęs uwalnia przesuszoną chrupkość, całkowicie pozbawioną wilgoci."
RECIPE.model = "models/props_junk/garbage_metalcan001a.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["food_biscuits"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_crisps"
RECIPE.name = "Chipsy ziemniaczane"
RECIPE.description = "Smaczna przekąska, która może się okazać cichym zabójcą kalorycznym."
RECIPE.model = "models/willardnetworks/food/snack01.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["food_crisps"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()
local RECIPE = ix.recipe:New()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_food_crackers"
RECIPE.name = "Krakersy"
RECIPE.description = "Krakersy, tak twarde, że można by budować z nich czołgi."
RECIPE.model = "models/willardnetworks/food/snack02.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["food_crackers"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_apple"
RECIPE.name = "Jabłko"
RECIPE.description = "Piękne i dorodne czerwone jabłko. Wygląda naprawdę soczyście."
RECIPE.model = "models/willardnetworks/food/apple.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["fruit_apple"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_banana"
RECIPE.name = "Banan"
RECIPE.description = "Banan jest świetnym źródłem energii i składników odżywczych, ale jednocześnie wygląda jak pistolet dla małp."
RECIPE.model = "models/willardnetworks/food/bananna.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["fruit_banana"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_orange"
RECIPE.name = "Pomarańcz"
RECIPE.description = "Wystarczy obrać i zjeść.. No i jeszcze zadowolić się dosyć kwaśnym posmakiem."
RECIPE.model = "models/willardnetworks/food/orange.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["fruit_orange"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_sandwich"
RECIPE.name = "Kanapka"
RECIPE.description = "Bardzo popularna w Mieście 21, prosta kanapka z syntetycznego mięsa z serem. Idealna na szybki posiłek w podróży i w pracy."
RECIPE.model = "models/willardnetworks/food/sandwich.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 22
RECIPE.result = {["comfort_sandwich"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Foods
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_artskewer"
RECIPE.name = "Syntetyczne mięso na szaszłykach"
RECIPE.description = "Syntetyczne mięso na szaszłykach to opcja dla wegan i wegetarian, która pozwala poczuć smak grillowania, bez uczucia winy wobec zwierząt."
RECIPE.model = "models/willardnetworks/food/meatskewer2.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["artificial_skewer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_breadslice"
RECIPE.name = "Kromka chleba"
RECIPE.description = "Kromka chleba to podstawa wielu dań, która pozwala nam cieszyć się prostotą i wygodą jedzenia."
RECIPE.model = "models/willardnetworks/food/bread_slice.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["baking_bread_slice"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_halfbread"
RECIPE.name = "Połówka chleba"
RECIPE.description = "Pół bochenka chleba gotowego do spożycia."
RECIPE.model = "models/willardnetworks/food/bread_half.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["baking_bread_half"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_cookednoodles"
RECIPE.name = "Gotowany makaron"
RECIPE.description = "Gotowany makaron, niezależnie od czasów jest bardzo popularnym wyborem kulinarnym."
RECIPE.model = "models/willardnetworks/food/noodles.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 7
RECIPE.result = {["comfort_noodles"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_bagel"
RECIPE.name = "Bajgiel"
RECIPE.description = "Nigdy nie wiadomo gdzie zaczynają się, a gdzie kończą bajgle, ale zawsze smakują dobrze, zwłaszcza z dodatkiem kremowego masła lub słodkiego dżemu."
RECIPE.model = "models/willardnetworks/food/bagel2.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["baking_bagel"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_roastedartmeat"
RECIPE.name = "Pieczone syntetyczne mięso"
RECIPE.description = "Nafaszerowane substancjami chemicznymi i innymi substytutami podtrzymującymi ważność; nie licząc tego, że prawdopodobnie dostaniesz raka - to jest całkiem smaczne."
RECIPE.model = "models/willardnetworks/food/steak2.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 9
RECIPE.result = {["artificial_meat"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_vegsoup"
RECIPE.name = "Zupa jarzynowa"
RECIPE.description = "Zupa jarzynowa to taki mały ogródek na talerzu, pełen warzyw, które się znudziły, ale dalej chcą dawać życie i energię. Miejmy nadzieje, że nie będzie za słona."
RECIPE.model = "models/willardnetworks/food/vegetablesoup.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["comfort_soup"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_watermelon"
RECIPE.name = "Arbuz"
RECIPE.description = "Orzeźwiający i soczysty owoc."
RECIPE.model = "models/willardnetworks/food/watermelon_unbreakable.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["fruit_watermelon"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "food_cookedantlionmeat"
RECIPE.name = "Pieczone mięso z Antliona"
RECIPE.description = "Ciepłe, żylaste mięso z Antliona."
RECIPE.model = "models/willardnetworks/food/cooked_alienmeat.mdl"
RECIPE.category = "Restauracja"
RECIPE.subcategory = "Jedzenie"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 6
RECIPE.result = {["antlion_roast"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()