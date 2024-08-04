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
RECIPE.uniqueID = "rec_craft_suitcase"
RECIPE.name = "Bavul"
RECIPE.description = "Taşımak istemediğiniz her şeyi taşımaya hazır küçük bir bavul."
RECIPE.model = "models/weapons/w_suitcase_passenger.mdl"
RECIPE.category = "Depolama"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_cloth"] = 2, ["comp_plastic"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["suitcase"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full XP
	{level = 15, exp = 40}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_small_bag"
RECIPE.name = "Küçük Çanta"
RECIPE.description = "Kalçanızda duran küçük bir el çantası."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Depolama"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 3, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["smallbag"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 80}, -- full XP
	{level = 15, exp = 40}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_large_bag"
RECIPE.name = "Büyük Çanta"
RECIPE.description = "Üzerinde Combine amblemi olan bir sırt çantası."
RECIPE.model = "models/willardnetworks/clothingitems/backpack.mdl"
RECIPE.category = "Depolama"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["largebag"] = 1}
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 100}, -- full XP
	{level = 25, exp = 50}, -- half XP
	{level = 30, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_lock"
RECIPE.name = "Asma Kilit"
RECIPE.description = "Kullanıldığında bir konteynere/kapıya şifre koyar. Sadece sahibi çevrimiçi olduğunda vurulabilir."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Depolama"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_screws"] = 1, ["comp_plastic"] = 1}
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_small"
RECIPE.name = "Küçük Konteyner"
RECIPE.description = "5x3 boyutunda konteyner. Bu öğeyi hazırladığınızda bu konteyneri kurmak için bir yöneticiyle iletişime geçin. Şifre belirlemek için konteyner kilidi öğesine ihtiyaç duyar."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Depolama"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_refined_plastic"] = 1, ["comp_adhesive"] = 1, ["comp_rivbolts"] = 1}
RECIPE.result = {["container_small_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 25, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_medium"
RECIPE.name = "Orta Boy Konteyner"
RECIPE.description = "5x8 boyutunda konteyner. Bu öğeyi hazırladığınızda bu konteyneri kurmak için bir yöneticiyle iletişime geçin. Şifre belirlemek için konteyner kilidi öğesine ihtiyaç duyar."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Depolama"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["container_small_dummy"] = 2, ["comp_rivbolts"] = 2}
RECIPE.result = {["container_medium_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 125}, -- full xp
	{level = 35, exp = 60}, -- half xp
	{level = 40, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_large"
RECIPE.name = "Büyük Konteyner"
RECIPE.description = "5+ üyeli bir grup gerektirir - 9x9 boyutlu konteyner. Bu konteyneri kurmak için bir yönetici ile iletişime geçin. Parola belirlemek için bir konteyner kilidi gerekir."
RECIPE.model = "models/props_wasteland/controlroom_storagecloset001a.mdl"
RECIPE.category = "Depolama"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["container_medium_dummy"] = 2, ["comp_rivbolts"] = 2}
RECIPE.result = {["container_large_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_scrate"
RECIPE.name = "Standart Sandık"
RECIPE.description = "6x6 boyutunda konteyner. Bu konteyneri kurmak için bir yönetici ile iletişime geçin. Parola belirlemek için bir konteyner kilidi gerekir."
RECIPE.model = "models/props_wasteland/controlroom_storagecloset001a.mdl"
RECIPE.category = "Depolama"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["container_medium_dummy"] = 1, ["comp_wood"] = 2}
RECIPE.result = {["container_scrate_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 100}, -- full xp
	{level = 25, exp = 50}, -- half xp
	{level = 30, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_container_lcrate"
RECIPE.name = "Büyük Sandık"
RECIPE.description = "5+ üyeli bir grup gerektirir - 9x9 boyutlu konteyner. Bu konteyneri kurmak için bir yönetici ile iletişime geçin. Parola belirlemek için bir konteyner kilidi gerekir."
RECIPE.model = "models/props_wasteland/controlroom_storagecloset001a.mdl"
RECIPE.category = "Depolama"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["container_large_dummy"] = 1, ["comp_wood"] = 4}
RECIPE.result = {["container_lcrate_dummy"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 200}, -- full xp
	{level = 45, exp = 100}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_safe"
RECIPE.name = "Kasa"
RECIPE.description = "Eşyalarınızı saklamak için kırılmaz bir kasa. (Konteyner sınırının üstünde 2 kasanız olabilir.)"
RECIPE.model = "models/willardnetworks/safe.mdl"
RECIPE.category = "Depolama"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 4, ["comp_refined_plastic"] = 3, ["comp_electronics"] = 1, ["comp_rivbolts"] = 2}
RECIPE.result = {["container_safe"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 0}, -- full xp
	{level = 50, exp = 0},
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_grouplock"
RECIPE.name = "Grup Kilidi"
RECIPE.description = "Kapılara uygulanan metal bir aparat. Çalışması için bir grup gerektirir."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Depolama"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["trash_biolock"] = 1, ["comp_electronics"] = 1, ["comp_screws"] = 1}
RECIPE.result = {["grouplock"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full xp
	{level = 15, exp = 25}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()