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
    ["attn_30rnd_mag"] = "Extended 30rnd Magazine",
    ["attn_7xscope"] = "7X Scope",
    ["attn_acog"] = "ACOG",
    ["attn_aimpoint"] = "Aimpoint CompM2",
    ["attn_eotech"] = "EOTech 552",
    ["attn_folded_sights"] = "Folded Sights",
    ["attn_foregrip"] = "Foregrip",
    ["attn_gp25"] = "GP-25",
    ["attn_laser"] = "Laser",
    ["attn_m203"] = "M203",
    ["attn_suppressor"] = "Suppressor",

    --["am_gib"] = "G.I.B Ammunition",
    --["am_magnum"] = "Magnum Ammunition",
    --["am_match"] = "Match Ammunition",
    ["ar15_ext_mag_60"] = "Extended AR-15 Magazine",
    ["ar15_ext_ris_barrel"] = "RIS Extended Handguard",
    ["ar15_m16_barrel"] = "M16 Handguard",
    ["ar15_m16_stock"] = "M16 Stock",
    ["ar15_magpul_barrel"] = "Magpul Handguard",
    ["ar15_magpul_stock"] = "Magpul Stock",
    ["ar15_ris_barrel"] = "RIS Handguard",
    ["cod_kit_slt"] = "Slate",
    ["cod_kit_spo"] = "Spec-Ops",
    ["cod_si_rds"] = "Red Dot Sight",
    ["ins2_br_heavy"] = "Heavy Barrel",
    ["ins2_mag_drum_75rd"] = "Drum Magazine",
    ["ins2_mag_ext_pistol"] = "Extended Pistol Magazine",
    ["ins2_mag_speedloader"] = "Speed Loader",
    ["ins2_pm_alt"] = "Alternative Makarov Look",
    ["ins2_pm_honorary"] = "Honorary Makarov",
    ["ins2_pm_soviet"] = "Classic Soviet Vintage Makarov",
    ["ins2_si_2xrds"] = "Aimpoint CompM2 2X",
    ["ins2_si_c79"] = "C79 Elcan",
    ["ins2_si_kobra"] = "Kobra Reflex Sight",
    ["ins2_si_mx4"] = "MX4 Scope",
    ["ins2_si_po4x"] = "PO 4x24P",
    ["ins2_ub_flashlight"] = "Flashlight",
    ["ins2_usp_chrome"] = "USP Chrome Finish",
    --["sg_frag"] = "Frag Ammunition",
    --["sg_slug"] = "Slug Ammunition",
    ["tfa_nam_sling"] = "Sling",
}

for k, v in pairs(atts) do
    local ITEM = ix.item.Register(k, nil, false, nil, true)
    ITEM.name = v
    ITEM.category = "Attachment"
    ITEM.model = "models/props_lab/box01a.mdl"
    ITEM.description = "A box containing a "..v.." attachment."
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