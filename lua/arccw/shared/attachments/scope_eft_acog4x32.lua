--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "ACOG TA01NSN"
att.Icon = Material("vgui/entities/eft_attachments/scopes/optic_acog.png", "mips smooth")
att.Description = "ACOG TA01NSN 4x32 rifle scope manufactured by Trijicon."

att.SortOrder = 3

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_optic_large"

att.Model = "models/entities/eft_attachments/eft_scope_acog/models/eft_scope_acog_4x32.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 10, -1.45),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/scope_eft_acog.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 16
att.HolosightBone = "holosight"
att.HolosightPiece = "models/entities/eft_attachments/eft_scope_acog/models/eft_scope_acog_4x32_HSP.mdl"
att.Colorable = false

att.HolosightBlackbox = true

att.HolosightMagnification = 4

att.Mult_SightTime = 1.06
att.Mult_Recoil = 0.98
att.Mult_RecoilSide = 1
att.Mult_VisualRecoilMult = 0.7

att.Mult_SpeedMult = 0.95
att.Mult_SightedSpeedMult = 0.8