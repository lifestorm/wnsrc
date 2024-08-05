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

function PLUGIN:DatabaseConnected()
    for _, identifier in pairs(self.identifiers) do
        local query = mysql:Create("ix_"..identifier.."s")
        query:Create(identifier.."_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
        query:Create(identifier.."_data", "TEXT")
        query:PrimaryKey(identifier.."_id")
        query:Execute()
    end
end

function PLUGIN:FetchDatabaseWritingData(identifier, id, callback)
    local query = mysql:Select("ix_"..identifier.."s")
    query:Select(identifier.."_id")
    query:Select(identifier.."_data")
    query:Where(identifier.."_id", id)
    query:Limit(1)

    query:Callback(function(result)
        if (!istable(result) or #result == 0) then
            callback(false)
            return
        end

        if !callback or (callback and !isfunction(callback)) then return end
        callback(result)
    end)

    query:Execute()
end

function PLUGIN:FetchCachedWritingData(identifier, id)
    local cachedTable = self["cached"..Schema:FirstToUpper(identifier).."s"]
    if !cachedTable then return false end
    if !cachedTable[id] then return false end

    return cachedTable[id]
end

function PLUGIN:FetchWritingData(client, identifier, id, callback)
    local cachedData = self:FetchCachedWritingData(identifier, id)
    if cachedData then
        return callback(cachedData)
    end

    return self:FetchDatabaseWritingData(identifier, id, function(result)
        if !result then return false end
        if !result[1] then return false end

        local resultData = result[1][identifier.."_data"]
        if !resultData then return false end

        result[1][identifier.."_data"] = util.JSONToTable(resultData)

        local cachedTable = "cached"..Schema:FirstToUpper(identifier).."s"
        if self[cachedTable] then
            self[cachedTable][id] = result[1][identifier.."_data"]
        end

        return callback(result[1][identifier.."_data"])
    end)
end

function PLUGIN:AddWriting(client, identifier, data, item)
    if !item or (item and IsEntity(item)) then
        if identifier != "newspaper" then return false end
        local found = false
        for _, v in pairs(ents.FindInSphere( client:GetPos(), 100 )) do
            if v != item then continue end
            found = true
        end

        if !found then
            client:NotifyLocalized("You are not near a newspaper printer!")
            item:Close()
            return
        end

        local cachedTable = "cached"..Schema:FirstToUpper(identifier).."s"
        local queryObj = mysql:Insert("ix_"..identifier.."s")
        queryObj:Insert(identifier.."_data", util.TableToJSON(data))

        queryObj:Callback(function(result, status, lastID)
            self[cachedTable][lastID] = data
            item:PrintNewspaper(client, data, lastID)
        end)

        queryObj:Execute()

        return false
    end

    local success, lastOwner, editedTimes = self:ItemChecks(client, identifier, item)
    if !success then
        if lastOwner then
            client:NotifyLocalized(lastOwner)
        end

        return false
    end

    local cachedTable = "cached"..Schema:FirstToUpper(identifier).."s"
    local character = client:GetCharacter()
    if !character then return false end
    local writingID = item:GetData("writingID", false)
    if !editedTimes then editedTimes = 0 end

    data.owner = lastOwner or character.id
    data.font = character:GetHandwriting()
    data.editedTimes = editedTimes
    item:SetData("title", data.title or data.title1 or "")
    item:SetData("owner", data.owner)

    if writingID then
        data.editedTimes = editedTimes + 1

        local query2 = mysql:Update("ix_"..identifier.."s")
        query2:Where(identifier.."_id", writingID)
        query2:Update(identifier.."_data", util.TableToJSON(data))
        query2:Execute()

        self[cachedTable][writingID] = data
        return
    end

	local queryObj = mysql:Insert("ix_"..identifier.."s")
    queryObj:Insert(identifier.."_data", util.TableToJSON(data))

    queryObj:Callback(function(result, status, lastID)
        item:SetData("writingID", lastID)
        self[cachedTable][lastID] = data
    end)

	queryObj:Execute()
end

function PLUGIN:CheckForHandwriting(client)
    if !IsValid(client) then return false end

    local character = client:GetCharacter()
    if !character then return end

    local handWriting = character:GetHandwriting()
    if (!handWriting or !PLUGIN.validHandwriting[handWriting]) then
        client:NotifyLocalized("noHandwritingSelected")
        netstream.Start(client, "ixWritingOpenHandWritingSelector")
        return false
    end

    return true
end

function PLUGIN:CanOpenWriting(client)
    if client.CantPlace then
        client:NotifyLocalized("waitBeforeReadingWriting")
        return false
    end

    if !self:CheckForHandwriting(client) then return false end

    client.CantPlace = true

    timer.Simple(3, function()
        if client then
            client.CantPlace = false
        end
    end)

    return true
end

function PLUGIN:OpenWriting(client, item)
    if !self:CanOpenWriting(client) then return false end
    local writingID = item:GetData("writingID", false)
    local cracked = item:GetData("cracked", false)
    if writingID then
        self:FetchWritingData(client, item.identifier, writingID, function(data)
            if !data then
                client:NotifyLocalized("writingDataError")
                return
            end

            netstream.Start(client, "ixWritingOpenViewerEditor", item.id, item.identifier, data, {builder = false, cracked = cracked})
        end)

        return
    end

    netstream.Start(client, "ixWritingOpenViewerEditor", item.id, item.identifier)
end

function PLUGIN:ItemChecks(client, identifier, item)
    local character = client:GetCharacter()
    if !character then return false end

    local inventory = character:GetInventory()
    if !inventory then return false end

    if !inventory.GetItemByID then return false end
    if !inventory:GetItemByID(item.id) then
        local targetEnt = client:GetEyeTraceNoCursor().Entity
        if !IsValid(targetEnt) then return false end
        if targetEnt:GetClass() != "ix_item" then return false end
        if (targetEnt.ixItemID and targetEnt.ixItemID != item.id) then return false end
    end

    local writingID = item:GetData("writingID", false)
    if writingID then
        return self:FetchWritingData(client, identifier, writingID, function(data)
            if data.owner != character.id then return false, "writingOwnerNotYou" end
            if data.editedTimes and data.editedTimes >= ix.config.Get("maxEditTimes"..Schema:FirstToUpper(identifier), 0) then
                return false, "writingMaxEditsReached"
            end

            return true, data.owner, data.editedTimes
        end)
    end

    return true
end

function PLUGIN:SetHandwriting(client, targetChar, font)
    if !targetChar then return false end

    if (self.validHandwriting[font]) then
        targetChar:SetHandwriting(font)

        if (client:GetCharacter() != targetChar) then
            client:NotifyLocalized("writingFontSet", font)
        end
    else
        if !IsValid(client) then return false end

        return client:NotifyLocalized("writingFontInvalid")
    end
end

function PLUGIN:SetBookColor(client, itemID, bodygroups)
    local item = ix.item.instances[itemID]
    if !item then return false end
    if !self:ItemChecks(client, "book", item) then return false end

    item:SetBodygroups(bodygroups)
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("gmod_nail", true, true, false, {
		OnSave = function(entity, data) --OnSave
            if (!entity.itemparentPos) then
                entity.itemparentPos = ix.item.instances[entity.itemparentID]:GetEntity():GetPos()
            end

            if (!entity.itemparentAngs) then
                entity.itemparentAngs = ix.item.instances[entity.itemparentID]:GetEntity():GetAngles()
            end

            data.parent = entity.itemparentID
            data.parentPos = entity.itemparentPos
            data.parentAngs = entity.itemparentAngs
            data.motion = false
		end,
		OnRestore = function(entity, data) --OnRestore
            local parentEntity = ix.item.instances[data.parent]:GetEntity()
            entity:SetParent(parentEntity)
            entity.itemparentID = data.parent

            if (data.parentPos) then
                entity.itemparentPos = data.parentPos
                parentEntity:SetPos(data.parentPos)
            end

            if (data.parentAngs) then
                entity.itemparentAngs = data.parentAngs
                parentEntity:SetAngles(data.parentAngs)
            end

            parentEntity:GetPhysicsObject():EnableMotion(false)
		end,
        ShouldSave = function(entity)
            return entity.itemparentID and ix.item.instances[entity.itemparentID] and IsValid(ix.item.instances[entity.itemparentID]:GetEntity())
        end,
        ShouldRestore = function(data)
            if (!ix.item.instances[data.parent]) then return false end

            local parentEntity = ix.item.instances[data.parent]:GetEntity()
            if (!IsValid(parentEntity)) then return false end

            return true
        end
	})

    ix.saveEnts:RegisterEntity("ix_newspaperprinter", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.paper = entity.paper
            data.ink = entity.ink
            data.registeredCID = entity.registeredCID
            data.owner = entity:GetNWInt("owner")
		end,
		OnRestore = function(entity, data) --OnRestore
            entity.paper = data.paper or 0
            entity.ink = data.ink or 0
            entity:SetInk(data.ink or 0)
            entity:SetPaper(data.paper or 0)
            entity.registeredCID = data.registeredCID
            entity:SetNWInt("owner", data.owner)
		end,
	})

    ix.saveEnts:RegisterEntity("ix_crackedprinter", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.paper = entity.paper
            data.ink = entity.ink
            data.registeredCID = entity.registeredCID
            data.owner = entity:GetNWInt("owner")
		end,
		OnRestore = function(entity, data) --OnRestore
            entity.paper = data.paper or 0
            entity.ink = data.ink or 0
            entity:SetInk(data.ink or 0)
            entity:SetPaper(data.paper or 0)
            entity.registeredCID = data.registeredCID
            entity:SetNWInt("owner", data.owner)
		end,
	})
