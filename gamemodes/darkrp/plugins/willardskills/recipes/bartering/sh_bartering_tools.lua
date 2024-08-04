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
RECIPE.name = "Cuillère de cuisine"
RECIPE.description = "Utile pour préparer des ragoûts."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["tool_spoon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_kettle"
RECIPE.name = "Bouilloire"
RECIPE.description = "Une bouilloire qui peut égoutter de l'eau parfaitement bouillante."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["tool_kettle"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_knife"
RECIPE.name = "Couteau de cuisine"
RECIPE.description = "Couteau épais et semi-émoussé. Utilisé pour couper les aliments sur une planche à découper ou une surface."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["tool_knife"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_scissors"
RECIPE.name = "Ciseaux"
RECIPE.description = "Attention ça coupe!"
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["tool_scissors"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_syringe"
RECIPE.name = "Seringue"
RECIPE.description = "Seringue pouvant contenir des substances liquides, utile à des fins médicales."
RECIPE.model = "models/willardnetworks/skills/syringeammo.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["comp_syringe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_cookingpot"
RECIPE.name = "Pot de cuisson"
RECIPE.description = "Une marmite noire en fer. Mettez-la sur le feu !"
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_cookingpot"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_fryingpan"
RECIPE.name = "Poêle à frire"
RECIPE.description = "Une poêle à frire noire en fer. Bonne pour la cuisson des aliments."
RECIPE.model = "models/props_c17/metalPot002a.mdl" -- This model is wrong. Use the hl2 frying pan model plz
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["tool_fryingpan"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_razor"
RECIPE.name = "Outils de coiffeur"
RECIPE.description = "Un outil pour les âmes créatives dans un paysage autrement déprimant."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["beard_razor"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_wrench"
RECIPE.name = "Clé à molette"
RECIPE.description = "Une vieille clé à molette. Elle pourrait être utilisée pour la mise en caisse."
RECIPE.model = "models/props_c17/tools_wrench01a.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_wrench"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_toolkit"
RECIPE.name = "Boîte à outils"
RECIPE.description = "Une petite caisse en métal contenant divers outils de construction pour assembler des objets."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Outils"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["tool_toolkit"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_coffeemachine"
RECIPE.name = "Machine a café"
RECIPE.description = "Lorsque vos chaussures doivent être parfaites, une machine à café est tout ce dont vous avez besoin."
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Machines"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 45
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_oven_assembly"
RECIPE.name = "Kit d'assemblage du four"
RECIPE.description = "Cet emballage en bois contient, outre un ensemble d'instructions, un grand nombre de pièces différentes pour l'appareil de cuisson."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Machines"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 80
RECIPE.result = {["tool_oven_assembly"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_grouplock"
RECIPE.name = "Combine Lock de groupe"
RECIPE.description = "Appareil métallique appliqué aux portes. Nécessite un groupe pour fonctionner."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Stockage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 80
RECIPE.result = {["grouplock"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Storage

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_lock"
RECIPE.name = "Cadenas"
RECIPE.description = "Définit un mot de passe aléatoire sur un conteneur lorsqu'il est utilisé."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Stockages"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_satchel"
RECIPE.name = "Sacoche"
RECIPE.description = "Une petite sacoche qui se pose sur la hanche."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Sacs"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 70
RECIPE.result = {["smallbag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_container_small"
RECIPE.name = "Petit conteneur"
RECIPE.description = "Conteneur de taille 5x3. Contactez un administrateur pour installer ce conteneur lorsque vous avez fabriqué cet objet. Nécessite un élément de verrouillage du conteneur pour définir un mot de passe."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Stockage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 90
RECIPE.result = {["container_small_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_mixer"
RECIPE.name = "Mixer"
RECIPE.description = "Il semble utile pour mélanger des liquides ou des produits chimiques. L'étiquette d'avertissement indique Ne pas ouvrir en cours de fonctionnement"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Machines"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 180
RECIPE.result = {["tool_mixer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_backpack"
RECIPE.name = "Sac"
RECIPE.description = "Un petit sac à dos portant le cachet de Combine."
RECIPE.model = "models/willardnetworks/clothingitems/backpack.mdl"
RECIPE.category = "Sacs"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["largebag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_safe"
RECIPE.name = "Coffre Fort"
RECIPE.description = "Un coffre-fort incassable pour conserver vos objets."
RECIPE.model = "models/willardnetworks/safe.mdl"
RECIPE.category = "Stockage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 850
RECIPE.result = {["container_safe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()