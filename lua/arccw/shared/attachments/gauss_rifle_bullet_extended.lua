--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Extended Magazine"
att.Icon = Material("entities/acwatt_gauss_rifle_ammo.png")
att.Description = "Lengthened magazines containing standard iron slugs. Slower to reload."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"

att.AutoStats = true
att.Mult_ReloadTime = 1.25
att.MagExtender = true

att.ActivateElements = {"extendedmag"}

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end