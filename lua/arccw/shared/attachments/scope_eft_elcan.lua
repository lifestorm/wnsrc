--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "ELCAN SpecterDR 1x/4x"
att.Icon = Material("vgui/entities/eft_attachments/scope_elcan_icon.png", "mips smooth")
att.Description = "The SpecterDR (Dual Role) 1x/4x scope from Specter scope series designed by ELCAN has marked a breakthrough in the optic sight development by becoming the first variable scope that truly has two work modes, switching from 4x magnification to 1x in one touch. Comes in black and flat dark earth."

att.SortOrder = 3

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_optic_large"

att.Model = "models/entities/eft_attachments/scopes/eft_scope_elcan.mdl"
att.ModelBodygroups = "00"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 10, -1.575),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ZoomLevels = 8,
        IgnoreExtra = false
    },
    {
        Pos = Vector(0, 15, -2.7),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        HolosightBone = "holosight2",
        HolosightData = {
            Holosight = false,
            --HolosightReticle =  Material("vgui/entities/eft_attachments/reticles/scope_eft_deltapoint.png", "mips smooth"),
            --HolosightSize = 1,
            Colorable = true
        },
        IgnoreExtra = true
    },
}

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/scope_eft_elcan.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 13
att.HolosightBone = "holosight"
att.HolosightPiece = "models/entities/eft_attachments/scopes/eft_scope_elcan_hsp.mdl"
att.Colorable = false

att.HolosightBlackbox = true

att.HolosightMagnification = 4
att.HolosightMagnificationMin = 1.01
att.HolosightMagnificationMax = 4

att.Mult_SightTime = 1.06
att.Mult_Recoil = 0.98
att.Mult_RecoilSide = 0.99
att.Mult_VisualRecoilMult = 0.7

att.Mult_SpeedMult = 0.96
att.Mult_SightedSpeedMult = 0.75