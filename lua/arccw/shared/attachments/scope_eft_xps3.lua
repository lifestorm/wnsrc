--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Eotech XPS3-0"
att.Icon = Material("vgui/entities/eft_attachments/scope_xps3_icon.png")
att.Description = "XPS3 is more compact than the other holographic sights, but just as effective; moreover, such approach leaves more mounting space for additional equipment. Both hunters and armed forces operatives value it for small size and weight, which are particularly noticeable over long missions. The model 3-0 features a two-dot reticle of 1 MOA."

att.SortOrder = 1

att.Desc_Pros = {
    "autostat.holosight",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_optic_medium"

att.Model = "models/entities/eft_attachments/eft_scope_xps3/models/eft_scope_xps3.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 10, -1.15) * 1.25,
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.ModelScale = Vector(1, 1, 1)
att.ModelOffset = Vector(0, -0, 0)

att.Holosight = true
att.HolosightReticle = Material("vgui/entities/eft_attachments/reticles/scope_eft_eotech.png")
att.HolosightSize = 1
att.HolosightBone = "holosight"
att.HolosightNoFlare = true

att.Mult_SightTime = 1.03
att.Mult_Recoil = 0.99
att.Mult_RecoilSide = 1
att.Mult_VisualRecoilMult = 0.9

att.Mult_SpeedMult = 0.98
att.Mult_SightedSpeedMult = 0.95

att.Colorable = true