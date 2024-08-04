--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Jackhammer"
att.Icon = Material("entities/hammer.png")
att.Description = "Makes the hammer very light, resulting in a increased firerate."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "ar2_hammer"

att.Override_Firemodes = {
    {
        Mode = -10,
        RunAwayBurst = true,
        PostBurstDelay = 0.35,
    },
    {
        Mode = 0,
    },
}

att.Mult_Recoil = 2.5
att.Mult_ReloadTime = 0.9
att.Mult_RPM = 5