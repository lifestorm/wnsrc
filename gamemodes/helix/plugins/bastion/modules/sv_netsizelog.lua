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
PLUGIN.MIN_PLAYER_COUNT = 50
PLUGIN.STOP_AFTER_CONNECTED_FOR = 3600
PLUGIN.MIN_SIZE = 10000

ORIGINAL_NET = ORIGINAL_NET or table.Copy(net)

file.CreateDir("netlogs")

local _net = ORIGINAL_NET
local IsValid = IsValid

local currentMessageName

local function netLog(players)
    if player.GetCount() <= PLUGIN.MIN_PLAYER_COUNT then return end

    if type(players) == "Player" then
        players = { players }
    elseif type(players) == "CRecipientFilter" then
        players = players:GetPlayers()
    end

    if #players == 1 then
        local ply = players[1]
		
		if (!IsValid(ply)) then return end

        if ply:TimeConnected() > PLUGIN.STOP_AFTER_CONNECTED_FOR then return end
        if _net.BytesWritten() < PLUGIN.MIN_SIZE then return end

        local steamid = ply:SteamID64()

        local f = file.Open("netlogs/" .. steamid .. ".txt", "a", "DATA")
        f:Write("[" .. os.date("%H:%M:%S - %d/%m/%Y") .. "] [" .. steamid .. "] [" .. currentMessageName .. "] " .. _net.BytesWritten() .. " bytes\n")
        f:Close()
    end
end

local function netLogBroadcast()
    print("[BROADCAST] [" .. currentMessageName .. "] " .. _net.BytesWritten() .. " bytes")
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

-- We can probably ignore SendPVS and SendPAS for now
--[[
net.Broadcast = function(pos)
    netLogBroadcast()
    currentMessageName = nil
    return _net.Broadcast()
end
--]]
