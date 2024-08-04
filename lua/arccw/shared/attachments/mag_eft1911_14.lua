--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Mec-Gar 11-round magazine"
att.Icon = Material("vgui/entities/eft_attachments/1911_mag11_icon.png")
att.Description = "Mec-Gar 11-round .45 ACP magazine for M1911A1."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft1911_mag"

att.Model = "models/weapons/arc_eft_1911/eft_1911_magextended/models/eft_1911_mag14.mdl"

att.Mult_MoveSpeed = 0.99
att.Mult_SightTime = 1.03
att.Mult_ReloadTime = 1.10

att.MagExtender = true

	att.Hook_SelectReloadAnimation = function(wep, anim)
		if anim == "reload" then
			return "reload_long"
		elseif anim == "reload_empty" then
			return "reload_long_empty"
		end
	end