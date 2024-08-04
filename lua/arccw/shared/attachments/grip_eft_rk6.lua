--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Zenit RK-6 foregrip"
att.Icon = Material("vgui/entities/eft_attachments/foregrips/foregrip_rk6.png", "mips smooth")
att.Description = "RK-6 foregrip can be installed on the lower part of handguards with a WEAVER rail. It provides better operational control of weapon during fire."

att.SortOrder = 1

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_foregrip"}

att.LHIK = true

att.Model = "models/entities/eft_attachments/foregrips/eft_foregrip_rk6.mdl"

att.ModelOffset = Vector(0, -0, -0.2)
att.OffsetAng = Angle(-90, 180, 90)

att.Mult_SightTime = 0.8
att.Mult_Recoil = 1.08
att.Mult_RecoilSide = 1.15
att.Mult_VisualRecoilMult = 1.5

att.Mult_HipDispersion = 0.5
att.Mult_SightsDispersion = 1.4

att.Mult_SpeedMult = 1
att.Mult_SightedSpeedMult = 1.25
att.Mult_ShootSpeedMult = 1

att.Override_HoldtypeActive = "smg"