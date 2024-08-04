--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local loadQueue = {}

hook.Add( "PlayerInitialSpawn", "GM_FullLoadQueue", function( ply )
    loadQueue[ply] = true
end )

hook.Add( "SetupMove", "GM_FullLoadInit", function( ply, _, cmd )
    if not loadQueue[ply] then return end
    if cmd:IsForced() then return end

    loadQueue[ply] = nil
    hook.Run( "PlayerFullLoad", ply )
end )
