--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- this is a loose implementation of a virtual private business exchange (vPBX)
ix.phone = ix.phone or {}
ix.phone.switch = ix.phone.switch or {}
ix.phone.switch.lineTestPBX = 9
ix.phone.switch.lineTestExt = 999 -- reserved for testing

do
    -- set up ent to use for 2 way call testing
    timer.Simple(10, function()
        local lineTestEnt = ents.Create("landline_phone")
        lineTestEnt:SetPos(Vector(0, 0, 0))
        lineTestEnt:Spawn()
        lineTestEnt:SetNoDraw(true)
        -- if we dont do this then our landline point ent will fall through the world
        -- and get deleted
        local _phys = lineTestEnt:GetPhysicsObject()
        _phys:EnableGravity(false)
        _phys:EnableMotion(false)
        _phys:Sleep()

        lineTestEnt.currentName = "Line Test"
        lineTestEnt.currentPBX = ix.phone.switch.lineTestPBX
        lineTestEnt.currentExtension = ix.phone.switch.lineTestExt

        -- yes we need a real entity for this. doesn't have to be a landline but might as well
        ix.phone.switch.lineTestEnt = lineTestEnt
    end)
end

--                                           (optional)
-- takes in a dial sequence in the format of (exchange)(extension)
--                                        ex:     1        234
-- it returns it into a table as {"exchange", "extension"}
function ix.phone.switch:decodeSeq(dialSeq)
    -- dial sequences must be strings, but must be a real number as well and must be 4 digits
    if (type(dialSeq) != "string" or tonumber(dialSeq) == nil) then
        return nil
    elseif (string.len(dialSeq) > 4 or string.len(dialSeq) < 3) then
        return nil
    end

    local exchange = nil
    if (string.len(dialSeq) != 3) then -- otherwise it is a local dial (to endpoint in own exchange)
        exchange = tonumber(string.sub(dialSeq, 0, 1))
        if (exchange == nil or exchange < 1) then
            return nil
        end
    end

    -- the remaining digits should be the extension
    local ext = tonumber(string.sub(dialSeq, 2, 4))
    if (ext == nil or ext < 1) then
        return nil
    end

    return {["exchange"] = exchange, ["extension"] = ext}
end

function ix.phone.switch:BuildNewTwoWayConnection(sourceExc, sourceExt, destExc, destExt)
    local connID = self:buildNewConnection()
    self:buildNewConnectionNode(connID, sourceExc, sourceExt)
    self:buildNewConnectionNode(connID, destExc, destExt)

    return connID
end

