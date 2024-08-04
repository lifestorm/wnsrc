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
RECIPE.uniqueID = "rec_wep_frag"
RECIPE.name = "Grenade à fragmentation"
RECIPE.description = "Un projectile explosif conçu pour infliger des dégâts considérables dans un rayon restreint."
RECIPE.model = "models/weapons/tfa_mmod/w_grenade_thrown.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Grenades"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_grenadecase"] = 1, ["comp_explosive"] = 1, ["comp_greencompound"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["frag_grenade"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100},
	{level = 40, exp = 50},
	{level = 45, exp = 0}
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_wep_flash"
RECIPE.name = "Grenade flash"
RECIPE.description = "Un dispositif explosif conçu pour désorienter temporairement les ennemis avec une puissante explosion de lumière et de bruit. "
RECIPE.model = "models/weapons/tfa_csgo/w_flash.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Grenades"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_grenadecase"] = 1, ["comp_yellowcompound"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["flash_grenade"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 80},
	{level = 40, exp = 40},
	{level = 45, exp = 0}
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_wep_smoke"
RECIPE.name = "Grenade fumigène"
RECIPE.description = "Un dispositif pyrotechnique qui produit une épaisse fumée lorsqu'il est activé."
RECIPE.model = "models/weapons/tfa_csgo/w_smoke.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Grenades"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_grenadecase"] = 1, ["comp_bluecompound"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["smoke_grenade"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 80},
	{level = 40, exp = 40},
	{level = 45, exp = 0}
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_wep_incendiary"
RECIPE.name = "Grenade incendiaire"
RECIPE.description = "Une arme explosive qui libère une intense chaleur et des flammes dévastatrices lorsqu'elle explose."
RECIPE.model = "models/weapons/tfa_csgo/wm/w_incend.mdl"
RECIPE.category = "Armes"
RECIPE.subcategory = "Grenades"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_grenadecase"] = 1, ["comp_explosive"] = 1, ["comp_redcompound"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["incendiary_grenade"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100},
	{level = 40, exp = 50},
	{level = 45, exp = 0}
}
RECIPE:Register()