--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "AAC Illusion 9"
att.Icon = Material("vgui/entities/eft_attachments/illusion_muzzleicon.png", "mips smooth")
att.Description = "Illusion 9 is a compact, high performance silencer for modern 9mm semi-automatic pistols. Made by Advanced Armament Corp."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_surpressor_9mm"

att.SortOrder = 15

att.Model = "models/entities/eft_attachments/eft_surpressor_illusion/models/eft_surpressor_illusion.mdl"

att.ModelScale = Vector(40, 40, 40)

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_HeatCapacity = 0.5
att.Mult_HeatDissipation = 0.7

att.Mult_ShootPitch = 1.1
att.Mult_ShootVol = 0.75
att.Mult_Range = 1.05

att.Mult_SightTime = 1.12

att.Mult_Recoil = 0.93
att.Mult_RecoilSide = 0.93

att.Add_BarrelLength = 8