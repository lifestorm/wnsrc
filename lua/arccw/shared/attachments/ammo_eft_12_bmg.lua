--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "12/70 shell with .50 BMG bullet"
att.Icon = Material("vgui/entities/eft_attachments/ammo/12g_rip.png", "mips smooth")
att.Description = "12/70 Custom made slug shell with a shortened .50 BMG tracer bullet for 12ga shotguns. No one knows, who and why is producing these strange slugs in Tarkov, but they just work... somehow."
att.Desc_Pros = {
    "197 DMG"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "Slug ammo"
}
att.AutoStats = true
att.Slot = "ammo_eft_12"

att.Override_Num = 1

att.Mult_Damage = 197 /312
att.Mult_MuzzleVelocity = 0.99
att.Mult_Penetration = 8.6
att.Mult_AccuracyMOA = 0.5-0.129
att.Mult_HipDispersion  = 10
att.Mult_Recoil = 0.75

att.Mult_DamageMin = 0.9
att.Mult_Range = 1.1

att.ActivateElements = {"12bmg"}
att.Override_ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_slug_50_bmg_m17_traccer_shell.mdl"