--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Calibrated Capacitors"
att.Icon = Material("entities/acwatt_gauss_rifle_capacitor.png")
att.Description = "Fine tuned capacitors have incredible precision and better damage over range, but are slightly slower to charge."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = {"gauss_rifle_capacitor"}
att.InvAtt = "gauss_rifle_capacitor"
att.AutoStats = true

att.Mult_ShootPitch = 0.85
att.Mult_AccuracyMOA = 0.25

att.Mult_RPM = 0.85
att.Mult_FireAnimTime = 1 / 0.85

att.Mult_Range = 1.5
att.Mult_DamageMin = 1.2

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end