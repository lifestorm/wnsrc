--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Slide Pull Reload"
att.Icon = Material("entities/att/acwatt_ud_glock_mag_17.png", "smooth mips")
att.Description = "Slide releases are overrated."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
    "ud.glock.altanim"
}

att.Slot = "ud_glock_mag"
att.SortOrder = 999
att.Free = true
att.IgnorePickX = true


att.Hook_SelectReloadAnimation = function(wep, anim)
    if anim == "reload_empty" then
        return "reload_empty_fesiug"
    end
end