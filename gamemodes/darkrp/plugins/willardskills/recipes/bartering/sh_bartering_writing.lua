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
RECIPE.uniqueID = "bartering_writing_pin"
RECIPE.name = "İğne"
RECIPE.description = "Duvarlara kağıt asmak için kullanılan bir iğne."
RECIPE.model = "models/items/crossbowrounds.mdl"
RECIPE.category = "Yazma"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 2
RECIPE.result = {["pin"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_paper"
RECIPE.name = "Kağıt"
RECIPE.description = "Üzerine yazılacak bir kağıt."
RECIPE.model = "models/props_c17/paper01.mdl"
RECIPE.category = "Yazma"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 3
RECIPE.result = {["paper"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_notepad"
RECIPE.name = "Not Defteri"
RECIPE.description = "Yazmak için mavi bir not defteri."
RECIPE.model = "models/props_lab/clipboard.mdl"
RECIPE.category = "Yazma"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["notepad"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_book"
RECIPE.name = "Boş Kitap"
RECIPE.description = "Boş bir kitap, hazır ve doldurmanızı bekliyor."
RECIPE.model = "models/willardnetworks/misc/book.mdl"
RECIPE.category = "Yazma"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 10
RECIPE.result = {["book"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_writing_ink"
RECIPE.name = "Siyah Mürekkep"
RECIPE.description = "Siyah mürekkep yazıcı kartuşu."
RECIPE.model = "models/gibs/metal_gib2.mdl"
RECIPE.category = "Yazma"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 5
RECIPE.result = {["black_ink"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "bartering_audiobook_reading"
RECIPE.name = "[Ses Oynatıcı] Okumayı Öğrenin"
RECIPE.description = "Bu rustik cihazı dinlemek okuma özelliğinizi artıracaktır."
RECIPE.model = "models/props_lab/reciever01d.mdl"
RECIPE.category = "Yazma"
RECIPE.hidden = false
RECIPE.skill = "bartering"
RECIPE.cost = 30
RECIPE.result = {["audiobook_reading"] = 1}
RECIPE.buyAmount = 1 -- amount TEXT
RECIPE:Register()