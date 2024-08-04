--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Deadblow"
att.Icon = Material("entities/hammer.png")
att.Description = "Super accurate semi-auto action."
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "ar2_hammer"

att.Override_Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = 0
    }
}

att.Mult_AccuracyMOA = 0.1
att.Mult_Recoil = 0.75
att.Mult_RPM = 0.5