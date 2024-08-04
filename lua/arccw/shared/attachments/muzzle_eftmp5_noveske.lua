--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Noveske Muzzle Brake"
att.Icon = Material("vgui/entities/eft_attachments/noveske_muzzleicon.png", "mips smooth")
att.Description = "Muzzle brake and compensator noveske style for MP-5 and weapon systems based on it. Produced by HK."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_muzzle_mp5"

att.SortOrder = 15

att.Model = "models/weapons/arc_eft_mp5/eft_mp5_noveske/models/eft_mp5_muzzlenoveske.mdl"

att.ModelScale = Vector(1, 1, 1)

att.IsMuzzleDevice = true

att.Mult_ShootPitch = 0.95
att.Mult_ShootVol = 1.15

att.Mult_SightTime = 1.03

att.Mult_Recoil = 0.85
att.Mult_RecoilSide = 0.85

att.Add_BarrelLength = 1