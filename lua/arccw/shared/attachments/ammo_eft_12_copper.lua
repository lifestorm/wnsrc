--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "12/70 Copper Sabot Premier HP Slug"
att.Icon = Material("vgui/entities/eft_attachments/ammo/12g_slug.png", "mips smooth")
att.Description = "12/70 Copper solid slug shell for 12ga shotguns."
att.Desc_Pros = {
    "206 DMG"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "Slug ammo"
}
att.AutoStats = true
att.Slot = "ammo_eft_12"

att.Override_Num = 1

att.Mult_Damage = 206 /312
att.Mult_MuzzleVelocity = 1.065
att.Mult_Penetration = 4.6
att.Mult_AccuracyMOA = 0.2
att.Mult_HipDispersion  = 10
att.Mult_Recoil = 1.1

att.Mult_DamageMin = 1.1
att.Mult_Range = 1.5

att.ActivateElements = {"12cop"}
att.Override_ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_slug_hp_copper_shell.mdl"