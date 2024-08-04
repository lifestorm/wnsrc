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
RECIPE.uniqueID = "rec_craft_waterbottle"
RECIPE.name = "Su Şişesi"
RECIPE.description = "Yeniden doldurulabilir plastik bir şişe. Su ile doldurabilirsiniz."
RECIPE.model = "models/props_junk/garbage_plasticbottle002a.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_plastic"] = 4}
RECIPE.result = {["waterbottle"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_watercant"
RECIPE.name = "Su Matarası"
RECIPE.description = "Yeniden doldurulabilir metal bir matara. İçini suyla doldurabilirsiniz."
RECIPE.model = "models/willardnetworks/food/prop_bar_bottle_e.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_iron"] = 2}
RECIPE.result = {["canteen"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 200}, -- full xp
	{level = 10, exp = 100}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_watervalve"
RECIPE.name = "Su Vanası"
RECIPE.description = "Borulardan su çekmek için kullanılır."
RECIPE.model = "models/props/de_nuke/hr_nuke/metal_pipe_001/metal_pipe_001_gauge_valve_low.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_scrap"] = 2, ["comp_plastic"] = 2}
RECIPE.result = {["watervalve"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_tool_flashlight"
RECIPE.name = "El Yapımı El Feneri"
RECIPE.description = "El yapımı el feneri, bilinmeyen karanlığı keşfederken inanılmaz derecede kullanışlıdır."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_electronics"] = 1}
RECIPE.result = {["flashlight"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_syringe"
RECIPE.name = "Şırınga"
RECIPE.description = "Tıbbi amaçlar için yararlı, sıvı benzeri maddeler içerebilen bir şırınga."
RECIPE.model = "models/willardnetworks/skills/syringeammo.mdl"
RECIPE.category = "Aletler"
RECIPE.tool = "tool_toolkit"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_scrap"] = 2}
RECIPE.result = {["comp_syringe"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_lighter"
RECIPE.name = "Plastik Çakmak"
RECIPE.description = "Sigara yakmak için yapılmış ucuz bir plastik çakmak."
RECIPE.model = "models/willardnetworks/cigarettes/lighter.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_plastic"] = 2, ["comp_alcohol"] = 1}
RECIPE.result = {["lighter"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_scissors"
RECIPE.name = "Makas"
RECIPE.description = "Snip, snip, snip!"
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Aletler"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_plastic"] = 1}
RECIPE.result = {["tool_scissors"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_cooking_pot"
RECIPE.name = "Pişirme Tenceresi"
RECIPE.description = "Siyah, demir bir tencere. Ocağın üstüne koy!"
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Aletler"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 2, ["comp_plastic"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_cookingpot"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_razor"
RECIPE.name = "Kuaför aletleri"
RECIPE.description = "Aksi takdirde iç karartıcı bir manzarada yaratıcı ruhlar için bir araç."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_adhesive"] = 1, ["comp_plastic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beard_razor"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full XP
	{level = 10, exp = 25}, -- half XP
	{level = 15, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_kitchen_spoon"
RECIPE.name = "Mutfak Kaşığı"
RECIPE.description = "Güveç yapmak için kullanışlıdır."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_plastic"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_spoon"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_tool_kitchen_knife"
RECIPE.name = "Mutfak Bıçağı"
RECIPE.description = "Kalın, yarı küt bir bıçak. Kesme tahtası veya yüzey üzerindeki yiyecekleri kesmek için kullanılır."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_wood"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_knife"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_frying_pan"
RECIPE.name = "Kızartma Tavası"
RECIPE.description = "Siyah, demir bir kızartma tavası. Yemek pişirmek için iyi."
RECIPE.model = "models/props_c17/metalPot002a.mdl"
RECIPE.category = "Aletler"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_fryingpan"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_kettle"
RECIPE.name = "Su Isıtıcısı"
RECIPE.description = "Mükemmel kaynar su damlatabilen bir su ısıtıcısı."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Aletler"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_scrap"] = 1, ["comp_screws"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_kettle"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_toolkit"
RECIPE.name = "Araç Kiti"
RECIPE.description = "Eşyaları birleştirmek için çeşitli inşaat aletleri içeren küçük bir metal sandık."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_scrap"] = 6, ["comp_adhesive"] = 3, ["comp_plastic"] = 2}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["tool_toolkit"] = 1}
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full XP
	{level = 20, exp = 50}, -- half XP
	{level = 25, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_tool_tinderbox"
RECIPE.name = "Çıra Kutusu"
RECIPE.description = "Kamp ateşi yakmak için bir çıra kutusu."
RECIPE.model = "models/willardnetworks/props/tinderbox.mdl"
RECIPE.category = "Aletler"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_cloth"] = 3, ["comp_adhesive"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["tinderbox"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 100}, -- full xp
	{level = 20, exp = 50}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_mixer"
RECIPE.name = "Kimyasal Karıştırıcı"
RECIPE.description = "Bu, sıvıları veya kimyasalları birbirine karıştırmak için kullanışlı gibi görünüyor. Uyarı etiketinde şöyle yazıyor: Çalışırken açmayın"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Çalışma Tezgahları"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_iron"] = 2, ["comp_screws"] = 4, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_mixer"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 200}, -- full xp
	{level = 20, exp = 100}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_wrench"
RECIPE.name = "İngiliz anahtarı"
RECIPE.description = "Eski bir İngiliz anahtarı. Bunu sandıklamak için kullanabilirim."
RECIPE.model = "models/props_c17/tools_wrench01a.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_rivbolts"] = 1}
RECIPE.result = {["tool_wrench"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 70}, -- full xp
	{level = 30, exp = 35}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_chembench"
RECIPE.name = "Kimya Çalışma Tezgahı Kiti"
RECIPE.description = "Bu çalışma tezgahı, kimyasal bileşenlerin başarılı bir şekilde karıştırılmasını sağlamak için özel olarak tasarlanmıştır."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/chemistrystation02.mdl"
RECIPE.category = "Çalışma Tezgahları"
RECIPE.ingredients = {["comp_steel"] = 3, ["comp_wood"] = 4, ["comp_refined_plastic"] = 2}
RECIPE.result = {["tool_chembench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 300}, -- full xp
	{level = 30, exp = 150}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_oven_rusty"
RECIPE.name = "Paslı Fırın Montaj Kiti"
RECIPE.description = "Berbat görünüyor, berbat, ancak bir süre için herhangi bir pişirme ihtiyacında sizi tatmin edecektir."
RECIPE.model = "models/willardnetworks/skills/oven_shit.mdl"
RECIPE.category = "Çalışma Tezgahları"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_steel"] = 2, ["comp_plastic"] = 4, ["comp_screws"] = 4, ["comp_electronics"] = 2}
RECIPE.result = {["tool_oven_rusty_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 150}, -- full xp
	{level = 30, exp = 75}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_craftingbench"
RECIPE.name = "Üretim Tezgahı Kiti"
RECIPE.description = "Bu çalışma tezgahı, giyim eşyalarının başarılı bir şekilde işlenmesini sağlamak için özel olarak tasarlanmıştır."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/weaponworkbench02.mdl"
RECIPE.category = "Çalışma Tezgahları"
RECIPE.ingredients = {["comp_wood"] = 3, ["comp_iron"] = 1, ["comp_refined_plastic"] = 2, ["comp_rivbolts"] = 3}
RECIPE.result = {["tool_craftingbench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 180}, -- full xp
	{level = 30, exp = 90}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_metalbench"
RECIPE.name = "Metal Çalışma Tezgahı Kiti"
RECIPE.description = "Bu çalışma tezgahı, silah veya benzeri şeylerin başarılı bir şekilde üretilmesini sağlamak için özel olarak tasarlanmıştır."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl"
RECIPE.category = "Çalışma Tezgahları"
RECIPE.ingredients = {["comp_steel"] = 4, ["comp_wood"] = 4, ["comp_refined_plastic"] = 4, ["tool_craftingbench_assembly"] = 1}
RECIPE.result = {["tool_metalbench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 25
RECIPE.experience = {
	{level = 25, exp = 600}, -- full xp
	{level = 40, exp = 300}, -- half xp
	{level = 50, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_repair"
RECIPE.name = "Onarım Kaplaması"
RECIPE.description = "Çeşitli giysilerdeki hasarlı zırhları onarmak için kullanılan el yapımı onarım kaplaması."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Aletler"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_iron"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["tool_repair"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full XP
	{level = 40, exp = 50}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_breacher"
RECIPE.name = "Combine Kilit Kırıcı"
RECIPE.description = "Combine kilitlerini kırmak için üzerlerine yerleştirilen el yapımı bir cihaz."
RECIPE.model = "models/transmissions_element120/charger_attachment.mdl"
RECIPE.category = "Aletler"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_steel"] = 1, ["comp_refined_plastic"] = 1, ["comp_screws"] = 1, ["comp_electronics"] = 2}
RECIPE.result = {["lockbreacher"] = 1}
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 0}, -- full XP
	{level = 50, exp = 0}, -- half XP
	{level = 55, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_refill_zippo_lighter"
RECIPE.name = "Yedek Zippo Çakmak"
RECIPE.description = "Sigara yakmak için üretilmiş kaliteli bir metal çakmak."
RECIPE.model = "models/willardnetworks/cigarettes/zippo.mdl"
RECIPE.category = "Aletler"
RECIPE.ingredients = {["zippolighter"] = 1, ["comp_alcohol"] = 1}
RECIPE.result = {["zippolighter"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 50}, -- full xp
	{level = 10, exp = 25}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()
