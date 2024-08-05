--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix
local ents = ents
local ipairs = ipairs
local IsValid = IsValid
local ErrorNoHalt = ErrorNoHalt
local util = util

ix.saveEnts = ix.saveEnts or {}
ix.saveEnts.storedTypes = ix.saveEnts.storedTypes or {}
ix.saveEnts.cache = ix.saveEnts.cache or {}

function ix.saveEnts:RegisterEntity(class, bDeleteOnRemove, bAutoSave, bAutoRestore, funcs)
	if (!class) then return end
	ix.saveEnts.storedTypes[class] = {
		class = class,
		bDeleteOnRemove = bDeleteOnRemove,
		bAutoSave = bAutoSave,
		bAutoRestore = bAutoRestore,
		OnSave = funcs.OnSave,
		OnRestorePreSpawn = funcs.OnRestorePreSpawn,
		OnRestore = funcs.OnRestore,
		ShouldSave = funcs.ShouldSave,
		ShouldRestore = funcs.ShouldRestore,
		OnDelete = funcs.OnDelete,
	}
end

ix.saveEnts.batch = nil
ix.saveEnts.batchNumber = 0
ix.saveEnts.BATCH_SIZE = 500 -- amount of entities in a single 0.5 second batch, change as needed for performance/time it takes to save all entities

-- Helper function to check if an entity should save
local function ShouldSave(entity, bNoAutoSave)
	if (IsValid(entity) and ix.saveEnts.storedTypes[entity:GetClass()] and (!bNoAutoSave or ix.saveEnts.storedTypes[entity:GetClass()].bAutoSave)) then
		local info = ix.saveEnts.storedTypes[entity:GetClass()]
		if (info.ShouldSave and !info.ShouldSave(entity)) then
			return false
		end

		return true
	end

	return false
end

