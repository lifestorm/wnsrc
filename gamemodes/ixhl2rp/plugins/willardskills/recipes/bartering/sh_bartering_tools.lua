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
RECIPE.name = "Kitchen Spoon"
RECIPE.description = "Useful for making stews."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["tool_spoon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_kettle"
RECIPE.name = "Kettle"
RECIPE.description = "A kettle that can drip perfect boiling water."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["tool_kettle"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_lighter"
RECIPE.name = "Plastic Lighter"
RECIPE.description = "A cheap plastic lighter made to light up cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/lighter.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["lighter"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_knife"
RECIPE.name = "Kitchen Knife"
RECIPE.description = "A thick, semi-blunt knife. Used to cut food on cutting board or surface."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["tool_knife"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_scissors"
RECIPE.name = "Scissors"
RECIPE.description = "Snip, snip, snip!"
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["tool_scissors"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_syringe"
RECIPE.name = "Syringe"
RECIPE.description = "A syringe able to contain liquid-like substances, useful for medicinal purposes."
RECIPE.model = "models/willardnetworks/skills/syringeammo.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["comp_syringe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_cookingpot"
RECIPE.name = "Cooking pot"
RECIPE.description = "A black, iron cooking pot. Put it on a stove!"
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_cookingpot"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_fryingpan"
RECIPE.name = "Frying Pan"
RECIPE.description = "A black, iron frying pan. Good for cooking food."
RECIPE.model = "models/props_c17/metalPot002a.mdl" -- This model is wrong. Use the hl2 frying pan model plz
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["tool_fryingpan"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_razor"
RECIPE.name = "Hairdresser tools"
RECIPE.description = "A tool for creative souls in an otherwise depressing landscape."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["beard_razor"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_wrench"
RECIPE.name = "Wrench"
RECIPE.description = "An old wrench. Could use this for crating."
RECIPE.model = "models/props_c17/tools_wrench01a.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_wrench"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_toolkit"
RECIPE.name = "Toolkit"
RECIPE.description = "A small metal crate containing various construction tools for assembling items."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["tool_toolkit"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_coffeemachine"
RECIPE.name = "Coffee Machine"
RECIPE.description = "When you need drippling perfection on your shoes, a coffee machine is all you need."
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 45
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_oven_assembly"
RECIPE.name = "Oven Assembly Kit"
RECIPE.description = "Alongside a set of instructions, this wooden package contains a high ordeal of different component pieces for Cooking apperatus."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 80
RECIPE.result = {["tool_oven_assembly"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_grouplock"
RECIPE.name = "Group Lock"
RECIPE.description = "A metal apparatus applied to doors. Requires a group to function."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 80
RECIPE.result = {["grouplock"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Storage

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_lock"
RECIPE.name = "Container Lock"
RECIPE.description = "Sets a random password on a container when used."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_satchel"
RECIPE.name = "Satchel"
RECIPE.description = "A small satchel that rests on your hip."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 70
RECIPE.result = {["smallbag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_suitcase"
RECIPE.name = "Suitcase"
RECIPE.description = "A small suitcase ready to carry everything you'd rather not be."
RECIPE.model = "models/weapons/w_suitcase_passenger.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 70
RECIPE.result = {["suitcase"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_container_small"
RECIPE.name = "Small Container"
RECIPE.description = "5x3 sized container. Contact an admin to setup this container when you've crafted this item. Needs a container lock item to set a password."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 90
RECIPE.result = {["container_small_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_mixer"
RECIPE.name = "Mixer"
RECIPE.description = "This seems to be useful for mixing liquids or chemicals together. Its warning label reads: Do not open when in operation"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 180
RECIPE.result = {["tool_mixer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_backpack"
RECIPE.name = "Backpack"
RECIPE.description = "A small backpack with the Combine stamp upon it."
RECIPE.model = "models/willardnetworks/clothingitems/backpack.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["largebag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_safe"
RECIPE.name = "Container Safe"
RECIPE.description = "An unbreakable safe to keep your items in. (You may have 2 safes on top of the container limit.)"
RECIPE.model = "models/willardnetworks/safe.mdl"
RECIPE.category = "Tools & Storage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 850
RECIPE.result = {["container_safe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()