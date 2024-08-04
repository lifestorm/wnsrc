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
RECIPE.uniqueID = "rec_disinfectant"
RECIPE.name = "Dezenfektan"
RECIPE.description = "Yaraları durdurmak ve temizlemek için kullanılan bir şişe dezenfektan."
RECIPE.model = "models/willardnetworks/props/disinfectant.mdl"
RECIPE.category = "Tıbbi"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_alcohol"] = 1, ["comp_purifier"] = 1}
RECIPE.result = {["disinfectant_bottle"] = 6}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bandage"
RECIPE.name = "Bandaj Rulosu"
RECIPE.description = "Kanamayı durdurmak için kullanılan hijyenik bandaj rulosu."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Tıbbi"
RECIPE.ingredients = {["comp_cloth"] = 4, ["comp_alcohol"] = 1}
RECIPE.result = {["bandage"] = 6}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_makeshift_into_bandage"
RECIPE.name = "Bandage Roll"
RECIPE.description = "A cloth bandage roll doused in alcohol."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Tıbbi"
RECIPE.ingredients = {["makeshift_bandage"] = 6, ["comp_alcohol"] = 1}
RECIPE.result = {["bandage"] = 6}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_disinfected_bandage"
RECIPE.name = "Dezenfekte Bandaj"
RECIPE.description = "Kanamayı durdurmak ve yaraları temizlemek için kullanılan dezenfekte bandaj rulosu."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Tıbbi"
RECIPE.ingredients = {["bandage"] = 4, ["disinfectant_bottle"] = 3}
RECIPE.result = {["disinfected_bandage"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 150}, -- full xp
	{level = 10, exp = 75}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_painkillers"
RECIPE.name = "Ağrı Kesici"
RECIPE.description = "Ağrı kesici paketi. Hafif ağrılardan geçici rahatlama sağlar."
RECIPE.model = "models/willardnetworks/skills/pills1.mdl"
RECIPE.category = "Tıbbi"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1}
RECIPE.result = {["painkillers"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 180}, -- full xp
	{level = 10, exp = 90}, -- half xp
	{level = 20, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bloodstabilizer"
RECIPE.name = "Kan Stabilizatörü"
RECIPE.description = "Ağrıyı hafifletmek ve iyileşme sürecini desteklemek için kullanılan kırmızı bileşik ve ağrı kesici dolu bir şırınga."
RECIPE.model = "models/willardnetworks/skills/stimpak.mdl"
RECIPE.category = "Tıbbi"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_bloodsyringe"] = 4, ["comp_chemcomp"] = 2, ["painkillers"] = 1}
RECIPE.result = {["bloodstabilizer"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 250}, -- full xp
	{level = 20, exp = 125}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bloodbag"
RECIPE.name = "Kan Torbası"
RECIPE.description = "Bir hortum ve iğne ile bağlanmış bir plastik poşet. İçinde kan olduğu görünüyor."
RECIPE.model = "models/willardnetworks/skills/bloodbag.mdl"
RECIPE.category = "Tıbbi"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_bloodsyringe"] = 4, ["disinfectant_bottle"] = 2, ["comp_plastic"] = 4}
RECIPE.result = {["bloodbag"] = 4}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 260}, -- full xp
	{level = 20, exp = 130}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_firstaid"
RECIPE.name = "İlk Yardım Kiti"
RECIPE.description = "Hızlı ve etkili bir sağlık çözümü sunan küçük bir kırmızı çanta."
RECIPE.model = "models/willardnetworks/skills/medkit.mdl"
RECIPE.category = "Tıbbi"
RECIPE.ingredients = {["bandage"] = 3, ["disinfectant_bottle"] = 3, ["bloodstabilizer"] = 3, ["comp_stitched_cloth"] = 1}
RECIPE.result = {["firstaid"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 260}, -- full xp
	{level = 30, exp = 130}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_adrenaline"
RECIPE.name = "Adrenalin"
RECIPE.description = "Adrenalin dolu bir şırınga. Sert ağrılardan geçici rahatlama sağlar."
RECIPE.model = "models/willardnetworks/skills/adrenaline.mdl"
RECIPE.category = "Tıbbi"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_green"] = 1, ["comp_syringe"] = 1}
RECIPE.result = {["adrenaline"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 260}, -- full xp
	{level = 30, exp = 130}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_morphine"
RECIPE.name = "Morfin"
RECIPE.description = "Morfin dolu bir şırınga. Şiddetli ağrılardan rahatlama sağlar."
RECIPE.model = "models/willardnetworks/skills/adrenaline.mdl"
RECIPE.category = "Tıbbi"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 2, ["basic_red"] = 1, ["comp_syringe"] = 1}
RECIPE.result = {["morphine"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 300}, -- full xp
	{level = 45, exp = 150}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_med_surgerykit"
RECIPE.name = "Cerrahi Kit"
RECIPE.description = "Hemen müdahale için kullanılan bir dizi cerrahi aleti içeren kırmızı bir poşet."
RECIPE.model = "models/willardnetworks/skills/surgicalkit.mdl"
RECIPE.category = "Tıbbi"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["firstaid"] = 1, ["morphine"] = 3, ["bloodbag"] = 3, ["adrenaline"] = 1}
RECIPE.result = {["surgerykit"] = 3}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 320}, -- full xp
	{level = 45, exp = 160}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_med_xenpotion"
RECIPE.name = "Xen İksiri"
RECIPE.description = "Nadir Xen bileşenleri ile hazırlanan son derece egzotik bir uzaylı madde, inanılmaz organik yenilenmeyi getiriyor."
RECIPE.model = "models/willardnetworks/props/xenpotion3.mdl"
RECIPE.category = "Tıbbi"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["ing_xen_herb"] = 4, ["ing_xenberries"] = 4, ["bottle_vodka"] = 1}
RECIPE.result = {["xen_potion"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full xp
	{level = 50, exp = 0}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()
