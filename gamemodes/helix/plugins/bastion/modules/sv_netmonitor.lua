--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local hook_Add = hook.Add
local timer_Create = timer.Create
local os_time = os.time
local pairs = pairs
local net_ReadHeader = net.ReadHeader
local util_NetworkIDToString = util.NetworkIDToString
local ix = ix
local IsValid = IsValid
local string_len = string.len
local string_sub = string.sub

-- Code inspired by:
    -- Gmod Net Library Debug
    -- https://github.com/HexaneNetworks/gmod-netlibrary-debug
    -- v2.3
    -- October 2020

local PLUGIN = PLUGIN

hook_Add("DatabaseConnected", "bastionNetDB", function()
    local query = mysql:Create("bastion_netlog")
        query:Create("id", "BIGINT UNSIGNED NOT NULL AUTO_INCREMENT")
        query:Create("name", "VARCHAR(50) NOT NULL")
        query:Create("length", "INT UNSIGNED NOT NULL")
        query:Create("count", "INT UNSIGNED NOT NULL")
        query:Create("steamid", "VARCHAR(20) NOT NULL")
        query:Create("args", "VARCHAR(200) DEFAULT NULL")
        query:PrimaryKey("id")
    query:Execute()

    query = mysql:Create("bastion_netspam")
        query:Create("id", "INT UNSIGNED NOT NULL AUTO_INCREMENT")
        query:Create("name", "VARCHAR(50) NOT NULL")
        query:Create("type", "BOOL NOT NULL")
        query:Create("count", "INT UNSIGNED NOT NULL")
        query:Create("steamid", "VARCHAR(20) NOT NULL")
        query:Create("steam_name", "VARCHAR(50) NOT NULL")
        query:Create("ip", "VARCHAR(25) NOT NULL")
        query:Create("time", "INT NOT NULL")
        query:PrimaryKey("id")
    query:Execute()
end)

local netSpamCount = {}
local netFlagged = {}

local comSpamCount = {}
local comFlagged = {}

local threshold = 20

timer_Create("ixBastionNetSpam.Clear", 1.1, 0, function()
    local time = os_time()
    for steamID, data in pairs(netFlagged) do
        for name in pairs(data.names) do
            local query = mysql:Insert("bastion_netspam")
                query:Insert("name", name)
                query:Insert("type", 0)
                query:Insert("count", netSpamCount[steamID][name] or 0)
                query:Insert("steamid", steamID)
                query:Insert("steam_name", data.steamName)
                query:Insert("ip", data.ip)
                query:Insert("time", time)
            query:Execute()
        end
    end

    netSpamCount = {}
    netFlagged = {}

    for steamID, data in pairs(comFlagged) do
        for name in pairs(data.commands) do
            local query = mysql:Insert("bastion_netspam")
                query:Insert("name", name)
                query:Insert("type", 1)
                query:Insert("count", comSpamCount[steamID][name] or 0)
                query:Insert("steamid", steamID)
                query:Insert("steam_name", data.steamName)
                query:Insert("ip", data.ip)
                query:Insert("time", time)
            query:Execute()
        end
    end

    comSpamCount = {}
    comFlagged = {}
end)


local netIgnoreList = {
    ["76561198002319953"] = 2
}

local netSpamAmount = {
    ["NetStreamDS"] = 20,
    ["76561198002319953"] = 30
}

function net.Incoming(len, client)
    local i = net_ReadHeader()
    local name = util_NetworkIDToString(i)
    if (!name) then return end

	local func = net.Receivers[name:lower()]
    if (!func) then return end

    --
	-- len includes the 16 bit int which told us the message name
	--
	len = len - 16

    if (ix.config.Get("netAntiSpam")) then
        local steamID = IsValid(client) and client:SteamID64() or "UNKNOWN"
        netSpamCount[steamID] = netSpamCount[steamID] or {}
        netSpamCount[steamID][name] = (netSpamCount[steamID][name] or 0) + 1
        if (netSpamCount[steamID][name] > (netSpamAmount[name] or threshold)) then
            if (!netFlagged[steamID]) then
                netFlagged[steamID] = {
                    names = {},
                    steamID = steamID,
                    steamName = IsValid(client) and (client.SteamName and client:SteamName() or client:Name()) or "UNKNOWN PLAYER NAME",
                    ip = IsValid(client) and client:IPAddress() or "UNKNOWN IP"
                }

                if (!ix.config.Get("netLoggingEnabled")) then
                    local query = mysql:Insert("bastion_netlog")
                        query:Insert("name", name)
                        query:Insert("length", len)
                        query:Insert("count", netSpamCount[steamID][name])
                        query:Insert("steamid", steamID)
                    query:Execute()
                end
            end

            netFlagged[steamID].names[name] = true
        end



        if (ix.config.Get("netLoggingEnabled") and (!netIgnoreList[name] or netIgnoreList[name] < netSpamCount[steamID][name])) then
            local query = mysql:Insert("bastion_netlog")
                query:Insert("name", name)
                query:Insert("length", len)
                query:Insert("count", netSpamCount[steamID][name])
                query:Insert("steamid", steamID)
            query:Execute()
        end
    end

	func(len, client)
end

local conSpamAmount = {

}
local conIgnoreList = {

}

PLUGIN.oldRun = PLUGIN.oldRun or concommand.Run
function concommand.Run(client, command, args, argString)
    if (IsValid(client) and command and ix.config.Get("netAntiSpam")) then
        local steamID = IsValid(client) and client:SteamID64() or "UNKNOWN"
        comSpamCount[steamID] = comSpamCount[steamID] or {}
        comSpamCount[steamID][command] = (comSpamCount[steamID][command] or 0) + 1
        if (comSpamCount[steamID][command] > (conSpamAmount[command] or threshold)) then
            if (!comFlagged[steamID]) then
                comFlagged[steamID] = {
                    commands = {},
                    steamID = steamID,
                    steamName = IsValid(client) and (client.SteamName and client:SteamName() or client:Name()) or "UNKNOWN PLAYER NAME",
                    ip = IsValid(client) and client:IPAddress() or "UNKNOWN IP"
                }

                if (!ix.config.Get("netLoggingEnabled")) then
                    local query = mysql:Insert("bastion_netlog")
                        query:Insert("name", command)
                        query:Insert("length", #argString)
                        query:Insert("count", netSpamCount[steamID][command])
                        query:Insert("steamid", steamID)
                        query:Insert("args",  string_len(argString or "") > 200 and string_sub(argString, 1, 200) or argString or "")
                    query:Execute()
                end
            end

            comFlagged[steamID].commands[command] = true
        end

        if (ix.config.Get("netLoggingEnabled") and (!conIgnoreList[command] or conIgnoreList[command] < comSpamCount[steamID][command])) then
            local query = mysql:Insert("bastion_netlog")
                query:Insert("name", command)
                query:Insert("length", #argString)
                query:Insert("count", comSpamCount[steamID][command])
                query:Insert("steamid", steamID)
                query:Insert("args", string_len(argString or "") > 200 and string_sub(argString, 1, 200) or argString or "")
            query:Execute()
        end
    end

    return PLUGIN.oldRun(client, command, args, argString)
end
