--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "12/70 RIP"
att.Icon = Material("vgui/entities/eft_attachments/ammo/12g_rip.png", "mips smooth")
att.Description = "RIP (Radically Invasive Projectile) ammunition is a devastatingly effective choice for the anti-personnel use. This 12 cal ammo features a precision-machined solid copper lead-free projectile designed to produce huge damage to body."
att.Desc_Pros = {
    "265 DMG"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "Slug ammo"
}
att.AutoStats = true
att.Slot = "ammo_eft_12"

att.Override_Num = 1

att.Mult_Damage = 265 /312
att.Mult_MuzzleVelocity = 0.99
att.Mult_Penetration = 0.6
att.Mult_Precision = 1.8
att.Mult_Recoil = 1.35

att.Mult_DamageMin = 1.1
att.Mult_Range = 1.5

att.ActivateElements = {"12rip"}
att.Override_ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_rip_shell.mdl"