--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "6L31 60-round magazine"
att.Icon = Material("vgui/entities/eft_attachments/mags/6l31_icon.png", "mips smooth")
att.Description = "60-round quad-stack polymer Izhmash 6L31 magazine for 5.45x39 ammo, for AK-74 and compatible systems. Produced as a small batch, never serialized."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_mag_ak545"}

att.Model = "models/entities/eft_attachments/magazines_AK/6l31/models/eft_mag_6l31.mdl"

att.SortOrder = 99
att.Override_ClipSize = 40
att.Mult_ReloadTime = 1.15
att.Mult_SightTime = 1.15

att.Mult_SpeedMult = 0.95
att.Mult_SightedSpeedMult = 0.8

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_6l31"
    elseif anim == "reload_empty" then
        return "reload_6l31_empty"
    end
end