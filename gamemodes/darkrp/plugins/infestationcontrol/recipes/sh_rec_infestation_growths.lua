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
	RECIPE.name = "Sülük Bazlı Yapıştırıcı"
	RECIPE.description = "Nesneleri birbirine yapıştırmak için kullanılan bir yapıştırıcı. Çok yapışkan."
	RECIPE.model = "models/willardnetworks/props/glue.mdl"
	RECIPE.category = "Bileşenler"
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
	RECIPE.name = "Koarktat Mukus"
	RECIPE.description = "Oldukça yapışkan ve güçlü kokulu mukus benzeri bir sıvı. Eğitimli bir göz için, bazı ilaç uygulamaları var gibi görünüyor"
	RECIPE.model = "models/jq/hlvr/props/xenpack/xen_bulb002.mdl"
	RECIPE.category = "Tıbbi"
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
	RECIPE.name = "Erebus Mukus Ekstratı"
	RECIPE.description = "Erebus Mukusundan alkolü çıkarın."
	RECIPE.model = "models/props_lab/jar01a.mdl"
	RECIPE.category = "Alkol/kimyasal özütleme"
	RECIPE.subcategory = "Alkol"
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
	RECIPE.name = "Güçlü Yapıştırıcı"
	RECIPE.description = "Nesneleri birbirine yapıştırmak için daha güçlü bir yapıştırıcı. Çok yapışkan."
	RECIPE.model = "models/willardnetworks/props/spicyglue.mdl"
	RECIPE.category = "Bileşenler"
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
	RECIPE.name = "Küme Kovanı/Erebus Mukusu Ekstratı"
	RECIPE.description = "Bu iki yabancı maddeden rafine edilmemiş kimyasal bileşikler elde edin."
	RECIPE.model = "models/jq/hlvr/props/xenpack/xen_bulb002.mdl"
	RECIPE.category = "Alkol/kimyasal özütleme"
	RECIPE.subcategory = "Rafine Edilmemiş Kimyasallar"
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
	RECIPE.name = "Arıtıcı"
	RECIPE.description = "Herhangi bir karışımı veya maddeyi herhangi bir toksik bileşikten arındırabilen garip toz."
	RECIPE.model = "models/willardnetworks/skills/pill_bottle.mdl"
	RECIPE.category = "Bileşenler"
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
