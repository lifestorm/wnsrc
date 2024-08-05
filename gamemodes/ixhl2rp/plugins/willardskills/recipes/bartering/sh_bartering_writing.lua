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
RECIPE.name = "Paper Pin"
RECIPE.description = "A pin, used to hang up papers on walls."
RECIPE.model = "models/items/crossbowrounds.mdl"
RECIPE.category = "Writing"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["pin"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_paper"
RECIPE.name = "Paper"
RECIPE.description = "A paper to write on."
RECIPE.model = "models/props_c17/paper01.mdl"
RECIPE.category = "Writing"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["paper"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_notepad"
RECIPE.name = "Notepad"
RECIPE.description = "A blue notepad to write on."
RECIPE.model = "models/props_lab/clipboard.mdl"
RECIPE.category = "Writing"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["notepad"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_book"
RECIPE.name = "Blank Book"
RECIPE.description = "A blank book, ready and waiting for you to fill."
RECIPE.model = "models/willardnetworks/misc/book.mdl"
RECIPE.category = "Writing"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["book"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_ink"
RECIPE.name = "Black Ink"
RECIPE.description = "A black ink printer cartridge."
RECIPE.model = "models/gibs/metal_gib2.mdl"
RECIPE.category = "Writing"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["black_ink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_audiobook_reading"
RECIPE.name = "[Audio Player] Learn to Read"
RECIPE.description = "Listening to this rustic device will improve your reading capability."
RECIPE.model = "models/props_lab/reciever01d.mdl"
RECIPE.category = "Writing"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["audiobook_reading"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_newspaper_printer"
RECIPE.name = "Newspaper Printer"
RECIPE.description = "Prints newspapers, requires paper, black ink and a business permit to work."
RECIPE.model = "models/willardnetworks/plotter.mdl"
RECIPE.category = "Writing"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 750
RECIPE.result = {["newspaper_printer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()