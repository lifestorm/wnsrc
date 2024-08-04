--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Saiga 10-round magazine"
att.Icon = Material("vgui/entities/eft_attachments/mags/saiga545_icon.png", "mips smooth")
att.Description = "10-round polymer Izhmash Saiga 545 magazine, for the AK-based civilian carbine of the same name, for 5.45x39 ammo."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_mag_ak545"}

att.Model = "models/entities/eft_attachments/magazines_AK/saiga/models/saiga10round.mdl"

att.SortOrder = 99
att.Override_ClipSize = 10
att.Mult_ReloadTime = 0.85
att.Mult_SightTime = 0.9

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_saiga"
    elseif anim == "reload_empty" then
        return "reload_saiga_empty"
    end
end