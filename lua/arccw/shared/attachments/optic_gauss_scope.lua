--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "M2014-S (FLIR)"
att.Icon = Material("entities/acwatt_optic_gauss_scope.png")
att.Description = "Adjustable infrared long range sniper optic designed for the M2014 Gauss Rifle."

att.SortOrder = 40

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
    "autostat.thermal"
}
att.Desc_Cons = {
}
att.AutoStats = true

att.Slot = {"optic", "optic_sniper"}

att.Model = "models/weapons/arccw/atts/gauss_scope.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 12, -1.055),
        Ang = Angle(0, 0, 0),
        Magnification = 2.5,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ZoomLevels = 4,
        ZoomSound = "weapons/arccw/fiveseven/fiveseven_slideback.wav",
        Thermal = true,
        IgnoreExtra = true,
    }
}

att.ScopeGlint = true

att.Holosight = true
att.HolosightReticle = Material("hud/scopes/duplex.png")
att.HolosightNoFlare = true
att.HolosightSize = 14
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/arccw/atts/gauss_scope_hsp.mdl"
att.Colorable = true

att.HolosightMagnification = 4
att.HolosightBlackbox = true

att.HolosightMagnificationMin = 6
att.HolosightMagnificationMax = 12

att.Mult_SightTime = 1.4
att.Mult_SightedSpeedMult = 0.75
att.Mult_SpeedMult = 0.9