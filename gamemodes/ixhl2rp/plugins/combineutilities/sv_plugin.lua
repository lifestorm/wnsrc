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

function PLUGIN:GetHookCallPriority(hook)
	if (hook == "HandlePlayerDeath") then
		return 1100
	end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
    -- Datafile
    local bHasDatafile = character:GetHasDatafile()

    if (!bHasDatafile) then
        PLUGIN:CreateDatafile(client)
    end

    -- Teams
    if (client:IsCombine()) then
        self:LeaveTeam(client)

        net.Start("ixPTSync")
            net.WriteBool(true)
            net.WriteTable(self.teams)
        net.Send(client)
    else
        if (client:GetNetVar("ProtectionTeam")) then
            self:LeaveTeam(client)
        end

        net.Start("ixPTSync")
            net.WriteBool(false)
        net.Send(client)
    end
end

function PLUGIN:PostCalculatePlayerDamage(victim, damage, hitgroup)
    if (victim.beingAmputated and victim.beingAmputatedEnd > CurTime() and damage:GetAttacker() == victim.beingAmputated) then
        damage:ScaleDamage(hitgroup == HITGROUP_HEAD and 10 or 5)
    end
end

function PLUGIN:HandlePlayerDeath(victim, damage)
    if (victim.beingAmputated and victim.beingAmputatedEnd > CurTime() and damage:GetAttacker() == victim.beingAmputated) then
        for _, v in ipairs(player.GetAll()) do
            if (CAMI.PlayerHasAccess(v, "Helix - Ban Character")) then
                v:ChatNotify(victim.beingAmputated:Name().." has amputated "..victim:Name().." for: "..(victim.beingAmputatedReason or "no reason given"))
            end
        end
        victim.beingAmputated:Notify("Verdict delivered!")

        victim.beingAmputated = nil
        victim.beingAmputatedEnd = nil
        victim.beingAmputatedReason = nil

        return true --Do not let medical plugin interfere and put player in bleedout
    end
end

-- Entity related functions
function PLUGIN:PlayerButtonDown( client, key )
    if (IsFirstTimePredicted() and key == KEY_LALT) then
        local entity = client:GetEyeTraceNoCursor().Entity

        if !IsValid(entity) then
            return false
        end

        if !entity.canUse then
            return false
        end

        if (client:GetShootPos():Distance(entity:GetPos()) > 100) then
            return false
        end

        if entity:GetNWInt("owner") and client:GetCharacter():GetID() != entity:GetNWInt("owner") then
            return false
        end

        if entity.hasDiskInserted then client:NotifyLocalized("This computer has a disk inserted!") return false end

        if (entity:GetClass() == "ix_medical_computer" or entity:GetClass() == "ix_computer") then
            local getUsers = entity.users
            local getNotes = entity.notes

            local activeClass = "med_computer"

            if entity:GetClass() == "ix_computer" then
                activeClass = "cit_computer"
            end

            local pos = entity:GetPos()

            ix.item.Spawn(activeClass, pos + Vector( 0, 0, 2 ), function(item, entityCreated) item:SetData("users", getUsers) item:SetData("notes", getNotes) end, entity:GetAngles())

            entity:Remove()
        end
    end
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_medical_computer", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.motion = false
            data.users = entity.users
            data.notes = entity.notes
            data.owner = entity:GetNWInt("owner")
		end,
        OnRestore = function(entity, data)
            entity.users = data.users
            entity.notes = data.notes
            entity:SetNWInt("owner", data.owner)
        end
	})

    ix.saveEnts:RegisterEntity("ix_computer", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.motion = false
            data.users = entity.users
            data.notes = entity.notes
            data.owner = entity:GetNWInt("owner")
		end,
        OnRestore = function(entity, data)
            entity.users = data.users
            entity.notes = data.notes
            entity:SetNWInt("owner", data.owner)
        end
	})

    ix.saveEnts:RegisterEntity("ix_terminal", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})

    ix.saveEnts:RegisterEntity("ix_console", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})

    ix.saveEnts:RegisterEntity("npc_combine_camera", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
        OnRestore = function(entity, data)
            entity:SetOwner(nil)
        end,
	})

    ix.saveEnts:RegisterEntity("ix_workshiftterminal", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})
