--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "KAC Vertical pistol grip"
att.Icon = Material("vgui/entities/eft_attachments/KAC_GripIcon.png", "mips smooth")
att.Description = "Vertical pistol grip produced by Knights armament."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_foregrip"}

att.LHIK = true

att.Model = "models/entities/eft_attachments/eft_grip_kac/models/eft_grip_kac.mdl"

att.ModelOffset = Vector(0, -0, -0.2)

att.Mult_SightTime = 0.93
att.Mult_Recoil = 1.04
att.Mult_RecoilSide = 1.01
att.Mult_VisualRecoilMult = 0.8

att.Mult_HipDispersion = 0.9
att.Mult_SightsDispersion = 1.1

att.Mult_SpeedMult = 0.98
att.Mult_SightedSpeedMult = 1.1
att.Mult_ShootSpeedMult = 0.8

att.Override_HoldtypeActive = "smg"