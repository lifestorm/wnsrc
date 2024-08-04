--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "5.56x45mm HP"
att.Icon = Material("vgui/entities/eft_attachments/ammo/ammo_556_m855.png")
att.Description = "A .223 Remington (5.56x45mm) HP cartridge with a 3.6 gram lead core hollow-point bullet with a bimetallic jacket in a steel case, intended for hunting, home defense, and target practice. Despite not having the full energy of an intermediate cartridge, the bullet has a considerable stopping power effect as well as being able to cause substantial negative effects on the target after impact, at the cost of penetration capabilities, even against basic ballistic protection."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "ammo_eft_556"

att.Override_Ammo = "556_HP" -- overrides the ammo type with this one

att.Mult_Penetration = 0.5

att.Free = true

att.Mult_Damage = 1.25
att.Mult_DamageMin = 0.75
att.Mult_Precision = 0.35
att.Mult_Recoil = 1.1

att.ActivateElements = {"hp"}