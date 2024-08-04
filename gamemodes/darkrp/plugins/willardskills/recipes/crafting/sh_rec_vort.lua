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

RECIPE.uniqueID = "rec_craft_vort_shackles_fake"
RECIPE.name = "Vortigaunt Prangaları (sahte)"
RECIPE.description = "Uzuvları daraltan ve hareket etmeyi acı verici hale getiren metal bağlar ve destekler. Yerlerine kilitlenirler ve bir kez uygulandıktan sonra çıkarılamazlar."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1, ["comp_refined_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_shackles_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_collar_fake"
RECIPE.name = "Vortigaunt Yaka (sahte)"
RECIPE.description = "İçinde sınırda uzaylı teknolojisi bulunan ağır, metalik bir tasma. Bir vortigaunt'un etrafındaki enerjileri manipüle etme yeteneğini tamamen etkisiz hale getirir. Bir kez takıldığında, uygun aletler olmadan çıkarılamaz."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_collar_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 70}, -- full XP
	{level = 30, exp = 35}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_hooks_fake"
RECIPE.name = "Vortigaunt Kancaları (sahte)"
RECIPE.description = "Hem kelepçelerin hem de yakalıkların temel bileşeni. Bacakların etrafına çok sıkı otururlar. Yerine kilitlenir, bir kez uygulandıktan sonra çıkarılamazlar."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_slave_hooks_fake"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 30}, -- full XP
	{level = 30, exp = 15}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_meat01"
RECIPE.name = "Besin Kemeri"
RECIPE.description = "Her köşeden toplanmış lezzetli, ağız sulandıran headcrab derilerinden oluşan bir koleksiyon."
RECIPE.model = "models/n7/vorti_outfit/meat01.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["headcrab_skewer"] = 3, ["comp_rivbolts"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_meat01"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 200}, -- full XP
	{level = 10, exp = 100}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_meat02"
RECIPE.name = "Outlands Et Kemeri"
RECIPE.description = "Combine'ın perdesi altında bulunması zor bir ürün ve bulunduğunda hoş karşılanan bir lezzet."
RECIPE.model = "models/n7/vorti_outfit/meat02.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["antlion_skewer"] = 3, ["comp_rivbolts"] = 1, ["comp_stitched_cloth"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_meat02"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 300}, -- full XP
	{level = 10, exp = 150}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_bandanna"
RECIPE.name = "Vortigaunt Bandana"
RECIPE.description = "Gizlilik son derece önemlidir. Kimsenin burada bir Vortigaunt olduğunu bilmesini istemeyiz."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_bandana"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_helmet"
RECIPE.name = "Vortigaunt Kaskı"
RECIPE.description = "Pratiklikten önce koruma. Şansınız yaver giderse, düşman biraz daha yükseğe nişan almaya çalışabilir."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 3, ["comp_rivbolts"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_head_helmet"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 30, exp = 50}, -- half XP
	{level = 35, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_kevlar"
RECIPE.name = "Vortigaunt Kevlar"
RECIPE.description = "Standart bir insan kevlar seti, kabaca vortigaunt kullanımına uygun."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 1, ["comp_steel"] = 3, ["comp_rivbolts"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_vest"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full XP
	{level = 40, exp = 75}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_labcoat2"
RECIPE.name = "Vortigaunt Laboratuvar Önlüğü"
RECIPE.description = "Daha bilimsel bir yaşam tarzı arayan vortigauntlar için bilimsel bir üniforma."
RECIPE.model = "models/willardnetworks/clothingitems/torso_labcoat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_doc2"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_labcoat"
RECIPE.name = "Rozetli Vortigaunt Laboratuvar Önlüğü"
RECIPE.description = "Daha bilimsel bir yaşam tarzı arayan vortigauntlar için bilimsel bir üniforma. Bu varyant bir rozetle birlikte gelir."
RECIPE.model = "models/willardnetworks/clothingitems/torso_labcoat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_scrap"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_doc"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_chef_hat"
RECIPE.name = "Vortigaunt Aşcı Şapkası"
RECIPE.description = "Vortigauntlar, Vortessence ile olan bağlantıları nedeniyle mutfak sanatlarındaki üstün yetenekleriyle tanınırlar. Bir Vortigaunt'un geçici olarak uzman bir şef gibi davranması için geriye kalan tek adım bu aptal şapkalardan birini takmaktır."
RECIPE.model = "models/willardnetworks/clothingitems/head_chefhat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_head_chefhat"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_hoodie"
RECIPE.name = "Vortigaunt Kapüşonlu Üst"
RECIPE.description = "Daha uzun bir boyun için uzatılmış kapüşonlu. Bir vortigaunt'u en zorlu koşullarda bile sıcak tutmak için mükemmeldir."
RECIPE.model = "models/n7/vorti_outfit/hoodie.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 3, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_hoodie"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 70}, -- full XP
	{level = 20, exp = 35}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_trench_coat"
RECIPE.name = "Vortigaunt Kahverengi Trençkot"
RECIPE.description = "Güneşten yanmış, yenilenmiş bir trençkot. Vücudun sıcak ve biraz kuru olmasını sağlar."
RECIPE.model = "models/willardnetworks/clothingitems/torso_refugee_coat.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_stitched_cloth"] = 4, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light3_tc"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_poncho"
RECIPE.name = "Rafine Vortigaunt Panço"
RECIPE.description = "Güvenilir ve sağlam bir örtü, bileşimi tipik insan giysilerinden türetilmiştir. Bol kesim tasarımı ve kullanışlı kesikler rahatlık ve hareket özgürlüğü sağlar."
RECIPE.model = "models/n7/vorti_outfit/light01.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 2, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 50}, -- full XP
	{level = 20, exp = 25}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_covering"
RECIPE.name = "Eğreti Vortigaunt Kaplaması"
RECIPE.description = "Basit, sade bir örtü. Soğuk bir gecede sizi rahat tutmak için iyi, başka bir şey için değil."
RECIPE.model = "models/n7/vorti_outfit/light02.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 2, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_light2"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}

RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_craft_vort_armour"
RECIPE.name = "Vortigaunt Antlion Muhafız Plakası"
RECIPE.description = "Mağlup edilmiş Antlion muhafızlarının kalın zırhlı derilerinden yapılan bu zırh sadece sağlam değil, aynı zamanda deneyimli bir savaşçının işaretidir."
RECIPE.model = "models/n7/vorti_outfit/armor.mdl"
RECIPE.category = "Vortigaunt"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["ing_antlion_meat"] = 8, ["comp_steel"] = 3, ["comp_rivbolts"] = 2, ["comp_fabric"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["vortigaunt_torso_armor"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 300}, -- full XP
	{level = 40, exp = 150}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}

RECIPE:Register()