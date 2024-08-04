--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "TGP-A Surpressor"
att.Icon = Material("vgui/entities/eft_attachments/muzzles/muzzle_TGP.png", "mips smooth")
att.Description = "Tactical muzzle device/suppressor TGP-A, manufactured by State R&D Agency 'Special devices and Comms' for AK-based 5.45x39 automatic rifles."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_ak545"

att.SortOrder = 15

att.Model = "models/entities/eft_attachments/muzzle_tgp/muzzle/models/eft_muzzle_tgp.mdl"

att.ModelScale = Vector(1, 1, 1)

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_ShootPitch = 1.2
att.Mult_ShootVol = 0.85
att.Mult_Range = 0.9

att.Mult_SightTime = 1.10

att.Mult_Recoil = 0.97
att.Mult_RecoilSide = 0.95

att.Add_BarrelLength = 8