--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:PlayerSpawnedProp(client, model, entity)
	if (!client:GetNetVar("InfestationEditMode") or client:GetNetVar("InfestationEditMode") == 0) then return end

	if (client:GetNetVar("InfestationEditMode") == 1) then


	elseif (client:GetNetVar("InfestationEditMode") == 2) then

	end

	entity:SetNetVar("infestationProp", client:SteamID())
end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_infestation_prop", true, true, true, {
		OnSave = function(entity, data) --OnSave
			data.model = entity:GetModel()
			data.harvested = entity:GetHarvested()
			data.infestation = entity:GetInfestation()
			data.type = entity:GetType()
			data.core = entity:GetCore()
			data.sprayed = entity:GetSprayed()
		end,
		OnRestore = function(entity, data) --OnRestore
			entity:SetModel(data.model)
			entity:SetHarvested(data.harvested)
			entity:SetInfestation(data.infestation)
			entity:SetType(data.type)
			entity:SetCore(data.core)
			entity:SetColor(data.harvested and Color(127, 127, 127) or Color(255, 255, 255))
			entity:SetSprayed(false)
		end,
		ShouldSave = function(entity) --ShouldSave
			if (entity:GetSprayed() or !entity:GetInfestation() or !ix.infestation.stored[entity:GetInfestation()]) then
				ix.saveEnts:DeleteEntity(entity)

				return false
			end

			return true
		end,
		ShouldRestore = function(data) --ShouldRestore
			return !data.sprayed, true
		end
	})

	ix.saveEnts:RegisterEntity("ix_infestation_tank", true, true, true, {
		OnSave = function(entity, data) --OnSave
			data.chemVolume = entity:GetChemicalVolume()
			data.chemType = entity:GetChemicalType()
			data.hoseAttached = entity:GetHoseAttached()
			data.applicatorAttached = entity:GetApplicatorAttached()
			data.hoseConnected = entity:GetHoseConnected()
		end,
		OnRestore = function(entity, data) --OnRestore
			entity:SetChemicalVolume(data.chemVolume)
			entity:SetChemicalType(data.chemType)
			entity:SetHoseAttached(data.hoseAttached)
			entity:SetApplicatorAttached(data.applicatorAttached)
			entity:SetHoseConnected(false)
			entity:SetColor(data.color)
			entity:Spawn()

			entity:SetBodygroup(entity:FindBodygroupByName("Hose"), data.hoseAttached and 0 or 1)
			entity:SetBodygroup(entity:FindBodygroupByName("Applicator"), data.applicatorAttached and 0 or 1)
		end
	})
end

function PLUGIN:SaveData()
	ix.data.Set("infestationZones", ix.infestation.stored)

	self:SaveInfestationProps()
	self:SaveInfestationTanks()
end

function PLUGIN:LoadData()
	local data = ix.data.Get("infestationZones", {})
	ix.infestation.stored = data

	for name, data in pairs(data) do
		self:InfestationTimer(name, data.spread)
	end

	if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end
	for _, data in ipairs(ix.data.Get("infestationProps", {})) do
		if (data.sprayed) then continue end
		if (!data.infestation or !ix.infestation.stored[data.infestation]) then continue end

		local entity = ents.Create("ix_infestation_prop")
		entity:SetModel(data.model)
		entity:SetPos(data.position)
		entity:SetAngles(data.angles)
		entity:SetHarvested(data.harvested)
		entity:SetInfestation(data.infestation)
		entity:SetType(data.type)
		entity:SetCore(data.core)
		entity:SetSprayed(false)
		entity:SetColor(data.harvested and Color(127, 127, 127) or Color(255, 255, 255))
		entity:Spawn()
	end

	for _, data in ipairs(ix.data.Get("infestationTanks", {})) do
		local entity = ents.Create("ix_infestation_tank")

		entity:SetPos(data.position)
		entity:SetAngles(data.angles)
		entity:SetChemicalVolume(data.chemVolume)
		entity:SetChemicalType(data.chemType)
		entity:SetHoseAttached(data.hoseAttached)
		entity:SetApplicatorAttached(data.applicatorAttached)
		entity:SetHoseConnected(false)
		entity:SetColor(data.color)
		entity:Spawn()

		entity:SetBodygroup(entity:FindBodygroupByName("Hose"), data.hoseAttached and 0 or 1)
		entity:SetBodygroup(entity:FindBodygroupByName("Applicator"), data.applicatorAttached and 0 or 1)
	end
end

function PLUGIN:PlayerInitialSpawn(client)
	net.Start("ixInfestationZoneNetwork")
	net.WriteTable(ix.infestation.stored)
	net.Send(client)
end

