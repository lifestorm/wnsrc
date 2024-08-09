--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Vortex SPITFIRE PRISM SCOPE (1.5x)"
att.AbbrevName = "Spitfire (1.5x)"
att.Icon = Material("entities/att/acwatt_uc_optic_vortex_3x.png", "mips smooth")
att.Description = "Short to medium range combat scope that allows a more versatile engagement range."

att.SortOrder = 1.5

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"optic"}

att.Model = "models/weapons/arccw/atts/uc_vortex3x.mdl"
att.ModelOffset = Vector(0, 0, 0.18)

att.AdditionalSights = {
    {
        Pos = Vector(0, 8.5, -1.6),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ScopeMagnification = UC_HalfScope( 1.5 ),
        HolosightData = {
            Holosight = true,
            HolosightReticle = Material("hud/scopes/uc_vortex_reticle.png", "mips smooth"),
            HolosightNoFlare = true,
            HolosightSize = 8.5,
            HolosightPiece = "models/weapons/arccw/atts/uc_vortex3x_hsp.mdl",
            HolosightBlackbox = true,
            HolosightMagnification = UC_HalfScope( 1.5 ),
            Colorable = true,
        },
    }
}

-- att.Holosight = true
-- att.HolosightReticle = Material("mifl_tarkov_reticle/dot.png", "mips smooth")

att.HolosightPiece = "models/weapons/arccw/atts/uc_vortex3x_hsp.mdl"
-- att.HolosightNoFlare = true
-- att.HolosightSize = 1
-- att.HolosightBone = "holosight"
att.Colorable = true

att.Mult_SightedSpeedMult = .8