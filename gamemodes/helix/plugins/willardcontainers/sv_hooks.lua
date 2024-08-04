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
	local query = mysql:Create("ix_container_inactive")
		query:Create("inv_id", "INT UNSIGNED NOT NULL")
		query:Create("steamid", "VARCHAR(20) NOT NULL")
		query:Create("character_id", "INT UNSIGNED NOT NULL")
		query:Create("money", "INT UNSIGNED NOT NULL")
		query:Create("datetime", "INT UNSIGNED NOT NULL")
		query:Create("model", "TEXT NOT NULL")
		query:PrimaryKey("inv_id")
	query:Execute()
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	for k, v in ipairs(ents.FindByClass("ix_wncontainer")) do
		v:UpdatePrivateOwner(client)
	end
end

function PLUGIN:OnCharacterBanned(character, time)
	if (time == true) then
		self:OnCharacterBannedByID(character:GetID(), true)
	end
end

function PLUGIN:CharacterDeleted(client, id)
	self:OnCharacterBannedByID(id, true)

	local query = mysql:Delete("ix_container_inactive")
		query:Where("character_id", id)
	query:Execute()
end

function PLUGIN:OnCharacterBannedByID(charID, time)
	if (time == true) then
		for k, v in ipairs(ents.FindByClass("ix_wncontainer")) do
			if (v.ownerCharID == charID) then
				v:ChangeType(v.PKHOLD)
			else
				v:RemoveUser(charID)
			end
		end
	end
end

function PLUGIN:CanTransferItem(item, oldInv, newInv)
	if (newInv and newInv.vars and IsValid(newInv.vars.entity)) then
		local entity = newInv.vars.entity
		if (entity:GetClass() != "ix_wncontainer") then return end

		local entityType = entity:GetType()
		if (entityType == entity.PKHOLD or entityType == entity.CLEANUP or entityType == entity.MANCLEANUP) then
			return false
		end

		if (entityType == entity.PRIVATE and entity:GetPremium() and entity.premiumExpired) then
			return false
		end
	end
end

function PLUGIN:PostPlayerXenforoGroupsUpdate(client)
	local steamID = client:SteamID64()
	local hasAccess = CAMI.PlayerHasAccess(client, "Helix - Premium Container")
	for k, v in ipairs(ents.FindByClass("ix_wncontainer")) do
		if (v.owner == steamID and v:GetType() == v.PRIVATE and v:GetPremium()) then
			v.premiumExpired = !hasAccess
		end
	end
end

function PLUGIN:ContainerRemoved(container, inventory)
	local name, model, id, chips, itemText = "unknown", "error", 0, 0, "no items"
	local bShouldLog = false
	if (IsValid(container) and (container:GetClass() == "ix_container" or container:GetClass() == "ix_wncontainer")) then
		name = container:GetDisplayName()
		model = container:GetModel()
		id = inventory:GetID()
		chips = container:GetMoney()
		if (chips > 0) then
			bShouldLog = true
		end
	end

	local items = inventory:GetItems()
	if (table.Count(items) > 0) then
		itemText = "items: "
		for _, v in pairs(items) do
			if (!v.maxStackSize or v.maxStackSize == 1) then
				itemText = itemText.." "..v:GetName().." (#"..v:GetID()..");"
			else
				itemText = itemText.." "..v:GetStackSize().."x "..v:GetName().." (#"..v:GetID()..");"
			end
		end

		bShouldLog = true
	end

	if (bShouldLog) then
		ix.log.AddRaw(string.format("Container '%s' removed (inv #%d; model: %s) with %d chips and %s", name, id, model, chips, itemText))
	end
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_wncontainer", true, true, true, {
		OnSave = function(entity, data) --OnSave
			data.motion = false
			local inventory = entity:GetInventory()
			data.invID = inventory:GetID()
			data.model = entity:GetModel()
			data.name = entity:GetDisplayName()
			data.pass = entity:GetPass()
			data.money = entity:GetMoney()
			data.premium = entity:GetPremium() == true
			entity:SaveType(data)
		end,
		OnRestore = function(entity, data) --OnRestore
			local data2 = ix.container.stored[data.model:lower()] -- Model name
			if (data2) then
				local inventoryID = tonumber(data.invID) -- invID

				if (!inventoryID or inventoryID < 1) then
					ErrorNoHalt(string.format(
						"[Helix] Attempted to restore container inventory with invalid inventory ID '%s' (%s, %s)\n",
						tostring(inventoryID), data.name or "no name", data.model or "no model"))

					return
				end

				entity:SetModel(data.model) -- Model name
				entity:SetSolid(SOLID_VPHYSICS)
				entity:PhysicsInit(SOLID_VPHYSICS)

				if (data.name) then -- Display name
					entity:SetDisplayName(data.name)
				end
				entity:SetPass(data.pass)
				if (data.pass and data.pass != "") then
					entity.Sessions = {}
				end
				entity:SetMoney(data.money)
				entity:SetPremium(data.premium)
				entity:RestoreType(data)


				ix.inventory.Restore(inventoryID, data2.width, data2.height, function(inventory)
					inventory.vars.isBag = true
					inventory.vars.isContainer = true
					inventory.vars.entity = entity

					if (IsValid(entity)) then
						entity:SetInventory(inventory)
						entity:CheckActivity()
					end
				end)

				local physObject = entity:GetPhysicsObject()
				if (IsValid(physObject)) then
					physObject:EnableMotion()
				end
			end
		end,
		ShouldSave = function(entity)
			local inventory = entity:GetInventory()
			return entity:GetModel() != "models/error.mdl" and inventory:GetID() != 0 --avoid bad save that somehow happened
		end
	})
end