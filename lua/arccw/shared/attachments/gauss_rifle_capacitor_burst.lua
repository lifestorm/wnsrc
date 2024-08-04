--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

att.PrintName = "Burst Capacitors"
att.Icon = Material("entities/acwatt_gauss_rifle_capacitor.png")
att.Description = "Dangerous tinkering allows these capacitors to fire twice in rapid succession. Has a long delay after bursting."
att.Desc_Pros = {
    "Hyper-burst mode"
}
att.Desc_Cons = {
}
att.Slot = {"gauss_rifle_capacitor"}
att.InvAtt = "gauss_rifle_capacitor"
att.AutoStats = true

att.Override_Firemodes = {
    {
        Mode = -2,
        Mult_RPM = 25,
        RunawayBurst = true,
        PostBurstDelay = 1.5,
        Override_ShotRecoilTable = {[0] = 0, [1] = 1.5}
    },
    {
        Mode = 1
    },
    {
        Mode = 0
    }
}

att.Mult_ReloadTime = 1.2

if engine.ActiveGamemode() == "terrortown" then
    att.Free = true
end