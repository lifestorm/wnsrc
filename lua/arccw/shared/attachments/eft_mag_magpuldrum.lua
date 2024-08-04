--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Magpul PMAG D-60"
att.Icon = Material("vgui/entities/eft_attachments/mags/mag_ar_magpuldrum.png", "mips smooth")
att.Description = "The Magpul PMAG D-60 polymer 60-round magazine for 5.56x45 rounds."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = {"eft_mag_ar15"}

att.Model = "models/entities/eft_attachments/mags/eft_mag_magpuldrum.mdl"

att.SortOrder = 99
att.Override_ClipSize = 60
att.Mult_ReloadTime = 1.25
att.Mult_SightTime = 1.45

att.Mult_MalfunctionMean = 0.5

att.Mult_SpeedMult = 0.88
att.Mult_SightedSpeedMult = 0.74

att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload" then
        return "reload_drum"
    elseif anim == "reload_empty" then
        return "reload_drum_empty"
    end
end

att.Hook_TranslateAnimation = function(wep, anim)
    if anim == "exit_inspect" then
        return "exit_drum_inspect"
    elseif anim == "exit_inspect_empty" then
        return "exit_inspect_drum_empty"
    end
end