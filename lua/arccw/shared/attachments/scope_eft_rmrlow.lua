--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Trijicon RMR"
att.Icon = Material("vgui/entities/eft_attachments/RMR_Icon.png")
att.Description = "RMR(Ruggedized Miniature Reflex) - Durable and lightweight compact reflex sight."

att.SortOrder = 0

att.Desc_Pros = {
    "autostat.holosight",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_optic_small"

att.Model = "models/entities/eft_attachments/eft_scope_rmr/models/eft_scope_rmrlow.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 10, -0.675) * 1.25,
        Ang = Angle(0, 0, 0),
        Magnification = 1.05,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.ModelScale = Vector(1, 1, 1)
att.ModelOffset = Vector(0, -0.025, 0)

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/Scope_EFT_Dot.png")
att.HolosightSize = 0.2
att.HolosightBone = "holosight"
att.HolosightNoFlare = false

att.Mult_SightTime = 1.01
att.Mult_Recoil = 1
att.Mult_RecoilSide = 1
att.Mult_VisualRecoilMult = 0.9

att.Mult_SpeedMult = 0.99
att.Mult_SightedSpeedMult = 0.95

att.Colorable = true