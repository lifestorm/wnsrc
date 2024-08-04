--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Lightweight Slugs"
att.Icon = Material("entities/acwatt_gauss_rifle_ammo.png")
att.Description = "Shortened slugs using light alloy. Improves handling and recoil control, but damage and ranged performance is reduced."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Slot = "gauss_rifle_bullet"

att.AutoStats = true
att.Mult_RangeMin = 0
att.Mult_Range = 0.75
att.Mult_Penetration = 0.5
att.Mult_Recoil = 0.75
att.Mult_MoveDispersion = 0.5
att.Mult_HipDispersion = 0.5

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end