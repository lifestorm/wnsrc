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
RECIPE.uniqueID = "bartering_tool_spoon"
RECIPE.name = "Mutfak Kaşığı"
RECIPE.description = "Güveç yapmak için kullanışlıdır."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 8
RECIPE.result = {["tool_spoon"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_kettle"
RECIPE.name = "Su Isıtıcısı"
RECIPE.description = "Mükemmel kaynar su akıtabilen bir su ısıtıcısı."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["tool_kettle"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_lighter"
RECIPE.name = "Plastik Çakmak"
RECIPE.description = "Sigara yakmak için yapılmış ucuz bir plastik çakmak."
RECIPE.model = "models/willardnetworks/cigarettes/lighter.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["lighter"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_knife"
RECIPE.name = "Mutfak Bıçağı"
RECIPE.description = "Kalın, yarı kör bir bıçak. Kesme tahtasında veya yüzeyde yiyecekleri kesmek için kullanılır."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["tool_knife"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_scissors"
RECIPE.name = "Makas"
RECIPE.description = "Kırp, kırp, kırp!"
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["tool_scissors"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_syringe"
RECIPE.name = "Şırınga"
RECIPE.description = "Tıbbi amaçlar için yararlı olan sıvı benzeri maddeler içerebilen bir şırınga."
RECIPE.model = "models/willardnetworks/skills/syringeammo.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["comp_syringe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_cookingpot"
RECIPE.name = "Tencere"
RECIPE.description = "Siyah, demir bir tencere. Sobaya koy!"
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_cookingpot"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_fryingpan"
RECIPE.name = "Kızartma tavası"
RECIPE.description = "Siyah, demir bir tava. Yemek pişirmek için iyi."
RECIPE.model = "models/props_c17/metalPot002a.mdl" -- This model is wrong. Use the hl2 frying pan model plz
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 14
RECIPE.result = {["tool_fryingpan"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_razor"
RECIPE.name = "Kuaför Araçları"
RECIPE.description = "Yaratıcı ruhlar için bir araç."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 12
RECIPE.result = {["beard_razor"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_wrench"
RECIPE.name = "İngiliz Anahtarı"
RECIPE.description = "Eski bir İngiliz anahtarı."
RECIPE.model = "models/props_c17/tools_wrench01a.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["tool_wrench"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_toolkit"
RECIPE.name = "Araç Seti"
RECIPE.description = "Eşyaları monte etmek için çeşitli inşaat aletleri içeren küçük bir metal kasa."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["tool_toolkit"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_coffeemachine"
RECIPE.name = "Kahve Makinesi"
RECIPE.description = "Sabah vaktinde ihtiyacınız olan tek şey bir kahve makinesidir."
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 45
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "tool_oven_assembly"
RECIPE.name = "Fırın Montaj Kiti"
RECIPE.description = "Bu ahşap paket, bir dizi talimatın yanı sıra, Pişirme aparatı için çok sayıda farklı bileşen parçası içerir."
RECIPE.model = "models/props_junk/wood_crate001a.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 80
RECIPE.result = {["tool_oven_assembly"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_grouplock"
RECIPE.name = "Grup Kilidi"
RECIPE.description = "Kapılara uygulanan metal bir aparat. Bir grubun çalışması için bir grup gerekir."
RECIPE.model = "models/willardnetworks/props_combine/wn_combine_lock.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 80
RECIPE.result = {["grouplock"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

-- Storage

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_lock"
RECIPE.name = "Konteyner Kilidi"
RECIPE.description = "Kullanıldığında bir kapsayıcıda rastgele bir parola ayarlar."
RECIPE.model = "models/props_wasteland/prison_padlock001a.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["cont_lock_t1"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_satchel"
RECIPE.name = "El Çantası"
RECIPE.description = "Kalçana dayanan küçük bir çanta."
RECIPE.model = "models/willardnetworks/clothingitems/satchel.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 70
RECIPE.result = {["smallbag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_suitcase"
RECIPE.name = "Bavul"
RECIPE.description = "Taşımayı istemediğiniz her şeyi taşımaya hazır küçük bir bavul."
RECIPE.model = "models/weapons/w_suitcase_passenger.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 70
RECIPE.result = {["suitcase"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_container_small"
RECIPE.name = "Küçük Konteyner"
RECIPE.description = "5x3 boyutlu konteyner. Bu öğeyi hazırladıktan sonra bu kapsayıcıyı ayarlamak için bir yöneticiyle iletişime geçin. Parola ayarlamak için bir kapsayıcı kilidi öğesine ihtiyacı var."
RECIPE.model = "models/props_lab/filecabinet02.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 90
RECIPE.result = {["container_small_dummy"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_mixer"
RECIPE.name = "Mikser"
RECIPE.description = "Bu, sıvıları veya kimyasalları bir araya getirmek için yararlı görünüyor. Uyarı etiketinde şöyle yazıyor: Çalışırken açmayın"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 180
RECIPE.result = {["tool_mixer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_backpack"
RECIPE.name = "Sırt Çantası"
RECIPE.description = "Üzerinde Combine damgası olan küçük bir sırt çantası."
RECIPE.model = "models/willardnetworks/clothingitems/backpack.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["largebag"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_storage_safe"
RECIPE.name = "Konteyner Güvenli"
RECIPE.description = "Eşyalarınızı içeride tutmak için kırılmaz bir kasa. (Konteyner limitinin üstünde 2 kasanız olabilir.)"
RECIPE.model = "models/willardnetworks/safe.mdl"
RECIPE.category = "Aletler & Depolama"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 850
RECIPE.result = {["container_safe"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()