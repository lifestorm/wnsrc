--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

hook.Add("CreateTeams", "ArcCW_TrueNames", function()
    if !ArcCW.ConVars["truenames"]:GetBool() then return end

    for _, i in pairs(weapons.GetList()) do
        local wpn = weapons.GetStored(i.ClassName)

        if wpn.TrueName then
            wpn.PrintName = wpn.TrueName
        end
    end
end)