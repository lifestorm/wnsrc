--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ix.phone = ix.phone or {}
ix.phone.switch = ix.phone.switch or {}

-- a volatile table for caching ongoing connections
ix.phone.switch.connections = ix.phone.switch.connections or {}

function ix.phone.switch:ConnectionValid(connID)
    if (self.connections[connID] == false) then
        return false
    end

    return istable(self.connections[connID])
end

function ix.phone.switch:buildNewConnectionNode(connID, extID, extNum)
    -- helper function to create source requests for connections
    -- constructs a table that can be used by ix.phone.switch:connect()
    if (!self:ConnectionValid(connID)) then
        return
    end

    if (!self.connections[connID].nodes) then
        self.connections[connID].nodes = {}
    end

    local nodeID = #self.connections[connID].nodes + 1
    self.connections[connID].nodes[nodeID] = {}
    self.connections[connID].nodes[nodeID]["exchange"] = extID
    self.connections[connID].nodes[nodeID]["extension"] = extNum
end

function ix.phone.switch:buildNewConnection()
    -- helper function to that creates a new connection

    -- attempt to reuse a freshly terminated connection
    for id, conn in ipairs(self.connections) do
        if (conn == false) then
            self.connections[id] = {}
            return id
        end
    end

    -- no terminated connections
    connectionID = #self.connections + 1
    self.connections[connectionID] = {}

    return connectionID
end

function ix.phone.switch:Disconnect(connID, noNotify)
    -- disconnects provided connection at connID
    -- if notify is set, then it wont notify listeners that the connection is terminated
    if (!istable(self.connections[connID])) then
        return
    end

    local _nodes = self.connections[connID].nodes
    for _, node in ipairs(_nodes) do
        local recievers = self:getReceivers(node.exchange, node.extension)

        if (!istable(recievers) or table.Count(recievers) < 1) then
            continue
        end

        for _, reciever in ipairs(recievers) do
            local ent = self.endpoints:GetEndpoint(reciever.endID)
            if (ent and ent.HangUp and ent.isRinging) then
                ent:HangUp()
            end
        end

        local listeners = self:getListenersFromRecvs(recievers)

        if (!listeners or table.Count(listeners) < 1) then
            continue
        end

        for _, listener in ipairs(listeners) do
            self:DisconnectClient(listener)
        end
    end

    self.connections[connID] = false
end

-- disconnects the client's status and notifies them of said status change
-- IMPORTANT: Make sure you destroy the connection too!
function ix.phone.switch:DisconnectClient(client)
    if (!client or !IsValid(client)) then
        return ErrorNoHaltWithStack("Attempt to disconnect invalid client "..tostring(client))
    end

    local character = client:GetCharacter()
    if (!istable(character)) then
        return ErrorNoHaltWithStack("Attempt to disconnect client with invalid character "..tostring(character))
    end

    self:ResetCharVars(character)
    self:NotifyStatusChange(client, false, false)
end

function ix.phone.switch:NotifyStatusChange(client, bCallActive, bInCall)
    net.Start("ixConnectedCallStatusChange")
        net.WriteBool(bCallActive)
        net.WriteBool(bInCall)
    net.Send(client)
end

function ix.phone.switch:NotifyAllListenersOfStatusChange(endID, bCallActive, bInCall)
    local listeners = self.endpoints:GetListeners(endID)
    if (!listeners or table.Count(listeners) < 1) then
        return -- no need to do anything; no listeners
    end

    for _, listener in ipairs(listeners) do
        -- notify all listeners of their call status change
        self:NotifyStatusChange(listener, bCallActive, bInCall)
    end
end

function ix.phone.switch:getListenersFromRecvs(recievers)
    local listeners = {}
    for k, recv in ipairs(recievers) do
        -- there will almost always be one reciever.. but treating this as a list in case we ever do 'conference calls'
        local _listeners = self.endpoints:GetListeners(recv.endID)
        if (istable(_listeners)) then
            for _, listener in ipairs(_listeners) do
                listeners[table.Count(listeners) + 1] = listener
            end
        end
    end

    return listeners
end

function ix.phone.switch:getReceivers(extID, extNum)
    local conn = self:GetActiveConnection(extID, extNum)
    if (!istable(conn)) then
        return
    end

    return self:getSourceRecieversFromConnection(conn.targetConnID,
        conn.sourceNodeID)
end

function ix.phone.switch:GetListeners(extID, extNum)
    return self:getListenersFromRecvs(self:getReceivers(extID, extNum))
end

function ix.phone.switch:GetReceivers(extID, extNum)
    local conn = self:GetActiveConnection(extID, extNum)
    if (!istable(conn)) then
        return
    end

    return self:getSourceRecieversFromConnection(conn.targetConnID,
        conn.sourceNodeID)
end

-- returns the active connection in the form of {"targetConnID", "sourceNodeID"} if one is present
function ix.phone.switch:GetActiveConnection(extID, extNum)
    for connID, conn in ipairs(self.connections) do
        if (conn == false) then
            continue
        end

        for nodeID, node in ipairs(conn.nodes) do
            if (node["exchange"] == extID and node["extension"] == extNum) then
                -- source is present in this connection
                return {targetConnID = connID, sourceNodeID = nodeID}
            end
        end
    end
end

-- returns the actively connected (except for the source) recievers for a given connection
function ix.phone.switch:getSourceRecieversFromConnection(connID, sourceNodeID)
    local res = {}
    for nodeID, node in ipairs(self.connections[connID].nodes) do
        if (nodeID != sourceNodeID) then
            -- we want to return this as it exists in the exchange as that will give us 
            -- extra details the node tree does not contain such as name and endID
            res[#res + 1] = self:GetDest(node["exchange"], node["extension"])
        end
    end

    return res
end