function PLUGIN:KeyPress(client, key)
	local editMode = client:GetNetVar("InfestationEditMode")

	if (!editMode) then return end

	if (client:KeyDown(IN_DUCK) and client:KeyDown(IN_SPEED)) then
		local desiredEditMode = false

		if (editMode == 0) then -- Main menu.
			if (client:KeyDown(IN_ATTACK)) then -- Create a new infestation zone.
				desiredEditMode = 1
			elseif (client:KeyDown(IN_ATTACK2)) then -- Edit an existing infestation zone.
				local entity = client:GetEyeTraceNoCursor().Entity

				if (entity and IsValid(entity) and entity:GetClass() == "ix_infestation_prop") then
					desiredEditMode = 2
					client:SetNetVar("InfestationEditName", entity:GetInfestation())
				else
					client:NotifyLocalized("invalidZone")
				end
			elseif (client:KeyDown(IN_WALK)) then -- Exit infestation edit mode.
				desiredEditMode = nil

				ix.log.Add(client, "infestationLog", client:GetName() .. " (" .. client:SteamID() .. ") has exited Infestation Edit Mode.")
			end
		elseif (editMode == 1) then -- Create infestation zone.
			if (client:KeyDown(IN_ATTACK)) then -- Create a new infestation zone.
				for _, prop in pairs(ents.FindByClass("prop_physics")) do
					if (prop:GetNetVar("infestationProp") and prop:GetNetVar("infestationProp") == client:SteamID()) then
						local physicsObject = prop:GetPhysicsObject()

						if (IsValid(physicsObject)) then
							physicsObject:EnableMotion(false)
						end
					end
				end

				net.Start("ixInfestationZoneCreate")
				net.Send(client)
			elseif (client:KeyDown(IN_ATTACK2)) then -- Define core prop.
				local entity = client:GetEyeTraceNoCursor().Entity

				if (entity and IsValid(entity) and entity:GetNetVar("infestationProp") and entity:GetNetVar("infestationProp") == client:SteamID()) then
					for _, prop in pairs(ents.FindByClass("prop_physics")) do
						if (prop and IsValid(prop) and prop:GetNetVar("infestationProp") and prop:GetNetVar("infestationProp") == client:SteamID() and prop:GetNetVar("infestationCore")) then
							prop:SetNetVar("infestationCore", nil)
						end
					end

					entity:SetNetVar("infestationCore", true)
				else
					client:NotifyLocalized("invalidInfestationProp")
				end
			elseif (client:KeyDown(IN_WALK)) then -- Go back to menu.
				desiredEditMode = 0

				for _, prop in pairs(ents.FindByClass("prop_physics")) do
					if (prop:GetNetVar("infestationProp") and prop:GetNetVar("infestationProp") == client:SteamID()) then
						prop:Remove()
					end
				end
			end
		elseif (editMode == 2) then -- Edit infestation zone.
			if (client:KeyDown(IN_ATTACK)) then -- Save changes & open menu.

			-- To be added. Maybe.

			elseif (client:KeyDown(IN_ATTACK2)) then -- Remove infestation zone.
				local targetInfestation = client:GetNetVar("InfestationEditName")

				self:UpdateInfestation(targetInfestation, nil)

				for _, entity in ipairs(ents.FindByClass("ix_infestation_prop")) do
					if (entity:GetInfestation() == targetInfestation) then
						entity:Remove()
					end
				end

				self:SaveInfestationProps()
				desiredEditMode = 0

				client:NotifyLocalized("zoneRemoved")
				ix.log.Add(client, "infestationLog", client:GetName() .. " (" .. client:SteamID() .. ") removed the \"" .. targetInfestation .. "\" Infestation Zone.")
			elseif (client:KeyDown(IN_WALK)) then -- Go back to menu.
				desiredEditMode = 0

				for _, prop in pairs(ents.FindByClass("prop_physics")) do
					if (prop:GetNetVar("infestationProp") and prop:GetNetVar("infestationProp") == client:SteamID()) then
						prop:Remove()
					end
				end
			end
		end

		if (desiredEditMode != false) then
			client:SetNetVar("InfestationEditMode", desiredEditMode) -- Doing it this way purely to make the code a bit easier to read.
		end
	end
end

function PLUGIN:EntityTakeDamage(entity, damageInfo)
	local client = damageInfo:GetAttacker()

	if ((entity:GetClass() == "npc_headcrab" or entity:GetClass() == "npc_headcrab_black" or entity:GetClass() == "npc_headcrab_fast")
	and (damageInfo:GetDamageType() == DMG_SLASH or (IsValid(client) and client:IsPlayer() and client:IsVortigaunt() and client:GetActiveWeapon() and IsValid(client:GetActiveWeapon()) and client:GetActiveWeapon():GetClass() == "ix_hands"))
	and !entity:GetNetVar("heartHarvested")
	and math.random(0, 10) > 8) then -- I hate this
		if (!client:GetCharacter():GetInventory():Add("ing_headcrab_meat")) then
			ix.item.Spawn("ing_headcrab_meat", client)
		end

		if (!entity or !IsValid(entity)) then return end

		entity:Kill()
	end
end
