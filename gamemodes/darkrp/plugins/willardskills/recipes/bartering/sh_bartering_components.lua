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
RECIPE.uniqueID = "bartering_comp_adhesive"
RECIPE.name = "Yapıştırıcı"
RECIPE.description = "Nesneleri birbirine yapıştırmak için bir yapıştırıcı. Çok yapışkan."
RECIPE.model = "models/willardnetworks/props/glue.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["comp_adhesive"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_wood"
RECIPE.name = "Hurda Ahşap"
RECIPE.description = "Kırık görünen ama kullanışlı tahta çubuklar."
RECIPE.model = "models/Gibs/wood_gib01a.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["comp_wood"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_screws"
RECIPE.name = "Çivi Kutusu"
RECIPE.description = "Çivi içeren bir kutu. Biraz paslı görünüyorlar."
RECIPE.model = "models/willardnetworks/skills/screws.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["comp_screws"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_scraps"
RECIPE.name = "Metal Hurdalar"
RECIPE.description = "İşçilik için yararlı olabilecek metal hurda parçaları."
RECIPE.model = "models/gibs/manhack_gib01.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 4
RECIPE.result = {["comp_scrap"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_electronics"
RECIPE.name = "Elektronik Parçalar"
RECIPE.description = "Hurdaya çıkarılmış elektronik parçalar. Bunların ne için kullanıldığını merak ediyor musunuz?"
RECIPE.model = "models/willardnetworks/skills/circuit.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["comp_electronics"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_comp_cloth"
RECIPE.name = "Kumaş Paçavralar"
RECIPE.description = "Bir parça kumaş paçavra, işçilik için kullanılabilir."
RECIPE.model = "models/willardnetworks/skills/cloth.mdl"
RECIPE.category = "Bileşenler"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["comp_cloth"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()