--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

netstream.Hook("ixModelAnimationsRunSequence", function(ply, sequence)
    if (!CAMI.PlayerHasAccess(ply, "Helix - " .. PLUGIN.name, nil) or !IsValid(ply)) then return end

    ply:LeaveSequence()

    timer.Simple(0.1, function()
        ply:ForceSequence(sequence, nil, 999, true)
    end)
end)

netstream.Hook("ixModelAnimationsResetSequence", function(ply)
    if (!CAMI.PlayerHasAccess(ply, "Helix - " .. PLUGIN.name, nil) or !IsValid(ply)) then return end

    ply:LeaveSequence()
end)