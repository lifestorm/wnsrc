--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "20-Round Mag"
att.Icon = Material("vgui/entities/eft_attachments/MP5_20Mag_Icon.png")
att.Description = "Lightweight 20-round magazine for the MP5, the lighter weight allowing for increased mobility."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eftmp5_mag"

att.Mult_MoveSpeed = 1.1
att.Mult_SightTime = 0.9
att.Mult_ReloadTime = 0.85

att.MagReducer = true

att.ActivateElements = {"Magazine_20"}

	att.Hook_SelectReloadAnimation = function(wep, anim)
		if anim == "reload" then
			return "reload_short"
		elseif anim == "reload_empty" then
			return "reload_short_empty"
		end
	end