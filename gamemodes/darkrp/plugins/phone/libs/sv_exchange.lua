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
 
-- a table used for managing pbxs and their members
ix.phone.switch.exchanges = ix.phone.switch.exchanges or {}

--[[ The following is some boiler plate code for creating and managing extensions and exchanges
    In practice these things are just keys in a table and in the DB but it is probably best
    if you use the functions here and not directly modify ix.phone.switch.exchanges directly!

    This is necessary to keep the switching code readable 
]]
function ix.phone.switch:AddExchange(exID)
    if (self:ExchangeExists(exID)) then
        return false
    end

    self.exchanges[exID] = {}
    return true
end

function ix.phone.switch:RmExchange(exID)
    if (!self:ExchangeExists(exID)) then
        return false
    end

    self.exchanges[exID] = nil
    return true
end

function ix.phone.switch:ExchangeExists(exID)
    return self.exchanges[exID] != nil
end

function ix.phone.switch:DestExists(exID, extNum)
    if (self.exchanges[exID] != nil) then
        return self.exchanges[exID][extNum] != nil
    else
        return false
    end
end

function ix.phone.switch:AddDest(exID, extNum, extName, endID)
    -- returns false if destination exists or exchange doesn't
    -- set noDB if you do not wish to store this destination to the database
    if (self:DestExists(exID, extNum)) then
        return false
    end

    self.exchanges[exID][extNum] = {}
    self.exchanges[exID][extNum]["name"] = extName or ""
    self.exchanges[exID][extNum]["endID"] = endID
    return true
end

function ix.phone.switch:GetDest(exID, extNum)
    if (!self:DestExists(exID, extNum)) then
        return false
    end

    return self.exchanges[exID][extNum]
end

function ix.phone.switch:RmDest(exID, extNum)
    -- returns false if destination does not exist
    if (!self:DestExists(exID, extNum)) then
        return false
    end

    self.exchanges[exID][extNum] = nil

    return true
end

function ix.phone.switch:MvDest(fromExID, fromExtNum, toExID, toExtNum)
    if (!self:RmDest(fromExID, fromExtNum)) then
        return false
    end

    return self:AddDest(toExID, toExtNum)
end

function ix.phone.switch:SetName(exID, extNum, name)
    if (!self:DestExists(exID, extNum)) then
        return false
    end

    self.endpoints[self.exchanges[exID][extNum]["endID"]].currentName = name
    return true
end
