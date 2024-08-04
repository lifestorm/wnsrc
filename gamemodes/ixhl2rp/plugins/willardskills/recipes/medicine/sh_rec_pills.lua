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
RECIPE.uniqueID = "rec_basicgreen"
RECIPE.name = "Zielone tabletki"
RECIPE.description = "Niewielkich rozmiarów zielona tabletka. Dzięki niej jesteś szybszy."
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_green"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_basicblue"
RECIPE.name = "Niebieskie tabletki"
RECIPE.description = "Niewielkich rozmiarów niebieska tabletka. Dzięki niej jesteś inteligentniejszy."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_blue"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_basicred"
RECIPE.name = "Czerwone Tabletki"
RECIPE.description = "Niewielkich rozmiarów czerwona tabletka. Dzięki niej jesteś silniejszy."
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_red"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_basicyellow"
RECIPE.name = "Żółte Tabletki"
RECIPE.description = "Niewielkich rozmiarów żółta tabletka. Dzięki niej twój wzrok uległ niewielkiej poprawie."
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_yellow"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_improvedred"
RECIPE.name = "Czerwone tabletki lepszej jakości."
RECIPE.description = "Niewielkich rozmiarów czerwona tabletka. Dzięki niej jesteś silniejszy."
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_red"] = 1}
RECIPE.result = {["improved_red"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_improvedgreen"
RECIPE.name = "Zielone tabletki lepszej jakości"
RECIPE.description = "Niewielkich rozmiarów zielona tabletka. Dzięki niej jesteś szybszy"
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_green"] = 1}
RECIPE.result = {["improved_green"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_improvedblue"
RECIPE.name = "Niebieskie tabletki lepszej jakości"
RECIPE.description = "Niewielkich rozmiarów niebieska tabletka. Dzięki niej jesteś inteligentniejszy."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["improved_blue"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_improvedyellow"
RECIPE.name = "Żółte tabletki lepszej jakości"
RECIPE.description = "Niewielkich rozmiarów żółta tabletka. Dzięki niej twój wzrok uległ znaczącej poprawie."
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_chemcomp"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["improved_yellow"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 160}, -- full xp
	{level = 30, exp = 80}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualityred"
RECIPE.name = "Czerwone tabletki doskonałej jakości"
RECIPE.description = "Ciekawa czerwona tabletka, jej smak jest bardziej wyrafinowany niż dotychczas. Dzięki niej można poczuć się super silnym."
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_red"] = 1}
RECIPE.result = {["quality_red"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualitygreen"
RECIPE.name = "Zielone tabletki doskonałej jakości"
RECIPE.description = "Ciekawa zielona tabletka, jej smak jest bardziej wyrafinowany niż dotychczas. Dzięki niej jest się o wiele szybszym."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_green"] = 1}
RECIPE.result = {["quality_green"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualityblue"
RECIPE.name = "Niebieskie tabletki doskonałej jakości"
RECIPE.description = "Ciekawa niebieska tabletka, jej smak jest bardziej wyrafinowany niż dotychczas. Dzięki niej jesteś super inteligentny... wiedza po prostu pędzi przez umysł."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_blue"] = 1}
RECIPE.result = {["quality_blue"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualityyellow"
RECIPE.name = "Żółte tabletki doskonałej jakości"
RECIPE.description = "Ciekawa żółta pigułka, jej smak jest bardziej wyrafinowany niż dotychczas. Doskonale wyostrza percepcję wzrokową."
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_yellow"] = 1}
RECIPE.result = {["quality_yellow"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 250}, -- full xp
	{level = 45, exp = 125}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_orangepill"
RECIPE.name = "Pomarańczowe tabletki"
RECIPE.description = "Ta tabletka pozornie sprawia, że czujesz się nieco silniejszy, a twój wzrok jest bardziej ostry."
RECIPE.model = "models/willardnetworks/skills/pills7.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["basic_red"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["orange_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 180}, -- full xp
	{level = 30, exp = 90}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_purplepill"
RECIPE.name = "Fioletowe tabletki"
RECIPE.description = "Ta tabletka pozornie sprawia, że szybciej myślisz i biegasz."
RECIPE.model = "models/willardnetworks/skills/pills6.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["basic_green"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["purple_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 180}, -- full xp
	{level = 30, exp = 90}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "medpill_dark"
RECIPE.name = "Czarne tabletki"
RECIPE.description = "Ta tabletka pozornie wzmacnia wszystkie twoje zmysły."
RECIPE.model = "models/willardnetworks/skills/pills8.mdl"
RECIPE.category = "Dopalacze"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["orange_pill"] = 1, ["purple_pill"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["dark_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 300}, -- full xp
	{level = 45, exp = 150}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()