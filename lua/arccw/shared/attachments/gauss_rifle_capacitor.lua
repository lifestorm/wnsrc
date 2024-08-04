--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Turbo Capacitors"
att.Icon = Material("entities/acwatt_gauss_rifle_capacitor.png")
att.Description = "Liquid-cooled capacitors increase firing rate dramatically, but each shot is not as powerful or precise."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = {"gauss_rifle_capacitor"}
att.AutoStats = true

att.Mult_ShootPitch = 1.5
att.Mult_AccuracyMOA = 5

att.Mult_RPM = 1.5
--att.Mult_FireAnimTime = 0.5

att.Mult_Range = 0.6
att.Mult_Damage = 0.6
att.Mult_DamageMin = 0.6

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end