--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local punished = {}

eProtect.logDetectionHandeler = function(ply, reason, info, type)
    if eProtect.data.general["bypassgroup"][ply:GetUserGroup()] or eProtect.config["disabledModules"]["detection_log"] then return end
    local sid, sid64 = ply:SteamID(), ply:SteamID64()

    if eProtect.data.general["bypass_sids"][sid] or eProtect.data.general["bypass_sids"][sid64] then return end

    if punished[sid] and CurTime() < punished[sid] then return end
    punished[sid] = CurTime() + eProtect.data.general.timeout + 1
    
    local name, sid64 = ply:Nick(), ply:SteamID64()

    eProtect.logDetection(name, sid64, reason, info, type)
end

if eProtect.queueNetworking then
    eProtect.queueNetworking(nil, "punishmentLogging")
end