--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local atts = {
    ["attn_30rnd_mag"] = "Powiększony magazynek 30rnd",
    ["attn_7xscope"] = "Luneta 7X",
    ["attn_acog"] = "ACOG",
    ["attn_aimpoint"] = "Kolimator Aimpoint CompM2",
    ["attn_eotech"] = "Celownik holograficzny EOTech 552",
    ["attn_folded_sights"] = "Składane przyrządy celownicze",
    ["attn_foregrip"] = "Uchwyt przedni",
    ["attn_gp25"] = "Granatnik GP-25",
    ["attn_laser"] = "Laser",
    ["attn_m203"] = "Granatnik M203",
    ["attn_suppressor"] = "Tłumik",

    --["am_gib"] = "G.I.B Ammunition",
    --["am_magnum"] = "Magnum Ammunition",
    --["am_match"] = "Match Ammunition",
    ["ar15_ext_mag_60"] = "Powiększony magazynek AR-15",
    ["ar15_ext_ris_barrel"] = "Powiększone łoże RIS",
    ["ar15_m16_barrel"] = "Łoże M16",
    ["ar15_m16_stock"] = "Kolba M16",
    ["ar15_magpul_barrel"] = "Łoże Magpul",
    ["ar15_magpul_stock"] = "Kolba Magpul",
    ["ar15_ris_barrel"] = "Łoże RIS",
    ["cod_kit_slt"] = "Zamek",
    ["cod_kit_spo"] = "Spec-Ops",
    ["cod_si_rds"] = "Celownik kolimatorowy",
    ["ins2_br_heavy"] = "Ciężka lufa",
    ["ins2_mag_drum_75rd"] = "Magazyn bębnowy",
    ["ins2_mag_ext_pistol"] = "Powiększony magazynek do pistoletu",
    ["ins2_mag_speedloader"] = "Szybkoładownica",
    ["ins2_pm_alt"] = "Alternatywny wygląd Makarova",
    ["ins2_pm_honorary"] = "Honorowy wygląd Makarova",
    ["ins2_pm_soviet"] = "Klasyczny wygląd Makarova",
    ["ins2_si_2xrds"] = "Kolimator Aimpoint CompM2 2X",
    ["ins2_si_c79"] = "Celownik optyczny C79 Elcan",
    ["ins2_si_kobra"] = "Kolimator Kobra",
    ["ins2_si_mx4"] = "Luneta MX4",
    ["ins2_si_po4x"] = "Celownik PO 4x24P",
    ["ins2_ub_flashlight"] = "Latarka",
    ["ins2_usp_chrome"] = "Chromowe wykończenie USP",
    --["sg_frag"] = "Frag Ammunition",
    --["sg_slug"] = "Slug Ammunition",
    ["tfa_nam_sling"] = "Pasek",
}

for k, v in pairs(atts) do
    local ITEM = ix.item.Register(k, nil, false, nil, true)
    ITEM.name = v
    ITEM.category = "Attachment"
    ITEM.model = "models/props_lab/box01a.mdl"
    ITEM.description = "Pudełko w środku którego znajduje się "..v.."."
end

PLUGIN.attnTranslate = {
    ["ar15_si_folded"] = "attn_folded_sights",
    ["at_grip"] = "attn_foregrip",
    ["br_supp"] = "attn_suppressor",
    ["cod_br_supp"] = "attn_suppressor",
    ["cod_fg_gp25"] = "attn_gp25",
    ["cod_fg_grip"] = "attn_foregrip",
    ["cod_fg_m203"] = "attn_m203",
    ["cod_scope_7x"] = "attn_7xscope",
    ["cod_scope_acog"] = "attn_acog",
    ["cod_ub_laser"] = "attn_laser",
    ["ins2_br_supp"] = "attn_suppressor",
    ["ins2_fg_gp25"] = "attn_gp25",
    ["ins2_fg_grip"] = "attn_foregrip",
    ["ins2_fg_m203"] = "attn_m203",
    ["ins2_mag_ext_carbine_30rd"] = "attn_30rnd_mag",
    ["ins2_mag_ext_rifle_30rd"] = "attn_30rnd_mag",
    ["ins2_si_folded"] = "attn_folded_sights",
    ["ins2_si_eotech"] = "attn_eotech",
    ["ins2_si_mosin"] = "attn_7xscope",
    ["ins2_si_rds"] = "attn_aimpoint",
    ["ins2_ub_laser"] = "attn_laser",
    ["si_acog"] = "attn_acog",
    ["si_aimpoint"] = "attn_aimpoint",
    ["si_eotech"] = "attn_eotech",
}