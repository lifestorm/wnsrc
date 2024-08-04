--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:GenerateRecipes() -- Make sure crafting is initialized before we try to add recipes.
	local RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "rec_leech_adhesive"
	RECIPE.name = "Klej na bazie pijawek"
	RECIPE.description = "Klej do sklejania przedmiotów. Bardzo lepki."
	RECIPE.model = "models/willardnetworks/props/glue.mdl"
	RECIPE.category = "Komponenty"
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["ing_raw_leech"] = 3}
	RECIPE.result = {["comp_adhesive"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "crafting"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "rec_coarctate_mucus"
	RECIPE.name = "Śluz Coarctate"
	RECIPE.description = "Dość lepki i silnie pachnący podobny do śluzu płyn. Dla wprawnego oka może mieć pewne zastosowania medyczne."
	RECIPE.model = "models/jq/hlvr/props/xenpack/xen_bulb002.mdl"
	RECIPE.category = "Medycyna"
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["ic_cluster_hive"] = 1}
	RECIPE.result = {["ic_coarctate_mucus"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "crafting"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "break_mucus_alcohol"
	RECIPE.name = "Ekstraktuj Śluz Erebus"
	RECIPE.description = "Wyekstraktuj alkohol ze Śluzu Erebus."
	RECIPE.model = "models/props_lab/jar01a.mdl"
	RECIPE.category = "Ekstrakcja alkoholowa/chemiczna"
	RECIPE.subcategory = "Alkohol"
	RECIPE.station = {"tool_oven", "tool_oven_rusty"}
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["crafting_water"] = 1}
	RECIPE.result = {["comp_alcohol"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "medicine"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "rec_strong_adhesive"
	RECIPE.name = "Mocny klej"
	RECIPE.description = "Mocniejszy klej do sklejania przedmiotów ze sobą. Jeszcze bardziej klejący niż zwykły klej."
	RECIPE.model = "models/willardnetworks/props/spicyglue.mdl"
	RECIPE.category = "Komponenty"
	RECIPE.ingredients = {["comp_adhesive"] = 1, ["ic_cluster_hive"] = 1}
	RECIPE.result = {["comp_adhesive"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "crafting"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "break_cluster_mucus_chemical"
	RECIPE.name = "Ekstraktuj Klaster/Śluz Erebus"
	RECIPE.description = "Ekstraktuj nierafinowane związki chemiczne z tych dwóch obcych substancji."
	RECIPE.model = "models/jq/hlvr/props/xenpack/xen_bulb002.mdl"
	RECIPE.category = "Ekstrakcja alkoholowa/chemiczna"
	RECIPE.subcategory = "Nierafinowane substancje chemiczne"
	RECIPE.station = {"tool_oven", "tool_oven_rusty"}
	RECIPE.ingredients = {["ic_erebus_mucus"] = 1, ["ic_cluster_hive"] = 1}
	RECIPE.result = {["comp_chemicals"] = 2}
	RECIPE.hidden = false
	RECIPE.skill = "medicine"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()

	RECIPE = ix.recipe:New()
	RECIPE.uniqueID = "rec_comp_purifier_cluster"
	RECIPE.name = "Oczyszczalnik"
	RECIPE.description = "Dziwny pył, który może oczyścić dowolną mieszaninę lub substancję z toksycznych związków."
	RECIPE.model = "models/willardnetworks/skills/pill_bottle.mdl"
	RECIPE.category = "Komponenty"
	RECIPE.ingredients = {["ic_cluster_hive"] = 1, ["comp_chemicals"] = 1}
	RECIPE.result = {["comp_purifier"] = 1}
	RECIPE.hidden = false
	RECIPE.skill = "crafting"
	RECIPE.level = 0
	RECIPE.experience = {
		{level = 0, exp = 120}, -- full xp
		{level = 10, exp = 60}, -- half xp
		{level = 15, exp = 0} -- no xp
	}
	RECIPE:Register()
end
