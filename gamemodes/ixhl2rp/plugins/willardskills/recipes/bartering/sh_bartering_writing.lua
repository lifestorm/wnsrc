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
RECIPE.uniqueID = "bartering_writing_pin"
RECIPE.name = "Pinezka do papieru"
RECIPE.description = "Pinezka, służy do zawieszania papieru na ścianie czy tablicy."
RECIPE.model = "models/items/crossbowrounds.mdl"
RECIPE.category = "Pismo"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["pin"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_paper"
RECIPE.name = "Papier"
RECIPE.description = "Papier, na którym można pisać."
RECIPE.model = "models/props_c17/paper01.mdl"
RECIPE.category = "Pismo"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["paper"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_notepad"
RECIPE.name = "Notatnik"
RECIPE.description = "Notatnik w którym możesz pisać."
RECIPE.model = "models/props_lab/clipboard.mdl"
RECIPE.category = "Pismo"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["notepad"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_book"
RECIPE.name = "Pusta książka"
RECIPE.description = "Pusta książka, gotowa i czekająca na wypełnienie przez Ciebie."
RECIPE.model = "models/willardnetworks/misc/book.mdl"
RECIPE.category = "Pismo"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["book"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_ink"
RECIPE.name = "Czarny tusz"
RECIPE.description = "Wkład do drukarki z czarnym tuszem."
RECIPE.model = "models/gibs/metal_gib2.mdl"
RECIPE.category = "Pismo"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["black_ink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_audiobook_reading"
RECIPE.name = "[Odtwarzacz Audio] Naucz się czytać"
RECIPE.description = "Słuchanie tego szeleszczącego urządzenia poprawi Twoją zdolność czytania."
RECIPE.model = "models/props_lab/reciever01d.mdl"
RECIPE.category = "Pismo"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["audiobook_reading"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_newspaper_printer"
RECIPE.name = "Drukarka gazet"
RECIPE.description = "Drukuje gazety. Wymaga papieru, czarnego tuszu i zezwolenia na prowadzenie działalności."
RECIPE.model = "models/willardnetworks/plotter.mdl"
RECIPE.category = "Pismo"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 750
RECIPE.result = {["newspaper_printer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()