function ix.phone.switch:Dial(sourceExc, sourceExt, dialSeq)
    if (!self:DestExists(sourceExc, sourceExt)) then
        return self.DialStatus.SourceNotExist
    end

    --[[
        Decode the user provided dial sequence into a switchable pair of of pbx and ext
    ]]
    if (!istable(dialSeq) and #dialSeq < 1) then
        return self.DialStatus.NoDialSeq
    end

    local decodedDest = self:decodeSeq(dialSeq)

    if (!istable(decodedDest)) then
        return self.DialStatus.CannotDecodeDial
    end

    if (decodedDest.exchange == self.lineTestPBX and decodedDest.extension == self.lineTestExt) then
        self:StartLineTest(sourceExc, sourceExt)
        return self.DialStatus.DebugMode
    end

    if (decodedDest.exchange == nil) then
        decodedDest.exchange = sourceExc
    end

    if (!self:DestExists(decodedDest.exchange, decodedDest.extension)) then
        return self.DialStatus.NumberNotFound
    end

    --[[
        Get the endpoint IDs and corresponding entities for source & destination
    ]]
    local destination = self:GetDest(decodedDest.exchange, decodedDest.extension)
    local source = self:GetDest(sourceExc, sourceExt)

    if (!destination.endID or !source.endID) then
        return self.DialStatus.EndpointNotFound
    end

    local destEnt = self.endpoints:GetEndpoint(tonumber(destination.endID))
    local sourceEnt = self.endpoints:GetEndpoint(tonumber(source.endID))

    --[[
        Check if the line is busy
    ]]
    local _conn = self:GetActiveConnection(decodedDest.exchange, decodedDest.extension)
    if (_conn and istable(_conn) or destEnt.offHook) then
        return self.DialStatus.LineBusy
    end

    --[[
        Build new connection for source & dest with the pbxs and exts.
    ]]
    local connID = self:BuildNewTwoWayConnection(sourceExc, sourceExt,
        decodedDest.exchange, decodedDest.extension)

    --[[
        Setup the callbacks and start the call
    ]]
    local ringCallback = function(status)
        if (!status) then -- call did not go through so we need to clean up
            self:Disconnect(connID)
        end

        self:NotifyAllListenersOfStatusChange(tonumber(destination.endID), status, status)
        self:NotifyAllListenersOfStatusChange(tonumber(source.endID), status, status)
    end

    destEnt:EnterRing(ringCallback) -- set the target as ringing

    local hangUpCallback = function(status)
        -- cleanup
        self:Disconnect(connID)
    end

    destEnt.hangUpCallback = hangUpCallback
    sourceEnt.hangUpCallback = hangUpCallback

    return self.DialStatus.Success
end

-- returns back a list of player entities that are listening to the phone this character is speaking into
function ix.phone.switch:GetCharacterActiveListeners(character)
    if (!istable(character)) then
        return
    end

    local connMD = character:GetLandlineConnection()
    if (!connMD) then
        return
    end

    return self:GetListeners(connMD.exchange, connMD.extension)
end

function ix.phone.switch:GetPlayerActiveListeners(client)
    local character = client:GetCharacter()
    if (!istable(character)) then
        return nil
    end

    return self:GetCharacterActiveListeners(character)
end

-- rudely hangs up every single active call related to this character
-- typically used when the player disconnects or switches chars mid call
function ix.phone.switch:DisconnectActiveCallIfPresentOnClient(client)
    local character = client:GetCharacter()
    if (!istable(character)) then
        return
    end

    local connMD = character:GetLandlineConnection()
    if (!istable(connMD) and !connMD["active"]) then
        -- probably ran hangup on a phone someone else was speaking on
        -- we should allow this in the future (maybe?) but for now we exit
        client:NotifyLocalized("You are not speaking on the phone.")
        return
    end

    -- terminate any existing connections here 
    local conn = self:GetActiveConnection(connMD["exchange"], connMD["extension"])
    if (!istable(conn)) then
        client:NotifyLocalized("Error: AttemptedHangupOnActivePhoneNoConn")
        -- This shouldn't be possible but if it happens then there is some lingering issue with
        -- this character's var being active when they are not in an active connection
        self:ResetCharVars(character)
        return
    end

    self:Disconnect(conn["targetConnID"])
end

-- returns whether or not the 'listener' is in an active phone call with 'speaker'
function ix.phone.switch:ListenerCanHearSpeaker(speaker, listener)
    local speakerChar = speaker:GetCharacter()
    local listeners = self:GetCharacterActiveListeners(speakerChar)
    if (!istable(listeners)) then
        -- doubly make sure that the call activity is set correctly on the caller
        speaker:NotifyLocalized("You are not currently on a phone call!")
        ErrorNoHaltWithStack("Speaker ("..tostring(speaker:GetName())..") has invalid listener list!")
        self:ResetCharVars(speakerChar)
        return false
    end

    for _, _listener in ipairs(listeners) do
        if (_listener == listener) then
            return true
        end
    end

    return false
end

--[[
    Some helpers for setting the correct things in the correct order
]]

-- Reset ix.character.landlineConnection variables to default state
function ix.phone.switch:ResetCharVars(character)
    character:SetLandlineConnection({
        active = false,
        exchange = nil,
        extension = nil
    })
end

-- Set ix.character.landlineConnection variables
function ix.phone.switch:SetCharVars(character, bActive, exc, ext)
    character:SetLandlineConnection({
        active = bActive,
        exchange = exc,
        extension = ext
    })
end

-- Create a fake destination for testing purposes
-- Do nothing if one exists already
function ix.phone.switch:initLineTestNumber()
    if (!self:ExchangeExists(self.lineTestPBX)) then
        self:AddExchange(self.lineTestPBX)
    end

    if (!self.lineTestEnt.endpointID) then
        self.lineTestEnt.endpointID = self.endpoints:Register(self.lineTestEnt)
        print("Line Test Initalized! EndID: "..tostring(self.lineTestEnt.endpointID))
    end

    local destination = self:GetDest(self.lineTestPBX, self.lineTestExt)
    if (!destination) then
        self:AddDest(self.lineTestPBX, self.lineTestExt, "Line Test", self.lineTestEnt.endpointID)
    end
end

-- used for debugging purposes (by doing lua_run in rcon)
-- calls a specific landline
function ix.phone.switch:DebugSinglePartyCall(exchange, ext)
    if (!self:DestExists(exchange, ext)) then
        ErrorNoHalt("Destination does not exist!")
        return -- source does not exist or is not valid
    end

    self:initLineTestNumber()
    local connID = self:buildNewConnection()
    self:buildNewConnectionNode(connID, exchange, ext)
    self:buildNewConnectionNode(connID, self.lineTestPBX, self.lineTestExt)

    local dest = self:GetDest(exchange, ext)

    if (!istable(dest)) then
        self:Disconnect(connID) -- source dissapeared for some reason
        ErrorNoHalt("Destination does not exist, or is invalid!")
        return
    end

    print("Destination Endpoint Found!: "..table.ToString(dest, "Destination Endpoint", true))

    local destEnt = self.endpoints:GetEndpoint(tonumber(dest.endID))
    print("Destination Entity Found! ID: "..tostring(destEnt:EntIndex()))

    destEnt:EnterRing(function(status)
        if (!status) then -- call did not go through so we need to clean up
            self:Disconnect(connID)
        end

        self:NotifyAllListenersOfStatusChange(tonumber(dest.endID), status, status)
        local client = destEnt.inUseBy
        net.Start("LineTestChat")
            net.WriteString("This is a test to determine connection stability. It will automatically disconnect in 10 seconds.")
        net.Send(client)

        net.Start("LineStatusUpdate")
            net.WriteString(self.DialStatus.DebugMode)
        net.Send(client)

        timer.Simple(15, function()
            net.Start("LineTestChat")
                net.WriteString("Line test has completed. Disconnecting now.")
            net.Send(client)

            self:Disconnect(connID)
        end)
    end)

    local hangUpCallback = function()
        -- cleanup
        self:Disconnect(connID)
    end

    destEnt.hangUpCallback = hangUpCallback
end

-- used for debugging purposes
-- allows landline to make a call out to a test entity placed at map root
function ix.phone.switch:StartLineTest(exchange, ext)
    if (!self:DestExists(exchange, ext)) then
        ErrorNoHalt("Source does not exist!")
        return -- source does not exist or is not valid
    end

    self:initLineTestNumber()
    local connID = self:BuildNewTwoWayConnection(exchange, ext, self.lineTestPBX, self.lineTestExt)

    local conn = self:GetActiveConnection(exchange, ext)
    if (!istable(conn)) then
        ErrorNoHalt("Failed to construct connection nodes! ", tostring(connID))
        return
    end

    print("Connection nodes constructed!: "..table.ToString(conn, "ConnID: "..tostring(connID), true))
    local source = self:GetDest(exchange, ext)

    if (!istable(source)) then
        self:Disconnect(connID) -- source dissapeared for some reason
        ErrorNoHalt("Source does not exist, or is invalid!")
        return
    end

    print("Source Endpoint Found!: "..table.ToString(source, "Source Endpoint", true))

    local sourceEnt = self.endpoints:GetEndpoint(tonumber(source["endID"]))
    print("Source Entity Found! ID: "..tostring(sourceEnt:EntIndex()))

    local listeners = self:GetListeners(self.lineTestPBX, self.lineTestExt)
    local client = listeners[1]
    if (!client) then
        self:Disconnect(connID)
        print("Destination listener pool: "..table.ToString(listeners, "Listener Pool", true))
        ErrorNoHalt("Destination has no listeners!")
        return
    end

    local hangUpCallback = function()
        -- cleanup
        self:Disconnect(connID)
    end

    sourceEnt.hangUpCallback = hangUpCallback

    print("Line Test Listener Found! ID: "..tostring(client))
    timer.Simple(2, function()
        net.Start("ixConnectedCallStatusChange")
            net.WriteBool(true)
            net.WriteBool(true)
        net.Send(client)

        net.Start("LineTestChat")
            net.WriteString("This is a test to determine connection stability. It will automatically disconnect in 10 seconds.")
        net.Send(client)
    end)

    timer.Simple(15, function()
        net.Start("LineTestChat")
            net.WriteString("Line test has completed. Disconnecting now.")
        net.Send(client)

        net.Start("ixConnectedCallStatusChange")
            net.WriteBool(false)
            net.WriteBool(false)
        net.Send(client)

        self:Disconnect(connID)
    end)
end
