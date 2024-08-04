--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "PMAG GEN M3 10"
att.Icon = Material("vgui/entities/eft_attachments/mags/mag_ar_pmag10.png", "mips smooth")
att.Description = "10-round polymer Magpul PMAG GEN M3 10 magazine, for 5.56x45 ammunition."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_mag_ar15"}

att.Model = "models/entities/eft_attachments/mags/eft_mag_pmag10.mdl"

att.SortOrder = 99
att.Override_ClipSize = 10
att.Mult_ReloadTime = 0.8
att.Mult_SightTime = 0.8

att.Mult_MalfunctionMean = 1.2

att.Mult_SpeedMult = 1.05
att.Mult_SightedSpeedMult = 1.1

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_10"
    elseif anim == "reload_empty" then
        return "reload_10_empty"
    end
end

att.Hook_TranslateAnimation = function(wep, anim)
    if anim == "exit_inspect" then
        return "exit_10_inspect"
    elseif anim == "exit_inspect_empty" then
        return "exit_inspect_10_empty"
    end
end