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

--Made by Liquid
PLUGIN.MIN_PLAYER_COUNT = 30
PLUGIN.STOP_AFTER_CONNECTED_FOR = 600
PLUGIN.MIN_SIZE = 100
PLUGIN.TRACE_SIZE = 1000

ORIGINAL_NET = ORIGINAL_NET or table.Copy(net)

local _net = ORIGINAL_NET
local IsValid = IsValid

local currentMessageName
hook.Add("DatabaseConnected", "bastionNetSizeLog", function()
    local query = mysql:Create("bastion_netsizelog")
        query:Create("id", "INT UNSIGNED NOT NULL AUTO_INCREMENT")
        query:Create("steamid", "VARCHAR(20) NOT NULL")
        query:Create("timestamp", "INT(11) UNSIGNED NOT NULL")
        query:Create("realtime", "FLOAT NOT NULL")
        query:Create("message_name", "VARCHAR(128) NOT NULL")
        query:Create("size", "INT(11) UNSIGNED NOT NULL")
        query:Create("stack_trace", "TEXT DEFAULT NULL")
        query:PrimaryKey("id")
        query:Callback(function()
            local delete = mysql:Delete("bastion_netsizelog")
                delete:WhereLT("timestamp", os.time() - 3 * 24 * 3600)
            delete:Execute()
        end)
    query:Execute()
end)

local function netLog(players)
    local count = player.GetCount()
    if (count > 1 and count <= PLUGIN.MIN_PLAYER_COUNT) then return end

    if (type(players) == "Player") then
        players = {players}
    elseif (type(players) == "CRecipientFilter") then
        players = players:GetPlayers()
    end

    local size = _net.BytesWritten()
    if (size <= PLUGIN.MIN_SIZE) then return end

    for k, v in ipairs(players) do
		if (!IsValid(v)) then continue end

        if (v.ixStopNetLog or v:TimeConnected() > PLUGIN.STOP_AFTER_CONNECTED_FOR) then
            v.ixStopNetLog = true
            continue
        end

        local query = mysql:Insert("bastion_netsizelog")
            query:Insert("steamid", v:SteamID64())
            query:Insert("timestamp", os.time())
            query:Insert("realtime", RealTime())
            query:Insert("message_name", currentMessageName)
            query:Insert("size", size)
            if (size >= PLUGIN.TRACE_SIZE or currentMessageName == "NetStreamDS") then
                query:Insert("stack_trace", debug.traceback())
            end
        query:Execute()
    end
end

net.Start = function(name, unreliable)
    currentMessageName = name

    return _net.Start(name, unreliable)
end

net.Send = function(players)
    netLog(players)
    currentMessageName = nil
    return _net.Send(players)
end

net.SendOmit = function(players)
    netLog(players)
    currentMessageName = nil
    return _net.SendOmit(players)
end

net.Broadcast = function(pos)
    netLog(player.GetAll())
    currentMessageName = nil
    return _net.Broadcast()
end
