--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "12/70 Dual Sabot Slug"
att.Icon = Material("vgui/entities/eft_attachments/ammo/12g_slug.png", "mips smooth")
att.Description = "12/70 Dual Sabot Slug shell for 12ga shotguns"
att.Desc_Pros = {
    "85x2 DMG"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "Dual slug ammo"
}
att.AutoStats = true
att.Slot = "ammo_eft_12"

att.Override_Num = 2

att.Mult_Damage = 85*2 /312
att.Mult_Penetration = 5.6
att.Mult_AccuracyMOA = 0.9
att.Mult_Recoil = 1.15

att.Mult_DamageMin = 1.1
att.Mult_Range = 1.5

att.ActivateElements = {"12dss"}
att.Override_ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_dual_sabot_slug_shell.mdl"