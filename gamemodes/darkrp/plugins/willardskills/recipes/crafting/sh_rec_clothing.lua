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

RECIPE.uniqueID = "rec_legs_padded_blue"
RECIPE.name = "Pantalon Rembourré - Bleu"
RECIPE.description = "Un pantalon rembourré bleu."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel2.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_blue_pants"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_blue_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_legs_padded_black"
RECIPE.name = "Pantalon Rembourré - Noir"
RECIPE.description = "Un pantalon rembourré bleu."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel3.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_civilian_black"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_black_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_legs_padded_green"
RECIPE.name = "Pantalon Rembourré - Vert"
RECIPE.description = "Un pantalon rembourré bleu."
RECIPE.model = "models/willardnetworks/clothingitems/legs_rebel1.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Pantalons"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["legs_civilian_green"] = 1, ["comp_adhesive"] = 1, ["comp_stitched_cloth"] = 2}
RECIPE.result = {["legs_green_padded_pants"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 140}, -- full xp
	{level = 20, exp = 70}, -- half xp
	{level = 25, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_green"
RECIPE.name = "Uniforme - Vert"
RECIPE.description = "Un haut vert avec des bretelles. Possède également une plaque de bras, parfaite pour les insignes. Fournit une petite quantité d'armure."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel02.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Uniforme"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["denim_green"] = 1, ["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_reshaped_metal"] = 1}
RECIPE.result = {["torso_green_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_blue"
RECIPE.name = "Uniforme - Bleu"
RECIPE.description = "Un top bleu à bretelles. Dispose également d'une plaque de bras, parfaite pour les insignes. Fournit une petite quantité d'armure."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebel01.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Uniforme"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["denim_blue"] = 1, ["comp_fabric"] = 1, ["comp_adhesive"] = 2, ["comp_reshaped_metal"] = 1}
RECIPE.result = {["torso_blue_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_uniform_medic"
RECIPE.name = "Uniforme - Médecin"
RECIPE.description = "Un top médical à bretelles. Dispose également d'une plaque de bras, parfaite pour les insignes. Fournit une petite quantité d'armure."
RECIPE.model = "models/willardnetworks/clothingitems/torso_rebelmedic.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Uniforme"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["torso_medic_shirt"] = 1, ["comp_adhesive"] = 2, ["comp_reshaped_metal"] = 1}
RECIPE.result = {["torso_medical_rebel_uniform"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 120}, -- full xp
	{level = 30, exp = 60}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_medichelmet"
RECIPE.name = "Casque - Médecin"
RECIPE.description = "Un casque de médecin en métal. Il protège votre tête des chutes d'objets et des éclats d'obus."
RECIPE.model = "models/willardnetworks/clothingitems/head_helmet_med.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Casque"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_reshaped_metal"] = 2, ["comp_improved_nails_screws"] = 1}
RECIPE.result = {["helmet_medic"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_helmet"
RECIPE.name = "Casque - Militaire"
RECIPE.description = "Un casque militaire en métal. Il protège votre tête des chutes d'objets et des éclats d'obus."
RECIPE.model = "models/willardnetworks/clothingitems/head_helmet.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Casque"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_reshaped_metal"] = 2, ["comp_improved_nails_screws"] = 1}
RECIPE.result = {["helmet"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 20
RECIPE.experience = {
	{level = 20, exp = 100}, -- full xp
	{level = 30, exp = 50}, -- half xp
	{level = 35, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_blue"
RECIPE.name = "Bonnet - Bleu"
RECIPE.description = "Un bonnet bleu. Garde la tête au chaud par temps froid."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["head_blue_beanie"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_green"
RECIPE.name = "Bonnet - Vert"
RECIPE.description = "Un bonnet vert. Garde la tête au chaud dans le froid."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["head_green_beanie"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_red"
RECIPE.name = "Bonnet - Rouge"
RECIPE.description = "Un bonnet rouge. Garde la tête au chaud par temps froid"
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_red"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_brown"
RECIPE.name = "Bonnet - Marron"
RECIPE.description = "Un bonnet marron. Garde la tête au chaud par temps froid."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_brown"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_grey"
RECIPE.name = "Bonnet - Gris"
RECIPE.description = "Un bonnet gris. Garde la tête au chaud par temps froid."
RECIPE.model = "models/willardnetworks/clothingitems/head_beanie_update.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Bonnets"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["beanie_grey"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_head_beanie_bandana"
RECIPE.name = "Bandana"
RECIPE.description = "Un bandana rouge qui s'enroule autour de la moitié inférieure de la tête. Offre une légère protection contre les spores."
RECIPE.model = "models/willardnetworks/clothingitems/head_facewrap.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Masque"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["face_bandana"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 100}, -- full XP
	{level = 10, exp = 50}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_hands_tipless"
RECIPE.name = "Mitaines"
RECIPE.description = "Une paire de gants noirs sans le bout des doigts. Garde vos doigts libres."
RECIPE.model = "models/willardnetworks/clothingitems/hands_glove_fingerless.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Gants"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["hands_gloves"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["hands_tipless_gloves"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 60}, -- full XP
	{level = 10, exp = 30}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_trenchcoat"
RECIPE.name = "Trench Marron"
RECIPE.description = "Un trench marron usé. Protège de la pluie, un peu..."
RECIPE.model = "models/willardnetworks/clothingitems/torso_refugee_coat.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Uniforme"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["buttoned_white"] = 1, ["comp_fabric"] = 2, ["comp_strong_adhesive"] = 1, ["comp_reshaped_metal"] = 2}
RECIPE.result = {["overcoat_trench"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 30
RECIPE.experience = {
	{level = 30, exp = 150}, -- full xp
	{level = 40, exp = 100}, -- half xp
	{level = 45, exp = 0} -- no xp
}
RECIPE:Register()

RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_torso_medic"
RECIPE.name = "Chemise - Médecin"
RECIPE.description = "Un haut boutonné blanc avec une bande de croix rouge cousue."
RECIPE.model = "models/willardnetworks/clothingitems/torso_citizen_medic.mdl"
RECIPE.category = "Vêtements"
RECIPE.subcategory = "Uniforme"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["buttoned_white"] = 1, ["comp_stitched_cloth"] = 1, ["comp_adhesive"] = 1}
RECIPE.result = {["torso_medic_shirt"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 5
RECIPE.experience = {
	{level = 5, exp = 80}, -- full xp
	{level = 10, exp = 40}, -- half xp
	{level = 15, exp = 0} -- no xp
}
RECIPE:Register()

