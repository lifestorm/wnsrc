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

PLUGIN.name = "Containers"
PLUGIN.author = "Chessnut"
PLUGIN.description = "Provides the ability to store items."

ix.container = ix.container or {}
ix.container.stored = ix.container.stored or {}

ix.config.Add("containerSave", true, "Whether or not containers will save after a server restart.", nil, {
	category = "Containers"
})

ix.config.Add("containerOpenTime", 0.7, "How long it takes to open a container.", nil, {
	data = {min = 0, max = 50},
	category = "Containers"
})

function ix.container.Register(model, data)
	ix.container.stored[model:lower()] = data
end

ix.util.Include("sh_definitions.lua")

if (SERVER) then
	util.AddNetworkString("ixContainerPassword")

	function PLUGIN:PlayerSpawnedProp(client, model, entity)
		model = tostring(model):lower()
		local data = ix.container.stored[model:lower()]

		if (data) then
			if (hook.Run("CanPlayerSpawnContainer", client, model, entity) == false) then return end

			local container = ents.Create("ix_container")
			container:SetPos(entity:GetPos())
			container:SetAngles(entity:GetAngles())
			container:SetModel(model)
			container:Spawn()

			ix.inventory.New(0, "container:" .. model:lower(), function(inventory)
				-- we'll technically call this a bag since we don't want other bags to go inside
				inventory.vars.isBag = true
				inventory.vars.isContainer = true

				if (IsValid(container)) then
					container:SetInventory(inventory)
					self:SaveContainer()
					if (ix.saveEnts) then
						ix.saveEnts:SaveEntity(container)
					end
				end
			end)

			entity:Remove()

			hook.Run("PlayerSpawnedContainer", client, container)
		end
	end

	function PLUGIN:RegisterSaveEnts()
		ix.saveEnts:RegisterEntity("ix_container", true, true, true, {
			OnSave = function(entity, data) --OnSave
				data.motion = false
				local inventory = entity:GetInventory()
				local lockentity = entity:GetChildren()[1]
				data.invID = inventory:GetID()
				data.model = entity:GetModel()
				data.pass = entity.password
				data.name = entity:GetDisplayName()
				data.money = entity:GetMoney()
				data.lockpos = lockentity and lockentity:GetPos()
				data.lockangs = lockentity and lockentity:GetAngles()
				data.lockowner = lockentity and lockentity:GetNetVar("owner")
				data.group = entity.group
				data.oneway = entity:GetNetVar("isOneWay", false)
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



					if (data.pass) then -- Password
						entity.password = data.pass
						entity:SetLocked(true)
						entity:SetPassword(data.pass)
						entity.Sessions = {}
					end

					if (data.name) then -- Display name
						entity:SetDisplayName(data.name)
					end

					if (data.money) then -- Money
						entity:SetMoney(data.money)
					end

					if (data.lockpos) then -- Lock Pos
						local lockentity = ents.Create("ix_containerlock")
						lockentity:SetPos(data.lockpos) -- Lock Pos
						lockentity:SetAngles(data.lockangs) -- Lock Angles
						lockentity:SetParent(entity)
						lockentity:SetNetVar("owner", data.lockowner) -- Lock Owner
						lockentity:Spawn()
					end

					if (data.group) then
						entity.group = data.group -- Group
					end

					entity:SetNetVar("isOneWay", data.oneway)

					ix.inventory.Restore(inventoryID, data2.width, data2.height, function(inventory)
						inventory.vars.isBag = true
						inventory.vars.isContainer = true

						if (IsValid(entity)) then
							entity:SetInventory(inventory)
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
				return entity:GetModel() != "models/error.mdl" and inventory:GetID() != 0 //avoid bad save that somehow happened
			end
		})
	end

	function PLUGIN:CanSaveContainer(entity, inventory)
		return ix.config.Get("containerSave", true)
	end

	function PLUGIN:SaveContainer()
		local data = {}

		for _, v in ipairs(ents.FindByClass("ix_container")) do
			if (hook.Run("CanSaveContainer", v, v:GetInventory()) != false) then
				local inventory = v:GetInventory()
				if (!inventory) then continue end

				local lockentity = v:GetChildren()[1]

				data[#data + 1] = {
					v:GetPos(),
					v:GetAngles(),
					inventory:GetID(),
					v:GetModel(),
					v.password,
					v:GetDisplayName(),
					v:GetMoney(),
					lockentity and lockentity:GetPos(),
					lockentity and lockentity:GetAngles(),
					lockentity and lockentity:GetNetVar("owner"),
					v.group,
					v:GetNetVar("isOneWay", false)
				}
			else
				local index = v:GetID()

				local query = mysql:Delete("ix_items")
					query:Where("inventory_id", index)
				query:Execute()

				query = mysql:Delete("ix_inventories")
					query:Where("inventory_id", index)
				query:Execute()
			end
		end

		self:SetData(data)
	end

	function PLUGIN:SaveData()
		if (!ix.shuttingDown) then
			self:SaveContainer()
		end
	end

	function PLUGIN:ContainerRemoved(entity, inventory)
		self:SaveContainer()
	end

	function PLUGIN:LoadData()
		if (ix.saveEnts and !ix.config.Get("SaveEntsOldLoadingEnabled")) then return end
		local data = self:GetData()

		if (data) then
			for _, v in ipairs(data) do
				if (!v[4]) then continue end -- Model name

				local data2 = ix.container.stored[v[4]:lower()] -- Model name

				if (data2) then
					local inventoryID = tonumber(v[3]) -- invID

					if (!inventoryID or inventoryID < 1) then
						ErrorNoHalt(string.format(
							"[Helix] Attempted to restore container inventory with invalid inventory ID '%s' (%s, %s)\n",
							tostring(inventoryID), v[6] or "no name", v[4] or "no model"))

						continue
					end

					local entity = ents.Create("ix_container")
					entity:SetPos(v[1]) -- Pos
					entity:SetAngles(v[2]) -- Angles
					entity:Spawn()
					entity:SetModel(v[4]) -- Model name
					entity:SetSolid(SOLID_VPHYSICS)
					entity:PhysicsInit(SOLID_VPHYSICS)

					if (v[5]) then -- Password
						entity.password = v[5]
						entity:SetLocked(true)
						entity:SetPassword(v[5])
						entity.Sessions = {}
					end

					if (v[6]) then -- Display name
						entity:SetDisplayName(v[6])
					end

					if (v[7]) then -- Money
						entity:SetMoney(v[7])
					end

					if (v[8]) then -- Lock Pos
						local lockentity = ents.Create("ix_containerlock")
						lockentity:SetPos(v[8]) -- Lock Pos
						lockentity:SetAngles(v[9]) -- Lock Angles
						lockentity:SetParent(entity)
						lockentity:SetNetVar("owner", v[10]) -- Lock Owner
						lockentity:Spawn()
					end

					if (v[11]) then
						entity.group = v[11] -- Group
					end

					entity:SetNetVar("isOneWay", v[12])

					ix.inventory.Restore(inventoryID, data2.width, data2.height, function(inventory)
						inventory.vars.isBag = true
						inventory.vars.isContainer = true

						if (IsValid(entity)) then
							entity:SetInventory(inventory)
						end
					end)

					local physObject = entity:GetPhysicsObject()

					if (IsValid(physObject)) then
						physObject:EnableMotion()
					end
				end
			end
		end
	end

	net.Receive("ixContainerPassword", function(length, client)
		if ((client.ixNextContainerPassword or 0) > RealTime()) then
			return
		end

		local entity = net.ReadEntity()
		local password = net.ReadString()
		local dist = entity:GetPos():DistToSqr(client:GetPos())

		if (dist < 16384 and password) then
			if (entity.password and entity.password == password) then
				if (!entity:GetNetVar("isOneWay", false)) then
					entity:OpenInventory(client)
				end
				entity.Sessions[client:GetCharacter():GetID()] = true
			else
				client:NotifyLocalized("wrongPassword")
			end
		end

		client.ixNextContainerPassword = RealTime() + 0.5
	end)

	ix.log.AddType("containerPassword", function(client, ...)
		local arg = {...}
		return string.format("%s has %s the password for '%s'.", client:Name(), arg[3] and "set" or "removed", arg[1], arg[2])
	end)

	ix.log.AddType("containerName", function(client, ...)
		local arg = {...}

		if (arg[3]) then
			return string.format("%s has set container %d name to '%s'.", client:Name(), arg[2], arg[1])
		else
			return string.format("%s has removed container %d name.", client:Name(), arg[2])
		end
	end)

	ix.log.AddType("openContainer", function(client, ...)
		local arg = {...}
		return string.format("%s opened the '%s' #%d container.", client:Name(), arg[1], arg[2])
	end, FLAG_NORMAL)

	ix.log.AddType("closeContainer", function(client, ...)
		local name
		if !client or client and !IsValid(client) or IsValid(client) and !client.Name then
			name = "N/A"
		else
			name = client.Name and client:Name()
		end

		local arg = {...}
		return string.format("%s closed the '%s' #%d container.", name, arg[1], arg[2])
	end, FLAG_NORMAL)
else
	net.Receive("ixContainerPassword", function(length)
		local entity = net.ReadEntity()

		Derma_StringRequest(
			L("containerPasswordWrite"),
			L("containerPasswordWrite"),
			"",
			function(val)
				net.Start("ixContainerPassword")
					net.WriteEntity(entity)
					net.WriteString(val)
				net.SendToServer()
			end
		)
	end)
end

function PLUGIN:InitializedPlugins()
	for k, v in pairs(ix.container.stored) do
		if (v.name and v.width and v.height) then
			ix.inventory.Register("container:" .. k:lower(), v.width, v.height)
		else
			ErrorNoHalt("[Helix] Container for '"..k.."' is missing all inventory information!\n")
			ix.container.stored[k] = nil
		end
	end
end

-- properties
properties.Add("container_setpassword", {
	MenuLabel = "Set Password",
	Order = 400,
	MenuIcon = "icon16/lock_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_container") then return false end
		if (!gamemode.Call("CanProperty", client, "container_setpassword", entity)) then return false end

		return true
	end,

	Action = function(self, entity)
		Derma_StringRequest(L("containerPasswordWrite"), "", "", function(text)
			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local password = net.ReadString()

		entity.Sessions = {}

		if (password:len() != 0) then
			entity:SetLocked(true)
			entity:SetPassword(password)
			entity.password = password

			client:NotifyLocalized("containerPassword", password)
		else
			entity:SetLocked(false)
			entity:SetPassword(nil)
			entity.password = nil

			client:NotifyLocalized("containerPasswordRemove")
		end

		local name = entity:GetDisplayName()
		local inventory = entity:GetInventory()

		local definition = ix.container.stored[entity:GetModel():lower()]

		if (definition) then
			entity:SetDisplayName(definition.name)
		end

		if (ix.saveEnts) then
			ix.saveEnts:SaveEntity(self)
		end

		ix.log.Add(client, "containerPassword", name, inventory:GetID(), password:len() != 0)
	end
})

properties.Add("container_setname", {
	MenuLabel = "Set Name",
	Order = 400,
	MenuIcon = "icon16/tag_blue_edit.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_container") then return false end
		if (!gamemode.Call("CanProperty", client, "container_setname", entity)) then return false end

		return true
	end,

	Action = function(self, entity)
		Derma_StringRequest(L("containerNameWrite"), "", "", function(text)
			self:MsgStart()
				net.WriteEntity(entity)
				net.WriteString(text)
			self:MsgEnd()
		end)
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		local name = net.ReadString()

		if (name:len() != 0) then
			entity:SetDisplayName(name)

			client:NotifyLocalized("containerName", name)
		else
			local definition = ix.container.stored[entity:GetModel():lower()]

			entity:SetDisplayName(definition.name)

			client:NotifyLocalized("containerNameRemove")
		end

		if (ix.saveEnts) then
			ix.saveEnts:SaveEntity(self)
		end

		local inventory = entity:GetInventory()

		ix.log.Add(client, "containerName", name, inventory:GetID(), name:len() != 0)
	end
})
