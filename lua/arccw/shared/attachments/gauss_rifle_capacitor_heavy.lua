--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Heavy Capacitors"
att.Icon = Material("entities/acwatt_gauss_rifle_capacitor.png")
att.Description = "Overcharged capacitors are significantly more powerful, but are more cumbersome and much slower to charge."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = {"gauss_rifle_capacitor"}
att.InvAtt = "gauss_rifle_capacitor"
att.AutoStats = true

att.Mult_ShootPitch = 0.6

att.Mult_RPM = 0.6
att.Mult_FireAnimTime = 1 / 0.6

att.Mult_Damage = 1.5
att.Mult_DamageMin = 2.5

att.Mult_MoveDispersion = 1.5
att.Mult_ReloadTime = 1.3
att.Mult_Recoil = 1.5

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end