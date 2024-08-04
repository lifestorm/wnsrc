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
RECIPE.uniqueID = "rec_artfun"
RECIPE.name = "Artificial Fun"
RECIPE.description = "Zmiksowana sztuczna pasta z odrobiną kwasu z akumulatora samochodowego."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["proc_paste"] = 1, ["ing_protein"] = 1, ["comp_chemicals"] = 1}
RECIPE.result = {["drug_artificialfun"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 210}, -- full xp
	{level = 20, exp = 105}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_blueberry"
RECIPE.name = "Blue Berry"
RECIPE.description = "Dziwna fiolka wypełniona niebieskim płynem, smakuje jak sok z jagód, ale obrzydliwie pachnie."
RECIPE.model = "models/willardnetworks/skills/chemical_flask4.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["comp_charcoal"] = 1, ["fruit_berries"] = 1}
RECIPE.result = {["drug_blueberry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 210}, -- full xp
	{level = 20, exp = 105}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ozz"
RECIPE.name = "Eliksir Ozz'a"
RECIPE.description = "Dziwny płyn w szklanym słoiku, po otwarciu ma mocny i dziwny zapach. Smakuje jak benzyna, ale sprawia, że czujesz się mądrzejszy i bardziej spostrzegawczy."
RECIPE.model = "models/props_junk/glassjug01.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["disinfectant_bottle"] = 1}
RECIPE.result = {["drug_ozz"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 210}, -- full xp
	{level = 20, exp = 105}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bobmix"
RECIPE.name = "Bob's Trail Mix"
RECIPE.description = "Zastanawiasz się co by się stało, gdybyś wziął destylat każdego dostępnego (publicznie) napoju bobowego, zmieszał go ze sobą i wstrzyknął powstały produkt prosto w ramię? Sprawdź sam, śmiało."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_bobfizz"] = 1, ["drink_bobgrape"] = 1, ["drink_boboriginal"] = 1}
RECIPE.result = {["drug_bobmix"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 210}, -- full xp
	{level = 20, exp = 105}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_darkshot"
RECIPE.name = "Dark Shot"
RECIPE.description = "Krew zmieszana z różnymi lekami, po spożyciu której możesz odczuć pieczenie w gardle."
RECIPE.model = "models/willardnetworks/skills/medjar.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_bloodsyringe"] = 1, ["basic_red"] = 1, ["comp_chemicals"] = 1, ["drink_proc_whiskey"] = 1}
RECIPE.result = {["drug_darkshot"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 240}, -- full xp
	{level = 30, exp = 150}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_demon"
RECIPE.name = "Demon's Bees"
RECIPE.description = "Strzykawka wypełniona ciemnoczerwonym płynem w środku, po wstrzyknięciu możesz poczuć ekstremalne uczucie pieczenia w miejscu wstrzyknięcia."
RECIPE.model = "models/willardnetworks/skills/medx.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_syringe"] = 1, ["painkillers"] = 1, ["comp_chemcomp"] = 1}
RECIPE.result = {["drug_demon"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 240}, -- full xp
	{level = 30, exp = 120}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_speed"
RECIPE.name = "Speed"
RECIPE.description = "Rozgniecione opakowanie tabletek zmieszane w puszce. Daje poczucie bycia szybszym niż zazwyczaj."
RECIPE.model = "models/props_junk/popcan01a.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["crafting_water"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["drug_speed"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 240}, -- full xp
	{level = 30, exp = 120}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_thirdeye"
RECIPE.name = "The Third Eye"
RECIPE.description = "Strzykawka wypełniona białym płynem, po użyciu od razu możesz poczuć, że jesteś o wiele bardziej spostrzegawczy."
RECIPE.model = "models/willardnetworks/skills/pyscho.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_syringe"] = 1, ["ing_coffee_powder"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["drug_thirdeye"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 240}, -- full xp
	{level = 30, exp = 120}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_transhumano"
RECIPE.name = "Transhumano"
RECIPE.description = "Wyrafinowana pigułka, która sprawia, że czujesz się ultra silny, niektórzy wierzą, że to właśnie jej używają żołnierze Overwatch."
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["bloodstabilizer"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["drug_transhumano"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_xp"
RECIPE.name = "XP"
RECIPE.description = "Brązowy płyn w starej butelce, po powąchaniu go można poczuć się naprawdę lekko. Smakuje jak stary syrop na kaszel."
RECIPE.model = "models/willardnetworks/food/wine4.mdl"
RECIPE.category = "Narkotyki"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["morphine"] = 2, ["bottle_wine_white"] = 1, ["orange_pill"] = 1}
RECIPE.result = {["drug_xp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()