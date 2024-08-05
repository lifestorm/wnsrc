--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "5.56x45mm M995"
att.Icon = Material("vgui/entities/eft_attachments/ammo/ammo_556_m855.png")
att.Description = "A 5.56x45mm NATO M995 cartridge with a 3.4 gram armor-piercing bullet with a tungsten carbide penetrator over an aluminum base with a copper jacket, in a brass case. This cartridge was designed during the 1990s to provide United States Army personnel with capabilities to pierce light covers and light vehicles, as well as basic and intermediate ballistic body protections, in addition to providing outstanding results against some specialized protection models. However, due to its design, it has a significant bounce probability on various surfaces."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "ammo_eft_556"

att.Override_Ammo = "556_M995" -- overrides the ammo type with this one

att.Free = true

att.Mult_Penetration = 2
att.Mult_Damage = 0.75
att.Mult_DamageMin = 1.25
att.Mult_Precision = 0.25
att.Mult_Recoil = 1.1

att.ActivateElements = {"995"}