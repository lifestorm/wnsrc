--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "30-Round Magazine"
att.Icon = Material("vgui/entities/eft_mp7/eft_mp7_mag30.png", "mips smooth")
att.Description = "A standard 30-round 4.6x30 magazine for the MP7 SMGs, manufactured by Heckler & Koch."
att.SortOrder = 40
att.Desc_Pros = {
    "pro.magcap"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "eft_mag_mp7"

att.Model = "models/weapons/arc_eft_mp7/eft_mp7/models/eft_mp7_mag30.mdl"

att.Mult_MoveSpeed = 0.95
att.Mult_SightTime = 1.1
att.Override_ClipSize = 30
att.Mult_ReloadTime = 1.05

	att.Hook_SelectReloadAnimation = function(wep, anim)
		if anim == "reload" then
			return "reload_extended"
		elseif anim == "reload_empty" then
			return "reload_extended_empty"
		end
	end