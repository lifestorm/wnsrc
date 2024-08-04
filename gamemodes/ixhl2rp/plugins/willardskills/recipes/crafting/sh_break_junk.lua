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

RECIPE.uniqueID = "rec_junk_tv"
RECIPE.name = "Rozłóż telewizor"
RECIPE.description = "Zepsuty telewizor z dawnych lat, jest bezużyteczny"
RECIPE.model = "models/props_wasteland/controlroom_monitor001a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_tv"] = 1}
RECIPE.result = {["comp_electronics"] = 1, ["comp_plastic"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 55}, -- full xp
	{level = 20, exp = 27}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_toy"
RECIPE.name = "Rozłóż starą drewnianą zabawkę"
RECIPE.description = "W tych czasach ciężko takie znaleźć, jest wyrobiona z drewna."
RECIPE.model = "models/props_c17/playgroundTick-tack-toe_block01a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_toy"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tire"
RECIPE.name = "Rozłóż oponę"
RECIPE.description = "Przypomina Ci stare czasy, wtedy gdy samochody jeszcze istniały."
RECIPE.model = "models/props_vehicles/carparts_tire01a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["junk_tire"] = 1}
RECIPE.result = {["comp_plastic"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tincan"
RECIPE.name = "Rozłóż puszkę"
RECIPE.description = "Mała aluminiowa puszka po jedzeniu. Jest tobie nieprzydatna."
RECIPE.model = "models/props_junk/garbage_metalcan002a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_tincan"] = 1}
RECIPE.result = {["comp_scrap"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_takeaway"
RECIPE.name = "Rozłóż opakowanie"
RECIPE.description = "Znalezione w śmieciach, pewnie było w nim jedzenie."
RECIPE.model = "models/props_junk/garbage_takeoutcarton001a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_takeaway"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_sm_cardboard"
RECIPE.name = "Rozłóż mały karton"
RECIPE.description = "Mały karton w którym przenosiło się produkty. Jest pusty."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_sm_cardboard"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_shoe"
RECIPE.name = "Rozłóż buta"
RECIPE.description = "Brązowy but, pewnie należał do kogoś"
RECIPE.model = "models/props_junk/Shoe001a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_shoe"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_receiver"
RECIPE.name = "Rozłóż zniszczony odbiornik"
RECIPE.description = "Zniszczona część elektroniki, nie nadaje się do użytku"
RECIPE.model = "models/props_lab/reciever01c.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_receiver"] = 1}
RECIPE.result = {["comp_screws"] = 1, ["comp_electronics"] = 1, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plastic_bucket"
RECIPE.name = "Rozłóż plastikowe wiadro"
RECIPE.description = "Brudne plastikowe wiadro, prawdopodobnie używane do przechowywania chemikaliów."
RECIPE.model = "models/props_junk/plasticbucket001a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_plastic_bucket"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plasticcrate"
RECIPE.name = "Rozłóż plastikową skrzynkę"
RECIPE.description = "Plastikowy pojemnik. Nie jest on dla ciebie wiele wart."
RECIPE.model = "models/props_junk/PlasticCrate01a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_plasticcrate"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_plantpot"
RECIPE.name = "Rozłóż doniczkę"
RECIPE.description = "Donica używana do sadzenia i uprawiania ogrodu. Nie ma ona żadnego zastosowania."
RECIPE.model = "models/props_junk/terracotta01.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_plantpot"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_pipe"
RECIPE.name = "Rozłóż cienką metalową rurę"
RECIPE.description = "Nędzna metalowa rura. Nie jest przydatna jako broń."
RECIPE.model = "models/props_canal/mattpipe.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_pipe"] = 1}
RECIPE.result = {["comp_scrap"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_paintcan"
RECIPE.name = "Rozłóż pustą puszkę po farbie"
RECIPE.description = "Pusta puszka po farbie. Jest dla ciebie bezużyteczna."
RECIPE.model = "models/props_junk/metal_paintcan001b.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_paintcan"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_mug"
RECIPE.name = "Rozłóż kubek"
RECIPE.description = "Pusty plastikowy kubek."
RECIPE.model = "models/props_junk/garbage_coffeemug001a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_mug"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_pc_monitor"
RECIPE.name = "Rozłóż monitor"
RECIPE.description = "Było wiele planów dotyczących tego urządzenia, niestety nigdy nie było użyte powszechnie."
RECIPE.model = "models/props_lab/monitor01a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_pc_monitor"] = 1}
RECIPE.result = {["comp_plastic"] = 2, ["comp_electronics"] = 1, ["comp_scrap"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_lamp"
RECIPE.name = "Rozłóż lampkę"
RECIPE.description = "Zepsuta i bezużyteczna, ta lampka nie spełnia już swojej funkcji."
RECIPE.model = "models/props_lab/desklamp01.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_lamp"] = 1}
RECIPE.result = {["comp_plastic"] = 2, ["comp_screws"] = 1, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_keyboard"
RECIPE.name = "Rozłóż zepsutą klawiaturę"
RECIPE.description = "Zepsuta klawiatura, bez żadnej wartości."
RECIPE.model = "models/props_c17/computer01_keyboard.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_keyboard"] = 1}
RECIPE.result = {["comp_electronics"] = 1, ["comp_plastic"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_jug"
RECIPE.name = "Rozłóż plastikowy baniak"
RECIPE.description = "Pusty plastikowy baniak, potrzebuje dobrego czyszczenia."
RECIPE.model = "models/props_junk/garbage_milkcarton001a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_jug"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_jar"
RECIPE.name = "Rozłóż pusty słoik"
RECIPE.description = "Pusty słoik, nadający się do przechowywania dżemu lub czegoś podobnego. Jest bezużyteczny."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_jar"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_empty_bottle"
RECIPE.name = "Rozłóż butelke po burbonie"
RECIPE.description = "Stara butelka po trunku."
RECIPE.model = "models/willardnetworks/food/bourbon.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_empty_bottle"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_fruitjuice"
RECIPE.name = "Rozłóż pusty karton po soku"
RECIPE.description = "Pusty karton, dawniej miał przydatną zawartość."
RECIPE.model = "models/props_junk/garbage_plasticbottle003a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_empty_fruitjuice"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_emptyvial"
RECIPE.name = "Rozłóż pustą ampułkę leczniczą"
RECIPE.description = "Rozłóż pustą ampułkę leczniczą."
RECIPE.model = "models/willardnetworks/syringeemptyy.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_emptyvial"] = 1}
RECIPE.result = {["comp_crafting_water"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_gear"
RECIPE.name = "Rozłóż metalową zębatkę"
RECIPE.description = "Kawałek metalowego sprzętu, który kiedyś nadawał się do czegoś. Teraz jest bezwartościowy."
RECIPE.model = "models/props_wasteland/gear02.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_gear"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 40}, -- full xp
	{level = 20, exp = 20}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_gascan"
RECIPE.name = "Rozłóż pusty kanister"
RECIPE.description = "Pusty kanister, używany był do przenoszenia benzyny lub innego płynu."
RECIPE.model = "models/props_junk/metalgascan.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_gascan"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_fridge_door"
RECIPE.name = "Rozłóż drzwi od lodówki"
RECIPE.description = "Zepsute drzwi które kiedyś były częścią lodówki, są ciężkie i zimne w dotyku."
RECIPE.model = "models/props_interiors/refrigeratordoor02a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_fridgedoor"] = 1}
RECIPE.result = {["comp_scrap"] = 4, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 40, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_frame"
RECIPE.name = "Rozłóż ramę"
RECIPE.description = "Drewniana rama. Prawdopodobnie używana do montażu okna. Teraz jest bezużyteczna."
RECIPE.model = "models/props_c17/frame002a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_frame"] = 1}
RECIPE.result = {["comp_wood"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_tattered_drawer"
RECIPE.name = "Rozłóż obdartą szufladę"
RECIPE.description = "Jeszcze nie tak dawno była w czyimś domu."
RECIPE.model = "models/props_c17/FurnitureDrawer001a_Chunk01.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_tattered_drawer"] = 1}
RECIPE.result = {["comp_wood"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_doll"
RECIPE.name = "Rozłóż lalkę"
RECIPE.description = "Stara, zniszczona lalka dawno zapomnianego pokolenia."
RECIPE.model = "models/props_c17/doll01.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_doll"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_coffeecup"
RECIPE.name = "Rozłóż plastikowy kubek po kawie"
RECIPE.description = "Pusty kubek po kawie."
RECIPE.model = "models/willardnetworks/food/coffee.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_coffeecup"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_computerparts"
RECIPE.name = "Rozłóż części komputerowe"
RECIPE.description = "Stare przedwojenne części do komputerów z epoki wczesnych lat 2000. Raczej mało zaskakujące."
RECIPE.model = "models/props_lab/harddrive01.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_computerparts"] = 1}
RECIPE.result = {["comp_electronics"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 70}, -- full xp
	{level = 10, exp = 35}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_computer_tower"
RECIPE.name = "Rozłóż komputer"
RECIPE.description = "Powinien dać się ponownie uruchomić lub rozłożony na zasoby."
RECIPE.model = "models/props_lab/harddrive01.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_computer_tower"] = 1}
RECIPE.result = {["comp_electronics"] = 2, ["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_clock"
RECIPE.name = "Rozłóż zegar"
RECIPE.description = "Stary zepsuty zegar."
RECIPE.model = "models/props_combine/breenclock.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_clock"] = 1}
RECIPE.result = {["comp_wood"] = 2, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 20, exp = 25}, -- half xp
	{level = 30, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_carton"
RECIPE.name = "Rozłóż pusty karton po mleku"
RECIPE.description = "Mały plastikowy kartonik. Prawdopodobnie było w nim coś w formie płynnej."
RECIPE.model = "models/props_junk/garbage_milkcarton002a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_carton"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_cardboard"
RECIPE.name = "Rozłóż kartonowe pudło"
RECIPE.description = "Kartonowe pudło, służyło do przenoszenia rzeczy."
RECIPE.model = "models/props_junk/cardboard_box003a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_cardboard"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 30}, -- full xp
	{level = 10, exp = 15}, -- half xp
	{level = 15, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_junk_bucket"
RECIPE.name = "Rozłóż metalowe wiadro"
RECIPE.description = "Metalowe wiadro używane do przenoszenia płynów lub przedmiotów."
RECIPE.model = "models/props_junk/MetalBucket01a.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_bucket"] = 1}
RECIPE.result = {["comp_scrap"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 25}, -- full xp
	{level = 10, exp = 12}, -- half xp
	{level = 25, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_empty_can"
RECIPE.name = "Rozłóż puszkę wody Boba"
RECIPE.description = "Rozłóż pustą puszkę po wodzie Boba."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_empty_can"] = 1}
RECIPE.result = {["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_biolock"
RECIPE.name = "Rozłóż zepsutego Biolocka"
RECIPE.description = "Zepsuty Biolock, jaka szkoda."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["trash_biolock"] = 1}
RECIPE.result = {["comp_scrap"] = 4, ["comp_electronics"] = 2, ["comp_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_cigarettepack"
RECIPE.name = "Rozłóż paczkę papierosów"
RECIPE.description = "Porwij pustą paczkę po papierosach, palenie szkodzi."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["ciggie_pack"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_plushie"
RECIPE.name = "Rozłóż pluszowego żółwia"
RECIPE.description = "Miekki pluszak żółwia, nie ma zastosowania."
RECIPE.model = "models/willardnetworks/skills/turtle.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.ingredients = {["junk_turtle"] = 1}
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 20}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_junk_battery"
RECIPE.name = "Rozłóż akumulator"
RECIPE.description = "Stary akumulator z starego świata."
RECIPE.model = "models/Items/car_battery01.mdl"
RECIPE.category = "Recykling"
RECIPE.subcategory = "Śmieci"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["junk_battery"] = 1}
RECIPE.result = {["comp_scrap"] = 2, ["comp_chemicals"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()
