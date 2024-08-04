--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Hera Arms CQR tactical grip"
att.Icon = Material("vgui/entities/eft_attachments/foregrips/foregrip_heracqr.png", "mips smooth")
att.Description = "The CQR front grip is a easy to install, lightweight and compact frontgrip. In combination with our CQR Buttstock, operators will get a lightweight and ergonomic SBR System."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_foregrip"}

att.LHIK = true

att.Model = "models/entities/eft_attachments/foregrips/eft_foregrip_heracqr.mdl"

att.ModelOffset = Vector(0, -0, -0.2)
att.OffsetAng = Angle(-90, 180, 90)

att.Mult_SightTime = 1.1
att.Mult_Recoil = 0.9
att.Mult_RecoilSide = 0.96
att.Mult_VisualRecoilMult = 0.6

att.Mult_HipDispersion = 0.9
att.Mult_SightsDispersion = 1.1

att.Mult_SpeedMult = 0.96
att.Mult_SightedSpeedMult = 0.95
att.Mult_ShootSpeedMult = 1.1

att.Override_HoldtypeActive = "smg"