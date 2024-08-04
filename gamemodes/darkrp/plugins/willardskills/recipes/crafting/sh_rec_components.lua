--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Metal
local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_iron"
RECIPE.name = "Demir"
RECIPE.description = "Geri dönüştürülmüş metalden yapılmış demir. Eskisinden daha güçlü ve daha ağır."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 4, ["comp_screws"] = 1}
RECIPE.result = {["comp_iron"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 10, exp = 80}, -- full XP
	{level = 20, exp = 40}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_steel"
RECIPE.name = "Çelik"
RECIPE.description = "Demirden yapılmış güçlendirilmiş metal levha. Son derece güçlü ve iyi yapılmış."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Bileşenler"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 4, ["comp_rivbolts"] = 1}
RECIPE.result = {["comp_steel"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 25
RECIPE.experience = {
	{level = 25, exp = 100}, -- full xp
	{level = 35, exp = 50}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

-- Plastic
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_refined_plastic"
RECIPE.name = "Plastik Levha"
RECIPE.description = "Plastik levhalar. Plastik çöplerden üretilmiştir."
RECIPE.model = "models/props_junk/garbage_bag001a.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_plastic"] = 4, ["comp_screws"] = 1}
RECIPE.result = {["comp_refined_plastic"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

-- Nails
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_screws"
RECIPE.name = "Vida Kutusu"
RECIPE.description = "Çivi içeren bir kutu. Biraz paslı görünüyorlar."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Bileşenler"
RECIPE.tool = "tool_toolkit"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_screws"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_rivbolts"
RECIPE.name = "Vida Kutusu"
RECIPE.description = "Deneyimli zanaatkarlar için kullanışlı bir kutu sağlam vida."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_screws"] = 4, ["comp_iron"] = 1}
RECIPE.result = {["comp_rivbolts"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 10, exp = 80}, -- full XP
	{level = 30, exp = 40}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

-- Cloth
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_comp_stitched_cloth"
RECIPE.name = "Dikişli Kumaş"
RECIPE.description = "Dikişli bir kumaş parçası. Eskisinden daha sert."
RECIPE.model = "models/willardnetworks/skills/stitched_cloth.mdl"
RECIPE.category = "Bileşenler"
RECIPE.tool = "tool_scissors"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_cloth"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_stitched_cloth"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_fabric"
RECIPE.name = "Kumaş"
RECIPE.description = "Bir parça kumaş. Oldukça yumuşak."
RECIPE.model = "models/willardnetworks/skills/fabric.mdl"
RECIPE.category = "Bileşenler"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_stitched_cloth"] = 4, ["comp_adhesive"] = 2}
RECIPE.result = {["comp_fabric"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

-- Weapons

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_explosive_material"
RECIPE.name = "Patlayıcı Bileşik"
RECIPE.description = "Yumuşak patlayıcı bir bileşim. Şimdi patlayıcılarla oynamaya kalkma."
RECIPE.model = "models/willardnetworks/skills/explosive_material.mdl"
RECIPE.category = "Bileşenler"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_chemcomp"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["comp_explosive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 150}, -- full xp
	{level = 40, exp = 75}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_comp_weapon_parts"
RECIPE.name = "Silah Parçaları"
RECIPE.description = "Silah için metal parçalar."
RECIPE.model = "models/willardnetworks/skills/weaponparts.mdl"
RECIPE.category = "Bileşenler"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 2, ["comp_rivbolts"] = 2, ["comp_refined_plastic"] = 1}
RECIPE.result = {["comp_weapon_parts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

-- charcoal
RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_charcoal"
RECIPE.name = "Kömür Bloğu"
RECIPE.description = "Bazı kimyasal katkı maddeleri ve ısı kullanarak odunu kömüre dönüştürmek."
RECIPE.model = "models/willardnetworks/props/charcoal.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = {"tool_oven", "tool_oven_rusty"}
RECIPE.ingredients = {["comp_wood"] = 2, ["comp_chemcomp"] = 1}
RECIPE.result = {["comp_charcoal"] = 1}
RECIPE.level = 15
RECIPE.experience = {
	{level = 15, exp = 40}, -- full XP
	{level = 30, exp = 20}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_adhesive"
RECIPE.name = "El Yapımı Yapıştırıcı"
RECIPE.description = "Nesneleri birbirine yapıştırmak için bir Yapıştırıcı. Çok yapışkan."
RECIPE.model = "models/willardnetworks/props/glue.mdl"
RECIPE.category = "Bileşenler"
RECIPE.ingredients = {["ing_flour"] = 1, ["ing_vinegar"] = 1}
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