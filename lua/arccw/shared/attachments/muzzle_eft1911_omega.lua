--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "SilencerCo Omega 45k"
att.Icon = Material("vgui/entities/eft_attachments/1911_omega45k_icon.png", "mips smooth")
att.Description = "Light sound suppressor made by SilencerCo."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_1911"

att.SortOrder = 15

att.Model = "models/weapons/arc_eft_1911/eft_1911_muzzle_omega45k/models/eft_1911_omega45k.mdl"

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_ShootPitch = 1
att.Mult_ShootVol = 0.75
att.Mult_AccuracyMOA = 0.8
att.Mult_Range = 1.1

att.ModelScale = Vector(1, 1, 1)

att.Mult_SightTime = 1.16

att.Mult_Recoil = 0.90

att.Add_BarrelLength = 8