--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local netstream = netstream
local IsValid = IsValid
local ix = ix

local PLUGIN = PLUGIN

util.AddNetworkString("ixDoorPassword")

ix.log.AddType("containerlockSetOwner", function(client, inventoryId, ownerSteamID)
	return string.format("%s has changed the container's %s owner '%s'.", client:Name(), inventoryId, ownerSteamID)
end)

ix.log.AddType("doorSetLock", function(client, doorEnt)
	return string.format("%s has added a lock to a door. MapcreationID: %s, vector position: '%s'", client:Name(), doorEnt:MapCreationID(), doorEnt:GetPos())
end)

function PLUGIN:SetContainerPassword(client, entity, bShouldHaveLock, lockEntityID)
	entity.shouldHaveLock = true
	netstream.Start(client, "LockSetContainerPassword", entity, bShouldHaveLock, lockEntityID)
end

netstream.Hook("LockSetContainerPassword", function(client, entity, password, lockEntityID)
	if (!IsValid(entity)) then return end

	if !entity.Sessions and !entity:IsDoor() then
		entity.Sessions = {}
	end

	if !entity.shouldHaveLock then
		return false
	end

	local lockEntity = lockEntityID and Entity(lockEntityID)

	if (password:utf8len() != 0) then
		if entity:IsDoor() then
			if IsValid(lockEntity) then
				lockEntity.door = entity
				lockEntity.password = password
				lockEntity:SetPassword(password)

				if client:GetCharacter():GetGroup() then
					lockEntity.group = client:GetCharacter():GetGroup():GetID()
				end

				entity:Fire("Lock")
				entity:Fire("Close")
				entity.locked = lockEntity
				ix.saveEnts:SaveEntity(lockEntity)

				local doorPartner = entity:GetDoorPartner()
				if (IsValid(doorPartner)) then
					doorPartner:Fire("Lock")
					doorPartner:Fire("Close")
				end

				entity:EmitSound("doors/door_latch3.wav")
			end

			ix.log.Add(client, "doorSetLock", entity, password:utf8len() != 0)
		else
			if (entity:GetClass() != "ix_wncontainer") then
				entity:SetLocked(true)
				entity.password = password
				if client:GetCharacter():GetGroup() then
					entity.group = client:GetCharacter():GetGroup():GetID()
				end
			end
			entity:SetPassword(password)
			ix.saveEnts:SaveEntity(entity)

			local name = entity:GetDisplayName()
			local inventory = entity:GetInventory()

			ix.log.Add(client, "containerPassword", name, inventory:GetID(), password:utf8len() != 0)
		end

		client:NotifyLocalized("containerPassword", password)
	else
		client:GetCharacter():GetInventory():Add("cont_lock_t1")
		if IsValid(lockEntity) then
			lockEntity:Remove()
		end

		client:NotifyLocalized("You did not set a valid password!")
	end

	entity.shouldHaveLock = false
end)

netstream.Hook("LockOnCancel", function(client, entity)
	if !entity.shouldHaveLock then
		return false
	end

	client:GetCharacter():GetInventory():Add("cont_lock_t1")
	entity:GetChildren()[1]:Remove()
	entity.shouldHaveLock = false
end)

function PLUGIN:PlayerUseDoor(client, door)
	if (!IsValid(client)) then return end

	local doorPartner = door:GetDoorPartner()
	local shouldUseDoorPartner = false

	if !door.locked or door.locked and !IsValid(door.locked) then
		if !doorPartner then return end

		if !doorPartner.locked or doorPartner.locked and !IsValid(doorPartner.locked) then
			return
		end

		shouldUseDoorPartner = true
	end

	if door.locked and !door.locked.password then
		if !doorPartner then return end

		if !doorPartner.locked.password then
			return
		end

		shouldUseDoorPartner = true
	end

	if !door.GetSaveTable or door.GetSaveTable and !door:GetSaveTable() then
		if !doorPartner then return end

		if !doorPartner.GetSaveTable or doorPartner.GetSaveTable and !doorPartner:GetSaveTable() then
			return
		end

		shouldUseDoorPartner = true
	end

	if !door:GetSaveTable()["m_bLocked"] then
		if !doorPartner then return end

		if !doorPartner:GetSaveTable()["m_bLocked"] then
			return
		end

		shouldUseDoorPartner = true
	end

	if (door.Sessions and door.Sessions[client:SteamID()]) then
		door:Fire("Unlock")

		door.Sessions[client:SteamID()] = true

		if (IsValid(doorPartner)) then
			doorPartner:Fire("Unlock")
			doorPartner.Sessions = doorPartner.Sessions or {}
			doorPartner.Sessions[client:SteamID()] = true
		end

		door:EmitSound("doors/latchunlocked1.wav")

		return
	end

	net.Start("ixDoorPassword")
	net.WriteEntity(shouldUseDoorPartner and doorPartner or door)
	net.Send(client)
