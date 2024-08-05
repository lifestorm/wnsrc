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
eProtect.data.fakeNets = eProtect.data.fakeNets or {}

local generatedOnes = {}

eProtect.getRandUniqueNum = function()
    local rand = math.random(1, 999999)
    if generatedOnes[rand] then return eProtect.getRandUniqueNum() end
    generatedOnes[rand] = true

    return rand
end

eProtect.createFakeNets = function()
    if eProtect.config["disabledModules"]["fake_exploits"] then return end

    local createdNets = 0
    local maxFakeNets = 3

    local mixedTbl = {}

    for k,v in pairs(eProtect.data.badNets) do
        mixedTbl[eProtect.getRandUniqueNum()] = k
    end

    for k, netstring in pairs(mixedTbl) do
        local validateNet = tobool(util.NetworkStringToID(netstring))
        if validateNet then continue end
        createdNets = createdNets + 1

        eProtect.data.fakeNets[netstring] = eProtect.data.fakeNets[netstring] or eProtect.data.badNets[netstring]
        eProtect.data.fakeNets[netstring].enabled = true
        util.AddNetworkString(netstring)

        net.Receive(netstring, function(_, ply)
            eProtect.logDetectionHandeler(ply, "fake-exploit", netstring, 2)
            eProtect.punish(ply, 2, slib.getLang("eprotect", eProtect.config["language"], "banned-net-exploitation"))
        end)

        if maxFakeNets > 0 and (createdNets >= maxFakeNets) then break end
    end

    if eProtect.queueNetworking then
        eProtect.queueNetworking(nil, "fakeNets")
    end
end


eProtect.createFakeNets()