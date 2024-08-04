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
RECIPE.name = "Pâte artificielle modifiée"
RECIPE.description = "Pâte artificielle mélangée avec un peu d'acide de batterie de voiture pour faire bonne mesure."
RECIPE.model = "models/props_lab/jar01b.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["proc_paste"] = 1, ["ing_protein"] = 1, ["comp_unrefinedchemical"] = 1}
RECIPE.result = {["drug_artificialfun"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 70}, -- full xp
	{level = 20, exp = 35}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_blueberry"
RECIPE.name = "Blueberry en liquide"
RECIPE.description = "Un flacon étrange rempli de liquide bleu. Il a le goût d'un jus de baies mais sent dégoûtant."
RECIPE.model = "models/willardnetworks/skills/chemical_flask4.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_bluecompound"] = 1, ["comp_charcoal"] = 1, ["fruit_berries"] = 1}
RECIPE.result = {["drug_blueberry"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 70}, -- full xp
	{level = 20, exp = 35}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_ozz"
RECIPE.name = "Potion d'Ozz"
RECIPE.description = "Liquide étrange dans un bocal en verre, qui à l'ouverture a une odeur forte et étrange. Il a le goût de l'essence mais vous fait vous sentir intelligent et perspicace."
RECIPE.model = "models/props_junk/glassjug01.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_greencompound"] = 1, ["disinfectant_bottle"] = 1}
RECIPE.result = {["drug_ozz"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 70}, -- full xp
	{level = 20, exp = 35}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_bobmix"
RECIPE.name = "Mélange montagnard"
RECIPE.description = "Que se passerait-il si vous preniez le distillat de chaque soda de Richard (publiquement) disponible, les mélangeiez et injectiez le produit résultant directement dans votre bras ? Les scientifiques ont dit 'Rien de bon', tandis que les Crackhead dans les bidonvilles ont dit 'tu montes'. Allez prouver que l'un ou l'autre a raison."
RECIPE.model = "models/willardnetworks/food/bobdrinks_can.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["drink_bobfizz"] = 1, ["drink_bobgrape"] = 1, ["drink_boboriginal"] = 1}
RECIPE.result = {["drug_bobmix"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 70}, -- full xp
	{level = 20, exp = 35}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_darkshot"
RECIPE.name = "Shot Obscur"
RECIPE.description = "Du sang mélangé à divers médicaments, en le consommant, vous pouvez ressentir une sensation de brûlure dans la gorge."
RECIPE.model = "models/willardnetworks/skills/medjar.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_bloodsyringe"] = 1, ["basic_red"] = 1, ["comp_unrefinedchemical"] = 1, ["drink_proc_whiskey"] = 1}
RECIPE.result = {["drug_darkshot"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "rec_demon"
RECIPE.name = "La Fourmi Rouge"
RECIPE.description = "Une seringue remplie de liquide rouge foncé à l'intérieur, lors de l'injection, vous pouvez ressentir une sensation de brûlure extrême à l'endroit de l'injection."
RECIPE.model = "models/willardnetworks/skills/medx.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_syringe"] = 1, ["painkillers"] = 1, ["comp_redcompound"] = 1}
RECIPE.result = {["drug_demon"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full xp
	{level = 30, exp = 40}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_speed"
RECIPE.name = "Stimulant"
RECIPE.description = "Un paquet écrasé de pilules mélangées dans une canette. Vous donne le sentiment d'être rapide."
RECIPE.model = "models/willardnetworks/skills/medx.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["crafting_water"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["drug_speed"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full xp
	{level = 30, exp = 40}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_thirdeye"
RECIPE.name = "Le 3ème oeil"
RECIPE.description = "Un liquide blanc à l'intérieur de la seringue, qui après utilisation, pourrait vous faire ressentir une conscience accrue de l'environnement."
RECIPE.model = "models/willardnetworks/skills/pyscho.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_syringe"] = 1, ["ing_coffee_powder"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["drug_thirdeye"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 80}, -- full xp
	{level = 30, exp = 40}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_transhumano"
RECIPE.name = "Le Transhumain"
RECIPE.description = "Une pilule raffinée qui vous fait vous sentir ultra-fort, certains pensent que c'est ce qu'utilisent les OTAs."
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_bluecompound"] = 1, ["bloodstabilizer"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["drug_transhumano"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 100}, -- full xp
	{level = 45, exp = 50}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_xp"
RECIPE.name = "Morphine alcoolisée"
RECIPE.description = "Liquide brun dans une vieille bouteille, en la sentant, vous pouvez vous sentir vraiment léger. Ça a le goût du vieux sirop contre la toux."
RECIPE.model = "models/willardnetworks/food/wine4.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["morphine"] = 2, ["drink_white_wine"] = 1, ["orange_pill"] = 1}
RECIPE.result = {["drug_xp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 100}, -- full xp
	{level = 45, exp = 50}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_rave"
RECIPE.name = "Rave"
RECIPE.description = "Une drogue de fête hallucinogène conçue pour induire la sensation puissante d'être dans une rave."
RECIPE.model = "models/willardnetworks/skills/medx.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Hallucinogènes"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["drug_demon"] = 1, ["drug_thirdeye"] = 1, ["drug_speed"] = 1}
RECIPE.result = {["rave"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 50
RECIPE.experience = {
	{level = 40, exp = 300}, -- full xp
	{level = 45, exp = 150}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()