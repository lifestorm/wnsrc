--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "NcSTAR Tactical laser"
att.Icon = Material("vgui/entities/eft_attachments/tactical/tactical_ncstar.png", "mips smooth")
att.Description = "Compact tactical Laser Aiming-module with blue dot produced by NcSTAR."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_tactical"}

att.Model = "models/entities/eft_attachments/eft_tactical_ncstar.mdl"
att.ModelOffset = Vector(0, 0, 0)
att.OffsetAng = Angle(0, 0, 180)

att.KeepBaseIrons = true

att.Laser = false
att.LaserStrength = 1 / 5
att.LaserBone = "laser"

att.ColorOptionsTable = {Color(0, 0, 255)}

att.Mult_SightTime = 1.01
att.Mult_Recoil = 1
att.Mult_RecoilSide = 1
att.Mult_VisualRecoilMult = 1

att.Mult_SpeedMult = 1
att.Mult_SightedSpeedMult = 0.99

att.ToggleStats = {
    {
        PrintName = "On",
        Laser = true,
        Mult_HipDispersion = 0.75,
        Mult_MoveDispersion = 0.75
    },
    {
        PrintName = "Off",
    }
}