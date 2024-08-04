--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


Schema.CombineObjectives = Schema.CombineObjectives or {}

-- data saving
function Schema:SaveRationDispensers()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_rationdispenser")) do
		data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetEnabled()}
	end

	ix.data.Set("rationDispensers", data)
end

function Schema:SaveCombineLocks()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_combinelock")) do
		if (IsValid(v.door)) then
			data[#data + 1] = {
				v.door:MapCreationID(),
				v.door:WorldToLocal(v:GetPos()),
				v.door:WorldToLocalAngles(v:GetAngles()),
				v:GetLocked()
			}
		end
	end

	ix.data.Set("combineLocks", data)

	data = {}

	for _, v2 in ipairs(ents.FindByClass("ix_combinelock_cwu")) do
		if (IsValid(v2.door)) then
			data[#data + 1] = {
				v2.door:MapCreationID(),
				v2.door:WorldToLocal(v2:GetPos()),
				v2.door:WorldToLocalAngles(v2:GetAngles()),
				v2:GetLocked(),
				v2.accessLevel
			}
		end
	end

	ix.data.Set("combineLocksCwu", data)

	data = {}

	for _, v2 in ipairs(ents.FindByClass("ix_combinelock_dob")) do
		if (IsValid(v2.door)) then
			data[#data + 1] = {
				v2.door:MapCreationID(),
				v2.door:WorldToLocal(v2:GetPos()),
				v2.door:WorldToLocalAngles(v2:GetAngles()),
				v2:GetLocked(),
				v2.accessLevel
			}
		end
	end

	ix.data.Set("combineLocksDob", data)

	data = {}

	for _, v2 in ipairs(ents.FindByClass("ix_combinelock_cmru")) do
		if (IsValid(v2.door)) then
			data[#data + 1] = {
				v2.door:MapCreationID(),
				v2.door:WorldToLocal(v2:GetPos()),
				v2.door:WorldToLocalAngles(v2:GetAngles()),
				v2:GetLocked(),
				v2.accessLevel
			}
		end
	end

	ix.data.Set("combineLocksCmru", data)

	data = {}

	for _, v2 in ipairs(ents.FindByClass("ix_combinelock_moe")) do
		if (IsValid(v2.door)) then
			data[#data + 1] = {
				v2.door:MapCreationID(),
				v2.door:WorldToLocal(v2:GetPos()),
				v2.door:WorldToLocalAngles(v2:GetAngles()),
				v2:GetLocked(),
				v2.accessLevel
			}
		end
	end

	ix.data.Set("combineLocksMoe", data)
end

function Schema:SaveForceFields()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_forcefield")) do
		data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetMode()}
	end

	ix.data.Set("forceFields", data)
end

function Schema:SaveRebelForceFields()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_rebelfield")) do
		data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetMode()}
	end

	ix.data.Set("rebelForceFields", data)
end

-- data loading
function Schema:LoadRationDispensers()
	for _, v in ipairs(ix.data.Get("rationDispensers") or {}) do
		local dispenser = ents.Create("ix_rationdispenser")

		dispenser:SetPos(v[1])
		dispenser:SetAngles(v[2])
		dispenser:Spawn()
		dispenser:SetEnabled(v[3])
	end
end

function Schema:LoadCombineLocks()
	for _, v in ipairs(ix.data.Get("combineLocks") or {}) do
		local door = ents.GetMapCreatedEntity(v[1])

		if (IsValid(door) and door:IsDoor()) then
			local lock = ents.Create("ix_combinelock")

			lock:SetPos(door:GetPos())
			lock:Spawn()
			lock:SetDoor(door, door:LocalToWorld(v[2]), door:LocalToWorldAngles(v[3]))
			lock:SetLocked(v[4])
		end
	end

	for _, v in ipairs(ix.data.Get("combineLocksCwu") or {}) do
		local door = ents.GetMapCreatedEntity(v[1])

		if (IsValid(door) and door:IsDoor()) then
			local lock = ents.Create("ix_combinelock_cwu")

			lock:SetPos(door:GetPos())
			lock:Spawn()
			lock:SetDoor(door, door:LocalToWorld(v[2]), door:LocalToWorldAngles(v[3]))
			lock:SetLocked(v[4])
			lock.accessLevel = v[5]
		end
	end

	for _, v in ipairs(ix.data.Get("combineLocksDob") or {}) do
		local door = ents.GetMapCreatedEntity(v[1])

		if (IsValid(door) and door:IsDoor()) then
			local lock = ents.Create("ix_combinelock_dob")

			lock:SetPos(door:GetPos())
			lock:Spawn()
			lock:SetDoor(door, door:LocalToWorld(v[2]), door:LocalToWorldAngles(v[3]))
			lock:SetLocked(v[4])
			lock.accessLevel = v[5]
		end
	end

	for _, v in ipairs(ix.data.Get("combineLocksCmru") or {}) do
		local door = ents.GetMapCreatedEntity(v[1])

		if (IsValid(door) and door:IsDoor()) then
			local lock = ents.Create("ix_combinelock_cmru")

			lock:SetPos(door:GetPos())
			lock:Spawn()
			lock:SetDoor(door, door:LocalToWorld(v[2]), door:LocalToWorldAngles(v[3]))
			lock:SetLocked(v[4])
			lock.accessLevel = v[5]
		end
	end

	for _, v in ipairs(ix.data.Get("combineLocksMoe") or {}) do
		local door = ents.GetMapCreatedEntity(v[1])

		if (IsValid(door) and door:IsDoor()) then
			local lock = ents.Create("ix_combinelock_moe")

			lock:SetPos(door:GetPos())
			lock:Spawn()
			lock:SetDoor(door, door:LocalToWorld(v[2]), door:LocalToWorldAngles(v[3]))
			lock:SetLocked(v[4])
			lock.accessLevel = v[5]
		end
	end
end

function Schema:LoadForceFields()
	for _, v in ipairs(ix.data.Get("forceFields") or {}) do
		local field = ents.Create("ix_forcefield")

		field:SetPos(v[1])
		field:SetAngles(v[2])
		field:Spawn()
		field:SetMode(v[3])

		local skin = scripted_ents.Get("ix_forcefield")
		skin = skin.MODES

		if (v[3] == 1) then
			field:SetSkin(3)
			field.dummy:SetSkin(3)
		else
			field:SetSkin(skin[v[3]][4])
			field.dummy:SetSkin(skin[v[3]][4])
		end
	end
end

function Schema:SearchPlayer(client, target)
	if (!target:GetCharacter() or !target:GetCharacter():GetInventory()) then
		return false
	end

	local name = hook.Run("GetDisplayedName", target) or target:Name()
	local inventory = target:GetCharacter():GetInventory()

	ix.storage.Open(client, inventory, {
		entity = target,
		name = name
	})

	return true
end
