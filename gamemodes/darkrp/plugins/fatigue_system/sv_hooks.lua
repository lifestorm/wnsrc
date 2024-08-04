--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local function RestoreClientRestingInfoAndEntityDataToDefault(client)
	local restingEntity = client.ixRestingInfo.entity

	if (client.ixRestingInfo.seatsOccupyFuncs) then
		for k, func in pairs(client.ixRestingInfo.seatsOccupyFuncs) do
			restingEntity.seatsOccupiers[k] = nil

			func(restingEntity, false)
		end
	elseif (client.ixRestingInfo.seatOccupyFunc) then
		client.ixRestingInfo.seatOccupyFunc(restingEntity, false)
	end

	client.ixRestingInfo = nil
end

local function RestoreUnloadedCharacterDefaultStateAndSimplifyFatigueThinking(pluginTable, client, character)
	local fatigueTimerID = "ixFatigueThink" .. character:GetID()
	local bFatigueTimerExists = timer.Exists(fatigueTimerID)

	if (client:GetNetVar("actEnterAngle") and client.ixUntimedSequence) then
		if (client.ixRestingInfo) then
			if (bFatigueTimerExists) then
				local restingEntityModel = client.ixRestingInfo.entity:GetModel()
				timer.Create(fatigueTimerID, 1, 0, function()
					local restingEntityData = pluginTable.restingEntities[restingEntityModel]

					if (
						!character:ShiftEnergy(restingEntityData.energyRestorationRate or
						ix.config.Get("baseRestingEnergyRestoration", 0.004), restingEntityData.maxEnergyBonus)
					) then
						timer.Remove(fatigueTimerID)
					end
				end)
			end

			client:SetCollisionGroup(COLLISION_GROUP_NONE)

			local enterPos = client.ixRestingInfo.enterPos
			character:SetData("pos", {enterPos[1], enterPos[2], game.GetMap()})

			RestoreClientRestingInfoAndEntityDataToDefault(client)
		elseif (bFatigueTimerExists) then
			timer.Create(fatigueTimerID, 1, 0, function()
				if (!character:ShiftEnergy(ix.config.Get("baseRestingEnergyRestoration", 0.004))) then
					timer.Remove(fatigueTimerID)
				end
			end)
		end
	elseif (bFatigueTimerExists) then
		timer.Remove(fatigueTimerID)
	end
end

local function BagCountFilledSlotsCount(item)
	local bagInvID = item:GetData("id")
	local filledSlotsCount = 0

	if (!bagInvID) then
		return filledSlotsCount
	end

	local bagInventory = ix.item.inventories[bagInvID]

	-- could've just use "GetFilledSlotCount" instead of a loop, but what if the bag item allows nesting?
	for _, vItem in pairs(bagInventory:GetItems()) do
		filledSlotsCount = filledSlotsCount + vItem.width * vItem.height
	end

	return filledSlotsCount
end

