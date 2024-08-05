--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


util.AddNetworkString("ixVendingMachineManager")
util.AddNetworkString("ixOpenVendingInventory")
util.AddNetworkString("ixSetVendingMachineLabel")
util.AddNetworkString("ixToggleVendingMachineButton")
util.AddNetworkString("ixSetVendingMachinePrice")
util.AddNetworkString("ixSelectVendingMachineCID")
util.AddNetworkString("ixCollectVendingMachineCredits")
util.AddNetworkString("ixSetVendingMachineSkin")

local fields = {
	"credits", "labels", "buttons", "prices", "stocks"
}
function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_customvendingmachine", true, true, true, {
		OnSave = function(entity, data) --OnSave
			local inventory = ix.item.inventories[entity:GetID()]
			data.invID = inventory:GetID()
			data.motion = false
			for k, v in ipairs(fields) do
				data[v] = entity:GetNetVar(v)
			end
		end,
		OnRestore = function(entity, data) --OnRestore
			ix.inventory.Restore(data.invID, 10, 8, function(inventory)
				inventory.vars.isBag = true
				inventory.vars.isVendingMachine = true

				if (IsValid(entity)) then
					entity:SetID(inventory:GetID())
					entity:UpdateStocks()
				end
			end)

			for k, v in ipairs(fields) do
				entity:SetNetVar(v, data[v])
			end
		end,
		ShouldSave = function(entity) --ShouldSave
			local inventory = ix.item.inventories[entity:GetID()]
			return inventory:GetID() >= 1
		end,
		ShouldRestore = function(data) --ShouldRestore
			return data.invID >= 1
		end
	})
end

-- A function to save the Vending Machines.
function PLUGIN:SaveVendingMachines()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_customvendingmachine")) do
		local inventory = ix.item.inventories[v:GetID()]

		data[#data + 1] = {
			v:GetPos(),
			v:GetAngles(),
			inventory:GetID(),
			v:GetNetVar("credits"),
			v:GetNetVar("labels"),
			v:GetNetVar("buttons"),
			v:GetNetVar("prices"),
			v:GetNetVar("stocks"),
			v:GetSkin()
		}
	end

	ix.data.Set("customVendingMachines", data)
end

-- A function to load the Vending Machines.
function PLUGIN:LoadVendingMachines()
	for _, v in ipairs(ix.data.Get("customVendingMachines") or {}) do
		local inventoryID = tonumber(v[3])

		if (!inventoryID or inventoryID < 1) then
			ErrorNoHalt(string.format("[Helix] Attempted to restore container inventory with invalid inventory ID '%s'\n", tostring(inventoryID)))

			continue
		end

		local entity = ents.Create("ix_customvendingmachine")
		entity:SetPos(v[1])
		entity:SetAngles(v[2])
		entity:Spawn()

		ix.inventory.Restore(inventoryID, 10, 8, function(inventory)
			inventory.vars.isBag = true
			inventory.vars.isVendingMachine = true

			if (IsValid(entity)) then
				entity:SetID(inventory:GetID())
				entity:UpdateStocks()
			end
		end)

		entity:SetNetVar("credits", v[4])
		entity:SetNetVar("labels", v[5])
		entity:SetNetVar("buttons", v[6])
		entity:SetNetVar("prices", v[7])
		entity:SetNetVar("stocks", v[8])

		entity:SetSkin(v[9])

		local physicsObject = entity:GetPhysicsObject()

		if (IsValid(physicsObject)) then
			physicsObject:EnableMotion(false)
		end
	end
end

net.Receive("ixOpenVendingInventory", function(_, client)
	local machine = net.ReadEntity()

	if (!IsValid(client.ixVendingMachineEdit) or machine != client.ixVendingMachineEdit) then return end

 	local inventory = ix.item.inventories[machine:GetID()]

	if (inventory) then
		ix.storage.Open(client, inventory, {
			name = "Vending Machine",
			entity = machine,
			searchTime = 0
		})
	end
end)

net.Receive("ixSetVendingMachineLabel", function(_, client)
	local machine = net.ReadEntity()

	if (!IsValid(client.ixVendingMachineEdit) or machine != client.ixVendingMachineEdit) then return end

	local slot = net.ReadFloat()
	local label = net.ReadString()
	label = string.Left(label, 100)

	machine:SetData("labels", slot, label)
	ix.saveEnts:SaveEntity(machine)
end)

net.Receive("ixToggleVendingMachineButton", function(_, client)
	local machine = net.ReadEntity()

	if (!IsValid(client.ixVendingMachineEdit) or machine != client.ixVendingMachineEdit) then return end

	local slot = net.ReadFloat()

	local buttons = machine:GetNetVar("buttons", {})
	buttons[slot] = !buttons[slot]

	machine:SetNetVar("buttons", buttons)
	ix.saveEnts:SaveEntity(machine)
end)

net.Receive("ixSetVendingMachinePrice", function(_, client)
	local machine = net.ReadEntity()

	if (!IsValid(client.ixVendingMachineEdit) or machine != client.ixVendingMachineEdit) then return end

	local slot = net.ReadFloat()
	local price = net.ReadFloat()

	machine:SetData("prices", slot, price)
	ix.saveEnts:SaveEntity(machine)
end)

net.Receive("ixSelectVendingMachineCID", function(_, client)
	if (net.ReadBool()) then
		local entity = net.ReadEntity()

		if (IsValid(entity) and IsValid(client) and client == entity.cidSelection) then
			local idCard = net.ReadUInt(16)
			local idCardItem = ix.item.instances[idCard]

			idCardItem:LoadOwnerGenericData(entity.CheckIDCard, entity.CheckIDError, client, entity, client.isCollecting)
			entity.cidSelection = nil
		end
	else
		local entity = net.ReadEntity()

		if (IsValid(entity)) then
			entity:EmitSound("buttons/button2.wav")
			entity.cidSelection = nil
		end
	end
end)

net.Receive("ixCollectVendingMachineCredits", function(_, client)
	local machine = net.ReadEntity()

	if (!IsValid(client.ixVendingMachineEdit) or machine != client.ixVendingMachineEdit) then return end

	if (machine and IsValid(machine)) then
		machine:CollectCredits(client)
	end
end)

net.Receive("ixSetVendingMachineSkin", function(_, client)
	local machine = net.ReadEntity()

	if (!IsValid(client.ixVendingMachineEdit) or machine != client.ixVendingMachineEdit) then return end

	local skin = net.ReadFloat()

	if (machine and IsValid(machine) and !machine:GetLocked()) then
		machine:SetSkin(skin)
		ix.saveEnts:SaveEntity(machine)
	end
end)
