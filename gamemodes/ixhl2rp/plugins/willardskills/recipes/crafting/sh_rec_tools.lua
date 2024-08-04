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
RECIPE.uniqueID = "rec_craft_waterbottle"
RECIPE.name = "Butelka wody"
RECIPE.description = "Butelka po wodzie która można znowu napełnić."
RECIPE.model = "models/props_junk/garbage_plasticbottle002a.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["comp_plastic"] = 4}
RECIPE.result = {["waterbottle"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_watervalve"
RECIPE.name = "Zawór do wody"
RECIPE.description = "Możesz dzięki niemu zdobyć wodę z różnych miejsc."
RECIPE.model = "models/props/de_nuke/hr_nuke/metal_pipe_001/metal_pipe_001_gauge_valve_low.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["comp_scrap"] = 2, ["comp_plastic"] = 2}
RECIPE.result = {["watervalve"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_flashlight"
RECIPE.name = "Latarka domowej roboty"
RECIPE.description = "Latarka ręcznie stworzona, niesamowicie przydatna gdy zwiedzasz nieznane ciemności."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_electronics"] = 1}
RECIPE.result = {["flashlight"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_scissors"
RECIPE.name = "Nożyczki"
RECIPE.description = "Ciach!, Ciach!, Ciach!."
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Narzędzia"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_plastic"] = 1}
RECIPE.result = {["tool_scissors"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_cooking_pot"
RECIPE.name = "Garnek"
RECIPE.description = "Czarny, żelazny garnek do gotowania. Postaw go na kuchence!"
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Narzędzia"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 2, ["comp_plastic"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_cookingpot"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_razor"
RECIPE.name = "Przybory fryzjerskie"
RECIPE.description = "Narzędzia dla kreatywnych dusz w tym przygnębiającym otoczeniu."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_adhesive"] = 1, ["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beard_razor"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_kitchen_spoon"
RECIPE.name = "Łyżka"
RECIPE.description = "Przydatne do gotowania potraw."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_spoon"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_tool_kitchen_knife"
RECIPE.name = "Nóż kuchenny"
RECIPE.description = "Kruchy, półtępy nóż bez ostrego czubka. Używany do krojenia żywności na desce do krojenia lub innej powierzchni. Nie nadaje się do dźgania."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_wood"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_knife"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_frying_pan"
RECIPE.name = "Patelnia"
RECIPE.description = "Czarna, żeliwna patelnia. Połóż ją na kuchence!"
RECIPE.model = "models/props_c17/metalPot002a.mdl"
RECIPE.category = "Narzędzia"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_fryingpan"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_kettle"
RECIPE.name = "Czajnik"
RECIPE.description = "Czajnik w którym możesz ugotować wodę."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Narzędzia"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_kettle"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_toolkit"
RECIPE.name = "Skrzynka z narzędziami"
RECIPE.description = "Mała metalowa skrzynka zawierające narzędzia dzieki którym wytworzysz przedmioty."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["comp_scrap"] = 6, ["comp_adhesive"] = 3, ["comp_plastic"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["tool_toolkit"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_tool_tinderbox"
RECIPE.name = "Zestaw do ogniska"
RECIPE.description = "Zestaw dzięki któremu rozpalisz ognisko."
RECIPE.model = "models/willardnetworks/props/tinderbox.mdl"
RECIPE.category = "Narzędzia"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_cloth"] = 3, ["comp_adhesive"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["tinderbox"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_mixer"
RECIPE.name = "Mikser do chemii"
RECIPE.description = "Wydaje się przydatny do mieszania ze sobą płynów lub chemikaliów. Na jego etykiecie ostrzegawczej czytamy: 'Nie otwierać podczas pracy'"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Stoły warsztatowe"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_screws"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_mixer"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 200}, -- full xp
	{level = 20, exp = 100}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_wrench"
RECIPE.name = "Klucz"
RECIPE.description = "Stary klucz, można go użyć do tworzenia."
RECIPE.model = "models/props_c17/tools_wrench01a.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_rivbolts"] = 1}
RECIPE.result = {["tool_wrench"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 70}, -- full xp
	{level = 30, exp = 35}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_chembench"
RECIPE.name = "Chemiczny stół warsztatowy"
RECIPE.description = "Ten stół jest specjalnie stworzony aby zapewnić prawidłowe mieszanie chemikaliów."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/chemistrystation02.mdl"
RECIPE.category = "Stoły warsztatowe"
RECIPE.ingredients = {["comp_steel"] = 3, ["comp_wood"] = 4, ["comp_refined_plastic"] = 2}
RECIPE.result = {["tool_chembench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 300}, -- full xp
	{level = 30, exp = 150}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_oven_rusty"
RECIPE.name = "Zardzewiała kuchenka"
RECIPE.description = "Wygląda okropnie, jest okropne ale przynajmniej coś ugotujesz."
RECIPE.model = "models/willardnetworks/skills/oven_shit.mdl"
RECIPE.category = "Stoły warsztatowe"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_steel"] = 2, ["comp_plastic"] = 4, ["comp_screws"] = 4, ["comp_electronics"] = 2}
RECIPE.result = {["tool_oven_rusty_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_craftingbench"
RECIPE.name = "Zestaw stołu warsztatowego"
RECIPE.description = "Ten stół jest specjalnie stworzony aby zapewnić prawidłowe tworzenie odzieży."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/weaponworkbench02.mdl"
RECIPE.category = "Stoły warsztatowe"
RECIPE.ingredients = {["comp_wood"] = 3, ["comp_iron"] = 1, ["comp_refined_plastic"] = 2, ["comp_rivbolts"] = 3}
RECIPE.result = {["tool_craftingbench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 180}, -- full xp
	{level = 30, exp = 90}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_metalbench"
RECIPE.name = "Zestaw stołu warsztatowego do metalu"
RECIPE.description = "Ten stół jest specjalnie stworzony aby zapewnić prawidłowe tworzenie broni lub podobnych."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl"
RECIPE.category = "Stoły warsztatowe"
RECIPE.ingredients = {["comp_steel"] = 4, ["comp_wood"] = 4, ["comp_refined_plastic"] = 4, ["tool_craftingbench_assembly"] = 1}
RECIPE.result = {["tool_metalbench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 600}, -- full xp
	{level = 40, exp = 300}, -- half xp
	{level = 50, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_repair"
RECIPE.name = "Zestaw naprawczy pancerza"
RECIPE.description = "Własnoręcznie zrobiony zestaw naprawczy, można nim naprawic pancerz w odzieży."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Narzędzia"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_repair"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full XP
	{level = 40, exp = 50}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_breacher"
RECIPE.name = "Łamacz zamka kombinatu"
RECIPE.description = "Własnoręcznie zrobione urządzenie które złamie zamek kombinatu."
RECIPE.model = "models/transmissions_element120/charger_attachment.mdl"
RECIPE.category = "Narzędzia"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_refined_plastic"] = 1, ["comp_screws"] = 1, ["comp_electronics"] = 2}
RECIPE.result = {["lockbreacher"] = 1}
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full XP
	{level = 50, exp = 0}, -- half XP
	{level = 55, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_refill_zippo_lighter"
RECIPE.name = "Zapalniczka Zippo"
RECIPE.description = "Jakościowa zapalniczka na benzynę, może być uzupelniona."
RECIPE.model = "models/willardnetworks/cigarettes/zippo.mdl"
RECIPE.category = "Narzędzia"
RECIPE.ingredients = {["zippolighter"] = 1, ["comp_alcohol"] = 1}
RECIPE.result = {["zippolighter"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()
