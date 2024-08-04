--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "AN/PEQ-2"
att.Icon = Material("vgui/entities/eft_attachments/tactical/tactical_peq2.png", "mips smooth")
att.Description = "ATPIAL (Advanced Target Pointer Illuminator Aiming Laser) AN/PEQ-2 produced by L3 Insight Technologies. Tactical device that combines laser designators in both visible and IR band with IR searchlight."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_tactical_big"}

att.Model = "models/entities/eft_attachments/eft_tactical_peq2.mdl"
att.ModelOffset = Vector(0, 0, 0)
att.OffsetAng = Angle(0, 0, 180)

att.KeepBaseIrons = true

att.Laser = false
att.LaserStrength = 3 / 5
att.LaserBone = "laser"

att.ColorOptionsTable = {Color(255, 0, 0)}

att.Mult_SightTime = 1.09
att.Mult_Recoil = 1
att.Mult_RecoilSide = 1
att.Mult_VisualRecoilMult = 1

att.Mult_SpeedMult = 0.99
att.Mult_SightedSpeedMult = 0.96

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