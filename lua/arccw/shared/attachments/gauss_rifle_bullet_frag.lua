--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Shrapnel Slugs"
att.Icon = Material("entities/acwatt_gauss_rifle_ammo.png")
att.Description = "Slug that explodes into shrapnel upon firing. Has reduced precision and range."
att.Desc_Pros = {
    "+ 16 pellets per shot"
}
att.Desc_Cons = {
    "+20MOA Imprecision"
}
att.Slot = "gauss_rifle_bullet"

att.AutoStats = true
att.Override_Num = 16
att.Add_AccuracyMOA = 20
att.Mult_Range = 0.5
att.Mult_Penetration = 0.2

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end