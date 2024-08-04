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
RECIPE.name = "Broche"
RECIPE.description = "Une broche, utilisée pour accrocher des papiers sur les murs."
RECIPE.model = "models/props_c17/TrapPropeller_Lever.mdl"
RECIPE.category = "Imprimerie" 
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["pin"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_paper"
RECIPE.name = "Papier"
RECIPE.description = "Un papier pour écrire."
RECIPE.model = "models/props_c17/paper01.mdl"
RECIPE.category = "Imprimerie" 
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["paper"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_notepad"
RECIPE.name = "Bloc-notes"
RECIPE.description = "Un bloc-note pour écrire."
RECIPE.model = "models/willard/work/notepad1.mdl"
RECIPE.category = "Imprimerie" 
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["notepad"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_book"
RECIPE.name = "Livre blanc"
RECIPE.description = "Un livre vierge, prêt et attendant que vous le remplissiez."
RECIPE.model = "models/willardnetworks/misc/book.mdl"
RECIPE.category = "Imprimerie" 
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["book"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_ink"
RECIPE.name = "Encre noire"
RECIPE.description = "Une cartouche d'imprimante à encre noire."
RECIPE.model = "models/gibs/metal_gib2.mdl"
RECIPE.category = "Imprimerie" 
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["black_ink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_audiobook_reading"
RECIPE.name = "Apprendre à lire"
RECIPE.description = "L'écoute de cet appareil rustique améliorera votre capacité de lecture."
RECIPE.model = "models/props_lab/reciever01d.mdl"
RECIPE.category = "Imprimerie" 
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 13
RECIPE.result = {["audiobook_reading"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()