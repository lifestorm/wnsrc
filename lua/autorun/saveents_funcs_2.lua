--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile( "autorun/client/campaignents_clientfuncs_2.lua" )
AddCSLuaFile()

local aiVar = GetConVar( "ai_disabled" )

function saveents_EnabledAi()
    return aiVar:GetInt() == 0

end

local ignorePly = GetConVar( "ai_ignoreplayers" )

function saveents_IgnoringPlayers()
    return ignorePly:GetInt() == 1

end