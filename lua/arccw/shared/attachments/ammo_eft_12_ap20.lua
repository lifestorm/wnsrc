--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "12/70 AP-20 Slug"
att.Icon = Material("vgui/entities/eft_attachments/ammo/12g_slug.png", "mips smooth")
att.Description = "A 12/70 armor-piercing slug shell for 12 gauge shotguns. Designed for law enforcement forces of our overseas ʕ•ᴥ•ʔ friends ʕ•ᴥ•ʔ."
att.Desc_Pros = {
    "164 DMG"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "Slug ammo"
}
att.AutoStats = true
att.Slot = "ammo_eft_12"

att.Override_Num = 1

att.Mult_Damage = 164/312
att.Mult_MuzzleVelocity = 1.2
att.Mult_Penetration = 12.3
att.Mult_AccuracyMOA = 0.5
att.Mult_HipDispersion  = 10
att.Mult_Recoil = 1.5

att.Mult_DamageMin = 1.1
att.Mult_Range = 1.5

att.ActivateElements = {"12ap20"}
att.Override_ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_slug_ap_20_shell.mdl"