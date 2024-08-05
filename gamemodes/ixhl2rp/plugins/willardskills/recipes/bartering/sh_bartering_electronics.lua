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
RECIPE.name = "Request Device"
RECIPE.description = "A small device with rounded corners, housing two buttons. A small combine logo is visible."
RECIPE.model = "models/gibs/shield_scanner_gib1.mdl"
RECIPE.category = "Electronics"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["request_device"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_flashlight"
RECIPE.name = "Flashlight"
RECIPE.description = "Incredibly useful when exploring the unknown dark."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Electronics"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["flashlight"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tv"
RECIPE.name = "Television"
RECIPE.description = "A regime issued television to view propaganda broadcasts on."
RECIPE.model = "models/props_c17/tv_monitor01.mdl"
RECIPE.category = "Electronics"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["television"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_coffeemachine"
RECIPE.name = "Coffee Machine"
RECIPE.description = "When you need drippling perfection on your shoes, a coffee machine is all you need."
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Electronics"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 55
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cit_computer"
RECIPE.name = "Computer"
RECIPE.description = "A computer with access to notes, utilizing a dodgy regime OS, useful tool for stores."
RECIPE.model = "models/willardnetworks/props/willard_computer.mdl"
RECIPE.category = "Electronics"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["cit_computer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_elec_musicradio"
RECIPE.name = "Benefactor Radio"
RECIPE.description = "A manufactured radio with a tuner that can only tune to official Union-Approved radio stations."
RECIPE.model = "models/props_lab/citizenradio.mdl"
RECIPE.category = "Electronics"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["musicradio_cmb"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()
