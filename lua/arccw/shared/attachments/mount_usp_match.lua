--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "USP Match Compensator"
att.Icon = Material("vgui/entities/eft_attachments/usp_mount_match.png", "mips smooth")
att.Description = "The Match compensator from the special USP Match pistol kit will add additional weight to the front of your gun assisting to reduce vertical recoil. Features a mount for installation of additional tactical equipment. Manufactured by Heckler & Koch."

att.SortOrder = 1

att.Desc_Pros = {
	"Badass"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_usp_compensator"
att.GivesFlags = {"MountCompensator"}
att.ActivateElements = {"hidemount"}

att.Mult_Recoil = 0.8
att.Mult_RecoilSide = 1.4
att.Mult_VisualRecoilMult = 0.8

att.Mult_HipDispersion = 1.1

att.Mult_SpeedMult = 0.98

att.Mult_SightTime = 1.05

att.Mult_Range = 0.95
att.Mult_MuzzleVelocity = 1

att.SortOrder = 15

att.Model = "models/weapons/arc_eft_usp/atts/eft_usp_mount_match.mdl"

att.ModelOffset = Vector(-0.9, 0, -0.05)

att.ModelScale = Vector(1, 1, 1)