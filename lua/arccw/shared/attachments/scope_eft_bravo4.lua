--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "BRAVO4 4X30"
att.Icon = Material("vgui/entities/eft_attachments/scopes/optic_bravo4.png", "mips smooth")
att.Description = "Designed by Sig, BRAVO4 4X30 optical scope sight features the uniquely large FOV, 43% wider than closest competitors. It also has an extra rail mount on top of it that allows installation of backup compact sight."

att.SortOrder = 3

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_optic_large"

att.Model = "models/entities/eft_attachments/scopes/eft_scope_bravo4.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 12, -1.35),
        Ang = Angle(0, 0, 0),
        Magnification = 1.25,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/scope_eft_bravo4.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 11
att.HolosightBone = "holosight"
att.HolosightPiece = "models/entities/eft_attachments/scopes/eft_scope_bravo4_hsp.mdl"
att.Colorable = false

att.HolosightBlackbox = true

att.HolosightMagnification = 4

att.Mult_SightTime = 1.05
att.Mult_Recoil = 0.99
att.Mult_RecoilSide = 0.98
att.Mult_VisualRecoilMult = 0.85

att.Mult_SpeedMult = 0.97
att.Mult_SightedSpeedMult = 0.75