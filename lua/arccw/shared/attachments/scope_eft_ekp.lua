--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Cobra EKP-8-02"
att.Icon = Material("vgui/entities/eft_attachments/ekp_icon.png")
att.Description = "Cobra is a very popular reflex sight among security agencies and civilian shooters. It was designed for the armed forces of the Russian Federation, but was never formally adopted."

att.SortOrder = 1

att.Desc_Pros = {
    "autostat.holosight",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_optic_medium"}

att.Model = "models/entities/eft_attachments/eft_scope_ekp/models/eft_scope_ekp.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 10, -1.35) * 1.25,
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.ModelScale = Vector(1, 1, 1)
att.ModelOffset = Vector(0, -0, 0)

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/Scope_EFT_EKP.png")
att.HolosightSize = 1
att.HolosightBone = "holosight"
att.HolosightNoFlare = true

att.Mult_SightTime = 1.03
att.Mult_Recoil = 0.99
att.Mult_RecoilSide = 1
att.Mult_VisualRecoilMult = 0.9

att.Mult_SpeedMult = 0.96
att.Mult_SightedSpeedMult = 0.9

att.Colorable = true