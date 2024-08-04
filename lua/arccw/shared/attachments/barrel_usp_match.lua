--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "USP Match Barrel"
att.Icon = Material("vgui/entities/eft_attachments/usp_barrel_match.png", "mips smooth")
att.Description = "A 153mm barrel for the special version of the USP pistol - USP Match, chambered in .45 ACP. Manufactured by Heckler & Koch."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_usp_barrel"

att.SortOrder = 15

// stats

att.Mult_Range = 1.15
att.Mult_MuzzleVelocity = 1.05

att.Mult_Recoil = 0.93
att.Mult_RecoilSide = 1.04
att.Mult_VisualRecoilMult = 1.1

att.Mult_AccuracyMOA = 0.9
att.Mult_HipDispersion = 1.1

att.Add_BarrelLength = 4

att.Mult_SpeedMult = 0.97

att.Mult_SightTime = 1.03

att.Model = "models/weapons/arc_eft_usp/atts/eft_usp_barrel_match.mdl"

att.ModelScale = Vector(1, 1, 1)