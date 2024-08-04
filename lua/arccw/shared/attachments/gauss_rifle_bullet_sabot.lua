--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Sabot Slugs"
att.Icon = Material("entities/acwatt_gauss_rifle_ammo.png")
att.Description = "Shaped and reinforced slug designed to penetrate entire bunker walls. Has extremely high penetration and long range damage."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"

att.AutoStats = true
att.Mult_Range = 1.5
att.Mult_DamageMin = 2
att.Mult_Penetration = 10
att.Mult_Recoil = 1.5
att.Mult_AccuracyMOA = 2
att.MagReducer = true
att.ActivateElements = {"reducedmag"}

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end