--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "CQC Capacitors"
att.Icon = Material("entities/acwatt_gauss_rifle_capacitor.png")
att.Description = "Gyroscope-stablized capacitors improve agility of the rifle, but severely hurts precision and damage over range."
att.Desc_Pros = {
}
att.Desc_Cons = {
    "+10MOA Imprecision"
}
att.Slot = {"gauss_rifle_capacitor"}
att.InvAtt = "gauss_rifle_capacitor"
att.AutoStats = true

att.Mult_ShootPitch = 1.1
att.Add_AccuracyMOA = 10

att.Mult_RPM = 1.1
att.Mult_FireAnimTime = 1 / 1.1

att.Mult_SightTime = 0.7
att.Mult_HipDispersion = 0.7
att.Mult_MoveDispersion = 0.7
att.Mult_SightedSpeedMult = 2

att.Mult_Range = 0.4
att.Mult_Damage = 0.5
att.Mult_DamageMin = 0.5

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end