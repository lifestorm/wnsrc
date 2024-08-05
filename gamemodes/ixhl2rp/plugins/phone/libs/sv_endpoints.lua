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

-- a flat list of all the entities. each entity has an associated 'listeners' table which contains all of the players actively connected to that entity
ix.phone.switch.endpoints = ix.phone.switch.endpoints or {}

function ix.phone.switch.endpoints:exists(id)
    return self[id] != nil
end

function ix.phone.switch.endpoints:entExists(entIdx)
    for id, ent in ipairs(self) do
        if (entIdx == ent:EntIndex()) then
            return id
        end
    end
    return nil
end

function ix.phone.switch.endpoints:Register(ent)
    -- assigns an ID. if the ent already exists then it will return the existing id
    -- we need to have our own ID here rather than the index because the entity index might change but
    -- in that case the id shouldn't

    local entExists = self:entExists(ent:EntIndex())
    if (entExists != nil) then
        return nil
    end

    local newID = math.random(1000, 9999)
    if (self:exists(newID)) then
        return nil
    end

    self[newID] = ent
    return newID
end

function ix.phone.switch.endpoints:DeRegister(id)
    self[id] = nil
end

function ix.phone.switch.endpoints:GetEndpoint(id)
    -- returns the associated entity table
    if (self:exists(id)) then
        return self[id]
    end
end

function ix.phone.switch.endpoints:AddListener(id, client)
    if (!istable(self[id].listeners)) then
        self[id].listeners = {}
    end

    for _, listener in ipairs(self[id].listeners) do
        if (listener == client) then
            return
        end
    end

    self[id].listeners[table.Count(self[id].listeners) + 1] = client
end

function ix.phone.switch.endpoints:RmListener(id, client)
    if (!istable(self[id].listeners)) then
        return
    end

    for k, listener in ipairs(self[id].listeners) do
        if (listener == client) then
            self[id].listeners[k] = nil
        end
    end
end

function ix.phone.switch.endpoints:GetListeners(id)
    return self[id].listeners
end

function ix.phone.switch.endpoints:RingEndpoint(id, callback)
    -- rings and endpoint and, if the phone is picked up, it will call callback as true. otherwise false
    -- if the destination is unavailable or busy then it will return nil
    local ent = self:GetEndpoint(id)

    if (ent.inUse or ent.isRinging) then
        return nil
    end

    ent:EnterRing(callback)
end

function ix.phone.switch.endpoints:GetPlayersInRadiusFromPos(pos, radius)
    local entsInside = ents.FindInSphere(pos, radius)
    local res = {}

    for _, _ent in ipairs(entsInside) do
        if (_ent:IsPlayer() and _ent.GetCharacter and _ent:GetCharacter()) then
            res[_ent:SteamID64()] = _ent
        end
    end

    return res
end

-- returns a list of players within X radius of the endpoint
function ix.phone.switch.endpoints:GetPlayersInRadius(id, radius)
    local ent = self:GetEndpoint(id)
    if (!ent) then
        return
    end

    return self:GetPlayersInRadiusFromPos(ent:GetPos(), radius)
end
