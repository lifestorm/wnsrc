--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if CLIENT or !game.SinglePlayer() then return end

hook.Add("EntityTakeDamage", "ArcCW_ETD", function(npc, dmg)
    timer.Simple(0, function()
        if !IsValid(npc) then return end
        if npc:Health() <= 0 then
            net.Start("arccw_sp_health")
            net.WriteEntity(npc)
            net.Broadcast()
        end
    end)
end)