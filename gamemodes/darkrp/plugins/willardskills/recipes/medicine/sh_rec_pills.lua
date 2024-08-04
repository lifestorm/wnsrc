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
RECIPE.name = "Pilules vertes de base"
RECIPE.description = "Une petite pilule verte basique. Cela vous fait vous sentir... un peu plus rapide."
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_greencompound"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_green"] = 1}
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
RECIPE.uniqueID = "rec_basicblue"
RECIPE.name = "Pilules bleues de base"
RECIPE.description = "Une petite pilule bleue basique. Cela vous fait vous sentir... un peu plus intelligent."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_bluecompound"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_blue"] = 1}
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
RECIPE.uniqueID = "rec_basicred"
RECIPE.name = "Pilules rouges de base"
RECIPE.description = "Une petite pilule rouge basique. Ça te fait te sentir... un peu plus fort"
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_redcompound"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_red"] = 1}
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
RECIPE.uniqueID = "rec_basicyellow"
RECIPE.name = "Pilules jaunes de base"
RECIPE.description = "Une petite pilule jaune basique. Votre vision semble s'être légèrement améliorée."
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_yellowcompound"] = 1, ["ing_vegetable_pack"] = 1}
RECIPE.result = {["basic_yellow"] = 1}
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

RECIPE.uniqueID = "rec_improvedred"
RECIPE.name = "Pilules rouges améliorées"
RECIPE.description = "Une petite pilule rouge. Cela vous fait vous sentir plus fort."
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_refinedchemical"] = 1, ["basic_red"] = 1}
RECIPE.result = {["improved_red"] = 1}
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
RECIPE.uniqueID = "rec_improvedgreen"
RECIPE.name = "Pilules vertes améliorées"
RECIPE.description = "Une petite pilule verte. Cela vous fait vous sentir plus vite."
RECIPE.model = "models/willardnetworks/skills/pills2.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_refinedchemical"] = 1, ["basic_green"] = 1}
RECIPE.result = {["improved_green"] = 1}
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
RECIPE.uniqueID = "rec_improvedblue"
RECIPE.name = "Pilules bleues améliorées"
RECIPE.description = "Une petite pilule bleue. Cela vous fait vous sentir plus intelligent."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_refinedchemical"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["improved_blue"] = 1}
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
RECIPE.uniqueID = "rec_improvedyellow"
RECIPE.name = "Pilules jaunes améliorées"
RECIPE.description = "Une petite pilule jaune. Vous pouvez soudainement voir beaucoup plus clairement."
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["comp_refinedchemical"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["improved_yellow"] = 1}
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
RECIPE.uniqueID = "rec_qualityred"
RECIPE.name = "Pilules rouges de qualité"
RECIPE.description = "Une pastille rouge intéressante, son goût beaucoup plus raffiné qu'auparavant. Cela vous fait vous sentir super fort."
RECIPE.model = "models/willardnetworks/skills/pills4.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_red"] = 1}
RECIPE.result = {["quality_red"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 100}, -- full xp
	{level = 45, exp = 50}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualitygreen"
RECIPE.name = "Pilule verte de qualité"
RECIPE.description = "Une pilule verte intéressante, son goût beaucoup plus raffiné qu'auparavant. Cela vous fait vous sentir super vite."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_green"] = 1}
RECIPE.result = {["quality_green"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 100}, -- full xp
	{level = 45, exp = 50}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualityblue"
RECIPE.name = "Pilules bleues de qualité"
RECIPE.description = "Une pilule bleue intéressante, son goût beaucoup plus raffiné qu'auparavant. Cela vous fait vous sentir super intelligent... la connaissance se précipite dans l'esprit."
RECIPE.model = "models/willardnetworks/skills/pills5.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_blue"] = 1}
RECIPE.result = {["quality_blue"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 100}, -- full xp
	{level = 45, exp = 50}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_qualityyellow"
RECIPE.name = "Pilules jaunes de qualité"
RECIPE.description = "Une pastille jaune intéressante, son goût beaucoup plus raffiné qu'auparavant. Cela améliore beaucoup votre vision... est-ce une araignée sur mon mur ?"
RECIPE.model = "models/willardnetworks/skills/pills3.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["comp_purifier"] = 1, ["improved_yellow"] = 1}
RECIPE.result = {["quality_yellow"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 100}, -- full xp
	{level = 45, exp = 50}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_orangepill"
RECIPE.name = "Pilules oranges"
RECIPE.description = "Cette pilule vous fait apparemment vous sentir un peu plus fort et votre vision plus nette."
RECIPE.model = "models/willardnetworks/skills/pills7.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["basic_red"] = 1, ["basic_yellow"] = 1}
RECIPE.result = {["orange_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 60}, -- full xp
	{level = 30, exp = 30}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_purplepill"
RECIPE.name = "Pilules violettes"
RECIPE.description = "Cette pilule vous fait apparemment penser et courir plus vite."
RECIPE.model = "models/willardnetworks/skills/pills6.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_mixer"
RECIPE.ingredients = {["basic_green"] = 1, ["basic_blue"] = 1}
RECIPE.result = {["purple_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 60}, -- full xp
	{level = 30, exp = 30}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()

RECIPE.uniqueID = "medpill_dark"
RECIPE.name = "Pilules sombres"
RECIPE.description = "Cette étrange pilule fabriquée via une voie chimique complexe stimule apparemment tous vos sens. Il y a une sorte de montée d'adrénaline.."
RECIPE.model = "models/willardnetworks/skills/pills8.mdl"
RECIPE.category = "Drogues"
RECIPE.subcategory = "Boosteurs"
RECIPE.station = "tool_chembench"
RECIPE.ingredients = {["orange_pill"] = 1, ["purple_pill"] = 1, ["adrenaline"] = 1}
RECIPE.result = {["dark_pill"] = 1}
RECIPE.hidden = false
RECIPE.skill = "medicine"
RECIPE.level = 35
RECIPE.experience = {
	{level = 35, exp = 150}, -- full xp
	{level = 45, exp = 75}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()