end

function PLUGIN:CanInsertDisk(client, item)
    if !client then return false end
    if !client:Alive() then return false end

    local targetEnt = client:GetEyeTraceNoCursor().Entity
    if !targetEnt then client:Notify("You are not looking at a computer!") return false end
    if !IsValid(targetEnt) then client:Notify("You are not looking at a computer!") return false end
    local entClass = targetEnt:GetClass()
    if (entClass != "ix_medical_computer" and entClass != "ix_computer") then client:Notify("You are not looking at a computer!") return false end
    if targetEnt.hasDiskInserted then client:Notify("There is already a disk in this computer!") return false end

    return targetEnt
end

function PLUGIN:InsertDisk(client, item)
    local computerEnt = self:CanInsertDisk(client, item)
    if !computerEnt or (computerEnt and !IsValid(computerEnt)) then return false end

    local bSuccess, error = item:Transfer(nil, nil, nil, item.player)
    if (!bSuccess and isstring(error)) then
        client:Notify("Could not drop the disk and insert it.")
        return
    end

    local disk = bSuccess
	local rotation = Vector(0, 0, 0)
    local angle = computerEnt:GetAngles()
	angle:RotateAroundAxis(angle:Up(), rotation.x)

    disk:SetAngles(angle)
    disk:SetPos(computerEnt:GetPos() + computerEnt:GetUp() * -1.5 + computerEnt:GetForward() * -15)
    constraint.Weld( disk, computerEnt, 0, 0, 0, true, false )
    local physObj = disk:GetPhysicsObject()
    if !physObj then return end
    physObj:EnableMotion(false)

    computerEnt.hasDiskInserted = item:GetID()
    item.computer = computerEnt
end

netstream.Hook("RequestFloppyDiskData", function(client, computerEnt, password)
    if !computerEnt then return false end
    if !IsValid(computerEnt) then return false end
    if !IsEntity(computerEnt) then return false end
    local diskItem = ix.item.instances[computerEnt.hasDiskInserted]
    if !diskItem then return false end

    local diskPassword = diskItem:GetData("password", false)
    local diskData = diskItem:GetData("content", false)

    if !diskPassword then
        netstream.Start(client, "ReplyFloppyDiskData", true, false, diskData)
        return
    end

    if (diskPassword and !password) or !password then
        netstream.Start(client, "ReplyFloppyDiskData", false)
        return
    end

    if (diskPassword != password) then
        netstream.Start(client, "ReplyFloppyDiskData", false, true)
        return
    end

    if (diskPassword == password) then
        netstream.Start(client, "ReplyFloppyDiskData", true, false, diskData)
        return
    end
end)

netstream.Hook("FloppyDiskSetPassword", function(client, newPass, computerEnt)
    if !computerEnt then return false end
    if !IsValid(computerEnt) then return false end
    if !IsEntity(computerEnt) then return false end
    local diskItem = ix.item.instances[computerEnt.hasDiskInserted]
    if !diskItem then return false end

    diskItem:SetData("password", newPass)
end)

netstream.Hook("FloppyDiskSetData", function(client, newContent, computerEnt)
    if !computerEnt then return false end
    if !IsValid(computerEnt) then return false end
    if !IsEntity(computerEnt) then return false end
    local diskItem = ix.item.instances[computerEnt.hasDiskInserted]
    if !diskItem then return false end

    diskItem:SetData("content", newContent)
end)

netstream.Hook("SetFloppyDiskName", function(client, text, itemID, password)
    local character = client:GetCharacter()
    if !character then return false end

    local inventory = character:GetInventory()
    if !inventory then return false end

    local item = ix.item.instances[itemID]
    if !item then return end

    local password2 = item:GetData("password", false)
    if password2 and !password then return end

    if password2 != password then
        client:NotifyLocalized("Wrong password.")
        return
    end

    if !inventory.GetItemByID then return false end
    if !inventory:GetItemByID(itemID) then
        local targetEnt = client:GetEyeTraceNoCursor().Entity
        if !IsValid(targetEnt) then return false end
        if targetEnt:GetClass() != "ix_item" then return false end
        if (targetEnt.ixItemID and targetEnt.ixItemID != itemID) then return false end
    end

    item:SetData("customName", Schema:FirstToUpper(text))
    client:NotifyLocalized("Set the disk name to "..Schema:FirstToUpper(text))
end)

