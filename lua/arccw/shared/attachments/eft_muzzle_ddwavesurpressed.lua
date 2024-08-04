--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "WAVE QD sound suppressor"
att.Icon = Material("vgui/entities/eft_attachments/muzzles/muzzle_ddwavesurpressor.png", "mips smooth")
att.Description = "Daniel Defence Wave QD sound suppressor, which can be installed over a Wave muzzle brake."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_ar15"

att.SortOrder = 16

att.Model = "models/entities/eft_attachments/eft_muzzle_ddwave.mdl"
att.ModelBodygroups = "01"

att.ModelScale = Vector(1, 1, 1)

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_HeatCapacity = 0.5
att.Mult_HeatDissipation = 0.7

att.Mult_ShootPitch = 1
att.Mult_ShootVol = 1
att.Mult_Range = 0.86
att.Mult_AccuracyMOA = 0.95

att.Mult_MuzzleVelocity = 1.02

att.Mult_SightTime = 1.14

att.Mult_Recoil = 0.84
att.Mult_RecoilSide = 0.75

att.Add_BarrelLength = 16