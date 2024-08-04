--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "USP Match Iron Sights"
att.Icon = Material("vgui/entities/eft_attachments/usp_sights_tactical.png", "mips smooth")
att.Description = "Sights for the special version of the USP pistol - USP Tactical. Manufactured by Heckler & Koch."

att.SortOrder = 1

att.Desc_Pros = {
    "Slightly better sight picture."
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_usp_sights"

att.AdditionalSights = {
    {
        Pos = Vector(0.0, 15, -0.24) * 1.25,
        Ang = Angle(0.15, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.SortOrder = 15

att.Model = "models/weapons/arc_eft_usp/atts/eft_usp_sights_tactical.mdl"

att.ModelScale = Vector(1, 1, 1)