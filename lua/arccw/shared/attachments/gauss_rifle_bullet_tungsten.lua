--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Tungsten Slugs"
att.Icon = Material("entities/acwatt_gauss_rifle_ammo.png")
att.Description = "Ultra-durable tungsten slugs. Improves damage over range, but overpenetrates up close."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"

att.AutoStats = true
att.Mult_DamageMin = 1.75
att.Mult_Damage = 0.75
att.Mult_Penetration = 1.5

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end