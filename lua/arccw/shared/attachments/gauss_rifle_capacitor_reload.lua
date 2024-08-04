--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Quick-Eject Capacitors"
att.Icon = Material("entities/acwatt_gauss_rifle_capacitor.png")
att.Description = "Capacitors that quickly cycle slugs, accelerating reload speed."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = {"gauss_rifle_capacitor"}
att.InvAtt = "gauss_rifle_capacitor"
att.AutoStats = true

att.Mult_AccuracyMOA = 3
att.Mult_ReloadTime = 0.75

att.Mult_Range = 0.75

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end