--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Leupold Mark 4"
att.Icon = Material("vgui/entities/eft_attachments/scope_leupold_icon.png", "mips smooth")
att.Description = "Leupold Mark 4 LR 6.5-20x50 riflescope"

att.SortOrder = 4

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_optic_large"

att.Model = "models/entities/eft_attachments/eft_scope_leupold/models/eft_scope_leupold.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 14, -1),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/scope_eft_leupold.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 16
att.HolosightBone = "holosight"
att.HolosightPiece = "models/entities/eft_attachments/eft_scope_leupold/models/eft_scope_leupold_hsp.mdl"
att.Colorable = false

att.HolosightBlackbox = true

att.HolosightMagnification = 6.5

att.Mult_SightTime = 1.15
att.Mult_Recoil = 0.97
att.Mult_RecoilSide = 0.98
att.Mult_VisualRecoilMult = 0.6

att.Mult_SpeedMult = 0.94
att.Mult_SightedSpeedMult = 0.6