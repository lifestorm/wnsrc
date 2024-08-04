--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Machines --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_coffeemachine"
RECIPE.name = "Cafetière"
RECIPE.description = "Lorsque vous avez besoin d'une perfection dégoulinante sur vos chaussures, une machine à café est tout ce dont vous avez besoin."
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Machines"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 45
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_mixer"
RECIPE.name = "Mixeur"
RECIPE.description = "Cela semble être utile pour mélanger des liquides ou des produits chimiques ensemble. Son étiquette d'avertissement se lit comme suit : Ne pas ouvrir pendant le fonctionnement"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Machines"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 200
RECIPE.result = {["tool_mixer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Meubles --

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_oven_assembly"
RECIPE.name = "Kit d'assemblage de four"
RECIPE.description = "A côté d'un mode d'emploi, cet emballage en bois contient différentes pièces constitutives d'un appareil de cuisson."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Machines"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 300
RECIPE.result = {["tool_oven_assembly"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_oven_rusty_assembly"
RECIPE.name = "Kit d'assemblage de four rouillé"
RECIPE.description = "A côté d'un mode d'emploi, cet emballage en bois contient différentes pièces constitutives d'un appareil de cuisson rouillé."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Machines"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 250
RECIPE.result = {["tool_oven_rusty_assembly"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Stockage --

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_lock"
RECIPE.name = "Cadenas"
RECIPE.description = "Définit un mot de passe sur un stockage lorsqu'il est utilisé."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Stockage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 35
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_container_small"
RECIPE.name = "Armoire à dossiers"
RECIPE.description = "Conteneur de taille 3x3. Contactez un Admin pour configurer ce stockage lorsque vous aurez cet objet. Nécessite un cadenas pour définir un mot de passe."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Stockage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 40
RECIPE.result = {["container_small_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "container_medium_dummy"
RECIPE.name = "Armoire à dossiers moyenne"
RECIPE.description = "Conteneur de taille 3x3. Contactez un Admin pour configurer ce stockage lorsque vous aurez cet objet. Nécessite un cadenas pour définir un mot de passe."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Stockage"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["container_medium_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()