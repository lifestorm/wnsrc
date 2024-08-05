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

PLUGIN.name = "Persistence"
PLUGIN.description = "Define entities to persist through restarts."
PLUGIN.author = "alexgrist"
PLUGIN.stored = PLUGIN.stored or {}

ix.config.Add("maxLamps", 1, "How many lamps can be persisted.", nil, {
	data = {min = 1, max = 24},
	category = "persistence"
})

local function GetRealModel(entity)
	return entity:GetClass() == "prop_effect" and entity.AttachedEntity:GetModel() or entity:GetModel()
end

properties.Add("persist", {
	MenuLabel = "#makepersistent",
	Order = 400,
	MenuIcon = "icon16/link.png",

	Filter = function(self, entity, client)
		if (entity:IsPlayer() or entity:IsVehicle() or entity.bNoPersist) then return false end
		if (!gamemode.Call("CanProperty", client, "persist", entity)) then return false end

		return !entity:GetNetVar("Persistent", false)
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

		PLUGIN.stored[#PLUGIN.stored + 1] = entity

		entity:SetNetVar("Persistent", true)
		ix.saveEnts:SaveEntity(entity)

		ix.log.Add(client, "persist", GetRealModel(entity), true)
	end
})

properties.Add("persist_end", {
	MenuLabel = "#stoppersisting",
	Order = 400,
	MenuIcon = "icon16/link_break.png",

	Filter = function(self, entity, client)
		if (entity:IsPlayer()) then return false end
		if (!gamemode.Call("CanProperty", client, "persist", entity)) then return false end

		return entity:GetNetVar("Persistent", false)
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

		for k, v in ipairs(PLUGIN.stored) do
			if (v == entity) then
				table.remove(PLUGIN.stored, k)

				break
			end
		end

		entity:SetNetVar("Persistent", false)
		ix.saveEnts:DeleteEntity(entity)

		ix.log.Add(client, "persist", GetRealModel(entity), false)
	end
})

function PLUGIN:PhysgunPickup(client, entity)
	if (entity:GetNetVar("Persistent", false)) then
		return false
	end
end

if (SERVER) then
	function PLUGIN:RegisterSaveEnts()
		ix.saveEnts:RegisterEntity("gmod_lamp", true, true, true, {
			OnSave = function(entity, data) --OnSave
				data.model = entity:GetModel()
				data.texture = entity:GetFlashlightTexture()
				data.distance = entity:GetDistance()
				data.brightness = entity:GetBrightness()
				data.fov = entity:GetLightFOV()
				data.isOn = entity:GetOn()
				data.ownerSteamID = entity.ownerSteamID
			end,
			OnRestore = function(entity, data) --OnRestore
				entity:SetFlashlightTexture(data.texture)
				entity:SetDistance(data.distance)
				entity:SetBrightness(data.brightness)
				entity:SetLightFOV(data.fov)
				entity:SetOn(data.isOn)
				entity.ownerSteamID = data.ownerSteamID

				entity:SetNetVar("Persistent", true)
			end,
			OnRestorePreSpawn = function(entity, data)
				entity:SetModel(data.model)
			end,
			ShouldSave = function(entity)
				return entity:GetNetVar("Persistent")
			end
		})

		ix.saveEnts:RegisterEntity("prop_physics", true, true, true, {
			OnSave = function(entity, data) --OnSave
				data.model = entity:GetModel()
				data.ownerCharacter = entity.ownerCharacter
				data.ownerName = entity.ownerName
				data.ownerSteamID = entity.ownerSteamID

				if (entity.saveDescription and entity:GetNetVar("description")) then
					data.description = entity:GetNetVar("description")
					data.saveDescription = true
				end
			end,
			OnRestore = function(entity, data) --OnRestore
				entity.ownerCharacter = data.ownerCharacter
				entity.ownerName = data.ownerName
				entity.ownerSteamID = data.ownerSteamID

				if (data.saveDescription and data.description) then
					entity:SetNetVar("description", data.description)
					entity.saveDescription = true
				end

				entity:SetNetVar("Persistent", true)
			end,
			OnRestorePreSpawn = function(entity, data)
				entity:SetModel(data.model)
			end,
			ShouldSave = function(entity)
				return entity:GetNetVar("Persistent")
			end
		})

		ix.saveEnts:RegisterEntity("prop_effect", true, true, true, {
			OnSave = function(entity, data) --OnSave
				data.model = GetRealModel(entity)
			end,
			OnRestorePreSpawn = function(entity, data)
				entity:SetModel(data.model)
			end,
			OnRestore = function(entity, data) --OnRestore
				entity:SetNetVar("Persistent", true)
			end,
			ShouldSave = function(entity)
				return entity:GetNetVar("Persistent")
			end
		})
	end

	local useSaveEnts = {
		["prop_physics"] = true,
		["prop_effect"] = true,
		["gmod_lamp"] = true,
	}
	function PLUGIN:LoadData()
		local entities = self:GetData() or {}

		for _, v in ipairs(entities) do
			if (useSaveEnts[v.Class] and ix.saveEnts and !ix.config.Get("SaveEntsOldLoadingEnabled")) then
				continue
			end

			local entity = ents.Create(v.Class)

			if (IsValid(entity)) then
				entity:SetPos(v.Pos)
				entity:SetAngles(v.Angle)
				entity:SetModel(v.Model)
				entity:SetSkin(v.Skin)
				entity:SetColor(v.Color)
				entity:SetMaterial(v.Material)
				entity:Spawn()
				entity:Activate()

				if (v.Class == "prop_physics") then
					entity.ownerCharacter = v.ownerCharacter
					entity.ownerName = v.ownerName
					entity.ownerSteamID = v.ownerSteamID

					if (v.saveDescription and v.description) then
						entity:SetNetVar("description", v.description)
						entity.saveDescription = true
					end
				end

				if (v.bNoCollision) then
					entity:SetCollisionGroup(COLLISION_GROUP_WORLD)
				end

				if (istable(v.BodyGroups)) then
					for k2, v2 in pairs(v.BodyGroups) do
						entity:SetBodygroup(k2, v2)
					end
				end

				if (istable(v.SubMaterial)) then
					for k2, v2 in pairs(v.SubMaterial) do
						if (!isnumber(k2) or !isstring(v2)) then
							continue
						end

						entity:SetSubMaterial(k2 - 1, v2)
					end
				end

				local physicsObject = entity:GetPhysicsObject()

				if (IsValid(physicsObject)) then
					physicsObject:EnableMotion(v.Movable)
				end

				self.stored[#self.stored + 1] = entity

				entity:SetNetVar("Persistent", true)
			end
		end
	end

	function PLUGIN:SaveData()
		local entities = {}

		for _, v in ipairs(self.stored) do
			if (IsValid(v)) then
				--[[
				if (useSaveEnts[v:GetClass()] and ix.saveEnts and !ix.config.Get("SaveEntsOldLoadingEnabled")) then
					continue
				end
				--]]

				local data = {}
				data.Class = v.ClassOverride or v:GetClass()
				data.Pos = v:GetPos()
				data.Angle = v:GetAngles()
				data.Model = GetRealModel(v)
				data.Skin = v:GetSkin()
				data.Color = v:GetColor()
				data.Material = v:GetMaterial()
				data.bNoCollision = v:GetCollisionGroup() == COLLISION_GROUP_WORLD

				if (v:GetClass() == "prop_physics") then
					data.ownerCharacter = v.ownerCharacter
					data.ownerName = v.ownerName
					data.ownerSteamID = v.ownerSteamID

					if (v.saveDescription and v:GetNetVar("description")) then
						data.description = v:GetNetVar("description")
						data.saveDescription = true
					end
				end

				local materials = v:GetMaterials()

				if (istable(materials)) then
					data.SubMaterial = {}

					for k2, _ in pairs(materials) do
						if (v:GetSubMaterial(k2 - 1) != "") then
							data.SubMaterial[k2] = v:GetSubMaterial(k2 - 1)
						end
					end
				end

				local bodyGroups = v:GetBodyGroups()

				if (istable(bodyGroups)) then
					data.BodyGroups = {}

					for _, v2 in pairs(bodyGroups) do
						if (v:GetBodygroup(v2.id) > 0) then
							data.BodyGroups[v2.id] = v:GetBodygroup(v2.id)
						end
					end
				end

				local physicsObject = v:GetPhysicsObject()

				if (IsValid(physicsObject)) then
					data.Movable = physicsObject:IsMoveable()
				end

				entities[#entities + 1] = data
			end
		end

		self:SetData(entities)
	end

	ix.log.AddType("persist", function(client, ...)
		local arg = {...}
		return string.format("%s has %s persistence for '%s'.", client:Name(), arg[2] and "enabled" or "disabled", arg[1])
	end)
end