-- Helper function to save a batch of entities
local function SaveBatch()
	local lib = ix.saveEnts
	local offset = lib.batchNumber * lib.BATCH_SIZE
	-- If we have a batch and at least one more item above our offset exists (as the for loop starts at offset + 1)
	if (lib.batch and #lib.batch > offset) then
		local bDone = false
		for i = 1, lib.BATCH_SIZE do
			-- Check if the item still exists
			if (lib.batch[offset + i]) then
				lib:SaveEntity(lib.batch[offset + i], true)
			else
				--Batch complete!
				bDone = true
				break
			end
		end

		-- Batch not complete, and next batch has at least one more run?
		if (!bDone and #lib.batch > (offset + lib.BATCH_SIZE)) then
			-- Increase batch number and wait for the timer to run the next batch
			lib.batchNumber = lib.batchNumber + 1
			return
		end
	end

	--Batch complete if we get this far!
	lib.batch = nil
end

--- Saves all posible entities into the Database.
-- If the entity does not exist in the DB, a new entry is added.
-- If the entity does exist in the DB, the existing entry is updated.
-- Note that classes which do not have autosave enabled are ignored, they are expected to handle their own saving already (via SaveClass or SaveEntity)
function ix.saveEnts:SaveAll()
	if (ix.shuttingDown) then
		timer.Remove("ixSaveEnt")
		-- immediately save all date if the server is shutting down
		local entities = ents.GetAll()
		for i = 1, #entities do
			self:SaveEntity(entities[i])
		end
	else
		-- We are still running a batch, can't start a new one
		if (self.batch) then return end

		local entities = ents.GetAll()
		self.batch = {}
		for k, entity in ipairs(entities) do
			if (ShouldSave(entity, true)) then
				self.batch[#self.batch + 1] = entity
			end
		end
		self.batchNumber = 0

		-- Run batch 0 manually
		SaveBatch()
		-- If that doesn't cover it, set a timer
		if (self.batch and #self.batch > self.BATCH_SIZE) then
			-- We already did one run manually, so run timer for the amount of batches minus one
			timer.Create("ixSaveEnt", 0.5, math.ceil(#self.batch / self.BATCH_SIZE) - 1, SaveBatch)
		end
	end
end

--- Saves all posible entities from a specific class into the Database.
-- If the entity does not exist in the DB, a new entry is added.
-- If the entity does exist in the DB, the existing entry is updated.
-- Classes with autosave disabled will still be saved
function ix.saveEnts:SaveClass(class)
	if (self.storedTypes[class]) then
		local entities = ents.FindByClass(class)
		for i = 1, #entities do
			self:SaveEntity(entities[i])
		end
	end
end

-- Helper function to get the to-save data table
local function CreateDataTable(entity)
	local info = ix.saveEnts.storedTypes[entity:GetClass()]
	if (!info) then return end

	local data = {}
	data.pos = entity:GetPos()
	data.angles = entity:GetAngles()
	data.skin = entity:GetSkin()
	data.color = entity:GetColor()
	data.material = entity:GetMaterial()
	data.nocollide = entity:GetCollisionGroup() == COLLISION_GROUP_WORLD
	data.motion = false

	local physicsObject = entity:GetPhysicsObject()
	if (IsValid(physicsObject)) then
		data.motion = physicsObject:IsMotionEnabled()
	end

	local materials = entity:GetMaterials()
	if (istable(materials)) then
		data.submats = {}

		for k in pairs(materials) do
			if (entity:GetSubMaterial(k - 1) != "") then
				data.submats[k] = entity:GetSubMaterial(k - 1)
			end
		end
	end

	local bodygroups = entity:GetBodyGroups()
	if (istable(bodygroups)) then
		data.bodygroups = {}

		for _, v in pairs(bodygroups) do
			if (entity:GetBodygroup(v.id) > 0) then
				data.bodygroups[v.id] = entity:GetBodygroup(v.id)
			end
		end
	end

	if (info.OnSave) then
		data = info.OnSave(entity, data) or data
	end

	return data
end

-- Helper function to save an existing entity (was saved previously already)
local function UpdateEntity(entity)
	if (entity.ixSaveEntsID) then
		local success, data = pcall(CreateDataTable, entity)
		if (!success) then
			ErrorNoHalt("[SAVEENTS-U-"..entity:GetClass().."] "..data)
			return
		end

		local dataString = util.TableToJSON(data)
		local crc = util.CRC(dataString)

		if (crc == entity.ixSaveEntsCRC) then
			return
		end

		local query = mysql:Update("ix_saveents")
			query:Where("id", entity.ixSaveEntsID)
			query:Where("class", entity:GetClass())
			query:Where("map", game.GetMap())
			query:Update("data", dataString)
		query:Execute()

		entity.ixSaveEntsCRC = crc
	end
end

-- Helper function to save a new entity (not known to save system yet)
local function CreateEntity(entity)
	if (!entity.ixSaveEntsID and !entity.ixSaveEntsBeingCreated) then
		local class = entity:GetClass()
		local success, data = pcall(CreateDataTable, entity)
		if (!success) then
			ErrorNoHalt("[SAVEENTS-C-"..class.."] "..data)
			return
		end

		entity.ixSaveEntsBeingCreated = true

		local dataString = util.TableToJSON(data)
		local insertQuery = mysql:Insert("ix_saveents")
			insertQuery:Insert("class", class)
			insertQuery:Insert("map", game.GetMap())
			insertQuery:Insert("data", dataString)
			insertQuery:Insert("deleted", 0)
			insertQuery:Callback(function(result, status, id)
				if (IsValid(entity) and entity.ixSaveEntsBeingCreated) then
					entity.ixSaveEntsID = id
					entity.ixSaveEntsCRC = util.CRC(dataString)
					entity.ixSaveEntsBeingCreated = nil
				else
					-- Entity got deleted/unsaved before creation finished, so lets nuke it
					ix.saveEnts:DeleteEntityByID(id, class)
				end
			end)
		insertQuery:Execute()
	end
end

-- Saves a single entity into the Database.
-- If the entity does not exist in the DB, a new entry is added.
-- If the entity does exist in the DB, the existing entry is updated.
-- Setting bNoAutoSave to true causes the entity to not be saved if its class isn't marked for auto-save
function ix.saveEnts:SaveEntity(entity, bNoAutoSave)
	if (!self.dbLoaded) then
		self.cache[#self.cache + 1] = {entity, bNoAutoSave}
		return
	end

	if (ShouldSave(entity, bNoAutoSave)) then
		if (entity.ixSaveEntsID) then
			UpdateEntity(entity)
		else
			CreateEntity(entity)
		end
	end
end

-- Restore all entities saved in the DB, for as far as they weren't restored already
function ix.saveEnts:RestoreAll(class)
	local restoredEnts = {}
	for k, v in ipairs(ents.GetAll()) do
		if (v.ixSaveEntsID) then
			restoredEnts[v.ixSaveEntsID] = v:GetClass()
		end
	end

	local selectQuery = mysql:Select("ix_saveents")
		selectQuery:Where("map", game.GetMap())
		selectQuery:Where("deleted", 0)
		if (class) then
			selectQuery:Where("class", class)
		end
		selectQuery:Callback(function(result)
			if (!result) then return end
			for k, v in ipairs(result) do
				-- entity was already restored
				if (restoredEnts[v.id]) then
					if (restoredEnts[v.id] != v.class) then
						ErrorNoHalt("[SaveEnts] Restoring entity already exists with mismatched class! DBID:"..v.id.."; "..v.class.." (DB) vs "..restoredEnts[v.id].." (spawned)")
					end
					continue
				end

				-- this class is no longer registered (likely plugin failed to load, or it was removed)
				local info = self.storedTypes[v.class]
				if (!info) then continue end

				-- do not automatically restore unless we are specifically restoring this class
				if (!info.bAutoRestore and class != v.class) then continue end

				local data = util.JSONToTable(v.data)
				if (!data) then continue end

				if (info.ShouldRestore) then
					local success, bShouldRestore, bDelete = pcall(info.ShouldRestore, data)
					if (!success) then
						ErrorNoHalt("[SAVEENTS-L1-"..v.class.."] "..bShouldRestore)
						continue
					end

					if (!bShouldRestore) then
						if (bDelete) then
							self:DeleteEntityByID(v.id, v.class)
						end
						continue
					end
				end

				local entity = ents.Create(v.class)
				entity.ixSaveEntsID = v.id
				entity.ixSaveEntsCRC = util.CRC(v.data)

				if (data.pos) then entity:SetPos(data.pos) end
				if (data.angles) then entity:SetAngles(data.angles) end
				if (data.skin) then entity:SetSkin(data.skin) end
				if (data.color) then entity:SetColor(data.color) end
				if (data.material) then entity:SetMaterial(data.material) end

				if (info.OnRestorePreSpawn) then
					local success, err = pcall(info.OnRestorePreSpawn, entity, data)
					if (!success) then
						ErrorNoHalt("[SAVEENTS-L2-"..v.class.."] "..err)
						continue
					end
				end
				entity:Spawn()

				if (data.nocollide) then entity:SetCollisionGroup(COLLISION_GROUP_WORLD) end

				if (istable(v.submats)) then
					for k2, v2 in pairs(v.submats) do
						if (!isnumber(k2) or !isstring(v2)) then
							continue
						end

						entity:SetSubMaterial(k2 - 1, v2)
					end
				end

				if (istable(v.bodygroups)) then
					for k2, v2 in pairs(v.bodygroups) do
						entity:SetBodygroup(k2, v2)
					end
				end

				if (data.motion != nil) then
					local physicsObject = entity:GetPhysicsObject()
					if (IsValid(physicsObject)) then
						physicsObject:EnableMotion(data.motion)
					end
				end

				if (info.OnRestore) then
					local success, err = pcall(info.OnRestore, entity, data)
					if (!success) then
						ErrorNoHalt("[SAVEENTS-L3-"..v.class.."] "..err)
						continue
					end
				end
			end

			hook.Run("PostSaveEntsRestore", class)
		end)
	selectQuery:Execute()
end

-- Delete the save of an entity
function ix.saveEnts:DeleteEntity(entity)
	if (ix.shuttingDown) then return end
	if (!IsValid(entity)) then return end

	if (entity.ixSaveEntsBeingCreated) then
		-- stop creation, this will cause it to be deleted after creation is finished
		entity.ixSaveEntsBeingCreated = nil
		return
	end

	if (!entity.ixSaveEntsID) then
		return
	end

	local class = entity:GetClass()
	self:DeleteEntityByID(entity.ixSaveEntsID, class)

	entity.ixSaveEntsID = nil
	if (self.storedTypes[class] and self.storedTypes[class].OnDelete) then
		self.storedTypes[class].OnDelete(entity)
	end
end

-- Manually delete the save of an entity - you should use DeleteEntity unless you know what you are doing
function ix.saveEnts:DeleteEntityByID(id, class)
	local deleteQuery = mysql:Update("ix_saveents")
		deleteQuery:Where("id", id)
		deleteQuery:Where("map", game.GetMap())
		if (class) then
			--Extra safety check so you can't accidentally delete the wrong entity
			deleteQuery:Where("class", class)
		end
		deleteQuery:Update("deleted", os.time())
	deleteQuery:Execute()
end