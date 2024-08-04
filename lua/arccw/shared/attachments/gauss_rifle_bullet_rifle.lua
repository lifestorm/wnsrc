--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Intermediate Slugs"
att.Icon = Material("entities/acwatt_gauss_rifle_ammo.png")
att.Description = "Load small 7mm slugs that are less powerful, but easier to come by and allows a generous clip size."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"

att.AutoStats = true
att.Mult_ShootPitch = 1.1
att.Mult_RPM = 1.1
att.Mult_FireAnimTime = 1 / 1.1

att.Mult_Damage = 0.6
att.Mult_DamageMin = 0.75
att.Mult_Penetration = 0.5
att.Mult_Range = 0.6
att.Mult_RangeMin = 0.6

att.Mult_Recoil = 0.5
att.Mult_RecoilSide = 0.5
att.Mult_ReloadTime = 0.8

att.MagExtender = true
att.Override_Ammo = "ar2"
att.Override_Trivia_Calibre = "7mm Mini Slugs"
att.Override_ClipSize = 8

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
    att.Override_Ammo = "smg1"
end