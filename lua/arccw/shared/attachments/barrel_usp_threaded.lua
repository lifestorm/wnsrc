--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Threaded Barrel"
att.Icon = Material("vgui/entities/eft_attachments/usp_barrel_match.png", "mips smooth")
att.Description = "A 129mm threaded barrel for the special version of the USP pistol - USP Tactical, chambered in .45 ACP. Manufactured by Heckler & Koch."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_usp_barrel"

att.SortOrder = 15

// stats

att.Mult_Range = 1.10
att.Mult_MuzzleVelocity = 1.02

att.Mult_Recoil = 0.97
att.Mult_RecoilSide = 1.02
att.Mult_VisualRecoilMult = 1.04

att.Mult_AccuracyMOA = 0.97
att.Mult_HipDispersion = 1.05

att.Add_BarrelLength = 2

att.Mult_SpeedMult = 0.99

att.Mult_SightTime = 1.015

att.GivesFlags = {"threadedbarrel"}

att.Model = "models/weapons/arc_eft_usp/atts/eft_usp_barrel_threaded.mdl"

att.ModelScale = Vector(1, 1, 1)