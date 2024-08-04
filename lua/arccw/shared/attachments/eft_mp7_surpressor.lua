--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "B&T Rotex 2 silencer"
att.Icon = Material("vgui/entities/eft_mp7/eft_mp7_surpressor.png", "mips smooth")
att.Description = "Rotex 2 is a 4.6x30 mm suppressor produced by Brügger & Thomet."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_mp7_surpressor"

att.SortOrder = 15

att.Model = "models/weapons/arc_eft_mp7/eft_mp7/models/eft_mp7_surpressor.mdl"

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_ShootPitch = 1.1
att.Mult_ShootVol = 0.75
att.Mult_Range = 1.05

att.Mult_SightTime = 1.12

att.Mult_Recoil = 0.93
att.Mult_RecoilSide = 0.93

att.Add_BarrelLength = 8