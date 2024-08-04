--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "8-shell magazine extension"
att.Icon = Material("vgui/entities/eft_attachments/mp153_m8.png", "mips smooth")
att.Description = "8-shell MP-153 12ga magazine extension."

att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_mp153_mag"

att.SortOrder = 5

att.Mult_DrawTime = 1.3
att.Mult_SightTime = 1.3
att.Mult_SpeedMult = 0.85
att.Override_ClipSize = 8
att.Mult_MalfunctionMean = 0.8

att.ActivateElements = {"m8"}
att.GivesFlags = {"long_mag"}