end

net.Receive("ixDoorPassword", function(length, client)
	if ((client.ixNextContainerPassword or 0) > RealTime()) then
		client:Notify("You cannot make another password attempt yet. Please wait a couple of seconds!")
		
		return
	end

	if (!playerPasswordAttempts) then
		playerPasswordAttempts = {}
	end

	if (!playerPasswordAttempts[client:SteamID()]) then
		playerPasswordAttempts[client:SteamID()] = 1
	elseif (playerPasswordAttempts[client:SteamID()] >= 10) then
		client:Notify("You have made too many wrong password attempts!")

		return
	end

	local entity = net.ReadEntity()
	if !entity.locked or (entity.locked and !IsValid(entity.locked)) then return end
	if !entity.locked.password then return end

	local password = net.ReadString()
	local dist = entity:GetPos():DistToSqr(client:GetPos())

	if (dist < 16384 and password) then
		if (entity.locked.password and entity.locked.password == password) then
			entity:Fire("Unlock")

			entity.Sessions = entity.Sessions or {}
			entity.Sessions[client:SteamID()] = true

			local doorPartner = entity:GetDoorPartner()
			if (IsValid(doorPartner)) then
				doorPartner:Fire("Unlock")
				doorPartner.Sessions = doorPartner.Sessions or {}
				doorPartner.Sessions[client:SteamID()] = true
			end

			entity:EmitSound("doors/latchunlocked1.wav")
			client:Notify("You have unlocked the door.")
		else
			client:NotifyLocalized("wrongPassword")

			playerPasswordAttempts[client:SteamID()] = playerPasswordAttempts[client:SteamID()] + 1
		end
	end

	client.ixNextContainerPassword = RealTime() + 5
end)

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_containerlock", true, true, true, {
		OnSave = function(entity, data) --OnSave
			data.door = entity.door:MapCreationID()
			data.password = entity.password
			data.owner = entity:GetNetVar("owner")
			data.group = entity.group
		end,
		OnRestore = function(entity, data) --OnRestore
			local door = ents.GetMapCreatedEntity(data.door)

			door.locked = entity
			entity.door = door
			entity:SetParent(door)
			entity:SetNetVar("owner", data.owner)

			entity.password = data.password
			entity:SetPassword(data.password)
			entity.group = data.group

			door:Fire("Lock", true)
			door:Fire("Close")
			local doorPartner = door:GetDoorPartner()
			if (IsValid(doorPartner)) then
				doorPartner:Fire("Lock")
				doorPartner:Fire("Close")
			end

		end,
		ShouldSave = function(entity) --ShouldSave
			return IsValid(entity.door)
		end,
		ShouldRestore = function(data) --ShouldRestore
			local door = ents.GetMapCreatedEntity(data.door)
			return IsValid(door) and door:IsDoor()
		end
	})
end

function PLUGIN:PrintDateSinceOnline(client, steamidNot64)
	if !steamidNot64 then return end
	local steamid64 = util.SteamIDTo64( steamidNot64 )
	if !steamid64 or steamid64 and steamid64 == "" then return end

	local query = mysql:Select("ix_players")
	query:Select("steamid")
	query:Select("last_join_time")
	query:Select("play_time")
	query:Select("steam_name")
	query:Where("steamid", steamid64)
	query:Limit(1)
	query:Callback(function(result)
		if (!result or (result and !istable(result)) or (istable(result) and #result == 0)) then
			client:Notify("Player not found in database!")
			return
		end

		local playTime = math.Round(result[1].play_time / 3600, 1)
		client:ChatPrint(result[1].steam_name .. " (" .. steamidNot64 .. "), was online " .. os.date("%x %X", result[1].last_join_time) .. ". Total play time: " .. playTime .. " hours.")
	end)

	query:Execute()
end