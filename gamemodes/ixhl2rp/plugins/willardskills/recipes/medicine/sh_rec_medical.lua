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
RECIPE.name = "Butelka ze środkiem dezynfekacyjnym"
RECIPE.description = "Butelka środka dezynfekującego, używanego do oczyszczania ran z bakterii."
RECIPE.model = "models/willardnetworks/props/disinfectant.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Bandaż"
RECIPE.description = "Rolka bandaży sanitarnych. Stosowana do zatamowania krwawienia."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Bandaż"
RECIPE.description = "Rolka bandaża z tkaniny oblana alkoholem."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Zdezynfekowany bandaż"
RECIPE.description = "Rolka zdezynfekowanych opatrunków sanitarnych. Stosowany do tamowania krwawienia i oczyszczania ran."
RECIPE.model = "models/stuff/bandages.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Środki przeciwbólowe"
RECIPE.description = "Opakowanie środków przeciwbólowych."
RECIPE.model = "models/willardnetworks/skills/pills1.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Stabilizator krwi"
RECIPE.description = "Strzykawka wypełniona czerwoną mieszanką i środkiem przeciwbólowym. Ma właściwości regenerujące."
RECIPE.model = "models/willardnetworks/skills/stimpak.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Torebka z krwią"
RECIPE.description = "Plastikowa torba z przymocowanym wężem i igłą. Wygląda na to, że jest w niej krew."
RECIPE.model = "models/willardnetworks/skills/bloodbag.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Apteczka pierwszej pomocy"
RECIPE.description = "Zestaw medyczny zawierający niezbędne narzędzia i leki służące do udzielenia podstawowej pomocy medycznej w przypadku nagłych wypadków lub urazów. "
RECIPE.model = "models/willardnetworks/skills/medkit.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Adrenalina"
RECIPE.description = "Strzykawka wypełniona adrenaliną. Zapewnia chwilową ulgę w ostrych bólach."
RECIPE.model = "models/willardnetworks/skills/adrenaline.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Morfina"
RECIPE.description = "Silny lek opioidowy stosowany w medycynie do łagodzenia bólu ostrych i przewlekłych oraz objawów duszności w chorobach nowotworowych i terminalnych."
RECIPE.model = "models/willardnetworks/skills/adrenaline.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Zestaw chirurgiczny"
RECIPE.description = "Kompletny zestaw narzędzi i przyrządów chirurgicznych, zapakowany w praktyczną torbę, służący do przeprowadzania operacji w warunkach szpitalnych lub w terenie."
RECIPE.model = "models/willardnetworks/skills/surgicalkit.mdl"
RECIPE.category = "Medycyna"
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
RECIPE.name = "Mikstura z wymiaru Xen"
RECIPE.description = "Wysoce egzotyczna, obca substancja stworzona z rzadkich składników Xen, przynosząca niesamowitą regenerację organiczną."
RECIPE.model = "models/willardnetworks/props/xenpotion3.mdl"
RECIPE.category = "Medycyna"
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
