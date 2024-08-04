--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "WAVE muzzle brake"
att.Icon = Material("vgui/entities/eft_attachments/muzzles/muzzle_ddwave.png", "mips smooth")
att.Description = "Daniel Defense Wave is a very effective muzzle brake that also serves as a platform for attaching a QD Wave sound suppressor."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_ar15"

att.SortOrder = 16

att.Model = "models/entities/eft_attachments/eft_muzzle_ddwave.mdl"
att.ModelBodygroups = "00"

att.ModelScale = Vector(1, 1, 1)

att.IsMuzzleDevice = true

att.Mult_ShootPitch = 1
att.Mult_ShootVol = 1
att.Mult_Range = 0.95

att.Mult_SightTime = 1.09

att.Mult_Recoil = 0.91
att.Mult_RecoilSide = 0.84

att.Add_BarrelLength = 2