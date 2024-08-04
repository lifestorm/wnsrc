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
RECIPE.name = "Bouteille d'eau"
RECIPE.description = "Une bouteille en plastique rechargeable. Vous pouvez le remplir d'eau."
RECIPE.model = "models/props/cs_office/water_bottle.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_scissors"
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
RECIPE.uniqueID = "rec_craft_watervalve"
RECIPE.name = "Valve d'eau"
RECIPE.description = "Utilisé pour capter l'eau des tuyaux."
RECIPE.model = "models/props/de_nuke/hr_nuke/metal_pipe_001/metal_pipe_001_gauge_valve_low.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.ingredients = {["comp_metal"] = 2, ["comp_plastic"] = 2}
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
RECIPE.name = "Lampe de poche artisanale"
RECIPE.description = "Lampe de poche artisanale, incroyablement utile pour explorer l'obscurité inconnue."
RECIPE.model = "models/willardnetworks/skills/flashlight.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.ingredients = {["comp_plastic"] = 3, ["comp_electronics"] = 2, ["comp_glass"] = 3}
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
RECIPE.name = "Seringue"
RECIPE.description = "Une seringue capable de contenir des substances de type liquide, utiles à des fins médicinales."
RECIPE.model = "models/willardnetworks/skills/syringeammo.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_toolkit"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.ingredients = {["comp_metal"] = 2, ["comp_glass"] = 1}
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
RECIPE.name = "Briquet en plastique"
RECIPE.description = "Un briquet en plastique bon marché conçu pour allumer les cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/lighter.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
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
RECIPE.name = "Ciseaux"
RECIPE.description = "Coupez, coupez, coupez !"
RECIPE.model = "models/willardnetworks/skills/scissors.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_metal"] = 1, ["comp_plastic"] = 1}
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
RECIPE.name = "Marmite"
RECIPE.description = "Une marmite noire en fer. Mettez-la sur une cuisinière !"
RECIPE.model = "models/props_c17/metalPot001a.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_metal"] = 2, ["comp_plastic"] = 1, ["comp_adhesive"] = 1}
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
RECIPE.name = "Outil de coiffeur"
RECIPE.description = "Un outil pour les âmes créatives dans un paysage autrement déprimant."
RECIPE.model = "models/props_junk/cardboard_box004a.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.ingredients = {["comp_metal"] = 1, ["comp_adhesive"] = 1, ["comp_plastic"] = 1}
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
RECIPE.name = "Cuillère à soupe"
RECIPE.description = "Utile pour faire des ragoûts."
RECIPE.model = "models/willardnetworks/skills/kitchenspoon.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
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
RECIPE.name = "Couteau de cuisine"
RECIPE.description = "Un couteau épais et semi-émoussé. Utilisé pour couper les aliments sur une planche à découper ou une surface."
RECIPE.model = "models/willardnetworks/skills/kitchenknife.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.ingredients = {["comp_metal"] = 1, ["comp_wood"] = 1, ["comp_adhesive"] = 1}
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
RECIPE.name = "Poêle à frire"
RECIPE.description = "Une poêle à frire noire en fer. Bon pour la cuisson des aliments."
RECIPE.model = "models/props_c17/metalPot002a.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_metal"] = 1, ["comp_nails_screws"] = 1, ["comp_adhesive"] = 1}
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
RECIPE.name = "Bouilloire"
RECIPE.description = "Une bouilloire pour...bouillir."
RECIPE.model = "models/props_interiors/pot01a.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_metal"] = 1, ["comp_nails_screws"] = 1, ["comp_adhesive"] = 1}
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
RECIPE.name = "Boîte à outils"
RECIPE.description = "Une petite caisse en métal contenant divers outils de construction pour assembler des objets."
RECIPE.model = "models/willardnetworks/skills/toolkit.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.ingredients = {["comp_metal"] = 6, ["comp_adhesive"] = 3, ["comp_plastic"] = 2}
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
RECIPE.name = "Poudrière"
RECIPE.description = "Une poudrière pour allumer un feu de camp."
RECIPE.model = "models/willardnetworks/props/tinderbox.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_cloth"] = 3, ["comp_adhesive"] = 1, ["comp_unrefinedchemical"] = 1}
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
RECIPE.name = "Mixeur"
RECIPE.description = "Cela semble être utile pour mélanger des liquides ou des produits chimiques ensemble. Son étiquette d'avertissement se lit comme suit : Ne pas ouvrir pendant le fonctionnement"
RECIPE.model = "models/willardnetworks/skills/chem_mixer.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.subcategory = "Machines"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_metal"] = 6, ["comp_nails_screws"] = 4, ["comp_strong_adhesive"] = 2}
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
RECIPE.name = "Clé Anglaise"
RECIPE.description = "Une vieille clé. Pourrait être utilisée pour la mise en caisse."
RECIPE.model = "models/props_c17/tools_wrench01a.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.ingredients = {["comp_reshaped_metal"] = 1, ["comp_improved_nails_screws"] = 1}
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
RECIPE.name = "Kit d'établi de chimie"
RECIPE.description = "Cet établi est spécialement conçu pour le mélange réussi des composants chimiques."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/chemistrystation02.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Machines"
RECIPE.ingredients = {["comp_refined_metal"] = 3, ["comp_craftwork_wood"] = 4, ["comp_strong_adhesive"] = 2, ["comp_glass"] = 3}
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
RECIPE.name = "Kit d'assemblage de four rouillé"
RECIPE.description = "Il a l'air terrible, c'est terrible, mais il vous satisfera dans tous les besoins de cuisson pendant un certain temps."
RECIPE.model = "models/willardnetworks/skills/oven_shit.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Machines"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_refined_metal"] = 3, ["comp_plastic"] = 5, ["comp_nails_screws"] = 5, ["comp_electronics"] = 3, ["comp_strong_adhesive"] = 3}
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
RECIPE.name = "Kit d'artisanat"
RECIPE.description = "Cet établi est spécialement conçu pour la fabrication réussie d'objets."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/weaponworkbench02.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Machines"
RECIPE.ingredients = {["comp_craftwork_wood"] = 3, ["comp_reshaped_metal"] = 1, ["comp_refined_plastic"] = 2, ["comp_improved_nails_screws"] = 3}
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
RECIPE.name = "Ensemble d'établi en métal"
RECIPE.description = "Cet établi est spécialement conçu pour la fabrication réussie d'armes ou de quelque chose de similaire."
RECIPE.model = "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Machines"
RECIPE.ingredients = {["comp_refined_metal"] = 4, ["comp_craftwork_wood"] = 2, ["comp_refined_plastic"] = 4, ["tool_craftingbench_assembly"] = 1}
RECIPE.result = {["tool_metalbench_assembly"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 600}, -- full xp
	{level = 40, exp = 300}, -- half xp
	{level = 50, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_repair"
RECIPE.name = "Placage de réparation"
RECIPE.description = "Plaque de réparation artisanale, utilisée pour réparer les armures endommagées sur divers surfaces."
RECIPE.model = "models/gibs/scanner_gib02.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_reshaped_metal"] = 1, ["comp_strong_adhesive"] = 1}
RECIPE.result = {["tool_repair"] = 1}
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 100}, -- full XP
	{level = 40, exp = 50}, -- half XP
	{level = 45, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_breacher"
RECIPE.name = "Dispositif de déstruction de bio-lock"
RECIPE.description = "Un dispositif artisanal qui est placé sur des serrures du Cartel pour les briser."
RECIPE.model = "models/transmissions_element120/charger_attachment.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.station = "tool_metalbench"
RECIPE.ingredients = {["comp_refined_metal"] = 1, ["comp_refined_plastic"] = 1, ["comp_strong_adhesive"] = 1, ["comp_electronics"] = 2}
RECIPE.result = {["lockbreacher"] = 1}
RECIPE.level = 50
RECIPE.experience = {
	{level = 50, exp = 0}, -- full XP
	{level = 50, exp = 0}, -- half XP
	{level = 55, exp = 0} -- 0 XP
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_tool_refill_zippo_lighter"
RECIPE.name = "Recharge Briquet Zippo"
RECIPE.description = "Un briquet en métal de qualité conçu pour allumer les cigarettes."
RECIPE.model = "models/willardnetworks/cigarettes/zippo.mdl"
RECIPE.category = "Utilitaires"
RECIPE.subcategory = "Outils"
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
