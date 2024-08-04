--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Mark 4 HAMR"
att.Icon = Material("vgui/entities/eft_attachments/scopes/optic_hamr.png", "mips smooth")
att.Description = "Hybrid Leupold-produced scope comprises the Mark 4 HAMR 4x24mm optical sight. It was developed for precision mid-range carbine fire using the 4x optics while being equally effective in close quarters thanks to use of compact reflex sight when necessary."

att.SortOrder = 3

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_optic_large"

att.Model = "models/entities/eft_attachments/scopes/eft_scope_hamr.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 10, -1.625),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/scope_eft_hamr.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 12
att.HolosightBone = "holosight"
att.HolosightPiece = "models/entities/eft_attachments/scopes/eft_scope_hamr_hsp.mdl"
att.Colorable = false

att.HolosightBlackbox = true

att.HolosightMagnification = 4

att.Mult_SightTime = 1.08
att.Mult_Recoil = 0.98
att.Mult_RecoilSide = 0.99
att.Mult_VisualRecoilMult = 0.75

att.Mult_SpeedMult = 0.94
att.Mult_SightedSpeedMult = 0.7