--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Hexagon 12K 12ga sound suppressor"
att.Icon = Material("vgui/entities/eft_attachments/muzzles/12g_muzzle_hexagon.png", "mips smooth")
att.Description = "Sound moderator made by Hexagon company for 12ga shotguns and carbines (Saiga, Vepr and others)."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_12g"

att.SortOrder = 15

att.Model = "models/entities/eft_attachments/12gmuzzles/hexagon_12k.mdl"

att.ModelScale = Vector(1, 1, 1)

att.Silencer = true
att.Override_MuzzleEffect = "muzzleflash_suppressed"
att.IsMuzzleDevice = true

att.Mult_HeatCapacity = 0.45
att.Mult_HeatDissipation = 0.5

att.Mult_ShootVol = 0.75

att.Mult_Recoil = 0.94
att.Mult_RecoilSide = 0.94
att.Mult_DrawTime = 1.28
att.Mult_SightTime = 1.28
att.Mult_Precision = 0.99

att.Mult_MuzzleVelocity = 1.1

att.Add_BarrelLength = 9

att.ExcludeFlags = {"long_mag"}