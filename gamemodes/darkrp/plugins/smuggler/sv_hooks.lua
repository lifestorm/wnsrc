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

function PLUGIN:PlayerLoadedCharacter(client, character)
    if (CAMI.PlayerHasAccess(client, "Helix - Manage Smugglers")) then
        netstream.Start(client, "ixSmugglingCacheUIDs", self.cacheIDList)
    end

    local uniqueID = "ixSmuggling"..client:SteamID64()
    timer.Create(uniqueID, 60, 0, function()
        if (!IsValid(client)) then timer.Remove(uniqueID) return end

        local char = client:GetCharacter()
        if (!char) then return end

        local pickupItems = char:GetSmugglingPickupDelay()

        if (#pickupItems == 0) then return end

        local k = 1
        while (#pickupItems >= k and pickupItems[k][1] < os.time()) do
            char:SetSmugglingPickupItems(pickupItems[k][2], pickupItems[k][3], 1)

            k = k + 1
        end

        if (k > 1) then
            local newTbl = {}
            for i = k, #pickupItems do
                newTbl[#newTbl + 1] = pickupItems[i]
            end

            char.vars.smugglingPickupDelay = newTbl
            char:Save()
        end

        client:UpdateStashWaypoints()
    end)

    local pickupItems = character:GetSmugglingPickupItems()
    for k, v in pairs(pickupItems) do
        if (k == "__invalid_cache") then continue end

        local bFound = false
        for _, v1 in pairs(self.pickupCaches) do
            if (k == v1.uniqueID) then
                bFound = true
                break
            end
        end

        if (bFound) then continue end

        pickupItems["__invalid_cache"] = pickupItems["__invalid_cache"] or {}
        for k1, v1 in pairs(v) do
            pickupItems["__invalid_cache"][k1] = (pickupItems["__invalid_cache"][k1] or 0) + v1
        end

        pickupItems[k] = nil
    end

    character.vars.smugglingPickupItems = pickupItems

    client:UpdateStashWaypoints(pickupItems)
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_smuggler", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.name = entity:GetDisplayName()
            data.description = entity:GetDescription()
            data.model = entity:GetModel()
            data.items = entity.items
            data.money = entity.money
            data.maxStock = entity.maxStock
            data.stashList = entity.stashList
            data.motion = nil

            if (entity.ixIsActiveSmuggler) then
                data.active = self.nextRotation
            end
		end,
		OnRestore = function(entity, data) --OnRestore
			entity:SetModel(data.model)
            entity:SetSolid(SOLID_BBOX)
            entity:PhysicsInit(SOLID_BBOX)

            local physObj = entity:GetPhysicsObject()
            if (IsValid(physObj)) then
                physObj:EnableMotion()
                physObj:Sleep()
            end

            entity:SetDisplayName(data.name)
            entity:SetDescription(data.description)

            local items = {}
            for uniqueID, itemData in pairs(data.items) do
                items[tostring(uniqueID)] = itemData
            end

            entity.items = items
            entity.money = data.money
            entity.maxStock = data.maxStock
            entity.stashList = data.stashList

            if (data.active and !self.nextRotation and data.active > os.time() + 300) then
                self.nextRotation = data.active
                entity:SetActive()
            else
                entity:SetInactive()
            end
		end,
	})

    ix.saveEnts:RegisterEntity("ix_pickupcache", true, true, true, {
		OnSave = function(entity, data) --OnSave
            data.name = entity:GetDisplayName()
            data.uniqueID = entity.uniqueID
            data.model = entity:GetModel()
            data.locationId = entity:GetLocationId()
            data.motion = false
		end,
		OnRestore = function(entity, data) --OnRestore
            entity:SetNewModel(data.model)

            local physObj = entity:GetPhysicsObject()
            if (IsValid(physObj)) then
                physObj:EnableMotion()
                physObj:Sleep()
            end

            entity:SetDisplayName(data.name)
            entity:SetLocationId(data.locationId)
            entity:UpdateUniqueID(data.uniqueID)
		end,
        ShouldSave = function(entity)
            return self.pickupCaches[entity.uniqueID]
        end
	})
end

function PLUGIN:SaveData()
    local smugglers = {}
    for _, entity in ipairs(ents.FindByClass("ix_smuggler")) do
        local bodygroups = {}

        for _, v in ipairs(entity:GetBodyGroups() or {}) do
            bodygroups[v.id] = entity:GetBodygroup(v.id)
        end

        smugglers[#smugglers + 1] = {
            name = entity:GetDisplayName(),
            description = entity:GetDescription(),
            pos = entity:GetPos(),
            angles = entity:GetAngles(),
            model = entity:GetModel(),
            skin = entity:GetSkin(),
            bodygroups = bodygroups,
            items = entity.items,
            money = entity.money,
            maxStock = entity.maxStock,
            stashList = entity.stashList
        }

        if (entity.ixIsActiveSmuggler) then
            smugglers[#smugglers].active = self.nextRotation
        end
    end
    ix.data.Set("smugglers", smugglers)

    local caches = {}
    for uid, entity in pairs(self.pickupCaches) do
        if (!IsValid(entity)) then
            self.pickupCaches[uid] = nil
            continue
        end

        local bodygroups = {}

        for _, v in ipairs(entity:GetBodyGroups() or {}) do
            bodygroups[v.id] = entity:GetBodygroup(v.id)
        end

        caches[#caches + 1] = {
            name = entity:GetDisplayName(),
            uniqueID = uid,
            pos = entity:GetPos(),
            angles = entity:GetAngles(),
            model = entity:GetModel(),
            skin = entity:GetSkin(),
            bodygroups = bodygroups,
            locationId = entity:GetLocationId()
        }
    end
    ix.data.Set("smuggling_caches", caches)
end

function PLUGIN:LoadData()
    if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

    local caches = ix.data.Get("smuggling_caches") or {}
    for _, v in ipairs(caches) do
        local entity = ents.Create("ix_pickupcache")
        entity:SetPos(v.pos)
        entity:SetAngles(v.angles)
        entity:Spawn()

        entity:SetNewModel(v.model)
        entity:SetSkin(v.skin or 0)

        local physObj = entity:GetPhysicsObject()
        if (IsValid(physObj)) then
            physObj:EnableMotion(false)
            physObj:Sleep()
        end

        entity:SetDisplayName(v.name)
        entity:SetLocationId(v.locationId)

        for id, bodygroup in pairs(v.bodygroups or {}) do
            entity:SetBodygroup(id, bodygroup)
        end

        entity:UpdateUniqueID(v.uniqueID)
    end

    for _, v in ipairs(ix.data.Get("smugglers") or {}) do
        local entity = ents.Create("ix_smuggler")
        entity:SetPos(v.pos)
        entity:SetAngles(v.angles)
        entity:Spawn()

        entity:SetModel(v.model)
        entity:SetSkin(v.skin or 0)
        entity:SetSolid(SOLID_BBOX)
        entity:PhysicsInit(SOLID_BBOX)

        local physObj = entity:GetPhysicsObject()

        if (IsValid(physObj)) then
            physObj:EnableMotion(false)
            physObj:Sleep()
        end

        entity:SetDisplayName(v.name)
        entity:SetDescription(v.description)

        for id, bodygroup in pairs(v.bodygroups or {}) do
            entity:SetBodygroup(id, bodygroup)
        end

        local items = {}
        for uniqueID, data in pairs(v.items) do
            items[tostring(uniqueID)] = data
        end

        entity.items = items
        entity.money = v.money
        entity.maxStock = v.maxStock
        entity.stashList = v.stashList

        if (v.active and !self.nextRotation and v.active > os.time() + 300) then
            self.nextRotation = v.active
            entity:SetActive()
        else
            entity:SetInactive()
        end
    end
end

function PLUGIN:PostLoadData()
    timer.Simple(10, function()
        if (!self.nextRotation) then
            self:RotateActiveSmuggler()
        end
    end)
end