netstream.Hook("FindLetterRecepient", function(client, text, itemID)
    local character = client:GetCharacter()
    if !character then return end

    local inventory = character:GetInventory()
    if !inventory then return end

    if !inventory:GetItemByID(itemID) then return end
    if inventory:GetItemByID(itemID).name != "Paper" then return end

    if string.len(text) == 5 and isnumber(tonumber(text)) then
        text = Schema:ZeroNumber(tonumber(text), 5)
    end

    local id = false
    local name = false
    local cid = false
    for _, v in pairs(ix.char.loaded) do
        if !isnumber(text) and string.len(tostring(text)) != 5 then
            if (ix.util.StringMatches(v:GetName(), text)) then
                id = v:GetID()
                name = v:GetName()
                cid = v:GetCid()
                break
            end
        else
            if ix.util.StringMatches(tostring(v:GetCid()), tostring(text)) then
                id = v:GetID()
                name = v:GetName()
                cid = v:GetCid()
                break
            end
        end
    end

    if !id or !name or !cid then
        local receiverQuery = mysql:Select("ix_characters")
        receiverQuery:Select("id")
        receiverQuery:Select("name")
        receiverQuery:Select("cid")

        if !isnumber(text) and string.len(tostring(text)) != 5 then
            receiverQuery:WhereLike("name", text)
        else
            receiverQuery:WhereLike("cid", text)
        end

        receiverQuery:Callback(function(result)
            if (!result or !istable(result) or #result == 0) then
                return
            end

            local first = result[1]
            id = first.id
            name = first.name
            cid = first.cid
        end)

        receiverQuery:Execute()
    end

    timer.Simple(3, function()
        if !id or !name or !cid then client:Notify("Could not find the person you were trying to send a letter to.") return end
        cid = cid or "00000"
        netstream.Start(client, "ReplyLetterRecepient", id, name, cid, itemID)
    end)
end)

function PLUGIN:AddLogToDatafile(client, toCharID, fromCID, fromName)
    local whomData = {
        fromGenericData = false,
        fromLogsTable = false,
        toGenericData = false,
        toLogsTable = false
    }

    for _, v in pairs(ix.char.loaded) do
        if ix.util.StringMatches(tostring(v:GetCid()), tostring(fromCID)) then
            whomData.fromGenericData = v:GetGenericdata()
            whomData.fromLogsTable = v:GetDatafilelogs()
            break
        end
    end

    if ix.char.loaded[tonumber(toCharID)] then
        whomData.toGenericData = ix.char.loaded[tonumber(toCharID)]:GetGenericdata()
        whomData.toLogsTable = ix.char.loaded[tonumber(toCharID)]:GetDatafilelogs()
    end

    local addLogsTo = {["to"] = toCharID, ["from"] = fromCID}
    if whomData.fromGenericData and whomData.fromLogsTable then addLogsTo["from"] = nil end
    if whomData.toGenericData and whomData.toLogsTable then addLogsTo["to"] = nil end

    if !whomData.fromGenericData or !whomData.fromLogsTable or !whomData.toGenericData or !whomData.toLogsTable then
        for whom, id in pairs(addLogsTo) do
            local query = mysql:Select("ix_characters")
            query:Select("name")
            query:Select("faction")
            query:Select("id")
            query:Select("cid")

            if whom != "to" then
                query:Where("cid", id)
            else
                query:Where("id", id)
            end

            query:Where("schema", Schema and Schema.folder or "helix")
            query:Callback(function(result)
                if (!istable(result) or #result == 0) then
                    return
                end

                local dataSelect = mysql:Select("ix_characters_data")
                dataSelect:Where("id", result[1].id)
                dataSelect:WhereIn("key", {"genericdata", "datafilelogs"})
                dataSelect:Callback(function(dataSelectResult)
                    if (!istable(dataSelectResult) or #dataSelectResult == 0) then
                        return
                    end

                    for _, v in ipairs(dataSelectResult) do
                        if whom == "to" then
                            if v.key == "genericdata" then
                                whomData.toGenericData = util.JSONToTable(v.data or "")
                            elseif v.key == "datafilelogs" then
                                whomData.toLogsTable = util.JSONToTable(v.data or "")
                            end
                        else
                            if v.key == "genericdata" then
                                whomData.fromGenericData = util.JSONToTable(v.data or "")
                            elseif v.key == "datafilelogs" then
                                whomData.fromLogsTable = util.JSONToTable(v.data or "")
                            end
                        end
                    end
                end)
                dataSelect:Execute()

            end)
            query:Execute()
        end
    end

    timer.Simple(4, function()
        if whomData.fromGenericData and whomData.fromLogsTable and whomData.toGenericData and whomData.toLogsTable then
            local combineutilities = ix.plugin.list["combineutilities"]
            if combineutilities and combineutilities.AddLog then
                for i = 1, 2 do
                    local logsT = (i == 1 and whomData.fromLogsTable or whomData.toLogsTable)
                    local genericT = (i == 1 and whomData.fromGenericData or whomData.toGenericData)
                    local fromName1 = whomData.fromGenericData.name or ""
                    local fromCID1 = whomData.fromGenericData.cid or ""
                    local toName = whomData.toGenericData.name or ""
                    local toCID = whomData.toGenericData.cid or ""

                    if (i == 1) then -- Only need the notification once
                        ix.combineNotify:AddNotification("LOG:// Subject '" .. fromName1 .. "' sent a letter to '" .. toName .. "'", nil, client)
                    end

                    combineutilities:AddLog(client, logsT, genericT, "TERMINAL", nil, "LETTER SENT/RECEIVED - "..fromName1.." | "..fromCID1.." -> "..toName.." | "..toCID, true, true)
                end
            end
        end
    end)
end

netstream.Hook("SendLetterToID", function(client, charID, itemID, fromCID, fromName)
    local character = client:GetCharacter()
    if !character then return end

    local inventory = character:GetInventory()
    if !inventory then return end

    if !inventory:GetItemByID(itemID) then return end
    if inventory:GetItemByID(itemID).name != "Paper" then return end

    local paperInstance = ix.item.instances[tonumber(itemID)]
    if !paperInstance then return end

    local paperWritingID = paperInstance:GetData("writingID")
    if !paperWritingID then return end

    local paperTitle = paperInstance:GetData("title", "Paper")
    local currentOwner = paperInstance:GetData("owner", false)

    if ix.char.loaded[tonumber(charID)] then
        ix.char.loaded[tonumber(charID)]:SetPurchasedItems("letter_"..itemID, {title = paperTitle, fromCID = fromCID, fromName = fromName, writingID = paperWritingID, owner = currentOwner})
        client:Notify("Letter has been successfully sent.")
        PLUGIN:AddLogToDatafile(client, charID, fromCID, fromName)
        ix.item.instances[tonumber(itemID)]:Remove()
    else
        local dataSelect = mysql:Select("ix_characters_data")
        dataSelect:Where("id", tonumber(charID))
        dataSelect:WhereIn("key", "purchasedItems")
        dataSelect:Callback(function(dataSelectResult)
            if (!istable(dataSelectResult) or #dataSelectResult == 0) then
                return
            end

            local purchasedItems = util.JSONToTable(dataSelectResult[1].data)
            if !purchasedItems then return end

            purchasedItems["letter_"..itemID] = {title = paperTitle, fromCID = fromCID, fromName = fromName, writingID = paperWritingID, owner = currentOwner}

            local updateQuery = mysql:Update("ix_characters_data")
            updateQuery:Update("data", util.TableToJSON(purchasedItems))
            updateQuery:Where("id", tonumber(charID))
            updateQuery:Where("key", "purchasedItems")
            updateQuery:Execute()

            ix.item.instances[tonumber(itemID)]:Remove()

            PLUGIN:AddLogToDatafile(client, charID, fromCID, fromName)
        end)
        dataSelect:Execute()

        client:Notify("Letter has been successfully sent.")
    end
end)
