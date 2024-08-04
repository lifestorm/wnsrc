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
RECIPE.uniqueID = "bartering_tool_request"
RECIPE.name = "Urządzenie zgłaszające"
RECIPE.description = "Małe urządzenie z zaokrąglonymi rogami, mieszczące dwa przyciski. Widoczne jest niewielkie logo Kombinatu."
RECIPE.model = "models/gibs/shield_scanner_gib1.mdl"
RECIPE.category = "Elektronika"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["request_device"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_flashlight"
RECIPE.name = "Latarka"
RECIPE.description = "Latarka to gadżet, bez którego odkrywanie sekretów w ciemności byłoby niemożliwe, chyba że jesteś nietoperzem. Dzięki niej zawsze będziesz miał światełko w tunelu, nawet jeśli jest to tunel pod ziemią."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Elektronika"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["flashlight"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tv"
RECIPE.name = "Telewizor"
RECIPE.description = "Telewizor wydany przez reżim, na którym można oglądać audycje propagandowe."
RECIPE.model = "models/props_c17/tv_monitor01.mdl"
RECIPE.category = "Elektronika"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["television"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_coffeemachine"
RECIPE.name = "Ekspres do kawy"
RECIPE.description = "Ekspres do kawy pozwala na rozpoczęcie dnia z mocniejszym kopem niż kopałby Czarny Koń Zorro. Dzięki niemu Twoje oczy będą tak rozszerzone, że będziesz wyglądać jak sowa w dzień."
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Elektronika"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 55
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cit_computer"
RECIPE.name = "Komputer"
RECIPE.description = "Odnowiony komputer z dostępem do notatek, chodzi na systemie zmodyfikowanym przez Uniwersalną Unię. Przydatny w sklepach."
RECIPE.model = "models/willardnetworks/props/willard_computer.mdl"
RECIPE.category = "Elektronika"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["cit_computer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_elec_musicradio1"
RECIPE.name = "Radio Benefaktor"
RECIPE.description = "Masowo produkowane radio ustawione na częstotliwość kontrolowaną przez Kombinat na której gra patriotyczna oraz klasyczna muzyka."
RECIPE.model = "models/props_lab/citizenradio.mdl"
RECIPE.category = "Elektronika"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["musicradio_cmb"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()
