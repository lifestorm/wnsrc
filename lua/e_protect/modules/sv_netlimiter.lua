--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

eProtect = eProtect or {}
eProtect.data = eProtect.data or {}
eProtect.data.netLimitation = eProtect.data.netLimitation or {}

for i = 1, 2048 do
    local netstring = util.NetworkIDToString(i)
    if !netstring then continue end
    if netstring and isstring(netstring) and eProtect.data.netLimitation[netstring] == nil and !eProtect.data.fakeNets[netstring] then
        local func = net.Receivers[string.lower(netstring)]
        if func then eProtect.data.netLimitation[netstring] = 0 end
    end
end

if eProtect.queueNetworking then
    eProtect.queueNetworking(nil, "netLimitation")
end

local generalCounter = {}
local specificCounter = {}
local timeout = {}

hook.Add("eP:PreNetworking", "eP:NetLimiter", function(ply, netstring, len)
    if !eProtect.data or !eProtect.data.general or eProtect.data.netLimitation[netstring] == -1 or eProtect.config["disabledModules"]["net_limiter"] then return end
    
    if !eProtect.data.netLimitation[netstring] then
        local func = net.Receivers[string.lower(netstring)]
        if func then eProtect.data.netLimitation[netstring] = 0 end

        eProtect.queueNetworking(nil, "netLimitation")
    end

    local sid, sid64 = ply:SteamID(), ply:SteamID64()
    local specific = eProtect.data.netLimitation[netstring] ~= nil and eProtect.data.netLimitation[netstring] > 0 or false

    specificCounter[sid] = specificCounter[sid] or {}

    if !timeout[sid] then timeout[sid] = CurTime() end

    if timeout[sid] and ((CurTime() - timeout[sid]) >= eProtect.data.general.timeout) then
        specificCounter[sid] = {}
        generalCounter[sid] = 0
        timeout[sid] = nil
    end

    if specific then
        specificCounter[sid][netstring] = specificCounter[sid][netstring] or 0
        specificCounter[sid][netstring] = specificCounter[sid][netstring] + 1
    else
        generalCounter[sid] = generalCounter[sid] or 0
        generalCounter[sid] = generalCounter[sid] + 1
    end

    local counter = specific and specificCounter[sid][netstring] or generalCounter[sid]
    local limit = specific and eProtect.data.netLimitation[netstring] or eProtect.data.general.ratelimit
    if limit > -1 and counter > limit and eProtect.data.general.overflowpunishment > 0 and !eProtect.data.general["bypassgroup"][ply:GetUserGroup()] and !eProtect.data.general["bypass_sids"][sid] and !eProtect.data.general["bypass_sids"][sid64] then
        if eProtect.data.general["whitelistergroup"][ply:GetUserGroup()] then
            eProtect.data.netLimitation[netstring] = -1
            eProtect.queueNetworking(nil, "netLimitation")
        return end

        eProtect.logDetectionHandeler(ply, "net-overflow", netstring, eProtect.data.general.overflowpunishment)
        if eProtect.data.general.overflowpunishment <= 2 then
            eProtect.punish(ply, eProtect.data.general.overflowpunishment, slib.getLang("eprotect", eProtect.config["language"], eProtect.data.general.overflowpunishment == 1 and "kick-net-overflow" or "banned-net-overflow"))
        end

        return false
    end
end)
