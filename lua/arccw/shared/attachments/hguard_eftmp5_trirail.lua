--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "PTR Tri-Rail"
att.Icon = Material("vgui/entities/eft_attachments/Trirail_HandguardIcon.png")
att.Description = "Handguard for MP5 produced by PTR, equipped with 3 rail mounts for installation of additional devices."
att.Desc_Pros = {
	"Tri-rails allowing for further attachments"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eftmp5_handguard"

att.Model = "models/weapons/arc_eft_mp5/eft_mp5_trirail/models/eft_mp5_hguardtrirail.mdl"

att.GivesFlags = {"lowerrail", "siderail"}

att.Mult_Recoil = 1
att.Mult_RecoilSide = 0.95
att.Mult_SightTime = 1.02