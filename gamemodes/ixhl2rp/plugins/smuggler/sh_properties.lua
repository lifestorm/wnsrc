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

properties.Add("smuggler_edit", {
	MenuLabel = "Edit Smuggler",
	Order = 999,
	MenuIcon = "icon16/user_edit.png",

	Filter = function(self, entity, client)
		if (!IsValid(entity)) then return false end
		if (entity:GetClass() != "ix_smuggler") then return false end
		if (!gamemode.Call( "CanProperty", client or LocalPlayer(), "smuggler_edit", entity)) then return false end

		return CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - Manage Smugglers", nil)
	end,

	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		entity.receivers[#entity.receivers + 1] = client

		local itemsTable = {}

		for k, v in pairs(entity.items) do
			if (!table.IsEmpty(v)) then
				itemsTable[k] = v
			end
		end

		client.ixSmuggler = entity

		net.Start("ixSmugglerEditor")
			net.WriteEntity(entity)
			net.WriteUInt(entity.money or 0, 16)
			net.WriteUInt(entity.maxStock or 0, 16)
			net.WriteTable(itemsTable)
			net.WriteTable(entity.messages)
		net.Send(client)
	end
})

properties.Add("pickup_id", {
	MenuLabel = "Set Unique ID",
	Order = 996,
	MenuIcon = "icon16/user_edit.png",

	Filter = function(self, entity, client)
		if (!IsValid(entity)) then return false end
		if (entity:GetClass() != "ix_pickupcache") then return false end
		if (!gamemode.Call( "CanProperty", client or LocalPlayer(), "pickup_id", entity)) then return false end
		if (PLUGIN.cacheIDList[entity:EntIndex()] and PLUGIN.cacheIDList[entity:EntIndex()].uniqueID != "") then return false end

		return CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - Manage Smugglers", nil)
	end,

	Action = function(self, entity)
		Derma_StringRequest("Enter new unique ID", "Enter new unique ID", "", function(text)
			if (!text or text == "") then return end

			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		local uniqueID = net.ReadString()

		if (!IsValid(entity)) then return end
		if (uniqueID == "") then return end
		if (!self:Filter(entity, client)) then return end

		if (PLUGIN.pickupCaches[uniqueID] and PLUGIN.pickupCaches[uniqueID] != entity) then
			client:NotifyLocalized("smugglerUniqueIDExists")
			return
		end

		entity:UpdateUniqueID(uniqueID)
		ix.saveEnts:SaveEntity(entity)
	end
})

properties.Add("pickup_location", {
	MenuLabel = "Set Location Id",
	Order = 997,
	MenuIcon = "icon16/user_edit.png",

	Filter = function(self, entity, client)
		if (!IsValid(entity)) then return false end
		if (entity:GetClass() != "ix_pickupcache") then return false end
		if (!gamemode.Call( "CanProperty", client or LocalPlayer(), "pickup_location", entity)) then return false end

		return CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - Manage Smugglers", nil)
	end,

	Action = function(self, entity)
		Derma_StringRequest("Enter new location ID", "", entity:GetLocationId(), function(text)
			if (!text or text == "") then return end

			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		local locationId = net.ReadString()

		if (!IsValid(entity)) then return end
		if (locationId == "") then return end
		if (!self:Filter(entity, client)) then return end

		entity:SetLocationId(string.utf8upper(locationId))
		ix.saveEnts:SaveEntity(entity)
	end
})

properties.Add("pickup_name", {
	MenuLabel = "Set Name",
	Order = 998,
	MenuIcon = "icon16/user_edit.png",

	Filter = function(self, entity, client)
		if (!IsValid(entity)) then return false end
		if (entity:GetClass() != "ix_pickupcache") then return false end
		if (!gamemode.Call( "CanProperty", client or LocalPlayer(), "pickup_name", entity)) then return false end

		return CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - Manage Smugglers", nil)
	end,

	Action = function(self, entity)
		Derma_StringRequest("Enter new display name", "", entity:GetDisplayName(), function(text)
			if (!text or text == "") then return end

			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		local name = net.ReadString()

		if (!IsValid(entity)) then return end
		if (name == "") then return end
		if (!self:Filter(entity, client)) then return end

		entity:SetDisplayName(name)
		ix.saveEnts:SaveEntity(entity)
	end
})

properties.Add("pickup_model", {
	MenuLabel = "Set Model",
	Order = 999,
	MenuIcon = "icon16/user_edit.png",

	Filter = function(self, entity, client)
		if (!IsValid(entity)) then return false end
		if (entity:GetClass() != "ix_pickupcache") then return false end
		if (!gamemode.Call( "CanProperty", client or LocalPlayer(), "pickup_model", entity)) then return false end

		return CAMI.PlayerHasAccess(client or LocalPlayer(), "Helix - Manage Smugglers", nil)
	end,

	Action = function(self, entity)
		Derma_StringRequest("Enter new model", "", entity:GetModel(), function(text)
			if (!text or text == "") then return end

			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		local model = net.ReadString()

		if (!IsValid(entity)) then return end
		if (model == "") then return end
		if (!self:Filter(entity, client)) then return end

		entity:SetNewModel(model)
		ix.saveEnts:SaveEntity(entity)
	end
})
