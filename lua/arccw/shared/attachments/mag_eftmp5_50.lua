--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "50-Round Drum"
att.Icon = Material("vgui/entities/eft_attachments/MP5_50Drum_Icon.png")
att.Description = "Heavy 50-round Drum, high mag capacity at a cost of mobility."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eftmp5_mag"

att.Mult_MoveSpeed = 0.95
att.Mult_SightTime = 1.25
att.Mult_ReloadTime = 1.15

att.MagExtender = true

att.ActivateElements = {"extendedmag"}

	att.Hook_SelectReloadAnimation = function(wep, anim)
		if anim == "reload" then
			return "reload_long"
		elseif anim == "reload_empty" then
			return "reload_long_empty"
		end
	end