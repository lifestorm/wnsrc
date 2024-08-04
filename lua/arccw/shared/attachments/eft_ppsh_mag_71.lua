--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "71-Round PPSH Drum"
att.Icon = Material("entities/acwatt_go_ak_mag_40.png", "mips smooth")
att.Description = "71-Round Standard Issue drum magazine for the PPSH-41"
att.SortOrder = 40
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_ppsh_magazine"

att.Model = "models/weapons/arc_eft_ppsh/eft_ppsh_drum/models/eft_ppsh_drum.mdl"

att.Mult_MoveSpeed = 0.9
att.Mult_SightTime = 1.25
att.Override_ClipSize = 71
att.Mult_ReloadTime = 1.25

att.ActivateElements = {"magazine"}

	att.Hook_SelectReloadAnimation = function(wep, anim)
		if anim == "reload" then
			return "reload_extended"
		elseif anim == "reload_empty" then
			return "reload_extended_empty"
		end
	end