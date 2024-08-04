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

util.AddNetworkString("BeginDialToPeer")
util.AddNetworkString("ixConnectedCallStatusChange")
util.AddNetworkString("RunHangupLandline")
util.AddNetworkString("RunGetPeerName")
util.AddNetworkString("OnGetPeerName")
util.AddNetworkString("LineTestChat")
util.AddNetworkString("LineStatusUpdate")
util.AddNetworkString("LandlineKeyPress")

net.Receive("LandlineKeyPress", function (len, client)
    local ent = Entity(net.ReadInt(17))
    if (ent and ent.inUseBy == client and ent.ButtonPress) then
        ent:ButtonPress()
    end
end)

net.Receive("BeginDialToPeer", function (len, client)
    local dialSeq = net.ReadString()
    if (string.len(dialSeq) < 3 or string.len(dialSeq) > 4 or tonumber(dialSeq) == nil) then
        return
    end

    local exchange = net.ReadInt(5)
    local extension = net.ReadInt(11)
    local character = client:GetCharacter()
    local vars = character:GetLandlineConnection()

    -- verify that this is coming from the correct place (or that no one is trying to manually call the hook)
    if (vars["exchange"] != exchange and vars["extension"] != extension) then
        return
    end

    local status = ix.phone.switch:Dial(exchange, extension, dialSeq)
    if (status) then
        net.Start("LineStatusUpdate")
            net.WriteString(status)
        net.Send(client)

        if (status != ix.phone.switch.DialStatus.Success and
            status != ix.phone.switch.DialStatus.DebugMode) then
            net.Start("ixConnectedCallStatusChange")
                net.WriteBool(true)
                net.WriteBool(false)
            net.Send(client)
        end
    end
end)

net.Receive("RunHangupLandline", function (len, client)
    PLUGIN:runHangupOnClient(client)
end)

net.Receive("RunGetPeerName", function (len, client)
    if (!client or !IsValid(client)) then
        return
    end

    local char = client:GetCharacter()
    local charMD = char:GetLandlineConnection()

    if (charMD.active) then
        if (!charMD.extension or !charMD.exchange) then
            return
        end

        recievers = ix.phone.switch:GetReceivers(charMD.exchange, charMD.extension)
        if (!recievers or #recievers < 1) then
            return
        end

        net.Start("OnGetPeerName")
            net.WriteString(recievers[1]["name"])
        net.Send(client)
    end
end)

function PLUGIN:runHangupOnClient(client)
    if (!client or !IsValid(client)) then
        return
    end
    local data = {}
        data.start = client:GetShootPos()
        data.endpos = data.start + client:GetAimVector() * 96
        data.filter = client
    local target = util.TraceLine(data).Entity

    if (!target or target.PrintName != "Landline Phone") then
        return
    end

    target:HangUp()
end

-- PHONE CLEANUP
-- this function literally just dumps all current ongoing connections that happen to have this client in them
local function cleanupActivePhoneConnectionsForClient(client)
    if (!client or !IsValid(client)) then
        return
    end

    local char = client:GetCharacter()
    local charCallMD = nil
    -- why do I have to do all this checking?? UGH thanks helix
    if (char and char.GetLandlineConnection) then
        charCallMD = char:GetLandlineConnection()
    end
    if (istable(charCallMD) and charCallMD["active"]) then
        ix.phone.switch:DisconnectActiveCallIfPresentOnClient(client)
    end

    if (char) then
        char:SetLandlineConnection({
            active = false,
            exchange = nil,
            extension = nil
        })
    end
end

-- peak laziness:
function PLUGIN:PlayerDisconnected(client)
    cleanupActivePhoneConnectionsForClient(client)
end

function PLUGIN:OnCharacterFallover(client, entity, bFallenOver)
    cleanupActivePhoneConnectionsForClient(client)
end

function PLUGIN:PlayerDeath(client)
    cleanupActivePhoneConnectionsForClient(client)
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
    cleanupActivePhoneConnectionsForClient(client)
end