end

function PLUGIN:PostSaveEntsRestore(class)
    if (!class) then
        timer.Simple(30, function()
            ix.saveEnts:RestoreAll("gmod_nail")
        end)
    end
end

function PLUGIN:CanPlayerTakeItem(client, entity)
	local item = ix.item.instances[entity.ixItemID]
	if (!item) then return end

	local character = client:GetCharacter()
	local charid = character.id or character:GetID()
	local data = item.data or {}

	if data.pin and data.owner then
		if data.owner == charid then
			item:SetData("pin", false)
			return true
		else
			client:NotifyLocalized("You cannot pick up pinned items unless you own them!")
			return false
		end
	end
end

function PLUGIN:PlayerButtonDown( client, key )
    if (IsFirstTimePredicted() and key == KEY_LALT) then
        local entity = client:GetEyeTraceNoCursor().Entity
        if !IsValid(entity) then return false end
        if !entity.canUse then return false end

        if (client:GetShootPos():DistToSqr(entity:GetPos()) > 100 * 100) then return false end

        local character = client:GetCharacter()
        if !character then return false end

        if entity:GetNWInt("owner") and client:GetCharacter():GetID() != entity:GetNWInt("owner") then
            return false
        end

        if (entity:GetClass() == "ix_newspaperprinter" or entity:GetClass() == "ix_crackedprinter") then
            local getInk = entity.ink or 0
            local getPaper = entity.paper or 0
            local registeredCID = entity.registeredCID or "00000"
            local activeClass = "newspaper_printer"

            if entity:GetClass() == "ix_crackedprinter" then
                activeClass = "newspaper_printer_cracked"
            end

            local pos = entity:GetPos()

            ix.item.Spawn(activeClass, pos + Vector( 0, 0, 2 ), function(item, entityCreated)
                item:SetData("ink", getInk)
                item:SetData("paper", getPaper)
                item:SetData("registeredCID", registeredCID)
            end, entity:GetAngles())

            entity:Remove()
        end
    end
