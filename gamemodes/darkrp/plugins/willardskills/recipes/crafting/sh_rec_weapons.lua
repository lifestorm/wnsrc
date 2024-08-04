--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


----- ARMES -----


local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_shotgun"
RECIPE.name = "Fusil à double canon scié de fortune" -- 8 DMG
RECIPE.description = "Une perche de fortune… agit essentiellement comme un double canon scié, juste fait de restes."
RECIPE.model = "models/weapons/c_duplet.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Fusils"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_light_weapon_parts"] = 2, ["comp_craftwork_wood"] = 3, ["comp_reshaped_metal"] = 5, ["comp_improved_nails_screws"] = 3, ["comp_stitched_cloth"] = 6, ["comp_strong_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["jnk_tikhar"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_boltrifle" -- 24 DMG
RECIPE.name = "Fusil à verrou Helsing"
RECIPE.description = "Un pistolet à air comprimé silencieux et rotatif qui tire des boulons métalliques."
RECIPE.model = "models/weapons/c_Helsing.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Fusils"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_strong_adhesive"] = 1, ["comp_craftwork_wood"] = 1, ["comp_reshaped_metal"] = 3, ["comp_improved_nails_screws"] = 1, ["comp_stitched_cloth"] = 2, ["comp_nails_screws"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["jnk_helsing"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_shotgun"
RECIPE.name = "Duplet Double Barrel"
RECIPE.description = "A Double Barrel shotgun made from the worst materials around, literally 2 water pipes for a barrel."
RECIPE.model = "models/weapons/c_duplet.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_strong_adhesive"] = 1, ["comp_reshaped_metal"] = 4, ["comp_improved_nails_screws"] = 2, ["comp_stitched_cloth"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["jnk_duplet"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 220}, -- full XP
	{level = 15, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_smg"
RECIPE.name = "Bastard SMG"
RECIPE.description = "A creation from scrap and pipe work... someone got bored one day."
RECIPE.model = "models/weapons/c_BastardGun.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_strong_adhesive"] = 1, ["comp_craftwork_wood"] = 1, ["comp_reshaped_metal"] = 4, ["comp_improved_nails_screws"] = 2, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["jnk_bassmg"] = 1}
RECIPE.level = 10 -- Lower level gain for testing
RECIPE.experience = {
	{level = 10, exp = 220}, -- full XP
	{level = 20, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_popper"
RECIPE.name = "Popper"
RECIPE.description = "A revolver capable of firing a powerful shot towards its foes. In all fairness, its actually quite decent."
RECIPE.model = "models/weapons/c_MetroRevolver.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_strong_adhesive"] = 1, ["comp_craftwork_wood"] = 1, ["comp_reshaped_metal"] = 2, ["comp_improved_nails_screws"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["jnk_popper"] = 1}
RECIPE.level = 10 -- Lower level gain for testing
RECIPE.experience = {
	{level = 10, exp = 220}, -- full XP
	{level = 20, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_vsk"
RECIPE.name = "VSK-94"
RECIPE.description = "A somewhat well-made VSK-94. Not sure how you did it, but good job."
RECIPE.model = "models/weapons/c_VSV.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_strong_adhesive"] = 2, ["comp_craftwork_wood"] = 2, ["comp_reshaped_metal"] = 4, ["comp_improved_nails_screws"] = 2, ["comp_stitched_cloth"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["jnk_vsv"] = 1}
RECIPE.level = 10 -- Lower level gain for testing
RECIPE.experience = {
	{level = 10, exp = 220}, -- full XP
	{level = 20, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_akm"
RECIPE.name = "Makeshift AKM"
RECIPE.description = "An AKM which someone tried making, made out of all sorts of scrap from the Outlands."
RECIPE.model = "models/weapons/c_kalash.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_strong_adhesive"] = 2, ["comp_craftwork_wood"] = 2, ["comp_reshaped_metal"] = 4, ["comp_improved_nails_screws"] = 2, ["comp_stitched_cloth"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["jnk_ak"] = 1}
RECIPE.level = 10 -- Lower level gain for testing
RECIPE.experience = {
	{level = 10, exp = 220}, -- full XP
	{level = 20, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_p90"
RECIPE.name = "Odd-looking P90"
RECIPE.description = "Is this meant to be a P90 as it has the capacity for one, the firerate for one. But no the looks of one."
RECIPE.model = "models/weapons/c_kalash2012.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_strong_adhesive"] = 2, ["comp_craftwork_wood"] = 2, ["comp_reshaped_metal"] = 4, ["comp_improved_nails_screws"] = 2, ["comp_stitched_cloth"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["jnk_p90"] = 1}
RECIPE.level = 10 -- Lower level gain for testing
RECIPE.experience = {
	{level = 10, exp = 220}, -- full XP
	{level = 20, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_ballrifle" -- 17
RECIPE.name = "Fusil à billes Tikhar"
RECIPE.description = "Une arme de fortune capable de tirer des plombs en forme de balle avec un impact assez lourd grâce non seulement au poids des balles mais aussi à la force de pression de l'arme."
RECIPE.model = "models/weapons/c_Tikhar.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Fusils"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_strong_adhesive"] = 3, ["comp_craftwork_wood"] = 3, ["comp_reshaped_metal"] = 5, ["comp_improved_nails_screws"] = 2, ["comp_stitched_cloth"] = 8, ["comp_heavy_weapon_parts"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["msballrifle"] = 1}
RECIPE.level = 25 -- Lower level gain for testing
RECIPE.experience = {
	{level = 10, exp = 220}, -- full XP
	{level = 20, exp = 110}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_ms_smg"
RECIPE.name = "Mitraillette bâtarde" -- 9 DMG
RECIPE.description = "Un design pour le moins intéressant mais cette arme de fortune agit comme une mitraillette, à tir rapide mais assez faible."
RECIPE.model = "models/weapons/c_BastardGun.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Mitraillettes"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_light_weapon_parts"] = 4, ["comp_craftwork_wood"] = 3, ["comp_reshaped_metal"] = 6, ["comp_improved_nails_screws"] = 3, ["comp_stitched_cloth"] = 4}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["mssmg"] = 1}
RECIPE.level = 40 -- Lower level gain for testing
RECIPE.experience = {
	{level = 10, exp = 150}, -- full XP
	{level = 15, exp = 75}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}

RECIPE:Register()

----- LVL 5 -----

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_leadpipe"
RECIPE.name = "Tuyau de plomb"
RECIPE.description = "Ce long tube cylindrique en métal lourd est fabriqué en plomb solide et résistant."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Armes de mêlées"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_reshaped_metal"] = 2, ["comp_improved_nails_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["leadpipe"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 15, exp = 100},
	{level = 20, exp = 50},
	{level = 25, exp = 0}
}

RECIPE:Register()

----- LVL 10 -----

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_knife"
RECIPE.name = "Couteau de cuisine (aiguisé)"
RECIPE.description = "Un couteau de cuisine aiguisé, comparé au couteau standard proposé par l'Union. Celui-ci n'est certainement pas autorisé."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_kitknife.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Armes de mêlées"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_metal"] = 2, ["comp_adhesive"] = 1, ["tool_knife"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["kitknife"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 5, exp = 100},
	{level = 10, exp = 50},
	{level = 15, exp = 0}
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_baseball_bat"
RECIPE.name = "Batte de baseball"
RECIPE.description = "Un instrument de puissance entre vos mains, la batte de baseball respire la détermination et la force. Sa forme effilée et son manche robuste en bois vous offrent une prise ferme et confortable. Chaque rainure et chaque éclat sur sa surface racontent une histoire de coups précis et puissants. Son poids équilibré vous confère un sentiment de contrôle et de confiance, prêt à affronter n'importe quel défi sur le terrain."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Armes de mêlées"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_reshaped_metal"] = 3, ["comp_craftwork_wood"] = 3, ["comp_improved_nails_screws"] = 2, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["baseballbat"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 20, exp = 200},
	{level = 30, exp = 100},
	{level = 35, exp = 0}
}

RECIPE:Register()

----- LVL 15 -----

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_hatchet"
RECIPE.name = "Hachette"
RECIPE.description = "Un outil polyvalent utilisé dans diverses tâches, la hachette est une petite hache à manche court."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_hatchet.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Armes de mêlées"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_reshaped_metal"] = 5, ["comp_wood"] = 4, ["comp_nails_screws"] = 3, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["hatchet"] = 1}
RECIPE.level = 15
RECIPE.experience = {
	{level = 10, exp = 120},
	{level = 20, exp = 60},
	{level = 25, exp = 0}
}

RECIPE:Register()

----- LVL 20 -----

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_cleaver"
RECIPE.name = "Couperet"
RECIPE.description = "Un outil tranchant et robuste doté d'une lame lourde et coupante, montée sur un manche solide en bois. "
RECIPE.model = "models/weapons/tfa_nmrih/w_me_cleaver.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Armes de mêlées"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_reshaped_metal"] = 6, ["comp_wood"] = 4, ["comp_nails_screws"] = 2, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["cleaver"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 10, exp = 100},
	{level = 20, exp = 50},
	{level = 25, exp = 0}
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_wep_crowbar"
RECIPE.name = "Pied de biche"
RECIPE.description = "Hum...un pied-de-biche. Maintenant, n'allez pas frapper à mort la Protection civile avec ça."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Armes de mêlées"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_reshaped_metal"] = 2, ["comp_nails_screws"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["crowbar"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200},
	{level = 30, exp = 100},
	{level = 35, exp = 0}
}
RECIPE:Register()

----- LVL 30 -----

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_sledgehammer"
RECIPE.name = "Masse"
RECIPE.description = "Cet outil robuste et puissant est l'essence même du métier de forgeron. Il se compose d'un manche solide en bois et d'une tête en acier forgé. "
RECIPE.model = "models/weapons/tfa_nmrih/w_me_sledge.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Armes de mêlées"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_reshaped_metal"] = 5, ["comp_craftwork_wood"] = 5, ["comp_improved_nails_screws"] = 5, ["comp_adhesive"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["sledgehammer"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 500},
	{level = 40, exp = 250},
	{level = 45, exp = 0}
}

RECIPE:Register()