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
RECIPE.uniqueID = "rec_clothing_gasmask"
RECIPE.name = "Gaz Maskesi"
RECIPE.description = "Tehlikeli gaz hariç diğer gazlara ve bazı kötü kokulara karşı yeterli koruma sağlar."
RECIPE.model = "models/willardnetworks/clothingitems/head_gasmask.mdl"
RECIPE.category = "Gaz Maskesi"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_iron"] = 1, ["comp_plastic"] = 2, ["comp_adhesive"] = 1}
RECIPE.result = {["head_gasmask"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full xp
	{level = 30, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_clothing_gasmask2"
RECIPE.name = "M40 Gaz Maskesi"
RECIPE.description = "Zararlı dumanlara, ölümcül gazlara ve bazı kötü kokulara karşı yeterli koruma sağlar."
RECIPE.model = "models/willardnetworks/clothingitems/m40_item.mdl"
RECIPE.category = "Gaz Maskesi"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_iron"] = 1, ["comp_plastic"] = 2, ["comp_adhesive"] = 1}
RECIPE.result = {["head_gasmask2"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 250}, -- full xp
	{level = 30, exp = 125}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_charcoal_refill"
RECIPE.name = "Kömür Filtresi Dolumu"
RECIPE.description = "Wrap the charcoal into a ready-to-use filter cartridge."
RECIPE.model = "models/gibs/shield_scanner_gib1.mdl"
RECIPE.category = "Gaz Maskesi"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_charcoal"] = 1, ["comp_stitched_cloth"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["comp_charcoal_refill"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 40}, -- full XP
	{level = 30, exp = 20}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_makeshift_filter"
RECIPE.name = "Derme Çatma Filtre"
RECIPE.description = "Yeniden doldurmak için açabileceğiniz ev yapımı bir gaz maskesi filtresi."
RECIPE.model = "models/willardnetworks/props/sovietfilter.mdl"
RECIPE.category = "Gaz Maskesi"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_charcoal_refill"] = 1, ["comp_iron"] = 2, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.result = {["makeshift_filter"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full XP
	{level = 30, exp = 125}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_makeshift_filter"
RECIPE.name = "Parçala: Eğreti Filtre"
RECIPE.description = "Bu filtreyi temel bileşenlerine ayırın."
RECIPE.model = "models/willardnetworks/props/sovietfilter.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Gaz Maskesi"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["makeshift_filter"] = 1}
RECIPE.result = {["comp_cloth"] = 1, ["comp_scrap"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "break_highquality_filter"
RECIPE.name = "Parçala: Yüksek Kalite Filtre"
RECIPE.description = "Bu filtreyi temel bileşenlerine ayırın."
RECIPE.model = "models/willardnetworks/props/blackfilter.mdl"
RECIPE.category = "Parçalama"
RECIPE.subcategory = "Gaz Maskesi"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["highquality_filter"] = 1}
RECIPE.result = {["comp_cloth"] = 1, ["comp_scrap"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 40}, -- full xp
	{level = 10, exp = 20}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()