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

RECIPE.uniqueID = "rec_wep_ms_ballrifle"
RECIPE.name = "Tikhar Ball Rifle"
RECIPE.description = "A makeshift weapon capable of firing ball-shaped pellets with quite the heavy impact thanks to not only the balls' weight but also the pressure force of the weapon."
RECIPE.model = "models/weapons/c_Tikhar.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_adhesive"] = 1, ["comp_wood"] = 3, ["comp_iron"] = 3, ["comp_rivbolts"] = 1, ["comp_stitched_cloth"] = 2}
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

RECIPE.uniqueID = "rec_wep_ms_boltrifle"
RECIPE.name = "Helsing Bolt Rifle"
RECIPE.description = "A silent, revolving air gun that shoots metal bolts."
RECIPE.model = "models/weapons/c_Helsing.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_adhesive"] = 1, ["comp_wood"] = 2, ["comp_iron"] = 2, ["comp_rivbolts"] = 1, ["comp_stitched_cloth"] = 1}
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
RECIPE.ingredients = {["comp_adhesive"] = 2, ["comp_weapon_parts"] = 1, ["leadpipe"] = 2}
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
RECIPE.ingredients = {["comp_adhesive"] = 2, ["comp_weapon_parts"] = 1, ["leadpipe"] = 1}
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
RECIPE.ingredients = {["comp_adhesive"] = 1, ["comp_weapon_parts"] = 1}
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
RECIPE.ingredients = {["comp_adhesive"] = 1, ["comp_weapon_parts"] = 2, ["comp_wood"] = 4, ["comp_stitched_cloth"] = 1}
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
RECIPE.ingredients = {["comp_adhesive"] = 1, ["comp_wood"] = 4, ["comp_weapon_parts"] = 3}
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
RECIPE.ingredients = {["comp_adhesive"] = 1, ["comp_wood"] = 4, ["comp_weapon_parts"] = 2}
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

RECIPE.uniqueID = "rec_wep_knife"
RECIPE.name = "Kitchen Knife (Sharpened)"
RECIPE.description = "A sharpened kitchen knife, compared to the standard knife that Combine offers... this one is most certainly not allowed."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_kitknife.mdl"
RECIPE.category = "Weapons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 4, ["tool_knife"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["kitknife"] = 1}
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 100},
	{level = 10, exp = 50},
	{level = 15, exp = 0}
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_cleaver"
RECIPE.name = "Cleaver"
RECIPE.description = "A cleaver to chop up meat."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_cleaver.mdl"
RECIPE.category = "Weapons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_wood"] = 1, ["comp_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["cleaver"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100},
	{level = 20, exp = 50},
	{level = 25, exp = 0}
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_hatchet"
RECIPE.name = "Hatchet"
RECIPE.description = "Your standard hatchet used to cut down trees or people."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_hatchet.mdl"
RECIPE.category = "Weapons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_wood"] = 1, ["comp_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["hatchet"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 120},
	{level = 20, exp = 60},
	{level = 25, exp = 0}
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_baseball_bat"
RECIPE.name = "Baseball Bat"
RECIPE.description = "For all your batting needs... as long as you even allowed to have such fun anymore."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl"
RECIPE.category = "Weapons"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_wood"] = 3, ["comp_rivbolts"] = 2, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["baseballbat"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 200},
	{level = 30, exp = 100},
	{level = 35, exp = 0}
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_wep_crowbar"
RECIPE.name = "Crowbar"
RECIPE.description = "Hmm... a crowbar. Now don't go whacking the Civil Protection to death with it."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
RECIPE.category = "Weapons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 2}
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

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_leadpipe"
RECIPE.name = "Lead Pipe"
RECIPE.description = "A pipe for you to use as a standard weapon, just don't go ripping pipes out of walls now."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl"
RECIPE.category = "Weapons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["leadpipe"] = 1}
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 100},
	{level = 20, exp = 50},
	{level = 25, exp = 0}
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_wep_sledgehammer"
RECIPE.name = "Sledge Hammer"
RECIPE.description = "Heavy and powerful. Careful not to hit anyone with this."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_sledge.mdl"
RECIPE.category = "Weapons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_wood"] = 3, ["comp_rivbolts"] = 2}
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