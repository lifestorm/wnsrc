--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "12/70 \"Poleva-3\" Slug"
att.Icon = Material("vgui/entities/eft_attachments/ammo/12g_slug.png", "mips smooth")
att.Description = "12/70 \"Poleva-3\" expanding slug shell for 12ga shotguns"
att.Desc_Pros = {
    "140 DMG"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "Slug ammo"
}
att.AutoStats = true
att.Slot = "ammo_eft_12"

att.Override_Num = 1

att.Mult_Damage = 140/312
att.Mult_MuzzleVelocity = 0.99
att.Mult_Penetration = 5.6
att.Mult_AccuracyMOA = 0.1
att.Mult_HipDispersion  = 10
att.Mult_Recoil = 0.85

att.Mult_DamageMin = 1.1
att.Mult_Range = 1.5

att.ActivateElements = {"12p3"}
att.Override_ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_slug_poleva_3_shell.mdl"