function PLUGIN:PrePlayerLoadedCharacter(client, character, lastCharacter)
	if (lastCharacter) then
		RestoreUnloadedCharacterDefaultStateAndSimplifyFatigueThinking(self, client, lastCharacter)

		client.ixEquipmentEnergyConsumptionRate = nil
		client.ixInventoryFilledSlotsCount = nil
	end

	if (!character:IsAffectedByFatigue()) then
		return
	end

	local equipInventoryID = character:GetEquipInventory()
	local equipInventory = ix.inventory.Get(equipInventoryID)
	client.ixEquipmentEnergyConsumptionRate = 0

	if (equipInventory.slots and equipInventory.slots[1]) then
		for _, item in pairs(equipInventory.slots[1]) do
			if (!item or !item.energyConsumptionRate) then
				continue
			end

			client.ixEquipmentEnergyConsumptionRate = client.ixEquipmentEnergyConsumptionRate + item.energyConsumptionRate
		end
	end

	local inventory = character:GetInventory()
	client.ixInventoryFilledSlotsCount = 0

	for _, item in pairs(inventory:GetItems()) do
		if (equipInventoryID == item.invID) then
			continue
		end

		client.ixInventoryFilledSlotsCount = client.ixInventoryFilledSlotsCount + (item.width * item.height)
	end

	local fatigueTimerID = "ixFatigueThink" .. character:GetID()

	timer.Create(fatigueTimerID, 1, 0, function()
		local energy = character:GetEnergy()
		local energyShift, maxEnergyBonus

		if (client:GetNetVar("actEnterAngle") and client.ixUntimedSequence) then
			if (client.ixRestingInfo) then
				local restingEntityModel = client.ixRestingInfo.entity:GetModel()
				local restingEntityData = self.restingEntities[restingEntityModel]
				maxEnergyBonus = restingEntityData.maxEnergyBonus or 0

				if (energy >= 100 + maxEnergyBonus) then
					return
				end

				energyShift = restingEntityData.energyRestorationRate or ix.config.Get("baseRestingEnergyRestoration", 0.004)

				if (client.ixRestingInfo.seatsOccupyFuncs and #client.ixRestingInfo.seatsOccupyFuncs == 2) then
					energyShift = energyShift * 1.5
				end
			else
				if (energy >= 100) then
					return
				end

				energyShift = ix.config.Get("baseRestingEnergyRestoration", 0.004)
			end

			if (!client:IsAFK() and client.ixInArea and ix.area.stored[client.ixArea].type == "rpArea") then
				energyShift = energyShift + ix.config.Get("rpAreaEnergyRestoration", 0.017)
			end
		elseif (client.ixInArea and ix.area.stored[client.ixArea].type == "rpArea") then
			if (energy >= 100 or IsValid(client.ixRagdoll) or client:IsAFK()) then
				return
			end

			energyShift = ix.config.Get("rpAreaEnergyRestoration", 0.017)
		else
			if (energy == 0 or !client.ixEquipmentEnergyConsumptionRate or IsValid(client.ixRagdoll) or client:IsAFK()) then
				return
			end

			local clientVelocityLength = client:GetVelocity():Length2DSqr()

			if (clientVelocityLength < 64) then -- 8 * 8
				return
			end

			energyShift = ix.config.Get("baseEnergyConsumption", 0.004)

			local strengthFraction = character:GetSpecial("strength") / 10
			local equipmentConsumption = client.ixEquipmentEnergyConsumptionRate * (1 - self.maxEquipmentEnergyConsumptionReduction * strengthFraction)
			local slotsConsumption = client.ixInventoryFilledSlotsCount * ix.config.Get("filledSlotEnergyConsumption", 0.001) *
				(1 - self.maxFilledSlotsEnergyConsumptionReduction * strengthFraction)

			energyShift = energyShift + equipmentConsumption + slotsConsumption
			local walkSpeed = client:GetWalkSpeed()

			if (client.searchingGarbage) then
				energyShift = energyShift + ix.config.Get("garbageCollectingEnergyConsumption", 0.0004)
			elseif (client:KeyDown(IN_SPEED) and clientVelocityLength >= (walkSpeed * walkSpeed)) then
				energyShift = energyShift + ix.config.Get("runningEnergyConsumption", 0.008)
			end

			energyShift = -energyShift
		end

		character:ShiftEnergy(energyShift, maxEnergyBonus)
	end)
end

function PLUGIN:OnItemTransferred(item, lastInventory, inventory) -- things I have to do in order to detect equipment consumption rate and filled slots count...
	local ownerCharacter = ix.char.loaded[inventory.owner]
	local lastOwnerCharacter = ix.char.loaded[lastInventory.owner]
	if (!ownerCharacter or !lastOwnerCharacter) then
		return
	end
	local ownerClient, lastOwnerClient

	if (
		(ownerCharacter and !ownerCharacter:IsAffectedByFatigue() or !ownerCharacter and true) and
		(lastOwnerCharacter and !lastOwnerCharacter:IsAffectedByFatigue() or !lastOwnerCharacter and true)
	) then
		return
	end

	if (!inventory.owner and lastInventory.owner) then
		lastOwnerClient = lastOwnerCharacter:GetPlayer()
		local equipInventory = lastOwnerCharacter:GetEquipInventory()

		if (lastInventory:GetID() == equipInventory) then
			lastOwnerClient.ixEquipmentEnergyConsumptionRate = lastOwnerClient.ixEquipmentEnergyConsumptionRate - (item.energyConsumptionRate or 0)
		else
			lastOwnerClient.ixInventoryFilledSlotsCount = lastOwnerClient.ixInventoryFilledSlotsCount - item.width * item.height
		end

		-- equipped item can be a bag too
		lastOwnerClient.ixInventoryFilledSlotsCount = lastOwnerClient.ixInventoryFilledSlotsCount - BagCountFilledSlotsCount(item)
	elseif (inventory.owner and !lastInventory.owner) then
		ownerClient = ownerCharacter:GetPlayer()
		ownerClient.ixInventoryFilledSlotsCount = ownerClient.ixInventoryFilledSlotsCount + item.width * item.height + BagCountFilledSlotsCount(item)
	elseif (inventory.owner != lastInventory.owner) then
		ownerClient = ownerCharacter:GetPlayer()
		lastOwnerClient = lastOwnerCharacter:GetPlayer()

		local itemSize = item.width * item.height
		ownerClient.ixInventoryFilledSlotsCount = ownerClient.ixInventoryFilledSlotsCount + itemSize
		lastOwnerClient.ixInventoryFilledSlotsCount = lastOwnerClient.ixInventoryFilledSlotsCount - itemSize - BagCountFilledSlotsCount(item)
	else
		ownerClient = ownerCharacter:GetPlayer()
		lastOwnerClient = lastOwnerCharacter:GetPlayer()

		local equipInventory = ownerCharacter:GetEquipInventory()
		local bTransferedToEquipInventory
	
		if (equipInventory == inventory:GetID()) then
			bTransferedToEquipInventory = true
		elseif (equipInventory == lastInventory:GetID()) then
			bTransferedToEquipInventory = false
		else
			return
		end

		if (bTransferedToEquipInventory) then
			ownerClient.ixEquipmentEnergyConsumptionRate = ownerClient.ixEquipmentEnergyConsumptionRate + (item.energyConsumptionRate or 0)
			ownerClient.ixInventoryFilledSlotsCount = ownerClient.ixInventoryFilledSlotsCount - (item.width * item.height)
		else
			ownerClient.ixEquipmentEnergyConsumptionRate = ownerClient.ixEquipmentEnergyConsumptionRate - (item.energyConsumptionRate or 0)
			ownerClient.ixInventoryFilledSlotsCount = ownerClient.ixInventoryFilledSlotsCount + (item.width * item.height)
		end
	end
end

function PLUGIN:OnEntityCreated(entity)
	if (entity:GetClass() == "ix_chair") then
		timer.Simple(0, function()
			if (!IsValid(entity)) then
				return
			end

			local entityData = self.restingEntities[entity:GetModel()]
			entity:SetValidActName(entityData.validActName)
		end)
	end
end

function PLUGIN:OnPlayerJump(client)
	if (!client:IsAffectedByFatigue() or (client.ixInArea and ix.area.stored[client.ixArea].type == "rpArea")) then
		return
	end

	local character = client:GetCharacter()
	character:ShiftEnergy(-ix.config.Get("jumpEnergyConsumption", 0.1))
end

function PLUGIN:PlayerInteractItem(client, action, item)
	if (item.base == "base_food" and action == "Consume" and item.energyShift) then
		local character = client:GetCharacter()

		character:ShiftEnergy(item.energyShift)
	end
end

function PLUGIN:OnCharacterDisconnect(client, character)
	RestoreUnloadedCharacterDefaultStateAndSimplifyFatigueThinking(self, client, character)
end

function PLUGIN:OnPlayerExitAct(client)
	if (client.ixRestingInfo) then
		local enterPos = client.ixRestingInfo.enterPos

		client:SetCollisionGroup(COLLISION_GROUP_NONE)
		client:SetPos(enterPos[1])
		client:SetEyeAngles(enterPos[2])

		RestoreClientRestingInfoAndEntityDataToDefault(client)
	end
end

function PLUGIN:CharacterDeleted(client, charID, bIsCurrentChar)
	timer.Remove("ixFatigueThink" .. charID)
end

function PLUGIN:OnCharacterBanned(character)
	timer.Remove("ixFatigueThink" .. character:GetID())
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_chair", true, true, true, {
		OnSave = function(entity, data)
			data.model = entity:GetModel()
		end,
		OnRestorePreSpawn = function(entity, data)
			entity:SetModel(data.model)
		end
	})

	ix.saveEnts:RegisterEntity("ix_couch", true, true, true, {
		OnSave = function(entity, data)
			data.model = entity:GetModel()
		end,
		OnRestorePreSpawn = function(entity, data)
			entity:SetModel(data.model)
		end
	})

	ix.saveEnts:RegisterEntity("ix_bed", true, true, true, {
		OnSave = function(entity, data)
			data.model = entity:GetModel()
		end,
		OnRestorePreSpawn = function(entity, data)
			entity:SetModel(data.model)
		end
	})
end
