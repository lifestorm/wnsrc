--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "AAC 762 SDN-6"
att.Icon = Material("vgui/entities/eft_attachments/surpressor_aac_icon.png", "mips smooth")
att.Description = "AAC 762 SDN-6 sound suppressor designed for use with a 7.62x51 NATO, but also functions as a superb multi-caliber suppressor for multiple hosts, providing excellent performance on 7.62 NATO, .300 AAC, 6.8 SPC, 6.5, and 5.56mm NATO. can only be installed on compatible with a 51T devices."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_762x51"

att.SortOrder = 15

att.Model = "models/entities/eft_attachments/eft_muzzle_aac/models/eft_surpressor_aac762x51.mdl"

att.ModelScale = Vector(1, 1, 1)

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_HeatCapacity = 0.5
att.Mult_HeatDissipation = 0.7

att.Mult_ShootPitch = 1.1
att.Mult_ShootVol = 0.75
att.Mult_Range = 1.05

att.Mult_SightTime = 1.15

att.Mult_Recoil = 0.97
att.Mult_RecoilSide = 0.95

att.Add_BarrelLength = 8