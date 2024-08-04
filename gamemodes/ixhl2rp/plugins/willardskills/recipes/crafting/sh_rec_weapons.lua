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
RECIPE.name = "Karabin Tichar"
RECIPE.description = "Własnoręcznie zrobiony karabin zdolny do strzelania metalowymi kulkami, których siła wcale nie jest taka zła jakby mogła się wydawać."
RECIPE.model = "models/weapons/c_Tikhar.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Karabin Helsinga"
RECIPE.description = "Cichy karabin bolt-action na metalowe śrubki."
RECIPE.model = "models/weapons/c_Helsing.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Dubeltówka Duple"
RECIPE.description = "Prowizoryczna strzelba dwulufowa wykorzystująca 2 przecięte rury wraz z wieloma doczepionymi częściami i tandetnym systemem strzelania. Postaraj się nie odstrzelić sobie ręki."
RECIPE.model = "models/weapons/c_duplet.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Pistolet Maszynowy Bękart"
RECIPE.description = "Własnoręcznie stworzony pistolet maszynowy o dosyć ciekawym wyglądzie, jest szybki ale nie za mocny."
RECIPE.model = "models/weapons/c_BastardGun.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Rewolwer Pukawka"
RECIPE.description = "Dobrej jakości rewolwer wykonany ze złomu przez nieznaną podziemną grupę. Lekki i poręczny. Używa amunicji .357."
RECIPE.model = "models/weapons/c_MetroRevolver.mdl"
RECIPE.category = "Bronie"
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
RECIPE.description = "Jak na swoje walory, całkiem mocny karabin. Nie jest kompletnym złomem, w przeciwieństwie do innych takich broni."
RECIPE.model = "models/weapons/c_VSV.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Prowizoryczne AK"
RECIPE.description = "AK jeszcze prostrzejsze od tych produkowanych masowo. Nikt tego nie potrzebował, ale musi się nadać."
RECIPE.model = "models/weapons/c_kalash.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Prowizoryczne P90"
RECIPE.description = "Kiepsko wykonana wersja P90 zrobiona ze złomu. Dosłownie złomowa pukawka."
RECIPE.model = "models/weapons/c_kalash2012.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Naostrzony nóż kuchenny"
RECIPE.description = "Naostrzony nóż kuchenny. W porównaniu do tego co jest publicznie dostępne... ten napewno nie jest legalny."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_kitknife.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Tasak"
RECIPE.description = "Tasak to krojenia mięsa."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_cleaver.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Toporek"
RECIPE.description = "Toporek, który idealnie nada się do ścinania drzew... lub ludzi."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_hatchet.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Kij bejsbolowy"
RECIPE.description = "Śmiało, wyżyj się na czymś."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Łom"
RECIPE.description = "Hm... Łom. Tylko nie próbuj teraz atakować nim oficerów Civil Protection!"
RECIPE.model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Rura"
RECIPE.description = "Rura która może posłużyć za broń."
RECIPE.model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl"
RECIPE.category = "Bronie"
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
RECIPE.name = "Młot wyburzeniowy"
RECIPE.description = "Ciężki i mocarny. Uważaj żeby nikogo nie uderzyć!"
RECIPE.model = "models/weapons/tfa_nmrih/w_me_sledge.mdl"
RECIPE.category = "Bronie"
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