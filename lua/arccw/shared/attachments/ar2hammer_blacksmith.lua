--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Blacksmith"
att.Icon = Material("entities/hammer.png")
att.Description = "Makes the hammer heavier, at the cost of a decreased firerate."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "ar2_hammer"

att.Override_Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1
    },
    {
        Mode = 0
    }
}

att.Mult_Recoil = 0.25
att.Mult_ReloadTime = 1.2
att.Mult_RPM = 0.5