--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "RPK-16 95-round drum"
att.Icon = Material("vgui/entities/eft_attachments/mags/drum545_icon.png", "mips smooth")
att.Description = "95-round polymer Izhmash magazine for 5.45x39 ammo, for RPK-16 and compatible systems."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_mag_ak545"}

att.Model = "models/entities/eft_attachments/magazines_AK/drum/models/eft_mag_545drum.mdl"

att.SortOrder = 99
att.Override_ClipSize = 95
att.Mult_ReloadTime = 1.4
att.Mult_SightTime = 1.7

att.Mult_SpeedMult = 0.75
att.Mult_SightedSpeedMult = 0.5

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_drum"
    elseif anim == "reload_empty" then
        return "reload_drum_empty"
    end
end