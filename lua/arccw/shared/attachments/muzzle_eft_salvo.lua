--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "SilencerCo Salvo 12 12ga sound suppressor"
att.Icon = Material("vgui/entities/eft_attachments/muzzles/12g_muzzle_salvo.png", "mips smooth")
att.Description = "Sound moderator made by SilencerCo company for 12ga shotguns and carbines (Saiga, Vepr and others). Very effective, but a bit too heavy."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_12g"

att.SortOrder = 15

att.Model = "models/entities/eft_attachments/12gmuzzles/silencerco_salvo_12g.mdl"

att.ModelScale = Vector(1, 1, 1)

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_HeatCapacity = 0.5
att.Mult_HeatDissipation = 0.7

att.Mult_ShootVol = 0.75

att.Mult_Recoil = 0.81
att.Mult_RecoilSide = 0.81
att.Mult_DrawTime = 1.28
att.Mult_SightTime = 1.28
att.Mult_Precision = 1.08

att.Mult_MuzzleVelocity = 1.1

att.Add_BarrelLength = 10

att.ExcludeFlags = {"long_mag"}