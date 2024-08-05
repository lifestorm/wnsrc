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

RECIPE.uniqueID = "rec_ammo_357"
RECIPE.name = "357 Rounds"
RECIPE.description = "357 rounds for a revolver."
RECIPE.model = "models/items/357ammo.mdl"
RECIPE.category = "Ammo"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_chemcomp"] = 2, ["comp_alcohol"] = 2}
RECIPE.result = {["bullets_357"] = 18}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 150}, -- full xp
	{level = 20, exp = 75}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ammo_sniper"
RECIPE.name = "Sniper Rounds"
RECIPE.description = "Loose sniper rounds for a sniper."
RECIPE.model = "models/items/sniper_round_box.mdl"
RECIPE.category = "Ammo"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_chemcomp"] = 2, ["comp_alcohol"] = 2, ["comp_explosive"] = 1}
RECIPE.result = {["bullets_sniper"] = 15}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 200}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ammo_smg"
RECIPE.name = "SMG Rounds"
RECIPE.description = "Loose rounds for sub-machine guns."
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Ammo"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_chemcomp"] = 2, ["comp_alcohol"] = 2}
RECIPE.result = {["bullets_smg1"] = 60}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 25
RECIPE.experience = {
	{level = 25, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ammo_arifle"
RECIPE.name = "Assault Rifle Ammo"
RECIPE.description = "Loose rifle rounds"
RECIPE.model = "models/Items/BoxSRounds.mdl"
RECIPE.category = "Ammo"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_chemcomp"] = 2, ["comp_alcohol"] = 3,}
RECIPE.result = {["bullets_assaultrifle"] = 60}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 35, exp = 50}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ammo_pistol"
RECIPE.name = "9mm Pistol Bullets"
RECIPE.description = "Loose pistol rounds."
RECIPE.model = "models/items/boxsrounds.mdl"
RECIPE.category = "Ammo"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["comp_alcohol"] = 1}
RECIPE.result = {["bullets_pistol"] = 60}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ammo_buckshot"
RECIPE.name = "Buckshot Shells"
RECIPE.description = "A stack of loose shotgun shells in a scrap cardboard box."
RECIPE.model = "models/Items/BoxBuckshot.mdl"
RECIPE.category = "Ammo"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["comp_alcohol"] = 2, ["comp_explosive"] = 1}
RECIPE.result = {["bullets_buckshot"] = 24}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full xp
	{level = 35, exp = 50}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()