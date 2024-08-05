--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "12/70 Flechette"
att.Icon = Material("vgui/entities/eft_attachments/ammo/12g_def.png", "mips smooth")
att.Description = "12/70 shell loaded with 15 5.25mm buckshot for 12ga shotguns."
att.Desc_Pros = {
    "200 DMG"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.AutoStats = true
att.Slot = "ammo_eft_12"


att.Mult_Damage = 200/312
att.Mult_MuzzleVelocity = 0.77
att.Mult_Penetration = 10.3
att.Mult_Precision = 0.9

att.Mult_Range = 0.7

att.ActivateElements = {"12fl"}
att.Override_ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_flechette_shell.mdl"