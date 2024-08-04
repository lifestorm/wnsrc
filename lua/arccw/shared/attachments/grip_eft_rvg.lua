--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Magpul RVG grip"
att.Icon = Material("vgui/entities/eft_attachments/grip_rvg_icon.png", "mips smooth")
att.Description = "Magpul RVG (Rail Vertical Grip) tactical grip. Common, unsophisticated and inexpensive, ergonomically shaped vertical foregrip."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_foregrip"}

att.LHIK = true

att.Model = "models/entities/eft_attachments/eft_grip_rvg/models/eft_grip_rvg.mdl"

att.ModelOffset = Vector(0, -0, -0.2)

att.Mult_SightTime = 1.04
att.Mult_Recoil = 0.95
att.Mult_RecoilSide = 0.8
att.Mult_VisualRecoilMult = 1.4

att.Mult_HipDispersion = 1.4
att.Mult_SightsDispersion = 0.85

att.Mult_SpeedMult = 0.96
att.Mult_SightedSpeedMult = 0.9
att.Mult_ShootSpeedMult = 1

att.Override_HoldtypeActive = "smg"