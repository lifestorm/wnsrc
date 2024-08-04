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
RECIPE.name = "Dispositif d'aide"
RECIPE.description = "Un petit appareil aux coins arrondis, abritant deux boutons. Un petit logo de l'union universelle  est visible."
RECIPE.model = "models/gibs/shield_scanner_gib1.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["request_device"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_flashlight"
RECIPE.name = "Lampe torche"
RECIPE.description = "Incroyablement utile lors de l'exploration de l'obscurité inconnue."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["flashlight"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tv"
RECIPE.name = "Télévision"
RECIPE.description = "AUne télévision pour regarder l'unique programme de l'Union."
RECIPE.model = "models/props_c17/tv_monitor01.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["television"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_coffeemachine"
RECIPE.name = "Machine à café"
RECIPE.description = "Un petit café ça vous va?"
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 55
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cit_computer"
RECIPE.name = "Ordinateur"
RECIPE.description = "Un ordinateur avec un accès aux notes, utilisant un système d'exploitation douteux. Outil utile pour les magasins."
RECIPE.model = "models/willardnetworks/props/willard_computer.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["cit_computer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_elec_musicradio_cmb"
RECIPE.name = "Radio de Bienfaiteur"
RECIPE.description = "Une radio fabriquée dont la fréquence est réglée sur une station de radio de l'Union qui propose à la fois de la musique classique et patriotique."
RECIPE.model = "models/props_lab/citizenradio.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["musicradio_cmb"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_elec_toolkit"
RECIPE.name = "Boîte à outils"
RECIPE.description = "Une petite caisse en métal contenant divers outils de construction pour assembler des objets."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 90
RECIPE.result = {["tool_toolkit"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_elec_scissors"
RECIPE.name = "Ciseaux"
RECIPE.description = "Coupez, coupez , coupez! Faite attention avec quand même..."
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_scissors"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_elec_lock"
RECIPE.name = "Cadenas"
RECIPE.description = "Permet de définir un mot de passe sur certains conteneurs/portes lorsqu'il est utilisé."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_elec_plastic_lighter"
RECIPE.name = "Briquet en plastique"
RECIPE.description = "Un petit briquet en plastique avec une surface légérement texturée pour une meilleur prise en main. Le couvercle s'ouvre facilement pour révéler une petite flamme prête à être allumée."
RECIPE.model = "models/willardnetworks/cigarettes/lighter.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["lighter"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()
