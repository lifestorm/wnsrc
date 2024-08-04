--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Compact prism scope 2.5x"
att.Icon = Material("vgui/entities/eft_attachments/scopes/optic_compactprism.png", "mips smooth")
att.Description = "The Compact Prism 2.5x magnification scope, manufactured by Primary Arms. The low magnification and bright illuminated reticle allow for fast both-eyes-open shooting at close range, while the ACSS CQB-M1 reticle allows for easy hits on targets out to 600 meters."

att.SortOrder = 2

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_optic_medium"

att.Model = "models/entities/eft_attachments/scopes/eft_scope_compactprism.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 10, -1.15),
        Ang = Angle(0, 0, 0),
        Magnification = 1.25,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/scope_eft_prism.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 8.5
att.HolosightBone = "holosight"
att.HolosightPiece = "models/entities/eft_attachments/scopes/eft_scope_compactprism_hsp.mdl"
att.Colorable = false

att.HolosightBlackbox = true

att.HolosightMagnification = 2.5

att.Mult_SightTime = 1.03
att.Mult_Recoil = 1
att.Mult_RecoilSide = 0.99
att.Mult_VisualRecoilMult = 0.95

att.Mult_SpeedMult = 0.99
att.Mult_SightedSpeedMult = 0.89