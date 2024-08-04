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
RECIPE.uniqueID = "bartering_tool_request"
RECIPE.name = "Talep Cihazı"
RECIPE.description = "Yuvarlatılmış köşelere sahip küçük bir cihaz, üzerinde iki düğme bulunuyor. Üzerinde küçük bir Combine logosu görünüyor."
RECIPE.model = "models/gibs/shield_scanner_gib1.mdl"
RECIPE.category = "Elektronik"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 15
RECIPE.result = {["request_device"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_flashlight"
RECIPE.name = "El Feneri"
RECIPE.description = "Bilinmeyen karanlığı keşfederken inanılmaz derecede kullanışlı."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Elektronik"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 25
RECIPE.result = {["flashlight"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tv"
RECIPE.name = "Televizyon"
RECIPE.description = "Propaganda yayınlarını izlemek için rejim tarafından verilen bir televizyon."
RECIPE.model = "models/props_c17/tv_monitor01.mdl"
RECIPE.category = "Elektronik"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 50
RECIPE.result = {["television"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_tool_coffeemachine"
RECIPE.name = "Kahve Makinesi"
RECIPE.description = "Ayakkabılarınıza damlayan mükemmelik gerektiğinde ihtiyacınız olan tek şey bir kahve makinesi."
RECIPE.model = "models/willardnetworks/skills/coffee_machine.mdl"
RECIPE.category = "Elektronik"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 55
RECIPE.result = {["tool_coffeemachine"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_cit_computer"
RECIPE.name = "Bilgisayar"
RECIPE.description = "Notlara erişim sağlayan, düşük kaliteli bir rejim işletim sistemi kullanan bir bilgisayar, mağazalar için kullanışlı bir araç."
RECIPE.model = "models/willardnetworks/props/willard_computer.mdl"
RECIPE.category = "Elektronik"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["cit_computer"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_elec_musicradio"
RECIPE.name = "Hayırsever Radyo"
RECIPE.description = "Yalnızca resmi Birlik Onaylı radyo istasyonlarını ayarlayabilen tunerli, üretilmiş bir radyo."
RECIPE.model = "models/props_lab/citizenradio.mdl"
RECIPE.category = "Elektronik"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 150
RECIPE.result = {["musicradio_cmb"] = 1}
RECIPE.buyAmount = 1
RECIPE:Register()