end

function PLUGIN:GetUnionNewspapers(client, bTerminal)
    local query = mysql:Select("ix_unionnewspapers")
    query:Select("unionnewspaper_id")
    query:Select("unionnewspaper_data")
    query:Callback(function(result)
        if (!istable(result) or #result == 0) then
            return
        end

        netstream.Start(client, "ixWritingReplyUnionNewspapers", result, bTerminal)
    end)

    query:Execute()
end

netstream.Hook("ixWritingGetUnionWritingData", function(client, writingID)
    PLUGIN:FetchWritingData(client, "newspaper", writingID, function(data)
        if !data then
            client:NotifyLocalized("writingDataError")
            return
        end

        netstream.Start(client, "ixWritingOpenViewerEditor", false, "newspaper", data, {builder = false, cracked = false})
    end)
end)

netstream.Hook("ixWritingGetUnionNewspapers", function(client, bTerminal)
    PLUGIN:GetUnionNewspapers(client, bTerminal)
end)

netstream.Hook("ixWritingSetBookColor", function(client, itemID, bodygroups)
    PLUGIN:SetBookColor(client, itemID, bodygroups)
end)

netstream.Hook("ixWritingAddWriting", function(client, identifier, data, itemID)
    local item
    if identifier != "newspaper" then
        item = (itemID and ix.item.instances[itemID] or false)
    end

    if identifier == "newspaper" then
        item = !Entity(itemID) and false or IsValid(Entity(itemID)) and Entity(itemID)
    end

    PLUGIN:AddWriting(client, identifier, data, item)
end)

netstream.Hook("ixWritingSetHandWriting", function(client, font)
    PLUGIN:SetHandwriting(client, client:GetCharacter(), font)
end)

netstream.Hook("ixWritingCloseNewspaperCreator", function(client, entityID)
    if isbool(entityID) then return false end
    if IsValid(Entity(entityID)) then
        if !Entity(entityID).Close then return end

        Entity(entityID):Close()
    end
end)